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
    // console.log('consultations ->', consultations);

    if (consultations.length <= 0) return res.send({ error: 'Nenhuma consulta encontrada' });

    // Retorna todas as consultas
    return res.send({
      consultations
    });
  } catch (error) {
    res.status(400).send({ error: error });
  }
});

router.get("/get_detailed_consultations", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /consultations/get_detailed_consultations - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {
    let consultations = (await execSQL("SELECT consultations.id, description, id_user_client"
      + ", id_user_psychologist, date, status,  default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"));
      let users = (await execSQL("SELECT users.first_name as user_name, users.last_name as user_last_name, users.email as user_email, users.id as user_id"
        + " FROM consultations"
        + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
        + " INNER JOIN users ON users.id=consultations.id_user_client"));
        consultations = consultations.map((item, index) => {
          item.user = users[index];
          return item;
        })

    return res.send({ consultations })

  } catch (error) {
    console.log({ error });
    return res.status(400).send({ error })
  }
});


router.post("/schedule", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /consultations/schedule - consultations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { id_user_client, psychologist, date, id_default_time } = req.body;
    console.log({ id_default_time })

    if (!id_user_client || !psychologist || !date || !id_default_time) return res.status(400).send({ error: "Id user client, psychologist, date or id_default_time not provided", error_code: "001" });

    let id_user_psychologist = psychologist.id;
    let now = new Date();

    let new_consultation = await execSQL("INSERT INTO consultations (id_user_client, id_user_psychologist, date, status, updated_at, id_default_time, channel_name) VALUES ('" + id_user_client + "', '" + id_user_psychologist + "', '" + date + "', 'scheduled', '" + now + "', '" + id_default_time + "', '"+ _generateHash() + "' )");

    if (!new_consultation) return res.send({ error: "Não foi possível agendar a consulta" });

    new_consultation = (await execSQL("SELECT consultations.id, channel_name, description, id_user_client"
      + ", id_user_psychologist, date, status,  default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"
      + " WHERE consultations.id='" + new_consultation.insertId + "' "))[0];

    let credits = await execSQL("SELECT consultations_credits FROM users WHERE id='" + id_user_client + "' ");
    credits = parseInt(credits[0].consultations_credits);
    credits = credits - 1;
    let new_credits = await execSQL("UPDATE users SET consultations_credits='" + (credits) + "' WHERE id= '" + id_user_client + "' ");

    let scheduled_consultations = (await execSQL("SELECT consultations.id, channel_name, description, id_user_client"
      + ", id_user_psychologist, date, status,  default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"
      + " WHERE consultations.id_user_client='" + id_user_client + "'  AND consultations.status='scheduled' "));

    scheduled_consultations = scheduled_consultations.map(c => {
      c.type = "consultation";
      c.temp_date = c.date.split("/");
      c.temp_hour = c.initial_hour.split(":");
      c.next_appointments = new Date(c.temp_date[2], c.temp_date[1], c.temp_date[0], c.temp_hour[0], c.temp_hour[1]);
      return c
    })
    // scheduled_consultations = scheduled_consultations.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()

    scheduled_consultations = scheduled_consultations.sort((a, b) => new Date(b.temp_date[2], b.temp_date[1], b.temp_date[0]) - new Date(a.temp_date[2], a.temp_date[1], a.temp_date[0])).reverse()

    return res.send({ scheduled_consultations, consultations_credits: credits, last_consultations_scheduled: new_consultation });

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

    if (!new_consultation) return res.send({ error: "Não foi possível cancelar a consulta", error_code: "002" });

    let canceled = await execSQL("INSERT INTO cancellations (id_user_client, id_consultation, text) VALUES ('" + consultation.id_user_client + "', '" + consultation.id + "', '" + consultation.text + "')");


    let credits = await execSQL("SELECT consultations_credits FROM users WHERE id='" + consultation.id_user_client + "' ");
    credits = parseInt(credits[0].consultations_credits);
    credits = credits + 1;
    let new_credits = await execSQL("UPDATE users SET consultations_credits='" + (credits) + "' WHERE id= '" + consultation.id_user_client + "' ");

    let scheduled_consultations = (await execSQL("SELECT consultations.id, description, id_user_client"
      + ", id_user_psychologist, date, status,  default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"
      + " WHERE consultations.id_user_client='" + consultation.id_user_client + "'  AND consultations.status='scheduled' "));

    scheduled_consultations = scheduled_consultations.map(c => {
      c.type = "consultation";
      c.temp_date = c.date.split("/");
      c.temp_hour = c.initial_hour.split(":");
      c.next_appointments = new Date(c.temp_date[2], c.temp_date[1], c.temp_date[0], c.temp_hour[0], c.temp_hour[1]);
      return c
    })
    // scheduled_consultations = scheduled_consultations.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()
    scheduled_consultations = scheduled_consultations.sort((a, b) => new Date(b.temp_date[2], b.temp_date[1], b.temp_date[0]) - new Date(a.temp_date[2], a.temp_date[1], a.temp_date[0])).reverse()

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

    if (!user_id) return res.status(400).send({ error: "user_id not provided", error_code: "001" });

    // let consultations = await execSQL("SELECT * FROM consultations INNER JOIN default_times ON default_times.id=consultations.id_default_time WHERE id_user_client = '" + user.id + "'");

    let consultations = (await execSQL("SELECT consultations.id, channel_name, description, id_user_client"
      + ", id_user_psychologist, date, status, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"
      + " WHERE consultations.id_user_client='" + user_id + "'"));
    if (!consultations) return res.status(400).send({ error: "Não foi possível encontrar as consultas", error_code: "002" });
    console.log({ consultations })

    consultations = consultations.map(c => {
      c.type = "consultation";
      c.temp_date = c.date.split("/");
      c.temp_hour = c.initial_hour.split(":");
      c.next_appointments = new Date(c.temp_date[2], c.temp_date[1], c.temp_date[0], c.temp_hour[0], c.temp_hour[1]);
      return c
    })
    // consultations = consultations.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()
    // consultations.map((c, index) => console.log(c.id, index));
    consultations = consultations.sort((a, b) => new Date(b.temp_date[2], b.temp_date[1], b.temp_date[0]) - new Date(a.temp_date[2], a.temp_date[1], a.temp_date[0])).reverse()

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

    let scheduled_consultations = (await execSQL("SELECT consultations.id, channel_name, description, id_user_client"
      + ", id_user_psychologist, date, status,  default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as psychologist_name, users.last_name as psychologist_last_name, users.email as psychologist_email"
      + " FROM consultations"
      + " INNER JOIN default_times ON default_times.id=consultations.id_default_time"
      + " INNER JOIN users ON users.id=consultations.id_user_psychologist"
      + " WHERE consultations.id_user_client='" + user_id + "' AND consultations.status='scheduled' "));
    if (!scheduled_consultations) return res.status(400).send({ error: "Não foi possível encontrar as consultas", error_code: "001" });
    // console.log({ scheduled_consultations })

    scheduled_consultations = scheduled_consultations.map(c => {
      c.type = "consultation";
      c.temp_date = c.date.split("/");
      c.temp_hour = c.initial_hour.split(":");
      c.next_appointments = new Date(c.temp_date[2], c.temp_date[1], c.temp_date[0], c.temp_hour[0], c.temp_hour[1]);
      return c
    })
    // scheduled_consultations = scheduled_consultations.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()
    // scheduled_consultations.map((c, index) => console.log(c.id, c.date, new Date(c.date), index));
    scheduled_consultations = scheduled_consultations.sort((a, b) => new Date(b.temp_date[2], b.temp_date[1], b.temp_date[0]) - new Date(a.temp_date[2], a.temp_date[1], a.temp_date[0])).reverse()

    return res.send({ scheduled_consultations });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "002" });
  }
});


const _generateHash = () =>{
  return Math.random().toString(36).substr(2); 
};


module.exports = (app) => app.use("/consultations", router);
