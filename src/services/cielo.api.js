const axios = require("axios");

const apiQueryUrl = 'https://apiquerysandbox.cieloecommerce.cielo.com.br'
const apiUrl = 'https://apisandbox.cieloecommerce.cielo.com.br'
const merchantId = 'e4c60d32-691b-44fd-b4bc-03f081360871'
const merchantKey = 'FWWZYEATMZGCEWDJYHQKVPVRAKLYWDAQIBPDRWCB'

const apiQuery = axios.create({
  baseURL: apiQueryUrl,
});

apiQuery.interceptors.request.use(function (config) {
  config.headers = {
    'Content-Type': 'application/json',
    'MerchantId': merchantId,
    'MerchantKey': merchantKey,
  };
  return config;
}, null, { synchronous: true });

const api = axios.create({
  baseURL: apiUrl,
});

api.interceptors.request.use(function (config) {
  config.headers = {
    'Content-Type': 'application/json',
    'MerchantId': merchantId,
    'MerchantKey': merchantKey,
  };
  return config;
}, null, { synchronous: true });


module.exports = {
  api, 
  apiQuery
}