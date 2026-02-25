const express = require('express');
const cors = require('cors');
const path = require('path');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// Busca esta sección y déjala así:
const credentials = {
  license: {
    username: process.env.LICENSE_USERNAME || 'validfmf',
    password: process.env.LICENSE_PASSWORD || 'PMfmf2026#$'
  },
  constancy: {
    username: process.env.CONSTANCY_USER || 'Constfmf', // Cambiado a USER
    password: process.env.CONSTANCY_PASS || 'PMC0nst#2026#' // Cambiado a PASS
  }
};

const validIDs = {
  license: process.env.LICENSE_KEY_MAIN || 'A9F3K7M2Q8R5LZ4X6B1', // Cambiado a LICENSE_KEY_MAIN
  constancy: [
    process.env.VALID_CONSTANCY_ID_1 || 'C7A9M2FQ',
    process.env.VALID_CONSTANCY_ID_2 || '9KX4B7L2'
  ]
};

// Nombres asociados a IDs de Constancy
const constancyNames = {
  'C7A9M2FQ': 'Bernardo González Romero',
  '9KX4B7L2': 'Aldo Vergara Ortiz'
};

// Endpoint de login
app.post('/api/login', (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ 
      success: false, 
      error: 'Username and password are required' 
    });
  }

  let userType = null;

  // Verificar credenciales de licencia
  if (username === credentials.license.username && password === credentials.license.password) {
    userType = 'license';
  }
  // Verificar credenciales de constancy
  else if (username === credentials.constancy.username && password === credentials.constancy.password) {
    userType = 'constancy';
  }

  if (userType) {
    // Generar un token simple (en producción usar JWT)
    const token = Buffer.from(`${userType}-${Date.now()}`).toString('base64');
    return res.json({ 
      success: true, 
      userType: userType,
      token: token
    });
  }

  res.status(401).json({ 
    success: false, 
    error: 'Invalid credentials' 
  });
});

// Endpoint para validar License ID
app.post('/api/validate-license', (req, res) => {
  const { licenseId } = req.body;

  if (!licenseId) {
    return res.status(400).json({ 
      success: false, 
      error: 'License ID is required' 
    });
  }

  if (licenseId.toUpperCase() === validIDs.license) {
    return res.json({ 
      success: true, 
      message: 'License is valid',
      details: {
        status: '✓ License Successfully Verified',
        timestamp: new Date().toISOString()
      }
    });
  }

  res.status(401).json({ 
    success: false, 
    error: 'Invalid License ID' 
  });
});

// Endpoint para validar Constancy ID
app.post('/api/validate-constancy', (req, res) => {
  const { constancyId } = req.body;

  if (!constancyId) {
    return res.status(400).json({ 
      success: false, 
      error: 'Constancy ID is required' 
    });
  }

  const id = constancyId.toUpperCase();
  
  if (validIDs.constancy.includes(id)) {
    return res.json({ 
      success: true, 
      message: 'Constancy is valid',
      details: {
        name: constancyNames[id],
        status: '✓ Constancy Successfully Verified',
        timestamp: new Date().toISOString()
      }
    });
  }

  res.status(401).json({ 
    success: false, 
    error: 'Invalid Constancy ID' 
  });
});

// Manejo de errores
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ 
    success: false, 
    error: 'Internal server error' 
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor ejecutándose en puerto ${PORT}`);
});
module.exports = app;