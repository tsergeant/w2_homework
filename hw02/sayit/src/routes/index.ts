import { Router } from "express";
const router = Router();

router.get("/", (req, res) => {
  res.sendFile("index.html", { root: "public" });
});

router.get("/about", (req, res) => {
  res.sendFile("about.html", { root: "public" });
});

export default router;