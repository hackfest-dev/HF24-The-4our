const express = require("express");
const { verifyToken } = require("../middlewares/authorization");

const orgRouter = express.Router();
const { upload, attachFileLinks } = require("../middlewares/file-upload");

const {
  orgSignUp,
  orgLogin,
  getAllFarmsOfOrganization,
} = require("../controllers/orgControllers");

orgRouter.post("/signup", upload, orgSignUp);

orgRouter.post("/login", orgLogin);

orgRouter.get("/getorgfarms", verifyToken, getAllFarmsOfOrganization);

module.exports = orgRouter;
