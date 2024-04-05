const Organisation = require("../models/OrgSchema");
const Farm = require("../models/FarmsSchema");
const { v4: uuidv4 } = require("uuid");
const {
  hashPassword,
  comparePassword,
  generateToken,
} = require("../middlewares/authorization");

const orgSignUp = async (req, res, next) => {
  try {
    const {
      orgName,
      email,
      password,
      phoneNumber,
      permanentAddress,
      regNumber,
      description,
      marketCap,
      docsLinks,
    } = req.body;

    const orgID = uuidv4();
    const adminApproval = false;
    const hashedpass = await hashPassword(password);

    const existingOrganisation = await Organisation.findOne({
      $or: [{ orgID }, { email }, { phoneNumber }, { regNumber }],
    });

    if (existingOrganisation) {
      return res
        .status(400)
        .json({ error: "Organisation with provided details already exists." });
    }

    // Create a new organisation document
    const newOrganisation = new Organisation({
      orgID,
      orgName,
      email,
      password: hashedpass,
      phoneNumber,
      permanentAddress,
      regNumber,
      description,
      marketCap,
      adminApproval,
      docsLinks,
    });

    // Save the organisation document to the database
    await newOrganisation.save();

    const token = await generateToken({
      orgID: orgID,
      type: "org",
    });

    res
      .status(201)
      .json({ message: "Organisation signed up successfully.", token: token });
  } catch (error) {
    // Handle errors
    console.error("Error in organisation sign up:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const orgLogin = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    // Find the organisation by email
    const organisation = await Organisation.findOne({ email });

    if (!organisation) {
      return res.status(404).json({ error: "Organisation not found" });
    }

    // Compare passwords
    const isPasswordMatch = await comparePassword(
      password,
      organisation.password
    );

    if (!isPasswordMatch) {
      return res.status(401).json({ error: "Invalid credentials" });
    }

    // Generate JWT token
    const token = await generateToken({
      orgID: organisation.orgID,
      type: "org",
    });

    res.status(200).json({ token });
  } catch (error) {
    // Handle errors
    console.error("Error in organisation login:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const getAllFarmsOfOrganization = async (req, res) => {
  try {
    const { orgID } = req.body;

    // Find all farms associated with the given orgID
    const farms = await Farm.find({ orgId: orgID });

    res.status(200).json({ farms });
  } catch (error) {
    console.error("Error in fetching farms:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

module.exports = { orgSignUp, orgLogin, getAllFarmsOfOrganization };
