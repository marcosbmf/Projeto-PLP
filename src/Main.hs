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
import qualified Data.List as L

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
    if (op == "1") 
        then exibirRestaurantes a
        else if (op == "2") 
            then verPedidosCliente a
            else main{-if (op == "3") 
                then avaliarRestaurante
                else main-}

exibirRestaurantes :: Cliente -> IO()
exibirRestaurantes clt = do
    clearScreen
    putStrLn("\n------ Restaurantes Cadastrados -------\n\n")
    rsts <- getRestaurantes
    putStrLn(listaRestaurantes rsts 1)
    putStrLn("\n\n\nDigite o número do restaurante que quer acessar ou 0 para voltar ao menu: ")
    choice <- getLine
    if choice == "0"
        then do menuCliente [clt]
        else do if (L.length rsts) > ((read choice) - 1) 
                    then do verCardapio clt (rsts!!((read choice) - 1))
                    else do putStrLn("\n OPÇÃO INVÁLIDA!")
                            pressEnter
                            menuCliente [clt]

verCardapio :: Cliente -> Restaurante -> IO()
verCardapio clt rst = do
    clearScreen
    putStrLn ("------ " ++ Text.unpack(nomeRst rst) ++ " -------\n\n")
    putStrLn("Cardápio: \n\n")
    menu <- getMenu rst
    putStrLn(listaItems menu 1)
    putStrLn "Deseja realizar um pedido? Dgite 1 se sim ou 0 se não: "
    choice <- getLine
    if choice == "0"
        then exibirRestaurantes clt
        else fazerPedido clt rst menu []

fazerPedido:: Cliente -> Restaurante -> [Item] -> [Item] -> IO()
fazerPedido clt rst menu pedido = do
    clearScreen
    putStrLn ("------ " ++ Text.unpack(nomeRst rst) ++ " -------\n\n")
    putStrLn("Cardápio: \n\n")
    putStrLn(listaItems menu 1)
    putStrLn "\n\nSelecione uma opcao para adicionar ao pedido ou 0 para finalizar:"
    choice <- getLine
    if (choice == "0") 
        then do confirmarPedido clt rst pedido
        else do if (L.length menu) > ((read choice)-1)
                    then do adicionaItem clt rst menu pedido (menu!!((read choice)-1))
                    else do putStrLn("\n\nOpção inválida!")
                            pressEnter
                            fazerPedido clt rst menu pedido

adicionaItem :: Cliente -> Restaurante -> [Item] -> [Item] -> Item -> IO()
adicionaItem clt rst menu pedido item = do
    clearScreen
    putStrLn ("------ " ++ Text.unpack(nomeRst rst) ++ " -------\n\n")
    putStrLn "Deseja adicionar o seguinte item ao seu pedido?\n\n"
    putStrLn(toString item)
    putStrLn "Digite 1 para confirmar ou 0 para cancelar!"
    choice <- getLine
    if choice == "1"
        then do putStrLn("Item adicionado com sucesso!")
                pressEnter
                fazerPedido clt rst menu (pedido++[item])
        else do putStrLn("Adição Cancelada com sucesso!")
                pressEnter
                fazerPedido clt rst menu pedido

confirmarPedido::Cliente -> Restaurante -> [Item] -> IO() -- A FUNCAO DEVE RECEBER O RESTAURANTE
confirmarPedido clt rst items = do
    putStrLn "\n\nDeseja Confirmar o seguinte pedido?\n\n"
    let pedido = criaPedido clt rst items
    putStrLn (pedidoToString pedido)
    putStrLn "Digite 1 para confirmar ou 0 para cancelar!"
    choice <- getLine
    op <- getLine
    if (choice == "1")
        then do savePedidos pedido
                putStrLn("\nPedido realizado com sucesso!")
                pressEnter
                menuCliente [clt]
        else do putStrLn ("\nPedido cancelado com sucesso!")
                pressEnter
                menuCliente [clt]

verPedidosCliente :: Cliente -> IO()
verPedidosCliente clt = do 
    clearScreen
    putStrLn("------ Pedidos de " ++ Text.unpack(nome clt) ++ " -------\n\n")
    pedidos <- getPedidosCliente clt
    putStrLn(listaPedidos pedidos 1)
    putStrLn("\n\n------ Digite o numero do pedido que deseja visualizar ou 0 para voltar ao menu: ")
    choice <- getLine
    if choice == "0"
        then do menuCliente [clt]
        else do if (L.length pedidos) > ((read choice) - 1)
                    then do clearScreen
                            putStrLn(exibePedidoCompleto (pedidos!!((read choice) - 1)))
                            pressEnter
                            verPedidosCliente clt
                    else do putStrLn("\n\nOpção inválida!")
                            pressEnter
                            menuCliente [clt]


---------------------------------------------------------------------
---------------------------------------------------------------------
----------------------- FUNCOES DO RESTAURANTE ----------------------
---------------------------------------------------------------------
---------------------------------------------------------------------

loginRestaurante::IO()
loginRestaurante = do clearScreen
                      putStrLn "----- LOGIN RESTAURANTE -----"
                      putStrLn "CNPJ: "
                      cnpjLogin <- getLine
                      putStrLn "Senha: "
                      senhaLogin <- getLine
                      restaurantes <- getRestaurantes
                      let rst = rstLoginRestaurante cnpjLogin senhaLogin restaurantes
                      menuRestaurante rst

menuRestaurante :: [Restaurante] -> IO ()
menuRestaurante [] = do putStr("\nLogin inválido!")
                        pressEnter
                        main

menuRestaurante [a] = do clearScreen
                         putStrLn("--------- Bem-vindo, " ++ Text.unpack(nomeRst a) ++ ". ----------\n")
                         putStrLn "MENU"
                         putStrLn "(1) Adicionar prato ao seu cardápio"
                         putStrLn "(2) Remover prato do seu cardápio"
                         putStrLn "(3) Ver pedidos feitos por clientes"
                         putStrLn "(4) Sair"
                         putStrLn "\n> "
                         op <- getLine
                         if op == "1" then do clearScreen
                                              putStrLn $ "Adicionar item ao cardápio de " ++ Text.unpack(nomeRst a) ++ ":\n"
                                              cadastraItem a
                                              menuRestaurante [a]
                                      else if op == "2" then do clearScreen
                                                                putStrLn $ "Remover item do cardápio de " ++ Text.unpack(nomeRst a) ++ ":\n" 
                                                                exibeCardapio a
                                                                putStrLn "> "
                                                                i <- getLine
                                                                deletaItem (read i) a
                                                                menuRestaurante [a]
                                                        else if op == "3" then do clearScreen
                                                                                  putStrLn $ "Lista de pedidos de " ++ Text.unpack(nomeRst a) ++ ":\n"
                                                                                  pedidos <- getPedidosRestaurante a
                                                                                  putStrLn $ listaPedidos pedidos 1
                                                                               
                                                                          else if op == "4" then menuRestaurante [a]
                                                                                            else do putStrLn "Comando inválido!"
                                                                                                    pressEnter
                                                                                                    menuRestaurante[a]
