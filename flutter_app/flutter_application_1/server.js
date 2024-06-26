const express = require('express');
const express = require('express');
const app = express();

// Aplica el middleware cors a todas las solicitudes
app.use(cors());

// Configuración de CORS con opciones específicas
const corsOptions = {
    origin: 'https://example.com', // Permite solo solicitudes desde este dominio
    methods: 'GET,POST',           // Permite solo los métodos GET y POST
    allowedHeaders: 'Content-Type', // Permite solo el encabezado Content-Type
  };
  
  // Aplica el middleware cors con opciones específicas
  app.use(cors(corsOptions));
