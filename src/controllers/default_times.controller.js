const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');
const router = express.Router();

router.get("/", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /default_times/ - default_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let default_times = await execSQL('SELECT * FROM default_times');

    console.log(chalk.bgBlue('QUERY AT ', new Date()));
    console.log('default_times ->', default_times);

    if (default_times.length <= 0) return res.send({ error: 'Nenhuma consulta encontrada' });

    // Retorna todas as consultas
    return res.send({
      default_times
    });
  } catch (error) {
    res.status(400).send({ error: error });
  }
});


//temp
router.post("/get_all", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /default_times/get_all - default_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let default_times = await execSQL('SELECT * FROM default_times');

    console.log(chalk.bgBlue('QUERY AT ', new Date()));
    console.log('default_times ->', default_times);

    if (default_times.length <= 0) return res.send({ error: 'Nenhuma consulta encontrada' });

    // Retorna todas as consultas
    return res.send({
      default_times
    });
  } catch (error) {
    res.status(400).send({ error: error });
  }
});


router.post("/get_by_id_user", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /default_times/get_by_id_user - default_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let id_user = req.body.id_user;
    if (!id_user) return res.status(400).send({ error: "user_id não fornecido" });
    let default_times = await execSQL("SELECT default_times.id, default_times.id_user, default_times.initial_hour, default_times.end_hour FROM default_times INNER JOIN default_times ON default_times.id = default_times.id_default_time WHERE id_user='" + id_user + "'");

    if (!default_times) return res.send({ error: "Não foi possível ler os horários disponíveis" });

    return res.send({ default_times });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error });
  }
});


router.post("/add_multiple_hours", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /default_times/add - default_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { id_user, default_times } = req.body;
    if (!id_user || !default_times || default_times?.length == 0) return res.status(400).send({ error: "user_id ou default_times não fornecidos" });

    default_times.map(async (t) => {
      try {
        await execSQL("INSERT INTO default_times (id_user, id_default_time) VALUES ('" + id_user + "','" + t + "')");
      } catch (error) {
        console.log({ error })
      }
    });

    default_times = await execSQL("SELECT default_times.id, default_times.id_user, default_times.initial_hour, default_times.end_hour FROM default_times INNER JOIN default_times ON default_times.id = default_times.id_default_time WHERE id_user='" + id_user + "'");

    return res.send({ default_times });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error });
  }
});


router.post("/delete", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /default_times/delete - default_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { id_user, id_available_time } = req.body;
    if (!id_user || !id_available_time) return res.status(400).send({ error: "user_id ou id_available_time não fornecidos" });

    let isDeleted = await execSQL("DELETE FROM default_times WHERE id ='" + id_available_time + "' AND id_user='" + id_user + "' ");

    if (!isDeleted) return res.status(400).send({ error: "Erro ao remover horário disponível" })

    default_times = await execSQL("SELECT default_times.id, default_times.id_user, default_times.initial_hour, default_times.end_hour FROM default_times INNER JOIN default_times ON default_times.id = default_times.id_default_time WHERE id_user='" + id_user + "'");

    return res.send({ default_times });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error });
  }
});



module.exports = (app) => app.use("/default_times", router);
