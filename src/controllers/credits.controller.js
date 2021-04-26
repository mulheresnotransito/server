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
  console.log(chalk.bgMagenta('[ get /credits/ - credits.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    // let credits = await execSQL('SELECT * FROM credits');
    let credits = await execSQL('SELECT credits.id, credits.id_user_client, users.first_name as name_user_client, credits.credit_classes, credits.credit_consultations FROM credits INNER JOIN users ON credits.id_user_client = users.id');

    console.log(chalk.bgBlue('QUERY AT ', new Date()))
    console.log('credits ->', credits)
    // if (credits.length <= 0) return res.status(400).send({ error: 'Nenhum usuário encontrado' })

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      credits
    });
  } catch (error) {
    res.status(400).send({ error: error })
  }
});

// router.post("/app_login", async (req, res) => {
//   console.log(chalk.bgMagenta('[ post /credits/app_login - credits.controller ]'));
//   console.log(chalk.magenta(JSON.stringify(req.body)));
//   try {

//     let user = req.body.user;

//     user = await execSQL("SELECT credits.id, credits.name, credits.email, user_types.title as user_type, signatures.status as signature_status, signatures.expiration_date as signature_expiration_date FROM credits INNER JOIN user_types ON credits.id_type = user_types.id INNER JOIN signatures ON credits.id_signature = signatures.id WHERE credits.email = '" + user.email + "' AND credits.password = '" + user.password + "'");

//     //is returning an array
//     user = user[0];

//     if (!user) return res.status(400).send({ error: 'Usuário ou senha incorretos' });

//     //set user is logged
//     (await execSQL("UPDATE credits SET is_logged='true' WHERE id='" + user.id + "'"));

//     console.log({ user });

//     //to check signature status
//     user.signature_expiration_date = parseInt(user.signature_expiration_date);
//     console.log('está ativo? =>>> ', new Date(user.signature_expiration_date) > new Date);

//     // Retorna os dados do usuário e o new token para ser usado na próxima requisição
//     return res.send({
//       // user: user[0],
//       user,
//       status: 200
//     });
//   } catch (error) {
//     res.status(400).send({ error: error })
//   }
// });

// router.post("/app_logout", async (req, res) => {
//   console.log(chalk.bgMagenta('[ post /credits/app_logout - credits.controller ]'));
//   console.log(chalk.magenta(JSON.stringify(req.body)));
//   try {

//     let user = req.body.user;

//     (await execSQL("UPDATE credits SET is_logged='" + false + "' WHERE email='" + user.email + "'"));

//     // Retorna os dados do usuário e o new token para ser usado na próxima requisição
//     return res.send({
//       status: 200
//     });
//   } catch (error) {
//     res.status(400).send({ error: error });
//   }
// });

// router.post("/app_register", async (req, res) => {
//   console.log(chalk.bgMagenta('[ post /credits/app_register - credits.controller ]'));
//   console.log(chalk.magenta(JSON.stringify(req.body)));
//   try {
//     let user = req.body.user;
//     if (!user.id_plan) return res.status(400).send({ error: "Plano não informado" });
//     if (!user.name) return res.status(400).send({ error: "Nome não informado" });
//     if (!user.email) return res.status(400).send({ error: "E-mail não informado" });
//     if (!user.password) return res.status(400).send({ error: "Senha não informada" });
//     user.name = user.name.replace(/'/g, "");
//     user.email = user.email.replace(/'/g, "").replace(/ /g, "");
//     user.password = user.password.replace(/'/g, "").replace(/ /g, "");
//     user.id_plan += "";
//     user.id_plan = user.id_plan.replace(/'/g, "").replace(/ /g, "");

//     // let info = await execSQL("SELECT user_types.title as user_type, user_types.id as id_user_type, plans.id as id_plan FROM user_types INNER JOIN plans");

//     // Seleciona o tipo usuário comum para o novo usuário, caso não haja um tipo definido
//     // if (!user.type) user.type = (user_types.filter(t => t.title == "COMMON_USER"))[0].id;

//     // // Verifica se o usuário enviado já existe 
//     let user_db = await execSQL("SELECT * FROM credits WHERE email='" + user.email + "'");
//     // console.log(user_db)
//     // Se já existir, retorna com a mensagem de erro
//     if (user_db.length != 0) return res.status(400).send({ error: "O usuário já existe" });

//     // Pega todos os tipos cadastrados no sistema
//     let info = {};
//     info.user_types = await execSQL("SELECT * FROM user_types");
//     info.plans = await execSQL("SELECT * FROM plans");

//     // Seleciona o plano FREE para o novo usuário, caso não haja um definido
//     // Seleciona o tipo do usuário comum para o novo usuário, caso não haja um definido
//     // if (!user.type) user.type = (info.user_types.filter(t => t.title == 'COMMON_USER'))[0];

