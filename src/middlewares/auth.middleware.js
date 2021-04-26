// import express from "express";
// import chalk from "chalk";
// import Token, { gerarToken } from "../models/token.model";
// import User from "../models/user.model";

// // Intercepta as rotas onde o middleware estiver inserido
// // 1. Verifica se a ação é de login ou de cadastro
// // 2. Verifica o token passado na requisição

// export default async (
//   req,
//   res,
//   next
// ) => {
//   // Início do Passo 1
//   console.log(chalk.bgBlue('[ req.body - auth.middleware ]'));
//   console.log(chalk.blue(JSON.stringify(req.body)));

//   // Verifica se a ação é de login, se for, passa sem verificar o token
//   if (req.body.acao == "login") return next();

//   // Verifica se a ação é de cadastro de usuário, se for, passa sem verificar o token
//   // if (req.body.acao == "cadastroDeUsuario") return next();
//   // Fim do Passo 1

//   // Início do Passo 2

//   // Pega os valores passados no campo chave do corpo da requisição
//   const authHeader = req.body.chave;

//   // Se o campo chave não existir, o token não foi passado
//   if (!authHeader) return res.status(401).send({ erro: "Token não enviado" });

//   // Busca o token no banco
//   let token: any = await Token.findOne(authHeader);

//   // Verifica se o token não existe (não é válido)
//   if (!token) return res.status(401).send({ erro: "Token não encontrado" });

//   // Se o token existir...
//   else {
    
//     // Verifica se o token expirou
//     if (Date.now() > token.dataExpiracao)
//       return res.status(401).send({ erro: "Token expirado" });

//     // Atualiza o token do usuário, gerando um novo token, sobrepondo o antigo no banco e gravando no campo novaChave do body
//     req.body = {
//       ...req.body,
//       novaChave: await Token.findOneAndUpdate(
//         authHeader,
//         gerarToken(authHeader.usuarioID),
//         { new: true }
//       )
//     };

//     // Fim do Passo 2

//     return next();
//   }
// };
