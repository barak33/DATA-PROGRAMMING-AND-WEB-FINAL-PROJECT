// Description: This code sets up a simple Express.js server with CRUD operations for managing student records in a MySQL database.
// db.js
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./db');

const app = express();
app.use(bodyParser.json());
app.use(cors());

const PORT = process.env.PORT || 5000;

/* --- CRUD Operations --- */

// 1. Get all students
app.get('/students', async (req, res) => {
    const [rows] = await db.query('SELECT * FROM Students');
    res.json(rows);
});

// 2. Get a specific student by ID
app.get('/students/:id', async (req, res) => {
    const [rows] = await db.query('SELECT * FROM Students WHERE student_id = ?', [req.params.id]);
    res.json(rows[0] || { message: "Student not found" });
});

// 3. Add a student
app.post('/students', async (req, res) => {
    const { name, email, age } = req.body;
    await db.query('INSERT INTO Students (name, email, age) VALUES (?, ?, ?)', [name, email, age]);
    res.json({ message: "Student added successfully" });
});

// 4. Update student details
app.put('/students/:id', async (req, res) => {
    const { name, email, age } = req.body;
    await db.query('UPDATE Students SET name = ?, email = ?, age = ? WHERE student_id = ?', [name, email, age, req.params.id]);
    res.json({ message: "Student updated successfully" });
});

// 5. Delete a student
app.delete('/students/:id', async (req, res) => {
    await db.query('DELETE FROM Students WHERE student_id = ?', [req.params.id]);
    res.json({ message: "Student deleted successfully" });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
