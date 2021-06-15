const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');

const router = express.Router();

router.get("/get_all", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /transactions/ - transactions.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let transactions = await execSQL('SELECT * FROM transactions');

    console.log(chalk.bgBlue('QUERY AT ', new Date()))
    console.log('transactions ->', transactions)
    if (transactions.length <= 0) return res.status(400).send({ error: 'Nenhuma transação encontrada' })

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      transactions
    });
  } catch (error) {
    res.status(400).send({ error: error })
  }
});

module.exports = (app) => app.use("/transactions", router);
