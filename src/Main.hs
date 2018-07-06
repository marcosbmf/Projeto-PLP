{-# LANGUAGE OverloadedStrings #-}

import System.IO
import System.Exit

import Control.Monad
import Estruturas
import Arquivos
import Cliente
import Item
import Pedido
import Restaurante
import Util

-- text
import Data.Text
import qualified Data.Text as Text

--
import qualified GHC.List as L

main:: IO ()
main = do
    clearScreen
    putStrLn "\n|--------------------------------------------------------------------|\n|--------------------    SISTEMA DE DELIVERY    ---------------------|\n|--------------------------------------------------------------------|\nMENU\n\n"
    putStrLn "(1) Login (cliente)\n(2) Login (restaurante)\n(3) Cadastrar-se (cliente)\n(4) Cadastrar-se (restaurante)\n(5) Sair\n\n"
    op <- getLine
    if (op == "1") then loginCliente
    else if (op == "2") then loginRestaurante
    else if (op == "3") then cadastrarCliente
    else if (op == "4") then cadastrarRestaurante
    else exitSuccess

---------------------------------------------------------------------
---------------------------------------------------------------------
----------------------- FUNCOES DO CLIENTE --------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------

cadastrarCliente::IO()
cadastrarCliente = do
    clearScreen
    putStrLn "----- CADASTRAR CLIENTE -----"
    cadastraCliente
    pressEnter
    main

cadastrarRestaurante::IO()
cadastrarRestaurante = do
    clearScreen
    putStrLn "----- CADASTRAR RESTAURANTE -----"
    cadastraRestaurante
    pressEnter
    main


loginCliente:: IO ()
loginCliente = do
    clearScreen
    putStrLn "----- LOGIN CLIENTE -----"
    putStrLn "Nome de usuario: "
    usuarioLogin <- getLine
    putStrLn "Senha: "
    usuarioSenha <- getLine
    clientes <- getClientes
    let clt = cltLoginCliente usuarioLogin usuarioSenha clientes
    menuCliente clt

menuCliente:: [Cliente] -> IO ()
menuCliente [] = do putStr("\nLogin Inválido!")
                    pressEnter
                    main
menuCliente [a] = do
    clearScreen
    putStrLn ("\n--------- Bem Vindo," ++ show(nome a) ++ ". ----------\n")
    putStrLn "MENU"
    putStrLn "(1) EXIBIR TODOS OS RESTAURANTES"
    putStrLn "(2) VER PEDIDOS"
    putStrLn "(3) AVALIAR RESTAURANTE"
    putStrLn "(4) SAIR"
    op <- getLine
    if (op == "1") then exibirRestaurantes a
    -- else if (op == "2") then verPedidos
    -- else if (op == "3") then avaliarRestaurante
    else main

exibirRestaurantes :: Cliente -> IO()
exibirRestaurantes clt = do
    clearScreen
    putStrLn("\n------ Restaurantes Cadastrados -------\n\n")
    rsts <- getRestaurantes
    putStrLn(listaRestaurantes rsts 1)
    putStrLn("\n\n\nDigite o número do restaurante que quer acessar ou 0 para voltar ao menu: ")
    choice <- getLine
    if choice == "0"
        then menuCliente [clt]
        else menuCliente [clt]


fazerPedido::IO()
fazerPedido = do
    clearScreen
    putStrLn "\n-------- FAZER UM PEDIDO --------"
    putStrLn "|=|=|=| RESTAURANTES CADASTRADOS |=|=|=|"
    -- aqui vema lista de restaurantes
    putStrLn "1\n2\n3\n4\n"
    putStrLn "Selecione uma opcao"
    putStrLn "(1) VER CARDAPIO"
    putStrLn "(2) VOLTAR AO MENU\n"
    op <- getLine
    if (op == "2") then main
    else verCardapio

verCardapio::IO()
verCardapio = do
    putStrLn "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n------ Restaurantes Cadastrados -------"
    -- novamente a lista de restaurantes
    putStrLn "1\n2\n3\n4"
    putStrLn "Escolha o Restaurante: "
    -- AQUI SERA VERIFICADO SE A OPCAO EXISTE
    -- logo apos isso ira pro menu de escolha da compra
    -- o metodo devera receber o restaurante escolhido
    -- porem este eh so um metodo provisorio ja que nao
    -- estao implementados os restaurantes
    rest <- getLine
    -- AQUI VEM O METODO DA FORMA CORRETA
    confirmarPedido

confirmarPedido::IO() -- A FUNCAO DEVE RECEBER O RESTAURANTE
confirmarPedido = do
    putStrLn "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nCardapio de RESTAURANTE TAL\n\n" -- AQUI VEM O NOME
    putStrLn "Selecione uma opcao: "
    putStrLn "(1) Realizar Pedido"
    putStrLn "(2)Voltar a lista de restaurantes"
    op <- getLine
    if (op == "1") then main
    else verCardapio


---------------------------------------------------------------------
---------------------------------------------------------------------
----------------------- FUNCOES DO RESTAURANTE ----------------------
---------------------------------------------------------------------
---------------------------------------------------------------------


loginRestaurante::IO()
loginRestaurante = do
    putStrLn "----- LOGIN RESTAURANTE -----"
    putStrLn "CNPJ: "
    -- VERIFICA CPNJ CADASTRADO
    cnpjLogin <- getLine
    putStrLn "Senha: "
    -- VERIFICA SENHA CORRETA
    senhaLogin <- getLine
    putStrLn "Ola restaurante tal" -- CONCATENA A STRING
    -- AI ENTAO VAI PRA O MENU DO RESTAURANTE