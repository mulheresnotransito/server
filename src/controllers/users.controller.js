const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');
const { api } = require('../services/cielo.api');

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
    console.log(user);

    //set user is logged
    (await execSQL("UPDATE users SET is_logged='true' WHERE id='" + user.id + "'"));

    // let lessons = await execSQL(SQL_FOR_GET_LESSONS + " WHERE lessons.id_user_client = '" + user.id + "' ORDER BY lessons.date ASC");
    // console.log({ lessons })
    let lessons = (await execSQL("SELECT lessons.id, description, id_user_client"
      + ", id_user_driver, date, status, starting_point, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as driver_name, users.email as driver_email"
      + ", cars.model as car_model, cars.license_plate as car_license_plate, cars.brand as car_brand"
      + " FROM lessons"
      + " INNER JOIN default_times ON default_times.id=lessons.id_default_time"
      + " INNER JOIN users ON users.id=lessons.id_user_driver"
      + " INNER JOIN cars ON cars.id_user=lessons.id_user_driver"
      + " WHERE lessons.id_user_client='" + user.id + "' ORDER BY lessons.date ASC"));

    lessons = lessons.map(l => {
      console.log(l.date)
      l.type = "lesson";
      return l
    })

    lessons = lessons.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()

    console.log({ lessons })

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
    console.log({ userToRegister: user })

    if (!user.is_driver) user.is_driver = 0;
    if (!user.is_psychologist) user.is_psychologist = 0;
    if (!user.is_client) user.is_client = 1;

    // // Verifica se o usuário enviado já existe 
    let user_db = await execSQL("SELECT * FROM users WHERE email='" + user.email + "'");
    console.log({ user_db })
    // Se já existir, retorna com a mensagem de erro
    if (user_db.length != 0) return res.status(400).send({ error: "O usuário já existe", error_code: "001" });

    // // Caso o usuário não exista, cria o usuário
    let user_new = await execSQL("INSERT INTO users (first_name, last_name, email, password, birthday, sex, language, country, is_client, is_psychologist, is_driver) VALUES ('" + user.first_name + "', '" + user.last_name + "', '" + user.email + "', '" + user.password + "', '" + user.birthday + "', '" + user.sex + "', '" + user.language + "', '" + user.country + "', '" + user.is_client + "', '" + user.is_psychologist + "', '" + user.is_driver + "')");

    if (user_new) user = (await execSQL("SELECT * FROM users WHERE id='" + user_new.insertId + "' "))[0];
    else res.status(400).send({ error: "Não foi possível fazer o registro.", error_code: "002" })
      //set user is logged
      (await execSQL("UPDATE users SET is_logged='true' WHERE id='" + user.id + "'"));

    // let lessons = await execSQL(SQL_FOR_GET_LESSONS + " WHERE lessons.id_user_client = '" + user.id + "' ORDER BY lessons.date ASC");
    // console.log({ lessons })
    let lessons = (await execSQL("SELECT lessons.id, description, id_user_client"
      + ", id_user_driver, date, status, starting_point, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as driver_name, users.email as driver_email"
      + ", cars.model as car_model, cars.license_plate as car_license_plate, cars.brand as car_brand"
      + " FROM lessons"
      + " INNER JOIN default_times ON default_times.id=lessons.id_default_time"
      + " INNER JOIN users ON users.id=lessons.id_user_driver"
      + " INNER JOIN cars ON cars.id_user=lessons.id_user_driver"
      + " WHERE lessons.id_user_client='" + user.id + "' ORDER BY lessons.date ASC"));

    lessons = lessons.map(l => {
      console.log(l.date)
      l.type = "lesson";
      return l
    })

    lessons = lessons.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()

    console.log({ lessons })

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
    console.log('erro, ', error)
    res.status(400).send({ error: error })
  }

});

