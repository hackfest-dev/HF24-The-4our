const express = require("express");

const farmRouter = express.Router();
const { verifyToken } = require("../middlewares/authorization");

const {
  createFarm,
  storeReturnsData,
  storeSyntheticData,
} = require("../controllers/farmController");

farmRouter.post("/create", verifyToken, createFarm);

farmRouter.post("/storereturns", storeReturnsData);

farmRouter.post("/storesyntheticreturns", storeSyntheticData);

module.exports = farmRouter;
