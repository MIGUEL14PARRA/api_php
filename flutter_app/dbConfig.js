// dbConfig.js

const mysql = require('mysql2');

const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'tu_usuario_mysql',
  password: 'tu_contraseña_mysql',
  database: 'ras'
});

module.exports = pool.promise();
