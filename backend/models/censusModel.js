const mongoose = require("mongoose");

const censusSchema = new mongoose.Schema(
  {
    // Introductory Part
    province: {
      type: String,
      required: [true, "Province is required"],
    },
    district: {
      type: String,
      required: [true, "District is required"],
    },
    municipality: {
      type: String,
      required: [true, "Municipality/VDC is required"],
    },
    wardNo: {
      type: Number,
      required: [true, "Ward no is required"],
    },
    tole: {
      type: String,
      required: [true, "Tole is required"],
    },
    familyHeadName: {
      type: String,
      required: [true, "Family head name is required"],
    },
    familyHeadContact: {
      type: Number,
      required: [true, "Family head contact is required"],
      unique: true,
    },

    // Family Part
    ownHouse: {
      type: String,
      enum: {
        values: ["own", "rent", "organizational", "other"],
        message:
          "{VALUE} not supported. OwnHouse should be either own, rent, organizational or other only",
      },
      default: "other",
    },
    baseHouseMade: {
      type: String,
      enum: {
        values: ["mud", "concretePillar", "metalframe", "wood", "other"],
        message:
          "{VALUE} not supported. baseHouseMade should be either mud, concretePillar, metalframe, wood or other only",
      },
    },
    drinkingWaterSource: {
      type: String,
      enum: {
        values: ["tap", "well", "jar", "river", "other"],
        message:
          "{VALUE} not supported. drinkingWaterSource should be either tap, well, jar, river or other only",
      },
    },
    foodHeatSource: {
      type: String,
      enum: {
        values: ["gas", "electricAppliances", "wood", "other"],
        message:
          "{VALUE} not supported. foodHeatSource should be either gas, electric appliances, wood or other only",
      },
    },
    lightSource: {
      type: String,
      enum: {
        values: ["electricity", "kerosene", "biogas", "solar", "other"],
        message:
          "{VALUE} not supported. lightSource should be either electricity, kerosene, biogas, solar or other only",
      },
    },
    householdFacilitiesEquipments: {
      type: [String],
    },

    //Death Part
    isDeathWithinPast12Months: {
      type: Boolean,
      required: [true, "isDeath record is required"],
    },
    noOfDeaths: {
      type: Number,
    },
    deathPersons: {
      type: [String],
    },

    // Absence Part
    isPersonAbroad: {
      type: String,
      enum: {
        values: ["yes", "no", "don't know"],
        message:
          "{VALUE} not supported. isAbroad should be either yes, no or dont know",
      },
    },
    abroadPersons: {
      type: [String],
    },

    // Individual Part
    individualDetail: [
      {
        type: mongoose.Schema.ObjectId,
        ref: "Individual",
      },
    ],

    // collectedBy: {
    //   type: mongoose.Schema.ObjectId,
    //   ref: "Ganak",
    // },
  },
  {
    timestamps: true,
  }
);

censusSchema.pre(/^find/, function (next) {
  this.populate({
    path: "collectedBy",
  });
  next();
});

const censusModel = mongoose.model("Census", censusSchema);

module.exports = censusModel;
