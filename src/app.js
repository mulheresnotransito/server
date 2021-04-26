const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
const path = require('path');

// import express from 'express';
// import cors from 'cors';
// import * as bodyParser from 'body-parser';
// import dotenv from 'dotenv';

dotenv.config();

const app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

require('./controllers/users.controller')(app);
require('./controllers/consultations.controller')(app);
require('./controllers/lessons.controller')(app);
require('./controllers/credits.controller')(app);
require('./controllers/notices.controller')(app);
require('./controllers/available_times.controller')(app);
require('./controllers/default_times.controller')(app);

let port = process.env.PORT || 3030;

app.get('/', (req, res) => {
  res.send({ error: "File not found..." })
});

app.listen(port, async () => {
  console.log('Server running on port ', port);
});