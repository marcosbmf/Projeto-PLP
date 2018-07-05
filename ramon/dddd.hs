main:: IO ()
main = do
    putStr "\n|--------------------------------------------------------------------|\n|--------------------    SISTEMA DE DELIVERY    ---------------------|\n|--------------------------------------------------------------------|\nMENU\n\n"
    putStr "(1) Login (cliente)\n(2) Login (restaurante)\n(3) Cadastrar-se (cliente)\n(4) Cadastrar-se (restaurante)\n(5) Sair\n\n"
    op <- getLine
    if (op == "1") then menuCliente
    else if (op == "2") then menuRestaurante
    else if (op == "3") then cadastrarCliente
    else if (op == "4") then cadastrarRestaurante
    else putStr "ADEUS MEU ANJO"


menuCliente:: IO ()
menuCliente = do
    putStr "----- LOGIN CLIENTE -----"
    putStr "Nome de usuario: "
    usuarioLogin <- getLine
    putStr "Senha: "
    senhaLogin <- getLine
    putStr "\nSeja bem vindo" 

menuRestaurante::IO()
menuRestaurante = do
    putStr "----- LOGIN RESTAURANTE -----"
    putStr "CNPJ: "
    -- VERIFICA CPNJ CADASTRADO
    cnpjLogin <- getLine
    putStr "Senha: "
    -- VERIFICA SENHA CORRETA
    senhaLogin <- getLine
    put "Ola restaurante tal" -- CONCATENA A STRING
    -- AI ENTAO VAI PRA O MENU DO RESTAURANTE

cadastrarCliente::IO()
cadastrarCliente = do
    putStr "----- CADASTRAR CLIENTE -----"
    putStr "Digite seu nome: "
    nomeCadastro <- getLine
    putStr "Insira seu CPF: "
    cpfCadastro <- getLine
    putStr "Insira seu telefone: "
    telefoneCadastro <- getLine
    putStr "Digite seu endereco: "
    enderecoCadastro <- getLine
    putStr "Escolha um nome de usuario: "
    usuarioCadastro <- getLine
    -- NESSA PARTE DEVE SE VERIFICAR SE JA EXISTE, CASO SIM RETORNA AO MENU INICIAL
    putStr "Escolha uma senha: "
    senhaCadastro <- getLine
    putStr "-------- Usuario Cadastrado ----------"



cadastrarRestaurante::IO()
cadastrarRestaurante = do
    putStr "----- CADASTRAR RESTAURANTE -----"
    putStr "Nome do restaurante: "
    loginRestCadastro <- getLine
    putStr "CNPJ (este sera seu login!!!): "
    cpnjCadastro <- getLine
    putStr "Telefone: "
    telefoneRestCadastro <- getLine
    putStr "Estilo de cozinha: "
    cozinhaCadastro <- getLine
    putStr "Aberto a partir de "
    horarioAbre <- getLine
    putStr "Fecha as: "
    horarioFecha <- getLine
    putStr "Senha: "
    senhaRestCadastro <- getLine
    putStr "CADASTROU MENINOOOO"