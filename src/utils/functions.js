export const gerarData = (tipo) => {
  let data = new Date();
  let hora = data.getHours() >= 10 ? data.getHours() : '0' + data.getHours();
  let minutos = data.getMinutes() >= 10 ? data.getMinutes() : '0' + data.getMinutes();
  let segundos = data.getSeconds() >= 10 ? data.getSeconds() : '0' + data.getSeconds();
  let dia = data.getDay() >= 10 ? data.getDay() : '0' + data.getDay();
  let mes = data.getMonth() >= 10 ? data.getMonth() : '0' + data.getMonth();
  let ano = data.getFullYear();

  let momento = dia + '-' + mes + '-' + ano + ' ' + hora + ':' + minutos + ':' + segundos;
  if (tipo === 'dmy') return momento.split(' ')[0];
  if (tipo === 'hora') return momento.split(' ')[1];
  if (tipo === 'data') return momento;
}

export const getFormattedDate = (date) => {

  let dia = date.getDay() >= 10 ? date.getDay() : '0' + date.getDay();
  let mes = date.getMonth() >= 10 ? date.getMonth() : '0' + date.getMonth();
  let ano = date.getFullYear();
  let moment = dia + '/' + mes + '/' + ano;
  console.log({ moment })
  return moment;
}