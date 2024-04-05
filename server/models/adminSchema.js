const mongoose = require("mongoose");

const adminSchema = new mongoose.Schema({
  AID: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
    unique: true,
  },
});
w;
module.exports = mongoose.model("Admins", adminSchema);
