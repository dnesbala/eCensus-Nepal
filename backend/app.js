const express = require("express");

const app = express();

app.listen(3000, () => console.log("Listening to the server"));

app.get("/", (req, res) => res.send("Welcome to homepage"));
