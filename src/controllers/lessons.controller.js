const express = require('express');
const chalk = require('chalk');
const { execSQL } = require('../database');
// const functions = require('../utils/functions');

const router = express.Router();

const getFormattedDate = (date) => {

  if (date.split("/").length == 3) return date;

  let dia = date.getDay() >= 10 ? date.getDay() : '0' + date.getDay();
  let mes = date.getMonth() >= 10 ? date.getMonth() : '0' + date.getMonth();
  let ano = date.getFullYear();
  let moment = dia + '/' + mes + '/' + ano;
  console.log({ moment })
  return moment;
}

router.get("/", async (req, res) => {
  console.log(chalk.bgMagenta('[ get /lessons/ - lessons.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));
  try {

    let lessons = await execSQL('SELECT * FROM lessons');
    // let lessons = await execSQL("SELECT lessons.id, lessons.name, lessons.email, user_types.title as user_type, signatures.status as signature_status, signatures.expiration_date as signature_expiration_date FROM lessons INNER JOIN user_types ON lessons.id_type = user_types.id INNER JOIN signatures ON lessons.id_signature = signatures.id");

    console.log(chalk.bgBlue('QUERY AT ', new Date()));
    console.log('lessons ->', lessons);

    if (lessons.length <= 0) return res.send({ error: 'Nenhuma aula encontrada' });

    // Retorna todas as aulas
    return res.send({
      lessons
    });
  } catch (error) {
    res.status(400).send({ error: error });
  }
});

router.post("/cancel", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /lessons/cancel - lessons.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let lesson = req.body.lesson;
    if (!lesson.id || !lesson.id_user_client || !lesson.text) return res.status(400).send({ error: "Lesson id, id_user_client or text not provided." });

    let new_lesson = await execSQL("SELECT status FROM lessons WHERE id= '" + lesson.id + "' ");
    let status = new_lesson[0].status;
    if (status == "canceled") return res.status(400).send({ error: "Aula já cancelada anteriormente.", error_code: "001" });

    let now = new Date();

    new_lesson = await execSQL("UPDATE lessons SET status='canceled', updated_at='" + now + "' WHERE id='" + lesson.id + "'");
    let credits = await execSQL("SELECT classes_credits FROM users WHERE id='" + lesson.id_user_client + "' ");
    credits = parseInt(credits[0].classes_credits);
    credits = credits + 1;
    let new_credits = await execSQL("UPDATE users SET classes_credits='" + (credits) + "' WHERE id= '" + lesson.id_user_client + "' ");

    if (!new_lesson) return res.send({ error: "Não foi possível cancelar a aula", error_code: "002" });

    let canceled = await execSQL("INSERT INTO cancellations (id_user_client, id_lesson, text) VALUES ('" + lesson.id_user_client + "', '" + lesson.id + "', '" + lesson.text + "')");

    let scheduled_lessons = (await execSQL("SELECT lessons.id, description, id_user_client"
      + ", id_user_driver, date, status, starting_point, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as driver_name, users.email as driver_email"
      + ", cars.model as car_model, cars.license_plate as car_license_plate, cars.brand as car_brand"
      + " FROM lessons"
      + " INNER JOIN default_times ON default_times.id=lessons.id_default_time"
      + " INNER JOIN users ON users.id=lessons.id_user_driver"
      + " INNER JOIN cars ON cars.id_user=lessons.id_user_driver"
      + " WHERE lessons.id_user_client='" + lesson.id_user_client + "'  AND lessons.status='scheduled' "));

    scheduled_lessons = scheduled_lessons.map(l => {
      console.log(l.date)
      l.type = "lesson";
      l.temp_date = l.date.split("/");
      return l
    })

    // scheduled_lessons = scheduled_lessons.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse();
    scheduled_lessons = scheduled_lessons.sort((a, b) => new Date(b.temp_date[2], b.temp_date[1], b.temp_date[0]) - new Date(a.temp_date[2], a.temp_date[1], a.temp_date[0])).reverse()

    return res.send({ scheduled_lessons, classes_credits: credits });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "003" });
  }
});


