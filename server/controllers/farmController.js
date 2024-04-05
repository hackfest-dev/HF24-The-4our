const Farm = require("../models/FarmsSchema"); // Import the Farm model
const { v4: uuidv4 } = require("uuid");
const Returns = require("../models/returnsSchema");
const InvestorToFarm = require("../models/investorToFarmSchema");

const createFarm = async (req, res, next) => {
  try {
    const {
      farmName,
      orgId,
      Location,
      energyCategory,
      farmValuation: farmValuationStr,
      numberOfShares: numberOfSharesStr,
      eachSharePrice: eachSharePriceStr,
      govtSubsidy: govtSubsidyStr,
      orgInvestment: orgInvestmentStr,
      expectedEnergyOutput: expectedEnergyOutputStr,
      energyUnit,
      description,
      farmReady,
      farmExpectedReadyDate: farmExpectedReadyDateStr,
      expectedDateOfReturns: expectedDateOfReturnsStr,
    } = req.body;

    // Parse string inputs to appropriate types
    const farmValuation = parseFloat(farmValuationStr);
    const numberOfShares = parseInt(numberOfSharesStr);
    const eachSharePrice = parseFloat(eachSharePriceStr);
    const govtSubsidy = parseFloat(govtSubsidyStr);
    const orgInvestment = parseFloat(orgInvestmentStr);
    const expectedEnergyOutput = parseFloat(expectedEnergyOutputStr);
    const farmExpectedReadyDate = new Date(farmExpectedReadyDateStr);
    const expectedDateOfReturns = new Date(expectedDateOfReturnsStr);

    const farmID = uuidv4();
    const totalInvestors = 0;
    const availableShares = numberOfShares;
    const orgInvestmentPercent = (orgInvestment / farmValuation) * 100;
    const govtEquityPercent = (govtSubsidy / farmValuation) * 100;
    const govtEnergyOutput = (govtEquityPercent / 100) * expectedEnergyOutput;
    const investorEquityPercent =
      ((eachSharePrice * numberOfShares) / farmValuation) * 100;
    const investorEnergyOutput =
      (investorEquityPercent / 100) * expectedEnergyOutput;
    const energyPerShare = investorEnergyOutput / numberOfShares;
    const actualEnergyPerShare = energyPerShare - energyPerShare * 0.1;
    const orgEnergyOutput = orgInvestmentPercent * expectedEnergyOutput;

    const existingFarm = await Farm.findOne({
      $and: [{ farmName }, { orgId }],
    });
    if (existingFarm) {
      return res.status(400).json({
        error: "Farm with provided name already exists for your organisation.",
      });
    }

    const expectedFarmValuation =
      numberOfShares * eachSharePrice + (govtSubsidy + orgInvestment);
    if (farmValuation !== expectedFarmValuation) {
      return res.status(400).json({
        error:
          "Farm valuation does not comply with the data you provided, please check the valuation and update it correctly.",
      });
    }

    // Create a new farm document
    const newFarm = new Farm({
      farmName,
      orgId,
      farmID,
      Location,
      energyCategory,
      farmValuation,
      totalInvestors,
      numberOfShares,
      availableShares,
      eachSharePrice,
      govtSubsidy,
      orgInvestment,
      orgInvestmentPercent,
      expectedEnergyOutput,
      energyUnit,
      description,
      govtEquityPercent,
      govtEnergyOutput,
      investorEquityPercent,
      investorEnergyOutput,
      energyPerShare: actualEnergyPerShare,
      orgEnergyOutput,
      farmReady,
      farmExpectedReadyDate,
      expectedDateOfReturns,
    });

    // Save the farm document to the database
    await newFarm.save();

    res.status(201).json({ message: "Farm created successfully." });
  } catch (error) {
    // Handle errors
    console.error("Error in creating farm:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const storeReturnsData = async (req, res, next) => {
  try {
    const { farmID, timestamp, energyGeneratedKilowattHours } = req.body;
    console.log(req.body);

    // Create a new returns document
    const newReturn = new Returns({
      farmID,
      timestamp,
      energyGeneratedKilowattHours,
    });

    // Save the returns document to the database
    await newReturn.save();

    res.status(201).json({ message: "Returns data stored successfully." });
  } catch (error) {
    // Handle errors
    console.error("Error in storing returns data:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

const updateInvestorReturns = async () => {
  try {
    // Fetch all investments from InvestorToFarm model
    const allInvestments = await InvestorToFarm.find();

    // Iterate over each investment
    for (const investment of allInvestments) {
      const { farmID, noOfShares, sharePrice, timestamp } = investment;

      // Calculate returns from the timestamp of investment to current date
      const currentTime = new Date();
      const investedPeriodInHours =
        (currentTime - timestamp) / (1000 * 60 * 60); // Convert milliseconds to hours

      // Fetch all returns data for the specific farm within the invested period
      const relevantReturns = await Returns.find({
        farmID,
        timestamp: { $gte: timestamp }, // Fetch returns after the investment timestamp
      });

      // Calculate total energy generated during the invested period
      let totalEnergyGenerated = 0;
      for (const ret of relevantReturns) {
        totalEnergyGenerated += ret.energyGeneratedKilowattHours;
      }

      // Calculate investor returns based on the energy generated and share price
      const investorReturns =
        (totalEnergyGenerated * sharePrice * noOfShares) /
        investedPeriodInHours;

      // Update the returns in InvestorToFarmSchema model
      await InvestorToFarm.updateOne(
        { farmID },
        { $set: { returns: investorReturns } }
      );
    }
  } catch (error) {
    console.error("Error updating investor returns:", error);
  }
};

const storeSyntheticData = async (req, res) => {
  try {
    const hourlyEnergyData = req.body;

    // Iterate over each hourly energy data object
    for (const data of hourlyEnergyData) {
      const { farmID, timestamp, energyGeneratedKilowattHours } = data;

      // Create a new Returns document
      const newReturn = new Returns({
        farmID,
        timestamp,
        energyGeneratedKilowattHours,
      });

      // Save the Returns document to the database
      await newReturn.save();
    }

    res
      .status(201)
      .json({ message: "Hourly energy data stored successfully." });
  } catch (error) {
    console.error("Error storing hourly energy data:", error);
    res.status(500).json({ error: "Internal server error" });
  }
};

module.exports = { createFarm, storeReturnsData, storeSyntheticData };
