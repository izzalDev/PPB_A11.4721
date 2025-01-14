import express from "express";
import { PrismaClient } from "@prisma/client";
import cors from 'cors';

const app = express();
const prisma = new PrismaClient();
const port = process.env.PORT || 3000;

app.use(express.json());
app.use(cors());

// Get all notes
app.get("/notes", async (req, res) => {
  try {
    const notes = await prisma.note.findMany();
    res.status(200).json({ data: notes });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "Internal server error." });
  }
});

// Get a specific note by ID
app.get("/notes/:id", async (req, res) => {
  try {
    const noteId = parseInt(req.params.id);
    const note = await prisma.note.findUnique({
      where: { id: noteId },
    });
    if (note) {
      res.status(200).json({ data: note });
    } else {
      res.status(404).json({ error: "Note not found." });
    }
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "Internal server error." });
  }
});

// Create a new note
app.post("/notes", async (req, res) => {
  console.log(req.body)
  try {
    const noteData = { ...req.body, date: new Date() };
    const note = await prisma.note.create({
      data: noteData,
    });
    res.status(201).json({ data: note });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "Internal server error." });
  }
});

// Update an existing note
app.put("/notes/:id", async (req, res) => {
  try {
    const noteId = parseInt(req.params.id);
    const noteData = req.body;
    const note = await prisma.note.update({
      where: { id: noteId },
      data: noteData,
    });
    res.status(200).json({ data: note });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "Internal server error." });
  }
});

// Delete a note
app.delete("/notes/:id", async (req, res) => {
  try {
    const noteId = parseInt(req.params.id);
    const note = await prisma.note.delete({
      where: { id: noteId },
    });
    res.status(200).json({ data: note });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "Internal server error." });
  }
});

// Start server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