router.post("/get_all_by_id_user_client", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /lessons/get_all_by_id_user_client - lessons.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { user_id } = req.body;

    // let lessons = await execSQL("SELECT * FROM lessons INNER JOIN default_times ON default_times.id=lessons.id_default_time WHERE id_user_client = '" + user.id + "'");

    let lessons = (await execSQL("SELECT lessons.id, description, id_user_client"
      + ", id_user_driver, date, status, starting_point, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as driver_name, users.email as driver_email"
      + ", cars.model as car_model, cars.license_plate as car_license_plate, cars.brand as car_brand"
      + " FROM lessons"
      + " INNER JOIN default_times ON default_times.id=lessons.id_default_time"
      + " INNER JOIN users ON users.id=lessons.id_user_driver"
      + " INNER JOIN cars ON cars.id_user=lessons.id_user_driver"
      + " WHERE lessons.id_user_client='" + user_id + "'"));
    if (!lessons) return res.status(400).send({ error: "Não foi possível encontrar as aulas", error_code: "001" });
    console.log({ lessons })
    lessons = lessons.map(l => {
      console.log(l.date)
      l.type = "lesson";
      l.temp_date = l.date.split("/");
      return l
    })

    // lessons = lessons.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse()
    lessons = lessons.sort((a, b) => new Date(b.temp_date[2], b.temp_date[1], b.temp_date[0]) - new Date(a.temp_date[2], a.temp_date[1], a.temp_date[0])).reverse()

    return res.send({ lessons });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "002" });
  }
});


router.post("/get_all_scheduled_by_id_user_client", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /lessons/get_all_scheduled_by_id_user_client - lessons.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { user_id } = req.body;

    // let lessons = await execSQL("SELECT * FROM lessons INNER JOIN default_times ON default_times.id=lessons.id_default_time WHERE id_user_client = '" + user.id + "'");

    let scheduled_lessons = (await execSQL("SELECT lessons.id, description, id_user_client"
      + ", id_user_driver, date, status, starting_point, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as driver_name, users.email as driver_email"
      + ", cars.model as car_model, cars.license_plate as car_license_plate, cars.brand as car_brand"
      + " FROM lessons"
      + " INNER JOIN default_times ON default_times.id=lessons.id_default_time"
      + " INNER JOIN users ON users.id=lessons.id_user_driver"
      + " INNER JOIN cars ON cars.id_user=lessons.id_user_driver"
      + " WHERE lessons.id_user_client='" + user_id + "' AND lessons.status='scheduled' "));
    if (!scheduled_lessons) return res.status(400).send({ error: "Não foi possível encontrar as aulas", error_code: "001" });
    console.log({ scheduled_lessons })

    scheduled_lessons = scheduled_lessons.map(l => {
      console.log(l.date)
      l.type = "lesson";
      l.temp_date = l.date.split("/");
      return l
    })

    // scheduled_lessons = scheduled_lessons.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse();
    scheduled_lessons = scheduled_lessons.sort((a, b) => new Date(b.temp_date[2], b.temp_date[1], b.temp_date[0]) - new Date(a.temp_date[2], a.temp_date[1], a.temp_date[0])).reverse()

    return res.send({ scheduled_lessons });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "002" });
  }
});