router.post("/buy_classes_credits", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /users/buy_classes_credits - users.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {
    let { paymentInfo, user, newCredits } = req.body;

    //to fix card brand not provided on development
    if (!paymentInfo.creditCard.brand) paymentInfo.creditCard.brand = "visa"

    if (!paymentInfo || !newCredits || !newCredits.installments) return res.status(400).send({ error: "Payment info or new credits not provided" });
    if (!user || !user.id || !user.first_name) return res.status(400).send({ error: "User info not provided" });
    if (!paymentInfo.creditCard || !paymentInfo.creditCard.number || !paymentInfo.creditCard.securityCode || !paymentInfo.creditCard.expirationDate || !paymentInfo.creditCard.brand || !paymentInfo.creditCard.holder)
      return res.status(400).send({ error: "Credit card info not provided" });

    newCredits.price = (newCredits.price).replace("R$", "");
    newCredits.price = (newCredits.price).replace(",", "");


    let userExists = await execSQL("SELECT * FROM users WHERE id='" + user.id + "' ");
    if (!userExists || userExists.length <= 0) return res.status(400).send({ error: "User not found" });
    const { creditCard } = paymentInfo;

    const response = await api.post('/1/sales', {
      "MerchantOrderId": "2014111703",
      "Customer": {
        "Name": user.first_name
      },
      "Payment": {
        "Type": "CreditCard",
        "Amount": newCredits.price,
        "Installments": newCredits.installments,
        "SoftDescriptor": "123456789ABCD",
        "CreditCard": {
          "CardNumber": creditCard.number,
          "Holder": creditCard.holder,
          "ExpirationDate": creditCard.expirationDate,
          "SecurityCode": creditCard.securityCode,
          "Brand": creditCard.brand || "Visa"
        },
        "IsCryptoCurrencyNegotiation": true
      }
    })

    console.log(chalk.yellow(JSON.stringify(response.data)));

    const { Status, ReturnCode, ReturnMessage, PaymentId, Tid, AuthorizationCode } = response.data.Payment

    if (Status !== 1) {
      return res.status(401).json({
        Status,
        Tid,
        ReturnCode,
        ReturnMessage,
        PaymentId,
        AuthorizationCode
      })
    }

    const capture = await api.put(`/1/sales/${PaymentId}/capture`)

    if (!capture.data.Status === 2) {
      await execSQL("INSERT INTO transactions (tid, status, authorizationCode, returnCode, returnMessage, id_client, paymentId, capture, isClassCredits, buyValue ) VALUES ('" + Tid + "', '" + Status + "', '" + AuthorizationCode + "', '" + ReturnCode + "', '" + ReturnMessage + "', '" + user.id + "', '" + PaymentId + "', '" + 0 + "', '" + 1 + "', '" + newCredits.price + "')");
      return res.status(401).json({
        error: 'Error for capture transaction',
        data: capture.data
      })
    }

    await execSQL("INSERT INTO transactions (tid, status, authorizationCode, returnCode, returnMessage, id_client, paymentId, capture, isClassCredits, buyValue) VALUES ('" + Tid + "', '" + Status + "', '" + AuthorizationCode + "', '" + ReturnCode + "', '" + ReturnMessage + "', '" + user.id + "', '" + PaymentId + "', '" + 1 + "', '" + 1 + "', '" + newCredits.price + "')");

    let credits = await execSQL("SELECT * FROM users WHERE id='" + user.id + "' ");
    credits = parseInt(credits[0].classes_credits);
    newCredits.credits = parseInt(newCredits.credits);
    credits = await execSQL("UPDATE users SET classes_credits= '" + (credits + newCredits.credits) + "' WHERE id= '" + user.id + "' ");
    user = await execSQL("SELECT * FROM users WHERE id='" + user.id + "' ");
    user = user[0]
    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      user
    });
  } catch (error) {
    console.log('erro, ', error)
    res.status(400).send({ error: error })
  }

});


