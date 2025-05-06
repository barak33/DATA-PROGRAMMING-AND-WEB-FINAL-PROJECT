# DATA-PROGRAMMING-AND-WEB-FINAL-PROJECT

Question 1: Build a Complete Database Management System
Objective:
Design and implement a full-featured database using only MySQL.

Clinical Booking System Database

Create a well-structured relational database using SQL.

Use SQL to create:

Tables with proper constraints (PK, FK, NOT NULL, UNIQUE)

Relationships (1-1, 1-M, M-M where needed)



Question 2: Create a Simple CRUD API Using MySQL + Programming

Objective:
Combine your MySQL skills with JavaScript to create a working CRUD API.

What to do:

Created a Student's Portal API

Design your database schema in MySQL (at least 2–3 tables)

Build an API using:

Node.js + Express (if using JavaScript)


Implement all CRUD operations (Create, Read, Update, Delete)

Connect your API to the MySQL database

To connect your API to a MySQL database, follow these steps using Node.js and Express:

1. Install MySQL driver for Node.js
Run the following command to install MySQL's Node.js package:

sh
npm install mysql2 dotenv
2. Create a .env File for Database Credentials
Store database connection details securely:

env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=StudentPortal
3. Create a db.js File for the Database Connection
This file establishes a connection to MySQL using mysql2:

js
const mysql = require('mysql2');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

// Use promise-based queries
module.exports = pool.promise();
4. Use the Connection in Your API
Import the db.js file into your API and perform database queries:

js
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const db = require('./db');  // Import the database connection

const app = express();
app.use(bodyParser.json());
app.use(cors());

const PORT = process.env.PORT || 5000;

/* --- CRUD Operations --- */

// Get all students
app.get('/students', async (req, res) => {
    const [rows] = await db.query('SELECT * FROM Students');
    res.json(rows);
});

// Add a new student
app.post('/students', async (req, res) => {
    const { name, email, age } = req.body;
    await db.query('INSERT INTO Students (name, email, age) VALUES (?, ?, ?)', [name, email, age]);
    res.json({ message: "Student added successfully" });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
5. Run the API
Start your MySQL server.

Run the API:

sh
node index.js
Test the endpoints using Postman or Curl.

