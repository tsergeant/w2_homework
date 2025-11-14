import express from "express";
import routes from "./routes/index.js";
const app = express();

app.use(express.static("public")); // serve HTML/CSS
app.use("/", routes);  // register routes

app.listen(3001, () => {
  console.log("Server running on http://localhost:3001");
});
