const express = require("express");

const adminRouter = express.Router();
const { verifyToken } = require("../middlewares/authorization");

const {
  getUnapprovedFarms,
  approveFarm,
  approveKYC,
  getNonKYCInvestors,
  rejectFarm,
} = require("../controllers/adminControllers");

adminRouter.get("/approvefarm/:farmId", approveFarm);

adminRouter.get("/rejectfarm/:farmId", rejectFarm);

adminRouter.get("/getunapproved", getUnapprovedFarms);

adminRouter.get("/approvekyc/:aadharNumber", approveKYC);

adminRouter.get("/getnonkyc", getNonKYCInvestors);

module.exports = adminRouter;
