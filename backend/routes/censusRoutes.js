const express = require("express");

const router = express.Router();

const censusController = require("../controllers/censusController");

router
  .route("/")
  .get(censusController.getCensusData)
  .post(censusController.createCensusData);

router
  .route("/:id")
  .patch(censusController.updateCensusData)
  .delete(censusController.deleteCensusData);

module.exports = router;
