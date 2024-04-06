const express = require("express");
const { verifyToken } = require("../middlewares/authorization");

const invRouter = express.Router();

const {
  invSignUp,
  invLogin,
  investInFarm,
  fetchPortfolio,
  fetchInvestorDetails,
} = require("../controllers/invControllers");

invRouter.post("/signup", invSignUp);

invRouter.post("/login", invLogin);

invRouter.post("/invest", verifyToken, investInFarm);

invRouter.get("/portfolio", verifyToken, fetchPortfolio);

invRouter.get("/details", verifyToken, fetchInvestorDetails);

module.exports = invRouter;
