const express = require('express');
const cors = require('cors');
require('dotenv').config();

const { createClient } = require('@supabase/supabase-js');

const app = express();

// ==============================
// 🔥 DEBUG MIDDLEWARE
// ==============================
app.use((req, res, next) => {
  console.log("REQUEST:", req.method, req.url);
  next();
});

// ==============================
// 🔥 CORS CONFIG
// ==============================
app.use(cors({
  origin: '*',
  methods: ['GET', 'POST', 'OPTIONS'],
  allowedHeaders: ['Content-Type'],
}));

app.options('*', cors());

app.use(express.json());

// ==============================
// SUPABASE CLIENT
// ==============================
const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

// ==============================
// TEST ROUTE
// ==============================
app.get('/', (req, res) => {
  res.send("Server is running 🚀");
});

// ==============================
// HANDLE PREFLIGHT
// ==============================
app.options('/register-business', cors());

// ==============================
// REGISTER BUSINESS (UPDATED)
// ==============================
app.all('/register-business', async (req, res) => {
  try {
    console.log("Incoming data:", req.body);

    // 🔥 FIXED FIELD MAPPING (Flutter → Backend)
    const {
      business_name: name,
      ntn,
      business_type: type,
      address,
      city,
      phone
    } = req.body;

    // ==============================
    // 🔍 STEP 1: CHECK DUPLICATE NAME
    // ==============================
    const { data: existing, error: checkError } = await supabase
      .from('businesses')
      .select('id')
      .ilike('name', name);

    if (checkError) {
      console.error("Check error:", checkError);
      return res.status(400).json({ error: checkError.message });
    }

    // ==============================
    // ⚠️ STEP 2: REQUIRE NTN IF DUPLICATE
    // ==============================
    if (existing.length > 0 && (!ntn || ntn.trim() === "")) {
      return res.json({
        duplicate: true,
        message: "Business exists with same name. Please enter NTN for unique identification."
      });
    }

    // ==============================
    // ✅ STEP 3: INSERT BUSINESS
    // ==============================
    const { data, error } = await supabase
      .from('businesses')
      .insert([
        {
          name,
          ntn,
          type,
          address,
          city,
          phone
        }
      ])
      .select();

    if (error) {
      console.error("Insert error:", error);
      return res.status(400).json({ error: error.message });
    }

    // ==============================
    // ✅ SUCCESS RESPONSE
    // ==============================
    res.json({
      message: "Business registered successfully",
      data
    });

  } catch (err) {
    console.error("Server error:", err);
    res.status(500).json({ error: err.message });
  }
});

// ==============================
// START SERVER
// ==============================
app.listen(5000, '0.0.0.0', () => {
  console.log("Server running on port 5000");
});