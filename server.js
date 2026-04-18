require('dotenv').config();
const express = require('express');
const cors = require('cors');
const pool = require('./db');

const app = express();

// ==============================
// ✅ CORS CONFIG (VERY IMPORTANT)
// ==============================
app.use(cors({
  origin: '*', // allow all (for development)
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type']
}));

// ==============================
// ✅ MIDDLEWARE
// ==============================
app.use(express.json());

// ==============================
// ✅ TEST ROUTE
// ==============================
app.get('/', (req, res) => {
  res.send('Backend is running 🚀');
});

// ==============================
// ✅ TEST DATABASE CONNECTION
// ==============================
app.get('/test-db', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()');
    res.json({
      status: "success",
      time: result.rows[0]
    });
  } catch (err) {
    console.error("DB Error:", err.message);
    res.status(500).json({ error: err.message });
  }
});

// ==============================
// ✅ CREATE BUSINESS API
// ==============================
app.post('/api/business/create', async (req, res) => {
  try {
    console.log("Incoming request:", req.body); // 🔥 DEBUG LOG

    const { business_name, ntn, business_type, address, city, phone } = req.body;

    // Basic validation
    if (!business_name || !ntn || !business_type || !address || !city || !phone) {
      return res.status(400).json({
        status: "error",
        message: "All fields are required"
      });
    }

    const result = await pool.query(
      `INSERT INTO businesses 
      (business_name, ntn, business_type, address, city, phone) 
      VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
      [business_name, ntn, business_type, address, city, phone]
    );

    console.log("Inserted:", result.rows[0]);

    res.json({
      status: "success",
      business: result.rows[0]
    });

  } catch (err) {
    console.error("API Error:", err.message);

    res.status(500).json({
      status: "error",
      message: err.message
    });
  }
});

// ==============================
// ✅ START SERVER
// ==============================
const PORT = 5000;

app.listen(PORT, () => {
  console.log("DB URL:", process.env.DATABASE_URL);
});