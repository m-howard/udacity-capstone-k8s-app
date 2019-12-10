require('dotenv').config();
const express = require('express');
const cors = require('cors');

const PORT = process.env.SERVER_PORT || 8080;
const app = express();

// Use middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors({ origin: '*' }));

// Routes
app.get('/healthcheck', (req, res) => res
  .status(200)
  .json({
    version: require('../package.json').version,
    environment: process.env.NODE_ENV || 'development',
  }));

// Allow cross-domain scripting
app.all('*', (req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'X-Requested-With');
  next();
});

// Start server
const server = app.listen(PORT, () => {
  console.log('Api server started.');
});
exports.http = server;
