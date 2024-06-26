const express = require('express');
const mysql = require('mysql2/promise'); // Incluye 'promise' para usar async/await
const app = express();

// Configuración de la conexión a MySQL
const pool = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'tu_usuario_mysql',
    password: 'tu_contraseña_mysql',
    database: 'ras'
});

// Ruta para obtener especies de anfibios
app.get('/api/especies/anfibios', async (req, res) => {
    try {
        const connection = await pool.getConnection();
        const [rows, fields] = await connection.query('SELECT * FROM anfibios');
        connection.release();
        res.json(rows);
    } catch (error) {
        console.error('Error al obtener especies de anfibios:', error);
        res.status(500).json({ error: 'Error al obtener especies de anfibios' });
    }
});

// Escuchar en un puerto
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor en ejecución en el puerto ${PORT}`);
});
