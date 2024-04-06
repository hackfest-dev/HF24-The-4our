const mongoose = require("mongoose");

const farmsSchema = new mongoose.Schema({
  farmName: {
    type: String,
    required: true,
  },
  orgId: {
    type: String,
    required: true,
  },
  farmID: {
    type: String,
    unique: true,
    required: true,
  },
  Location: {
    type: String,
    required: true,
  },
  energyCategory: {
    type: String,
    enum: ["Solar", "Wind", "Bio"],
  },
  farmValuation: {
    type: Number,
    required: true,
  },
  totalInvestors: {
    type: Number,
    required: true,
  },
  numberOfShares: {
    type: Number,
    required: true,
  },
  availableShares: {
    type: Number,
    required: true,
  },
  eachSharePrice: {
    type: Number,
    required: true,
  },
  govtSubsidy: {
    type: Number,
    required: true,
  },
  orgInvestment: {
    type: Number,
    required: true,
  },
  orgInvestmentPercent: {
    type: Number,
    required: true,
  },
  expectedEnergyOutput: {
    type: Number,
    required: true,
  },
  energyUnit: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  govtEquityPercent: {
    type: Number,
    required: true,
  },
  govtEnergyOutput: {
    type: Number,
    required: true,
  },
  investorEquityPercent: {
    type: Number,
    required: true,
  },
  investorEnergyOutput: {
    type: Number,
    required: true,
  },
  energyPerShare: {
    type: Number,
    required: true,
  },
  orgEnergyOutput: {
    type: Number,
    required: true,
  },
  farmReady: {
    type: Boolean,
    required: true,
  },
  farmExpectedReadyDate: {
    type: Date,
  },
  expectedDateOfReturns: {
    type: Date,
  },
  maintenanceCostPercent: {
    type: Number,
    required: true,
  },
  news: {
    type: Array,
    required: true,
  },
  latitude: {
    type: String,
    required: true,
  },
  longitude: {
    type: String,
    required: true,
  },
  imgurl: {
    type: String,
    required: true,
  },
  farmApproved: {
    type: Boolean,
    required: true,
  },
});

module.exports = mongoose.model("Farms", farmsSchema);
