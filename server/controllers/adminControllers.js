const Farm = require("../models/FarmsSchema");
const Investor = require("../models/InvestorSchema");
const RejectedFarm = require("../models/RejectedFarmsSchema");

// Controller to get unapproved farms
const getUnapprovedFarms = async (req, res) => {
  try {
    // Find all farms that are not yet approved
    const unapprovedFarms = await Farm.find({ farmApproved: false });

    // Send the unapproved farms as a response
    res.status(200).json(unapprovedFarms);
  } catch (error) {
    console.error("Error in getting unapproved farms:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

// Controller to approve farms
const approveFarm = async (req, res) => {
  try {
    // Extract farmID from request parameters
    const { farmId } = req.params;

    // Find the farm by farmID
    const farm = await Farm.findOne({ farmID: farmId });

    // If farm not found, return 404 error
    if (!farm) {
      return res.status(404).json({ message: "Farm not found" });
    }

    // Update the farm's approval status to true
    farm.farmApproved = true;

    // Save the updated farm data
    await farm.save();

    // Send success response
    res.status(200).json({ message: "Farm approved successfully" });
  } catch (error) {
    console.error("Error in approving farm:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const getNonKYCInvestors = async (req, res) => {
  try {
    // Find all investors who have not completed KYC
    const nonKYCInvestors = await Investor.find({ KYCDone: false });

    // Send the non-KYC investors as a response
    res.status(200).json(nonKYCInvestors);
  } catch (error) {
    console.error("Error in getting non-KYC investors:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

// Controller to approve KYC for investors
const approveKYC = async (req, res) => {
  try {
    // Extract email from request parameters
    const { aadharNumber } = req.params;

    // Find the investor by email
    const investor = await Investor.findOne({ aadharNumber });

    // If investor not found, return 404 error
    if (!investor) {
      return res.status(404).json({ message: "Investor not found" });
    }

    // Update the investor's KYC status to true
    investor.KYCDone = true;

    // Save the updated investor data
    await investor.save();

    // Send success response
    res.status(200).json({ message: "KYC approved successfully" });
  } catch (error) {
    console.error("Error in approving KYC:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const rejectFarm = async (req, res) => {
  try {
    // Extract farmID from request parameters
    const { farmId } = req.params;

    // Find the farm by farmID
    const farm = await Farm.findOne({ farmID: farmId });

    // If farm not found, return 404 error
    if (!farm) {
      return res.status(404).json({ message: "Farm not found" });
    }

    // Create a new RejectedFarm document
    const rejectedFarm = new RejectedFarm(farm.toObject());

    // Save the rejected farm to the RejectedFarms schema
    await rejectedFarm.save();

    // Delete the farm from the Farms schema
    await Farm.deleteOne({ farmID: farmId });

    // Send success response
    res.status(200).json({ message: "Farm rejected successfully" });
  } catch (error) {
    console.error("Error in rejecting farm:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

module.exports = {
  getUnapprovedFarms,
  approveFarm,
  approveKYC,
  getNonKYCInvestors,
  rejectFarm,
};
