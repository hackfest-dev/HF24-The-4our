const mongoose = require("mongoose");

const returnsSchema = new mongoose.Schema(
  {
    farmID: { type: String, required: true },
    timestamp: { type: Date, required: true },
    energyGeneratedKilowattHours: { type: Number, required: true },
  },
  {
    timeseries: {
      timeField: "timestamp",
      granularity: "hours",
    },
  }
);

module.exports = mongoose.model("Returns", returnsSchema);
