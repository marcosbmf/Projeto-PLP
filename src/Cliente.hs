{-# LANGUAGE OverloadedStrings #-}

{- Módulo com a definição do tipo Cliente e funções relacionadas a ele.
 
   @author Gustavo, Marcos Barros
-}
module Cliente
( cltToString
, novoCliente
, cltLoginCliente
, cadastraCliente
, getPedidosCliente
) where

import Estruturas
import Arquivos
import Util

-- text
import Data.Text
import qualified Data.Text as Text

{- Representação textual de um cliente.

   ex.:
        Nome: Haskell Curry
        Endereço: Rua Jaiminho, 35, Tangamandapio
        CPF: 451.467.610-19
        Login: curry
-}
cltToString :: Cliente -> String
cltToString clt = name ++ address ++ ssn ++ lgin
               where name = "Nome: " ++ show (nome clt) ++ "\n"
                     address = "Endereço: " ++ show (endereco clt) ++ "\n"
                     ssn = "CPF: " ++ show (cpf clt) ++ "\n"
                     lgin = "Login: " ++ show (login clt) ++ "\n"


{- Cria um novo cliente a partir das entradas do usuário.
Retorna IO(Cliente)
-}
novoCliente :: IO(Cliente)
novoCliente = do putStrLn("Insira o seu nome:")
                 nome <- getTextLine
                 putStrLn("Insira o seu endereço:")
                 endereco <- getTextLine
                 putStrLn("Insira o seu telefone:")
                 telefone <- getTextLine
                 putStrLn("Insira o seu CPF:")
                 cpf <- getTextLine
                 putStrLn("Insira o seu login:")
                 login <- getTextLine
                 putStrLn("Insira a sua senha:")
                 senha <- getTextLine
                 let cliente = Cliente login senha nome cpf endereco telefone
                 return cliente


{- Função para verificar se o login já existe. 

Caso exista, retorna False, que significa que o cadastro é inválido.
Caso não exista, o cadastro é válido, retorna True.
-}
verificaCadastro :: Cliente -> [Cliente] -> Bool
verificaCadastro cliente [] = True
verificaCadastro cliente [a] = False
verificaCadastro cliente clientes = verificaCadastro cliente [y | y <- clientes, show(login y) == show(login cliente)]

{-
      Função auxiliar para o cadastro dos clientes.

      clientes = o array de clientes atual.

      Retorna o array de clientes atualizado ou uma mensagem de erro caso já exista cliente com o mesmo login.
-}
cadastraClienteAux :: [Cliente] -> IO(Bool)
cadastraClienteAux clientes = do cliente <- novoCliente
                                 if verificaCadastro cliente clientes
                                    then do saveClientes cliente
                                            return True
                                    else return False


{-
      Função para cadastro de clientes. Usa cadastraCLienteAux.

      Retorna o array de clientes atualizado ou o anterior caso o cadastro tenha falhado.
-}
cadastraCliente :: IO()
cadastraCliente = do clientes <- getClientes
                     cadastro <- cadastraClienteAux clientes
                     if cadastro then putStrLn("\nCadastro realizado com sucesso!\n") else putStrLn("\nErro no cadastro. Login já existe.\n")

{-
      Recebe uma tentativa de login representada pelas strings de loginUser e senhaUser e o array atual de clientes.

      Retorna
      Left: mensagem de erro, login não teve sucesso.
      Right: Cliente com login e senha repassados, login teve sucesso.
-}
cltLoginCliente :: String -> String -> [Cliente] -> [Cliente]
cltLoginCliente loginUser senhaUser [] = []
cltLoginCliente loginUser senhaUser [a] = [a]
cltLoginCliente loginUser senhaUser clientes = cltLoginCliente (loginUser) (senhaUser) [y | y <- clientes, show (login y) == (loginUser), show (senha y) == (senhaUser)]

getPedidosCliente :: Cliente -> IO([Pedido])
getPedidosCliente clt = do pedidos <- getPedidos
                           return [y | y <- pedidos, show(cliente y) == show (nome clt)]

