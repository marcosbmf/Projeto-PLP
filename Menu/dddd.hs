import System.IO
import System.Exit

import Control.Monad

main:: IO ()
main = do
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

loginCliente:: IO ()
loginCliente = do
    putStrLn "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n----- LOGIN CLIENTE -----"
    putStrLn "Nome de usuario: "
    usuarioLogin <- getLine
    putStrLn "Senha: "
    usuarioLogin <- getLine
    -- VERIFICA SE USUARIO EXISTE E SE SENHA ESTA CORRETA
    -- if (verificaUsuario USUARIO) then menuCliente
    -- else main
    menuCliente

menuCliente::IO ()
menuCliente = do
    putStrLn "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n---------- Bem Vindo ----------\n"
    putStrLn "MENU"
    putStrLn "(1) EXIBIR TODOS OS RESTAURANTES"
    putStrLn "(2) VER PEDIDOS"
    putStrLn "(3) AVALIAR RESTAURANTE"
    putStrLn "(4) SAIR"
    op <- getLine
    if (op == "1") then fazerPedido
    -- else if (op == "2") then verPedidos
    -- else if (op == "3") then avaliarRestaurante
    else main

fazerPedido::IO()
fazerPedido = do
    putStrLn "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n-------- FAZER UM PEDIDO --------"
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

cadastrarCliente::IO()
cadastrarCliente = do
    putStrLn "----- CADASTRAR CLIENTE -----"
    putStrLn "Digite seu nome: "
    nomeCadastro <- getLine
    putStrLn "Insira seu CPF: "
    cpfCadastro <- getLine
    putStrLn "Insira seu telefone: "
    telefoneCadastro <- getLine
    putStrLn "Digite seu endereco: "
    enderecoCadastro <- getLine
    putStrLn "Escolha um nome de usuario: "
    usuarioCadastro <- getLine
    -- NESSA PARTE DEVE SE VERIFICAR SE JA EXISTE, CASO SIM RETORNA AO MENU INICIAL
    putStrLn "Escolha uma senha: "
    senhaCadastro <- getLine
    putStrLn "-------- Usuario Cadastrado ----------"
    main

cadastrarRestaurante::IO()
cadastrarRestaurante = do
    putStrLn "----- CADASTRAR RESTAURANTE -----"
    putStrLn "Nome do restaurante: "
    loginRestCadastro <- getLine
    putStrLn "CNPJ (este sera seu login!!!): "
    cpnjCadastro <- getLine
    putStrLn "Telefone: "
    telefoneRestCadastro <- getLine
    putStrLn "Estilo de cozinha: "
    cozinhaCadastro <- getLine
    putStrLn "Aberto a partir de "
    horarioAbre <- getLine
    putStrLn "Fecha as: "
    horarioFecha <- getLine
    putStrLn "Senha: "
    senhaRestCadastro <- getLine
    putStrLn "CADASTROU MENINOOOO"
    main
