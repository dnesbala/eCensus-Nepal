const mongoose = require("mongoose");

const individualSchema = new mongoose.Schema(
  {
    fullName: {
      type: String,
      required: [true, "Individual should have a full name"],
    },
    relation: {
      type: String,
      required: [true, "Individual should have relation with family head"],
    },
    gender: {
      type: String,
      enum: {
        values: ["male", "female", "others"],
        message:
          "{VALUE} not supported. Gender should be either male, female or others",
      },
    },
    dob: {
      type: Date,
      // required: [true, "DOB is required"],
    },
    age: {
      type: Number,
    },
  },
  {
    timestamps: true,
  }
);

individualSchema.pre("save", function (next) {
  this.age = 2021 - this.dob.getFullYear();
  next();
});

const individualModel = mongoose.model("Individual", individualSchema);

module.exports = individualModel;
