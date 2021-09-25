const Census = require("../models/censusModel");

const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");

exports.getCensusData = catchAsync(async (req, res, next) => {
  const censusData = await Census.find({});

  res.status(200).json({
    status: "success",
    results: censusData.length,
    data: { censusData },
  });
});

exports.createCensusData = catchAsync(async (req, res, next) => {
  await Census.create(req.body);

  res.status(201).json({
    status: "success",
    data: req.body,
  });
});

exports.updateCensusData = catchAsync(async (req, res, next) => {
  const updatedData = await Census.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
  });

  if (!updatedData)
    return next(new AppError("No census data found for the given ID.", 404));

  res.status(200).json({
    status: "success",
    data: updatedData,
  });
});

exports.deleteCensusData = catchAsync(async (req, res, next) => {
  const deletedCensusData = await Census.findByIdAndDelete(req.params.id);

  if (!deletedCensusData)
    return next(new AppError("No census data found for the given ID.", 404));

  res.status(204).json({
    status: "success",
    message: "Census data deleted successfully.",
  });
});