router.post("/schedule", async (req, res) => {
  console.log(chalk.bgMagenta('[ post /lessons/schedule - lessons.controller ]'));
  console.log(chalk.magenta(JSON.stringify(req.body)));

  try {

    let { date, id_default_time, id_user_client, starting_point } = req.body;
    if (date == getFormattedDate(date)) { }
    else date = getFormattedDate(date);

    let alreadyScheduled = await execSQL("SELECT * FROM lessons WHERE date='" + date + "' AND id_default_time='" + id_default_time + "' AND status='scheduled' ");
    if (alreadyScheduled.length > 0) return res.status(400).send({ error: "Horário indisponível para o usuário", error_code: "005" });

    let credits = await execSQL("SELECT * FROM users WHERE id='" + id_user_client + "' LIMIT 1");
    credits = parseInt(credits[0].classes_credits);
    console.log({ credits })

    if (credits <= 0) return res.status(400).send({ error: "Você não possui créditos", error_code: "001" });

    let drivers = await execSQL("SELECT * FROM users WHERE is_driver=1 ");
    let unavailableDrivers = await execSQL("SELECT id_user_driver FROM lessons WHERE date='" + date + "' AND id_default_time='" + id_default_time + "'");

    unavailableDrivers.map((un, index) => {
      drivers.map((d, i) => {
        if (d.id == un.id_user_driver) {
          drivers.splice(i, 1);
        }
      })
    });

    let indexOfRandomDriver = (Math.floor(Math.random() * (drivers.length) + 1) - 1);
    let selectedDriver = drivers[indexOfRandomDriver];
    console.log({ selectedDriver })

    if (!selectedDriver) return res.status(400).send({ error: "Não foi possível agendar a aula. Nenhum motorista disponível.", error_code: "002" });

    let now = new Date();
    let new_lesson = await execSQL("INSERT INTO lessons (id_default_time, id_user_client, id_user_driver, date, status, updated_at, starting_point) VALUES ('" + id_default_time + "', '" + id_user_client + "', '" + selectedDriver.id + "', '" + date + "', 'scheduled', '" + now + "', '" + starting_point + "')");
    console.log({ new_lesson })

    if (!new_lesson) return res.send({ error: "Não foi possível agendar a aula", error_code: "003" });

    // let lesson = (await execSQL("SELECT lessons.id, description, id_user_client, id_user_driver, date, status, starting_point, default_times.initial_hour, default_times.end_hour  "
    //   + "FROM lessons INNER JOIN default_times ON default_times.id=lessons.id_default_time WHERE lessons.id='" + new_lesson.insertId + "'"))[0];
    // lesson.driver = selectedDriver;

    let lesson = (await execSQL("SELECT lessons.id, description, id_user_client"
      + ", id_user_driver, date, status, starting_point, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as driver_name, users.email as driver_email"
      + ", cars.model as car_model, cars.license_plate as car_license_plate, cars.brand as car_brand"
      + " FROM lessons"
      + " INNER JOIN default_times ON default_times.id=lessons.id_default_time"
      + " INNER JOIN users ON users.id=lessons.id_user_driver"
      + " INNER JOIN cars ON cars.id_user=lessons.id_user_driver"
      + " WHERE lessons.id='" + new_lesson.insertId + "' "))[0];

    let new_credits = await execSQL("UPDATE users SET classes_credits = '" + (credits - 1) + "' WHERE id = '" + id_user_client + "'");
    credits = credits - 1;
    console.log({ new_credits })
    console.log({ id_user_client })

    let scheduled_lessons = (await execSQL("SELECT lessons.id, description, id_user_client"
      + ", id_user_driver, date, status, starting_point, default_times.initial_hour, default_times.end_hour  "
      + ", users.first_name as driver_name, users.email as driver_email"
      + ", cars.model as car_model, cars.license_plate as car_license_plate, cars.brand as car_brand"
      + " FROM lessons"
      + " INNER JOIN default_times ON default_times.id=lessons.id_default_time"
      + " INNER JOIN users ON users.id=lessons.id_user_driver"
      + " INNER JOIN cars ON cars.id_user=lessons.id_user_driver"
      + " WHERE lessons.id_user_client='" + id_user_client + "' AND lessons.status='scheduled' "));

      scheduled_lessons = scheduled_lessons.map(l => {
        console.log(l.date)
        l.type = "lesson";
        l.temp_date = l.date.split("/");
        return l
      })
  
      // scheduled_lessons = scheduled_lessons.sort((a, b) => new Date(b.date) - new Date(a.date)).reverse();
      scheduled_lessons = scheduled_lessons.sort((a, b) => new Date(b.temp_date[2], b.temp_date[1], b.temp_date[0]) - new Date(a.temp_date[2], a.temp_date[1], a.temp_date[0])).reverse()

    console.log({ scheduled_lessons, classes_credits: credits })
    return res.send({ scheduled_lessons, classes_credits: credits, last_lesson_scheduled: lesson });

  } catch (error) {
    console.log({ error })
    res.status(400).send({ error: error, error_code: "004" });
  }
});



module.exports = (app) => app.use("/lessons", router);
