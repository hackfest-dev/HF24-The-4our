const express = require("express");

const fetchRouter = express.Router();

const {
  fetchAllOrgs,
  fetchAllFarms,
  fetchFarmReturns,
  getFarmWithOrganisation,
} = require("../controllers/fetchController");

fetchRouter.get("/getallorgs", fetchAllOrgs);

fetchRouter.get("/getallfarms", fetchAllFarms);

fetchRouter.get("/:farmID/returns", fetchFarmReturns);

fetchRouter.get("/farm/:farmId", getFarmWithOrganisation);

module.exports = fetchRouter;
