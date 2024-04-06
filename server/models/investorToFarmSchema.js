const mongoose = require("mongoose");

const investorToFarmSchema = new mongoose.Schema({
  aadharNumber: {
    type: String,
    required: true,
  },
  farmID: {
    type: String,
    required: true,
  },
  orgId: {
    type: String,
    required: true,
  },
  noOfShares: {
    type: Number,
    required: true,
  },
  sharePrice: {
    type: Number,
    required: true,
  },
  transactionID: {
    type: String,
    required: true,
  },
  returns: {
    type: Number,
    required: true,
  },
  timestamp: {
    required: true,
    type: Date,
  },
});

module.exports = mongoose.model("InvestorToFarms", investorToFarmSchema);
