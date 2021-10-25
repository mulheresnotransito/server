const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');
const router = express.Router();

router.get("/", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /available_times/ - available_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let available_times = await execSQL('SELECT * FROM available_times');

    console.log(chalk.bgBlue('QUERY AT ', new Date()));
    console.log('available_times ->', available_times);

    if (available_times.length <= 0) return res.send({ message: "Nenhuma consulta encontrada" });

    // Retorna todas as consultas
    return res.send({
      available_times
    });
  } catch (error) {
    res.status(400).send({ error: error, error_code: "001" });
  }
});


//temp
router.post("/get_all", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /available_times/get_all - available_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let available_times = await execSQL('SELECT * FROM available_times');

    console.log(chalk.bgBlue('QUERY AT ', new Date()));
    console.log('available_times ->', available_times);

    if (available_times.length <= 0) return res.send({ message: 'Nenhuma consulta encontrada' });

    // Retorna todas as consultas
    return res.send({
      available_times
    });
  } catch (error) {
    res.status(400).send({ error: error, error_code: "002" });
  }
});


router.post("/get_by_id_user", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /available_times/get_by_id_user - available_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let id_user = req.body.id_user;
    if (!id_user) return res.status(400).send({ error: "user_id não fornecido", error_code: "003" });
    let available_times = await execSQL("SELECT available_times.id, available_times.id_user, default_times.initial_hour, default_times.end_hour FROM available_times INNER JOIN default_times ON default_times.id = available_times.id_default_time WHERE id_user='" + id_user + "'");

    if (!available_times) return res.send({ message: "Não foi possível ler os horários disponíveis" });

    return res.send({ available_times });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "004" });
  }
});


router.post("/add_multiple_hours", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /available_times/add - available_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { id_user, available_times } = req.body;
    if (!id_user || !available_times || available_times.length == 0) return res.status(400).send({ error: "user_id ou available_times não fornecidos", error_code: "005" });

    available_times.map(async (t) => {
      try {
        await execSQL("INSERT INTO available_times (id_user, id_default_time) VALUES ('" + id_user + "','" + t + "')");
      } catch (error) {
        console.log({ error })
      }
    });

    available_times = await execSQL("SELECT available_times.id, available_times.id_user, default_times.initial_hour, default_times.end_hour FROM available_times INNER JOIN default_times ON default_times.id = available_times.id_default_time WHERE id_user='" + id_user + "'");

    return res.send({ available_times });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "006" });
  }
});


router.post("/delete", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /available_times/delete - available_times.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { id_user, id_available_time } = req.body;
    if (!id_user || !id_available_time) return res.status(400).send({ error: "user_id ou id_available_time não fornecidos", error_code: "007" });

    let isDeleted = await execSQL("DELETE FROM available_times WHERE id ='" + id_available_time + "' AND id_user='" + id_user + "' ");

    if (!isDeleted) return res.status(400).send({ error: "Erro ao remover horário disponível", error_code: "008" })

    available_times = await execSQL("SELECT available_times.id, available_times.id_user, default_times.initial_hour, default_times.end_hour FROM available_times INNER JOIN default_times ON default_times.id = available_times.id_default_time WHERE id_user='" + id_user + "'");

    return res.send({ available_times });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "009" });
  }
});



module.exports = (app) => app.use("/available_times", router);
