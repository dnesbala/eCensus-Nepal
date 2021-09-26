const express = require("express");
const dotenv = require("dotenv");
const mongoose = require("mongoose");

const errorController = require("../backend/controllers/errorController");

const censusRoutes = require("../backend/routes/censusRoutes");
const ganakRoutes = require("./routes/ganakRoutes");

const app = express();

dotenv.config({});

// DATABASE Connection
mongoose
  .connect(process.env.DATABASE_CONNECTION_STRING, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then((conn) => console.log("Connected to DB successfully"))
  .catch((err) => console.log(err));

app.use(express.json());

app.use("/api/v1/census", censusRoutes);
app.use("/api/v1/ganak", ganakRoutes);

app.use(errorController);

// Listening to SERVER
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
