const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');

// import express from "express";
// import chalk from 'chalk';
// import User from "../models/user.model";
// import { execSQL } from '../database';
// import { Adress } from "models/adress.model";

const router = express.Router();

router.get("/", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /consultations/ - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let consultations = await execSQL('SELECT * FROM consultations');
    // let consultations = await execSQL("SELECT consultations.id, consultations.name, consultations.email, user_types.title as user_type, signatures.status as signature_status, signatures.expiration_date as signature_expiration_date FROM consultations INNER JOIN user_types ON consultations.id_type = user_types.id INNER JOIN signatures ON consultations.id_signature = signatures.id");

    console.log(chalk.bgBlue('QUERY AT ', new Date()));
    console.log('consultations ->', consultations);

    if (consultations.length <= 0) return res.send({ error: 'Nenhuma consulta encontrada' });

    // Retorna todas as consultas
    return res.send({
      consultations
    });
  } catch (error) {
    res.status(400).send({ error: error });
  }
});


router.post("/schedule", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /consultations/schedule - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let consultation = req.body.consultation;
    let now = new Date();

    let new_consultation = await execSQL("INSERT INTO consultations (description, id_user_client, id_user_psychologist, date, status, updated_at) VALUES ('" + consultation.description + "', '" + consultation.id_user_client + "', '" + consultation.id_user_psychologist + "', '" + now + "', 'scheduled', '" + now + "')");

    if (!new_consultation) return res.send({ error: "Não foi possível agendar a consulta" });
    consultation.id = new_consultation.insertId;

    return res.send({ consultation });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error });
  }
});


router.post("/cancel", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /consultations/cancel - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let consultation = req.body.consultation;
    let now = new Date();

    let new_consultation = await execSQL("UPDATE consultations SET description='" + consultation.description + "', status='canceled', updated_at='" + now + "' WHERE id='" + consultation.id + "'");

    if (!new_consultation) return res.send({ error: "Não foi possível cancelar a consulta" });

    return res.send({ consultation });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error });
  }
});

router.post("/get_by_id_user_client", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /consultations/get_by_id_user_client - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let user = req.body.user;

    let consultations = await execSQL("SELECT * FROM consultations WHERE id_user_client = '" + user.id + "'");

    if (!consultations) return res.status(400).send({ error: "Não foi possível encontrar as consultas" });

    return res.send({ consultations });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error });
  }
});



module.exports = (app) => app.use("/consultations", router);
