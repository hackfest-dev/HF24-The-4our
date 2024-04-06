const Investor = require("../models/InvestorSchema");
const Farm = require("../models/FarmsSchema");
const InvestorToFarm = require("../models/investorToFarmSchema");
const Org = require("../models/OrgSchema");
const { v4: uuidv4 } = require("uuid");
const {
  hashPassword,
  comparePassword,
  generateToken,
} = require("../middlewares/authorization");

const invSignUp = async (req, res, next) => {
  try {
    const {
      name,
      email,
      password,
      phoneNumber,
      permanentAddress,
      aadharNumber,
      panNumber,
      dateOfBirth,
      nomineeDetails,
    } = req.body;

    // Generate a unique random ID for the investor
    const investorID = uuidv4();
    const hashedpass = await hashPassword(password);
    const KYCDone = false;

    const existingInvestor = await Investor.findOne({
      $or: [{ email }, { phoneNumber }, { aadharNumber }, { panNumber }],
    });

    if (existingInvestor) {
      return res
        .status(400)
        .json({ error: "Investor with provided details already exists." });
    }

    // Create a new investor document with the generated investorID
    const newInvestor = new Investor({
      investorID,
      name,
      email,
      password: hashedpass,
      phoneNumber,
      permanentAddress,
      aadharNumber,
      panNumber,
      dateOfBirth,
      KYCDone,
      nomineeDetails,
    });

    // Save the investor document to the database
    await newInvestor.save();

    token = await generateToken({
      type: "investor",
      aadharNumber: aadharNumber,
    });

    res
      .status(201)
      .json({ message: "Investor signed up successfully.", token: token });
  } catch (error) {
    // Handle errors
    console.error("Error in sign up:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const investInFarm = async (req, res) => {
  try {
    const { aadharNumber, farmId, noOfShares, transactionID, timestamp } =
      req.body;

    const farm = await Farm.findOne({ farmID: farmId });
    const parsedTimestamp = new Date(timestamp);

    if (!farm) {
      return res.status(404).json({ error: "Farm not found" });
    }

    const orgId = farm.orgId;
    const sharePrice = farm.eachSharePrice;

    // Check if the number of shares being invested is greater than available shares
    if (noOfShares > farm.availableShares) {
      return res.status(400).json({ error: "Insufficient available shares" });
    }

    // Check if the investor has already invested in the farm
    const existingInvestment = await InvestorToFarm.findOne({
      aadharNumber,
      farmID: farmId,
    });

    const newInvestment = new InvestorToFarm({
      aadharNumber,
      farmID: farmId,
      orgId: orgId,
      noOfShares,
      sharePrice: sharePrice,
      transactionID,
      returns: 0,
      timestamp: parsedTimestamp,
    });
    await newInvestment.save();

    if (!existingInvestment) {
      // Increase the totalInvestors count in the farm schema
      await Farm.findOneAndUpdate(
        { farmID: farmId },
        { $inc: { totalInvestors: 1 } }
      );
    }

    // Decrease the available shares in the farm schema
    await Farm.findOneAndUpdate(
      { farmID: farmId },
      { $inc: { availableShares: -noOfShares } }
    );

    res.status(200).json({ message: "Investment successful." });
  } catch (error) {
    console.error("Error in investing:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const invLogin = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    // Find the investor by email
    const investor = await Investor.findOne({ email });

    if (!investor) {
      return res.status(404).json({ error: "Investor not found" });
    }

    // Compare passwords
    const isPasswordMatch = await comparePassword(password, investor.password);

    if (!isPasswordMatch) {
      return res.status(401).json({ error: "Invalid credentials" });
    }

    // Generate JWT token
    const token = await generateToken({
      type: "investor",
      aadharNumber: investor.aadharNumber,
    });

    res.status(200).json({ token });
  } catch (error) {
    // Handle errors
    console.error("Error in login:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const fetchPortfolio = async (req, res, next) => {
  try {
    // Parse Aadhar number from request parameters
    const { aadharNumber } = req.body;

    // Find investments made by the investor based on Aadhar number
    const investments = await InvestorToFarm.find({ aadharNumber });

    // Initialize an array to store portfolio details
    const portfolio = [];

    // Iterate over each investment to fetch farm and org details
    for (const investment of investments) {
      const { farmID } = investment;

      // Fetch farm details based on farm ID
      const farm = await Farm.findOne({ farmID });

      // Fetch organization details based on org ID
      const org = await Org.findOne({ orgID: farm.orgId });

      // Construct portfolio entry with farm and org details
      const portfolioEntry = {
        farm: farm.toObject(),
        org: {
          orgName: org.orgName,
          permanentAddress: org.permanentAddress,
          description: org.description,
        },
        investmentDetails: {
          noOfShares: investment.noOfShares,
          sharePrice: investment.sharePrice,
          transactionID: investment.transactionID,
          returns: investment.returns,
          timestamp: investment.timestamp,
        },
      };

      // Add portfolio entry to the portfolio array
      portfolio.push(portfolioEntry);
    }

    // Respond with the portfolio data
    res.status(200).json(portfolio);
  } catch (error) {
    // Handle errors
    console.error("Error in fetching portfolio:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const fetchInvestorDetails = async (req, res) => {
  try {
    const { aadharNumber } = req.body;

    // Find the investor by Aadhar number
    const investor = await Investor.findOne({ aadharNumber });

    if (!investor) {
      return res.status(404).json({ error: "Investor not found" });
    }

    res.status(200).json(investor);
  } catch (error) {
    console.error("Error in fetching investor details:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

module.exports = {
  invSignUp,
  investInFarm,
  invLogin,
  fetchPortfolio,
  fetchInvestorDetails,
};
