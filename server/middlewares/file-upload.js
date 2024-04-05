const multer = require("multer");
const path = require("path");

// Set storage engine
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    let folderName = "organisation-official-docs"; // Default folder name

    // Check the route path to determine the folder name
    if (req.originalUrl.includes("/org/signup")) {
      folderName = "org-official-docs";
    } else if (req.originalUrl.includes("/investor/signup")) {
      folderName = "investor-official-docs";
    }

    // Set the destination folder for uploads
    cb(null, `./uploads/${folderName}/`);
  },
  filename: function (req, file, cb) {
    // Set unique filename
    cb(null, Date.now() + "-" + file.originalname);
  },
});
// Initiate multer middleware
const upload = multer({
  storage: storage,
  limits: { fileSize: 100000000 }, // Set file size limit (100MB in this case)
  fileFilter: function (req, file, cb) {
    checkFileType(file, cb);
  },
}).array("files", 10); // Allow up to 5 files to be uploaded with field name 'docs'

// Check file type
function checkFileType(file, cb) {
  // Allowed extensions
  const filetypes = /jpeg|jpg|png|pdf/;
  // Check the extension
  const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
  // Check MIME type
  const mimetype = filetypes.test(file.mimetype);

  if (mimetype && extname) {
    return cb(null, true); // File type is allowed
  } else {
    cb("Error: Only images and pdf files are allowed!");
  }
}

// Middleware function to attach array of file links to req.docsLinks
const attachFileLinks = (req, res, next) => {
  const folderName = req.folderName; // Set the default folder name
  req.body.docsLinks = req.files.map((file) => ({
    filename: file.filename,
    url: `${process.env.SERVER_URL}uploads/${folderName}/${file.filename}`,
  }));
  next();
};

module.exports = { upload, attachFileLinks };
