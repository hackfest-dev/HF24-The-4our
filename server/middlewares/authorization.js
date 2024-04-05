const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");

// Generate JWT token
const generateToken = (payload) => {
  return jwt.sign(payload, process.env.JWT_SECRET);
};

// Verify JWT token
const verifyToken = (req, res, next) => {
  // Extract token from request headers, query parameters, or cookies
  const token = req.headers.authorization.split(" ")[1];

  // Check if token exists
  if (!token) {
    return res.status(401).json({ error: "Unauthorized" });
  }

  try {
    // Verify the token
    const decodedToken = jwt.verify(token, process.env.JWT_SECRET);

    // Check the token type
    if (decodedToken.type === "investor") {
      // If token type is investor, add aadharNumber to req.body
      req.body.aadharNumber = decodedToken.aadharNumber;
    } else if (decodedToken.type === "org") {
      // If token type is org, add orgID to req.body
      req.body.orgID = decodedToken.orgID;
    }

    // Call next middleware
    next();
  } catch (error) {
    // Token verification failed
    return res.status(401).json({ error: "Unauthorized" });
  }
};

// Hash password
const hashPassword = async (password) => {
  const salt = await bcrypt.genSalt(10);
  return bcrypt.hash(password, salt);
};

// Compare password with hash
const comparePassword = async (password, hash) => {
  return bcrypt.compare(password, hash);
};

const authorize = (roles) => {
  return (req, res, next) => {
    const { role } = req.user;

    if (!roles.includes(role)) {
      return res.status(403).json({ error: "Forbidden" });
    }
    next();
  };
};

module.exports = {
  generateToken,
  verifyToken,
  hashPassword,
  comparePassword,
  authorize,
};
