const mongoose = require("mongoose");

const orgSchema = new mongoose.Schema({
  orgID: {
    type: String,
    unique: true,
    required: true,
  },
  orgName: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    unique: true,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  phoneNumber: {
    type: String,
    unique: true,
    required: true,
  },
  permanentAddress: {
    type: String,
    required: true,
  },
  regNumber: {
    type: String,
    unique: true,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  marketCap: {
    type: Number,
    required: true,
  },
  adminApproval: {
    type: Boolean,
  },
  docsLinks: {
    type: Array,
    required: false,
  },
});

module.exports = mongoose.model("Organisations", orgSchema);
