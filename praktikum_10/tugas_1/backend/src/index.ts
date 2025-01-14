import express from "express";
import { Product, PrismaClient } from "@prisma/client";

const app = express();
const prisma = new PrismaClient();
const port = process.env.PORT || 8080;

app.use(express.json());

app.get("/products", async (req, res) => {
  try {
    const products: Product[] = await prisma.product.findMany();
    res.status(200).json({ data: products });
  } catch (e) {
    console.error(e);
    res
      .status(500)
      .json({ error: "Internal server error while fetching products." });
  }
});

app.get("/products/:id", async (req, res) => {
  try {
    const productId: number = parseInt(req.params.id);
    const product = await prisma.product.findUnique({
      where: { id: productId },
    });
    res.status(200).json({ data: product });
  } catch (e) {
    console.error(e);
    res
      .status(500)
      .json({ error: "Internal server error while fetching the product." });
  }
});

app.post("/products", async (req, res) => {
  try {
    const { name, purchasePrice, sellingPrice, stock } = req.body;
    const product: Product = await prisma.product.create({
      data: { name, purchasePrice, sellingPrice, stock, date: new Date() },
    });
    res.status(201).json({ data: product });
  } catch (e) {
    console.error(e);
    res
      .status(500)
      .json({ error: "Internal server error while creating the product." });
  }
});

app.put("/products/:id", async (req, res) => {
  try {
    const productId: number = parseInt(req.params.id);
    const { name, purchasePrice, sellingPrice, stock } = req.body;
    const product: Product = await prisma.product.update({
      where: { id: productId },
      data: { name, purchasePrice, sellingPrice, stock, date: new Date() },
    });
    res.status(200).json({ data: product });
  } catch (e) {
    console.error(e.message);
    res
      .status(500)
      .json({ error: "Internal server error while updating the product." });
  }
});

app.delete("/products/:id", async (req, res) => {
  try {
    const productId: number = parseInt(req.params.id);
    const product: Product = await prisma.product.delete({
      where: { id: productId },
    });
    res.status(200).json({ data: product });
  } catch (e) {
    console.error(e.message);
    res
      .status(500)
      .json({ error: "Internal server error while deleting the product." });
  }
});

app.listen(port, () => {
  console.log(`Server up and running on port: ${port}`);
});
