const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');

// import express from "express";
// import chalk from 'chalk';
// import User from "../models/user.model";
// import { execSQL } from '../database';
// import { Adress } from "models/adress.model";

const SQL_FOR_GET_LESSONS = "SELECT lessons.id, lessons.description, lessons.date, lessons.status, lessons.starting_point, users.id AS driver_id, users.first_name, users.last_name, users.email, users.sex, users.is_driver, cars.model AS car_model, cars.brand AS car_brand, cars.license_plate AS car_license_plate FROM lessons INNER JOIN users ON users.id = lessons.id_user_driver INNER JOIN cars ON lessons.id_user_driver = cars.id_user"
const SQL_FOR_GET_CONSULTATIONS = "SELECT consultations.id, consultations.description, consultations.date, consultations.status, users.id AS psychologist_id, users.first_name, users.last_name, users.email, users.sex, users.is_psychologist FROM consultations INNER JOIN users ON users.id = consultations.id_user_psychologist "

const router = express.Router();

router.get("/", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /users/ - users.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let users = await execSQL('SELECT * FROM users');

    console.log(chalk.bgBlue('QUERY AT ', new Date()))
    console.log('users ->', users)

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      users
    });
  } catch (error) {
    res.status(400).send({ error: error })
  }
});



router.post("/login", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /users/login - users.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let user = req.body.user;

    // user = await execSQL("SELECT users.id, users.first_name, users.email FROM users WHERE users.email = '" + user.email + "' AND users.password = '" + user.password + "'");
    user = await execSQL("SELECT * FROM users WHERE users.email = '" + user.email + "' AND users.password = '" + user.password + "'");

    //is returning an array
    user = user[0];

    if (!user) {
      return res.status(401).send({ message: 'Usuário ou senha incorretos' });
    }

    //set user is logged
    (await execSQL("UPDATE users SET is_logged='true' WHERE id='" + user.id + "'"));

    let lessons = await execSQL(SQL_FOR_GET_LESSONS + " WHERE lessons.id_user_client = '" + user.id + "' ORDER BY lessons.date ASC");
    // console.log({ lessons })
    lessons = lessons.map(l => {
      l.type = "lesson";
      return l
    })

    lessons = lessons.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()
    let consultations = await execSQL(SQL_FOR_GET_CONSULTATIONS + " WHERE id_user_client = '" + user.id + "'");
    consultations = consultations.map(c => {
      c.type = "consultation";
      return c
    })
    consultations = consultations.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()

    // console.log({ user });

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      user, lessons, consultations
    });
  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error })
  }
});



router.post("/logout", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /users/logout - users.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let user = req.body.user;

    user = await execSQL("SELECT users.id, users.email FROM users WHERE users.email = '" + user.email + "'");

    //is returning an array
    user = user[0];

    if (!user) return res.status(400).send({ error: 'Usuário ou senha incorretos' });

    //set user is logged
    (await execSQL("UPDATE users SET is_logged='false' WHERE id='" + user.id + "'"));

    console.log({ user });

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      user
    });
  } catch (error) {
    res.status(400).send({ error: error })
  }
});



router.post("/register", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /users/register - users.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {
    let user = req.body.user;

    // // Verifica se o usuário enviado já existe 
    let user_db = await execSQL("SELECT * FROM users WHERE email='" + user.email + "'");
    // console.log(user_db)
    // Se já existir, retorna com a mensagem de erro
    if (user_db.length != 0) return res.status(400).send({ error: "O usuário já existe" });

    // // Caso o usuário não exista, cria o usuário
    let user_new = await execSQL("INSERT INTO users (first_name, last_name, email, password, birthday, sex, language, country, is_client, is_psychologist, is_driver) VALUES ('" + user.first_name + "', '" + user.last_name + "', '" + user.email + "', '" + user.password + "', '" + user.birthday + "', '" + user.sex + "', '" + user.language + "', '" + user.country + "', '" + user.is_client + "', '" + user.is_psychologist + "', '" + user.is_driver + "')");

    if (user_new) user.id = user_new.insertId;
    else res.status(400).send({ error: "Não foi possível fazer o registro." })

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      // user: user_new[0]
      user
      // user: user_db
    });
  } catch (error) {
    console.log('erro, ', error)
    res.status(400).send({ error: error })
  }

});



module.exports = (app) => app.use("/users", router);