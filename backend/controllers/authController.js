const jwt = require("jsonwebtoken");

const Ganak = require("../models/ganakModel");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");

const sendToken = (user, res, statusCode) => {
  const token = jwt.sign(
    {
      id: user._id,
    },
    process.env.JWT_SECRET,
    { expiresIn: "30d" }
  );

  const cookieOptions = {
    expiresIn: Date.now() + 30 * 24 * 60 * 60 * 1000,
    httpOnly: true,
  };

  res.cookie("jwt", token, cookieOptions);

  user.password = undefined;

  res.status(statusCode).json({
    status: "success",
    token,
    data: user,
  });
};

exports.login = catchAsync(async (req, res, next) => {
  const { email, password } = req.body;

  if (!email || !password)
    return next(new AppError("Email and password should be provided.", 400));

  const user = await Ganak.findOne({ email });

  if (!user) return next(new AppError("Ganak doesnot exist.", 400));

  if (!(user.password == password))
    return next(new AppError("Either email or password is incorrect.", 400));

  sendToken(user, res, 200);
});

exports.protect = catchAsync(async (req, res, next) => {
  let token;
  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith("Bearer")
  ) {
    token = req.headers.authorization.split(" ")[1];
  }

  if (!token)
    return next(
      new AppError("You are not logged in. Please log in again.", 401)
    );
  const decodedPayload = jwt.verify(token, process.env.JWT_SECRET);

  const user = await Ganak.findById(decodedPayload.id);
  if (!user)
    return next(
      new AppError(
        "The user belonging to the token no longer exists. Please log in again.",
        401
      )
    );

  req.user = user;
  next();
});
