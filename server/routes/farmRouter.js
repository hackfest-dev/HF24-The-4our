const express = require("express");

const farmRouter = express.Router();

const {
  createFarm,
  storeReturnsData,
  storeSyntheticData,
} = require("../controllers/farmController");

farmRouter.post("/create", createFarm);

farmRouter.post("/storereturns", storeReturnsData);

farmRouter.post("/storesyntheticreturns", storeSyntheticData);

module.exports = farmRouter;
