const mongoose = require("mongoose");

const ganakSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "User should have a name"],
    },
    email: {
      type: String,
      trim: true,
      unique: true,
    },
    password: {
      type: String,
      required: [true, "User should have a password"],
      minLength: [8, "Password should be atleast 8 characters long"],
    },
  },
  {
    timestamps: true,
  }
);

const ganakModel = mongoose.model("Ganak", ganakSchema);

module.exports = ganakModel;
