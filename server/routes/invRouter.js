const express = require("express");

const invRouter = express.Router();

const {
  invSignUp,
  invLogin,
  investInFarm,
} = require("../controllers/invControllers");

invRouter.post("/signup", invSignUp);

invRouter.post("/login", invLogin);

invRouter.post("/invest", investInFarm);

module.exports = invRouter;
