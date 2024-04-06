const express = require("express");

const farmRouter = express.Router();
const { verifyToken } = require("../middlewares/authorization");

const {
  createFarm,
  storeReturnsData,
  storeSyntheticData,
  addNewsToFarm,
} = require("../controllers/farmController");

farmRouter.post("/create", verifyToken, createFarm);

farmRouter.post("/storereturns", storeReturnsData);

farmRouter.post("/storesyntheticreturns", storeSyntheticData);

farmRouter.post("/addnews", addNewsToFarm);

module.exports = farmRouter;
