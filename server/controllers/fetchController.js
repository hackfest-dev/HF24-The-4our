const Org = require("../models/OrgSchema");
const Farm = require("../models/FarmsSchema");
const Returns = require("../models/returnsSchema");
const Organisation = require("../models/OrgSchema");

const fetchAllOrgs = async (req, res, next) => {
  try {
    // Fetch all organizations
    const orgs = await Org.find();

    // Iterate over each organization and fetch associated farms
    const orgsWithFarms = await Promise.all(
      orgs.map(async (org) => {
        // Find farms for the current organization
        const farms = await Farm.find({ orgId: org.orgID });

        // Return the organization object with associated farms
        return {
          ...org.toObject(),
          farms: farms.map((farm) => farm.toObject()),
        };
      })
    );

    // Respond with the organizations containing associated farms
    res.status(200).json(orgsWithFarms);
  } catch (error) {
    // Handle errors
    console.error("Error in fetching organizations with farms:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const fetchAllFarms = async (req, res, next) => {
  try {
    // Fetch all farms
    const farms = await Farm.find();

    // Iterate over each farm and fetch associated organization details
    const farmsWithOrgDetails = await Promise.all(
      farms.map(async (farm) => {
        // Find the organization associated with the current farm
        const org = await Org.findOne({ orgID: farm.orgId });

        // Return the farm object with associated organization details
        return {
          farmID: farm.farmID,
          imgurl: farm.imgurl,
          farmName: farm.farmName,
          location: farm.Location,
          energyCategory: farm.energyCategory,
          description: farm.description,
          orgName: org ? org.orgName : "N/A",
          orgDescription: org ? org.description : "N/A",
          orgPermanentAddress: org ? org.permanentAddress : "N/A",
        };
      })
    );

    // Respond with the farms along with their associated organization details
    res.status(200).json(farmsWithOrgDetails);
  } catch (error) {
    // Handle errors
    console.error("Error in fetching farms with organization details:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const fetchFarmReturns = async (req, res, next) => {
  try {
    // Parse farm ID from request parameters
    const { farmID } = req.params;

    // Parse duration from query parameters
    const { duration } = req.query;

    // Define the start and end dates based on the duration
    const currentDate = new Date();
    let startDate = new Date();
    let endDate = new Date();

    switch (duration) {
      case "1D":
        startDate.setDate(currentDate.getDate() - 1);
        break;
      case "1M":
        startDate.setMonth(currentDate.getMonth() - 1);
        break;
      case "6M":
        startDate.setMonth(currentDate.getMonth() - 6);
        break;
      case "1Y":
        startDate.setFullYear(currentDate.getFullYear() - 1);
        break;
      default:
        // No time range specified, retrieve all data
        startDate = null;
        endDate = null;
        break;
    }

    // Construct the query based on the start and end dates and farm ID
    const query = { farmID };
    if (startDate && endDate) {
      query.timestamp = { $gte: startDate, $lte: endDate };
    } else if (startDate) {
      query.timestamp = { $gte: startDate };
    } else if (endDate) {
      query.timestamp = { $lte: endDate };
    }

    // Fetch returns data based on the query
    const farmReturns = await Returns.find(query);

    // Calculate analytics
    let avgEnergyOutput = 0;
    let totalEnergyOutput = 0;
    let highestOutput = 0;
    let highestLastYear = 0;
    let lowestLastYear = Infinity;

    farmReturns.forEach((returnData) => {
      const energyGenerated = returnData.energyGeneratedKilowattHours;
      totalEnergyOutput += energyGenerated;
      if (energyGenerated > highestOutput) {
        highestOutput = energyGenerated;
      }
      if (
        returnData.timestamp >= startDate &&
        returnData.timestamp <= endDate
      ) {
        if (energyGenerated > highestLastYear) {
          highestLastYear = energyGenerated;
        }
        if (energyGenerated < lowestLastYear) {
          lowestLastYear = energyGenerated;
        }
      }
    });

    const currentDateOutput =
      farmReturns.length > 0
        ? farmReturns[farmReturns.length - 1].energyGeneratedKilowattHours
        : 0;
    const avgReturns = (totalEnergyOutput * 3.85) / farmReturns.length;
    const farmDegradePercent = (Math.random() * (15 - 10) + 10).toFixed(2);
    const farmMaintenancePercent = (100 - farmDegradePercent).toFixed(2);

    // Prepare response data
    let responseData = {
      farmID,
      duration,
      analytics: {
        avgEnergyOutput: totalEnergyOutput / farmReturns.length,
        avgReturns,
        highestOutput,
        highestLastYear,
        lowestLastYear,
        farmDegradePercent,
        farmMaintenancePercent,
        currentOutput: currentDateOutput,
      },
      data: farmReturns,
    };

    // Respond with the fetched returns data along with analytics
    res.status(200).json(responseData);
  } catch (error) {
    // Handle errors
    console.error("Error in fetching farm returns:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const getFarmWithOrganisation = async (req, res) => {
  try {
    // Retrieve farm data
    const farmId = req.params.farmId;
    const farm = await Farm.findOne({ farmID: farmId });

    if (!farm) {
      return res.status(404).json({ message: "Farm not found" });
    }

    const organisation = await Organisation.findOne({ orgID: farm.orgId });

    if (!organisation) {
      return res.status(404).json({ message: "Organisation not found" });
    }

    // Combine farm and organisation data
    const farmWithOrganisation = {
      farm: farm,
      organisation: organisation,
    };

    // Send the combined data as a response
    res.json(farmWithOrganisation);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Server Error" });
  }
};

module.exports = {
  fetchAllOrgs,
  fetchAllFarms,
  fetchFarmReturns,
  getFarmWithOrganisation,
};
