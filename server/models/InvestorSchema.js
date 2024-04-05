const mongoose = require("mongoose");

const investorSchema = new mongoose.Schema({
  name: {
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
  aadharNumber: {
    type: String,
    unique: true,
    required: true,
  },
  panNumber: {
    type: String,
    unique: true,
    required: true,
  },
  dateOfBirth: {
    type: String,
    required: true,
  },
  KYCDone: {
    type: Boolean,
  },
  nomineeDetails: {
    nomineeName: String,
    nomineeAadhar: String,
    dateOfBirth: Date,
  },
});

module.exports = mongoose.model("Investors", investorSchema);
