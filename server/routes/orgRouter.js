const express = require("express");

const orgRouter = express.Router();
const { upload, attachFileLinks } = require("../middlewares/file-upload");

const { orgSignUp, orgLogin } = require("../controllers/orgControllers");

orgRouter.post("/signup", upload, attachFileLinks, orgSignUp);

orgRouter.post("/login", orgLogin);

module.exports = orgRouter;
