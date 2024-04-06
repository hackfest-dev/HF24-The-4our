const express = require("express");

const adminRouter = express.Router();
const { verifyToken } = require("../middlewares/authorization");

const {
  getUnapprovedFarms,
  approveFarm,
  approveKYC,
  getNonKYCInvestors,
} = require("../controllers/adminControllers");

adminRouter.post("/approvefarm", approveFarm);

adminRouter.get("/getunapproved", getUnapprovedFarms);

adminRouter.get("/approvekyc", approveKYC);

adminRouter.get("/getnonkyc", getNonKYCInvestors);

module.exports = adminRouter;
