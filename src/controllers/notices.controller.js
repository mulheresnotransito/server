const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');

const router = express.Router();

router.get("/get_all", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /notices/ - notices.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let notices = await execSQL('SELECT * FROM notices');

    console.log(chalk.bgBlue('QUERY AT ', new Date()))
    console.log('notices ->', notices)
    if (notices.length <= 0) return res.status(400).send({ error: 'Nenhuma notícia encontrada' })

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      notices
    });
  } catch (error) {
    res.status(400).send({ error: error })
  }
});

router.post("/new", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /notices/new - notices.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let notice = req.body;
    if (!notice.title || !notice.text || !notice.description) return res.status(400).send({ error: "Title or text not provided." });

    notice.title = (notice.title).replace(/'/g, "''");
    notice.text = (notice.text).replace(/'/g, "''");
    notice.description = (notice.description).replace(/'/g, "''");
    notice = await execSQL(`INSERT INTO notices (title, text, description) VALUES ('${notice.title}', '${notice.text}', '${notice.description}')`);
    console.log(chalk.bgBlue('QUERY AT ', new Date()))

    if (!notice) return res.status(400).send({ error: "Error on insert new notice." });
    notice = await execSQL(`SELECT * FROM notices WHERE id='${notice.insertId}'`);
    console.log(chalk.bgBlue('QUERY AT ', new Date()))
    if (!notice) return res.status(400).send({ error: "Error on return new notice." });
    notice = notice[0]
    console.log('notice ->', notice)

    // Retorna os dados do usuário e o new token para ser usado na próxima requisição
    return res.send({
      notice
    });
  } catch (error) {
    console.log({ error })
    res.status(400).send({ error })
  }
});



module.exports = (app) => app.use("/notices", router);
