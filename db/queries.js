const { Pool } = require('pg');
require('dotenv').config();

// ✅ Configuración mejorada: usa variables de entorno con fallbacks
const pool = new Pool({
  user: process.env.DB_USER || 'ebot_user',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'ebot',
  password: process.env.DB_PASSWORD || 'ebot_password',
  port: process.env.DB_PORT || 5432
});

// Manejo de errores de conexión
pool.on('error', (err) => {
  console.error('❌ Error inesperado en el cliente de PostgreSQL:', err);
  process.exit(-1);
});

// Verificar conexión al inicio
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('❌ No se pudo conectar a PostgreSQL:', err.message);
    console.error('📋 Verifica tu configuración en .env');
  } else {
    console.log('✅ Conectado a PostgreSQL exitosamente');
  }
});

const getUsers = (request, response) => {
  pool.query('SELECT * FROM users ORDER BY id ASC', (error, results) => {
    if (error) {
      console.error('Error al obtener usuarios:', error);
      return response.status(500).json({ error: 'Error al obtener usuarios' });
    }
    response.status(200).json(results.rows);
  });
};

const getUserById = (request, response) => {
  const id = parseInt(request.params.id);

  pool.query('SELECT * FROM users WHERE id = $1', [id], (error, results) => {
    if (error) {
      console.error('Error al obtener usuario:', error);
      return response.status(500).json({ error: 'Error al obtener usuario' });
    }
    response.status(200).json(results.rows);
  });
};

const getUserByUsername = (request, response) => {
  pool.query('SELECT * FROM users WHERE username = $1', [request.params.username], (error, results) => {
    if (error) {
      console.error('Error al obtener usuario:', error);
      return response.status(500).json({ error: 'Error al obtener usuario' });
    }
    response.status(200).json(results.rows);
  });
};

const createUser = (request, response) => {
  const {
    firstname,
    lastname,
    email,
    password_,
    username
  } = request.body;

  pool.query(`INSERT INTO users 
    (firstname, lastname, email, password_, username)
    VALUES ($1, $2, $3, $4, $5)`, [firstname, lastname, email, password_, username], (error, results) => {
    if (error) {
      console.error('Error al crear usuario:', error);
      return response.status(500).json({ error: 'Error al crear usuario' });
    }
    response.cookie('ebot-user', JSON.stringify({
      firstname,
      lastname,
      email,
      password_,
      username
    }), { maxAge: 900000 });
    response.status(201).send({
      message: 'Usuario creado exitosamente',
      body: {
        firstname,
        lastname,
        email,
        username
      }
    });
  });
};

const updateUser = (request, response) => {
  const id = parseInt(request.params.id);
  const { firstname, lastname, email, password_, username } = request.body;

  pool.query(`UPDATE users
    SET firstname = $1, lastname = $2, email = $3, password_ = $4, username = $5 WHERE id = $6`,
    [firstname, lastname, email, password_, username, id],
    (error, results) => {
      if (error) {
        console.error('Error al actualizar usuario:', error);
        return response.status(500).json({ error: 'Error al actualizar usuario' });
      }
      response.status(200).send(`Usuario modificado con ID: ${id}`);
    }
  );
};

const getProducts = (request, response) => {
  pool.query('SELECT * FROM products ORDER BY id ASC', (error, results) => {
    if (error) {
      console.error('Error al obtener productos:', error);
      return response.status(500).json({ error: 'Error al obtener productos' });
    }
    response.status(200).json(results.rows);
  });
};

module.exports = {
  getUsers,
  getUserById,
  getUserByUsername,
  createUser,
  updateUser,
  getProducts
};