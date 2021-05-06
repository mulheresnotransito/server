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


// router.post("/cancel", async (req, res) => {
//   console.log(chalk.bgMagenta('[ post /consultations/cancel - consultations.controller ]'));
//   console.log(chalk.magenta(JSON.stringify(req.body)));

//   try {

//     let consultation = req.body.consultation;
//     let now = new Date();

//     let new_consultation = await execSQL("UPDATE consultations SET description='" + consultation.description + "', status='canceled', updated_at='" + now + "' WHERE id='" + consultation.id + "'");

//     if (!new_consultation) return res.send({ error: "Não foi possível cancelar a consulta" });

//     return res.send({ consultation });

//   } catch (error) {
//     console.log({ error })
//     res.status(400).send({ error: error });
//   }
// });

router.post("/cancel", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /consultations/cancel - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let consultation = req.body.consultation;
    if (!consultation.id || !consultation.id_user_client || !consultation.text) return res.status(400).send({ error: "consultation id, id_user_client or text not provided." });

    let new_consultation = await execSQL("SELECT status FROM consultations WHERE id= '" + consultation.id + "' ");
    let status = new_consultation[0].status;
    if (status == "canceled") return res.status(400).send({ error: "Consulta já cancelada anteriormente.", error_code: "001" });

    let now = new Date();

    new_consultation = await execSQL("UPDATE consultations SET status='canceled', updated_at='" + now + "' WHERE id='" + consultation.id + "'");
    let credits = await execSQL("SELECT consultations_credits FROM users WHERE id='" + consultation.id_user_client + "' ");
    credits = parseInt(credits[0].consultations_credits);
    credits = credits + 1;
    let new_credits = await execSQL("UPDATE users SET consultations_credits='" + (credits) + "' WHERE id= '" + consultation.id_user_client + "' ");

    if (!new_consultation) return res.send({ error: "Não foi possível cancelar a consulta", error_code: "002" });

    let canceled = await execSQL("INSERT INTO cancellations (id_user_client, id_consultation, text) VALUES ('" + consultation.id_user_client + "', '" + consultation.id + "', '" + consultation.text + "')");

    let scheduled_consultations = (await execSQL("SELECT consultations.id, description, id_user_client"
      + ", id_user_psychologist, date, status,  default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"
      + " WHERE consultations.id_user_client='" + consultation.id_user_client + "'  AND consultations.status='scheduled' "));

    return res.send({ scheduled_consultations, consultations_credits: credits });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "003" });
  }
});

router.post("/get_all_by_id_user_client", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /consultations/get_all_by_id_user_client - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { user_id } = req.body;

    // let consultations = await execSQL("SELECT * FROM consultations INNER JOIN default_times ON default_times.id=consultations.id_default_time WHERE id_user_client = '" + user.id + "'");

    let consultations = (await execSQL("SELECT consultations.id, description, id_user_client"
      + ", id_user_psychologist, date, status, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"
      + " WHERE consultations.id_user_client='" + user_id + "'"));
    if (!consultations) return res.status(400).send({ error: "Não foi possível encontrar as consultas", error_code: "001" });
    console.log({ consultations })

    return res.send({ consultations });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "002" });
  }
});


router.post("/get_all_scheduled_by_id_user_client", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /consultations/get_all_scheduled_by_id_user_client - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { user_id } = req.body;

    // let consultations = await execSQL("SELECT * FROM consultations INNER JOIN default_times ON default_times.id=consultations.id_default_time WHERE id_user_client = '" + user.id + "'");

    let scheduled_consultations = (await execSQL("SELECT consultations.id, description, id_user_client"
      + ", id_user_psychologist, date, status,  default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"
      + " WHERE consultations.id_user_client='" + user_id + "' AND consultations.status='scheduled' "));
    if (!scheduled_consultations) return res.status(400).send({ error: "Não foi possível encontrar as consultas", error_code: "001" });
    console.log({ scheduled_consultations })

    return res.send({ scheduled_consultations });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "002" });
  }
});




module.exports = (app) => app.use("/consultations", router);
