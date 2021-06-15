const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');

const router = express.Router();

router.get("/get_all", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /cancellations/ - cancellations.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let cancellations = await execSQL('SELECT * FROM cancellations');

    console.log(chalk.bgBlue('QUERY AT ', new Date()))
    console.log('cancellations ->', cancellations)
    if (cancellations.length <= 0) return res.status(400).send({ error: 'Nenhum cancelamento encontrado' })

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      cancellations
    });
  } catch (error) {
    res.status(400).send({ error: error })
  }
});

module.exports = (app) => app.use("/cancellations", router);