//     user.type = { id: 2 };
//     // // Caso o usuário não exista, cria o usuário
//     let user_new = await execSQL("INSERT INTO credits (name, email, password, id_type) VALUES ('" + user.name + "', '" + user.email + "', '" + user.password + "', '" + user.type.id + "')");

//     if (user_new) console.log({ user_new })
//     user.id = user_new.insertId;


//     let current_plan = info.plans.filter(p => p.id == user.id_plan);
//     current_plan = current_plan[0];
//     console.log({ deadline_days: current_plan.deadline_days })

//     // Criar novo pagamento para o novo usuário com o plano FREE
//     user.id_payment = (await execSQL("INSERT INTO payments (id_user, id_plan, date, payment_method, final_value, status) "
//       + " VALUES ('" + user_new.insertId + "', '" + user.id_plan + "', '" + (new Date()).getTime() + "', 'FREE', '" + current_plan.value + "', 'active') ")).insertId;


//     // if (user.payment) console.log({ payment: user.payment })


//     let new_date = new Date();
//     new_date.setDate(new_date.getDate() + parseInt(current_plan.deadline_days));
//     console.log({ new_date })
//     console.log({ new_date_get_time: new_date.getTime() })

//     user.id_signature = (await execSQL("INSERT INTO signatures (id_plan, id_payment, expiration_date, status)"
//       + " VALUES ('" + user.id_plan + "', '" + user.id_payment + "', '" + new_date.getTime() + "', 'active')")).insertId;

//     console.log('test1')
//     console.log(user.id_signature)
//     // if (user.signature) console.log({ signature: user.signature });

//     let response = await execSQL("UPDATE credits SET id_signature = '" + user.id_signature + "', is_logged='true' WHERE id='" + user_new.insertId + "'");
//     console.log('test12')

//     // user_new = await execSQL("SELECT * FROM credits WHERE email='" + user.email + "'");

//     // Retorna os dados do usuário e o new token para ser usado na próxima requisição
//     return res.send({
//       // user: user_new[0]
//       user
//       // user: user_db
//     });
//   } catch (error) {
//     console.log('erro, ', error)
//     res.status(400).send({ error: error })
//   }

// });



// router.post("/delete", async (req, res) => {
//   console.log(chalk.bgMagenta('[ post /credits/delete - credits.controller ]'));
//   console.log(chalk.magenta(JSON.stringify(req.body)));
//   try {

//     let user = req.body.user;

//     user = await execSQL("DELETE FROM credits WHERE id='" + user.id + "'");

//     if (!user) return res.status(400).send({ error: 'Não foi possível deletar o usuário' });

//     console.log({ user });

//     return res.send({
//       message: "Usuário deletado com sucesso.",
//       status: 200
//     });
//   } catch (error) {
//     res.status(400).send({ error: error })
//   }
// });


// router.post("/update", async (req, res) => {
//   console.log(chalk.bgMagenta('[ post /credits/update - credits.controller ]'));
//   console.log(chalk.magenta(JSON.stringify(req.body)));
//   try {
//     let user = req.body.user;
//     // if (!user.id_plan) return res.status(400).send({ error: "Não foi possível editar o usuário. Erro: Plano não informado" });
//     if (!user.name) return res.status(400).send({ error: "Não foi possível editar o usuário. Erro: Nome não informado" });
//     if (!user.email) return res.status(400).send({ error: "Não foi possível editar o usuário. Erro: E-mail não informado" });
//     if (!user.password) return res.status(400).send({ error: "Não foi possível editar o usuário. Erro: Senha não informada" });
//     user.name = user.name.replace(/'/g, "");
//     user.email = user.email.replace(/'/g, "").replace(/ /g, "");
//     user.password = user.password.replace(/'/g, "").replace(/ /g, "");
//     // user.id_plan += "";
//     // user.id_plan = user.id_plan.replace(/'/g, "").replace(/ /g, "");

//     // // Caso o usuário não exista, cria o usuário
//     let updated_user = await execSQL("UPDATE credits SET name='" + user.name + "', email='" + user.email + "', password='" + user.password + "' WHERE id='" + user.id + "'");

//     if (!updated_user) return res.status(400).send({ error: "Erro: Não foi possível editar o usuário." });

//     console.log("Usuário editado com sucesso.", { user });

//     // Retorna os dados do usuário e o new token para ser usado na próxima requisição
//     return res.send({
//       message: "Usuário editado com sucesso.",
//       status: 200,
//     });
//   } catch (error) {
//     console.log('erro, ', error)
//     res.status(400).send({ error: error })
//   }

// });


module.exports = (app) => app.use("/credits", router);