router.post("/buy_consultations_credits", async (req, res) => {

  console.log(chalk.bgMagenta('[ post /users/buy_consultations_credits - users.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {
    let { paymentInfo, user } = req.body;
    let { newConsultationsCredits } = paymentInfo;

    //to fix card brand not provided on development
    if (!paymentInfo.creditCard.brand) paymentInfo.creditCard.brand = "visa"
    console.log(newConsultationsCredits)

    if (!paymentInfo || !newConsultationsCredits || !newConsultationsCredits.installments) return res.status(400).send({ error: "Payment info or new credits not provided" });
    if (!user || !user.id || !user.first_name) return res.status(400).send({ error: "User info not provided" });
    if (!paymentInfo.creditCard || !paymentInfo.creditCard.number || !paymentInfo.creditCard.securityCode || !paymentInfo.creditCard.expirationDate || !paymentInfo.creditCard.brand || !paymentInfo.creditCard.holder)
      return res.status(400).send({ error: "Credit card info not provided" });

    newConsultationsCredits.price = (newConsultationsCredits.price).replace("R$", "");
    newConsultationsCredits.price = (newConsultationsCredits.price).replace(",", "");

    let userExists = await execSQL("SELECT * FROM users WHERE id='" + user.id + "' ");
    if (!userExists || userExists.length <= 0) return res.status(400).send({ error: "User not found" });
    const { creditCard } = paymentInfo;


    const response = await api.post('/1/sales', {
      "MerchantOrderId": "2014111703",
      "Customer": {
        "Name": user.first_name
      },
      "Payment": {
        "Type": "CreditCard",
        "Amount": newConsultationsCredits.price,
        "Installments": newConsultationsCredits.installments,
        "SoftDescriptor": "123456789ABCD",
        "CreditCard": {
          "CardNumber": creditCard.number,
          "Holder": creditCard.holder,
          "ExpirationDate": creditCard.expirationDate,
          "SecurityCode": creditCard.securityCode,
          "Brand": creditCard.brand || "Visa"
        },
        "IsCryptoCurrencyNegotiation": true
      }
    })

    console.log(chalk.yellow(JSON.stringify(response.data)));

    const { Status, ReturnCode, ReturnMessage, PaymentId, Tid, AuthorizationCode } = response.data.Payment

    if (Status !== 1) {
      return res.status(401).json({
        Status,
        Tid,
        ReturnCode,
        ReturnMessage,
        PaymentId,
        AuthorizationCode
      })
    }

    const capture = await api.put(`/1/sales/${PaymentId}/capture`)

    if (!capture.data.status === 2) {
      await execSQL("INSERT INTO transactions (tid, status, authorizationCode, returnCode, returnMessage, id_client, paymentId, capture, isConsultationCredits, buyValue ) VALUES ('" + Tid + "', '" + Status + "', '" + AuthorizationCode + "', '" + ReturnCode + "', '" + ReturnMessage + "', '" + user.id + "', '" + PaymentId + "', '" + 0 + "', '" + 1 + "', '" + newConsultationsCredits.price + "')");
      return res.status(401).json({
        error: 'Error for capture transaction',
        data: capture.data
      })
    }

    await execSQL("INSERT INTO transactions (tid, status, authorizationCode, returnCode, returnMessage, id_client, paymentId, capture, isConsultationCredits, buyValue) VALUES ('" + Tid + "', '" + Status + "', '" + AuthorizationCode + "', '" + ReturnCode + "', '" + ReturnMessage + "', '" + user.id + "', '" + PaymentId + "', '" + 1 + "', '" + 1 + "', '" + newConsultationsCredits.price + "')");

    console.log(chalk.green(JSON.stringify(capture.data)));

    let credits = await execSQL("SELECT * FROM users WHERE id='" + user.id + "' ");

    credits = parseInt(credits[0].consultations_credits);
    newConsultationsCredits = parseInt(newConsultationsCredits.credits);
    credits = await execSQL("UPDATE users SET consultations_credits= '" + (credits + newConsultationsCredits) + "' WHERE id= '" + user.id + "' ");
    user = await execSQL("SELECT * FROM users WHERE id='" + user.id + "' ");
    user = user[0]
    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      user
    });
  } catch (error) {
    console.log('erro, ', error)
    res.status(400).send({ error: error })
  }

});


router.post("/get_all_psychologists", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /users/get_all_psychologists - users.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let psychologists = await execSQL("SELECT * FROM users WHERE is_psychologist='1' ");
    if (!psychologists) return res.status(400).send({ error: "Não foi possível carregar os psicólogos.", error_code: "001" });

    console.log({ psychologists });

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      psychologists
    });
  } catch (error) {
    console.log(error)
    res.status(400).send({ error: error, error_code: "002" })
  }

});

router.post("/delete", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /users/delete - users.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let { id } = req.body.user;

    let status = await execSQL("DELETE FROM users WHERE id='" + id + "' LIMIT 1 ");
    if (!status) return res.status(400).send({ error: "Não foi possível excluir o usuário", error_code: "001" });
    else if (status) status = true;

    return res.send({
      status
    });
  } catch (error) {
    res.status(400).send({ error: error })
  }
});




module.exports = (app) => app.use("/users", router);