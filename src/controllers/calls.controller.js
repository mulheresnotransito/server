const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');
const { RtcTokenBuilder, RtcRole } = require('agora-access-token');
const { v4 } = require('uuid');

// import express from "express";
// import chalk from 'chalk';
// import User from "../models/user.model";
// import { execSQL } from '../database';
// import { Adress } from "models/adress.model";

const router = express.Router();

// router.post("/new", async (req, res) => {
//   console.log(chalk.bgMagenta('[ post /calls/new - calls.controller ]'));
//   console.log(chalk.magenta(JSON.stringify(req.body)));
//   try {

//     let call = req.body;

//     let client = await execSQL(`SELECT * FROM users WHERE id = ${call.id_user_client}`);

//     //is returning an array
//     client = client[0];

//     if (!client) return res.status(400).send({ error: 'Id do cliente não existe' });

//     let psychologist = await execSQL(`SELECT * FROM users WHERE id = ${call.id_user_psychologist}`);

//     //is returning an array
//     psychologist = psychologist[0];

//     if (!psychologist) return res.status(400).send({ error: 'Id do Psicólogo não existe' });


//     let consultation = await execSQL(`SELECT * FROM consultations WHERE id = ${call.id_consultation}`);

//     //is returning an array
//     consultation = consultation[0];

//     if (!consultation) return res.status(400).send({ error: 'Id da consulta não existe' });

//     //create
//     call = await execSQL(`INSERT INTO calls (id_consultation, id_user_client, id_user_psychologist, channel_name) VALUES ('${call.id_consultation}', '${call.id_user_client}', '${call.id_user_psychologist}', '${_generateHash()}')`);
//     console.log(chalk.bgBlue('QUERY AT ', new Date()))

//     if (!call) return res.status(400).send({ error: "Error on insert new call." });
//     call = await execSQL(`SELECT * FROM calls WHERE id='${call.insertId}'`);
//     console.log(chalk.bgBlue('QUERY AT ', new Date()))
//     if (!call) return res.status(400).send({ error: "Error on return new call." });
//     call = call[0]
//     console.log('call ->', call)


//     return res.send({
//       call
//     });
//   } catch (error) {
//     console.log(String(error))
//     res.status(400).send({ error: error })
//   }
// });

router.post("/generate_token", async (req, res) => {
  const { channel_name } =  req.body;

  if(!channel_name){
    return res.status(401).json({
      error: 'channel_name not provided',
    })
  }

  try{
    console.log(`SELECT * FROM calls WHERE channel_name = ${channel_name}`)
   let call = await execSQL(`SELECT * FROM calls WHERE channel_name = '${channel_name}'`);
    //is returning an array
    call = call[0];
    if(!call){
      return res.status(401).json({
        error: 'Call not found with this channel_name'
      })
    }

    const role = RtcRole.PUBLISHER;
    const appID = process.env.AGORA_IO_APP_ID;
    const appCertificate = process.env.AGORA_IO_CERTIFICATE;
    const uid = v4();
    const expiration_time_in_seconds = 3600

    const current_timestamp = Math.floor(Date.now() / 1000)

    const privilege_expiredTs = current_timestamp + expiration_time_in_seconds

    const token = RtcTokenBuilder.buildTokenWithUid(appID, appCertificate, channel_name, uid, role, privilege_expiredTs);

    return res.json({
      uid,
      token,
      call,
    })
} catch (error) {
  console.log(String(error))
  res.status(400).send({ error: error })
}
})




module.exports = (app) => app.use("/calls", router);
