const mysql = require('mysql2');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'Tech@Weezy777',
    database: process.env.DB_NAME || 'student_portal',
    waitForConnections: true,
});

module.exports = pool.promise();
