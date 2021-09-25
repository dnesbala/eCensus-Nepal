const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");

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
    passwordConfirm: {
      type: String,
      required: [true, "User should confirm a password"],
      validate: {
        validator: function (value) {
          return this.password == value;
        },
      },
    },
  },
  {
    timestamps: true,
  }
);

ganakSchema.pre("save", async function (next) {
  this.password = await bcrypt.hash(this.password, 10);
  this.passwordConfirm = undefined;
  next();
});

ganakSchema.methods.correctPassword = async (password, passwordHash) => {
  return await bcrypt.compare(password, passwordHash);
};

const ganakModel = mongoose.model("Ganak", ganakSchema);

module.exports = ganakModel;
