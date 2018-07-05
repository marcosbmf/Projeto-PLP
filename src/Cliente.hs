{- Módulo com a definição do tipo Cliente e funções relacionadas a ele.
 
   @author Gustavo, Marcos Barros
-}
module Cliente
( Cliente(..)
, toString
, novoCliente
, cadastraPedido
, loginCliente
, cadastraCliente
) where

{- Construtor do tipo Cliente.
   
   login: login do Cliente no sistema de delivery
   senha: a senha do Cliente para acessar o sistema de delivery
   nome: nome do cliente
   cpf: cadastro de pessoa física
   endereco: endereço para entrega
   pedidos: lista de pedidos realizados pelo cliente 
-}
data Cliente = Cliente { login :: String
                       , senha :: String
                       , nome :: String
                       , cpf :: String
                       , endereco :: String
                       , telefone :: String
                       , pedidos :: [String]
                       } deriving (Show)
               
{- Representação textual de um cliente.

   ex.:
        Nome: Haskell Curry
        Endereço: Rua Jaiminho, 35, Tangamandapio
        CPF: 451.467.610-19
        Login: curry
-}
toString :: Cliente -> String
toString clt = name ++ address ++ ssn ++ lgin
               where name = "Nome: " ++ nome clt ++ "\n"
                     address = "Endereço: " ++ endereco clt ++ "\n"
                     ssn = "CPF: " ++ cpf clt ++ "\n"
                     lgin = "Login: " ++ login clt ++ "\n"


{- Cria um novo cliente a partir das entradas do usuário.
Retorna IO(Cliente)
-}
novoCliente :: IO(Cliente)
novoCliente = do putStrLn("Insira o seu nome:")
                 nome <- getLine
                 putStrLn("Insira o seu endereço:")
                 endereco <- getLine
                 putStrLn("Insira o seu telefone:")
                 telefone <- getLine
                 putStrLn("Insira o seu CPF:")
                 cpf <- getLine
                 putStrLn("Insira o seu login:")
                 login <- getLine
                 putStrLn("Insira a sua senha:")
                 senha <- getLine
                 let cliente = Cliente login senha nome cpf endereco telefone []
                 return cliente


{- Função para verificar se o login já existe. 

Caso exista, retorna False, que significa que o cadastro é inválido.
Caso não exista, o cadastro é válido, retorna True.
-}
verificaCadastro :: Cliente -> [Cliente] -> Bool
verificaCadastro cliente [] = True
verificaCadastro cliente [a] = False
verificaCadastro cliente clientes = verificaCadastro cliente [y | y <- clientes, login y == (login cliente)]

{-
      Função auxiliar para o cadastro dos clientes.

      clientes = o array de clientes atual.

      Retorna o array de clientes atualizado ou uma mensagem de erro caso já exista cliente com o mesmo login.
-}
cadastraClienteAux :: [Cliente] -> IO(Either String [Cliente])
cadastraClienteAux clientes = do cliente <- novoCliente
                                 if verificaCadastro cliente clientes
                                    then return (Right (clientes ++ [cliente]))
                                    else return (Left "Login já existe, cadastro não realizado.")


{-
      Função para cadastro de clientes. Usa cadastraCLienteAux.

      clientes = o array de clientes atual.

      Retorna o array de clientes atualizado ou o anterior caso o cadastro tenha falhado.
-}
cadastraCliente :: [Cliente] -> IO([Cliente])
cadastraCliente clientes = do eitherClientes <- cadastraClienteAux clientes
                              case eitherClientes of
                                    Right novoClientes -> return novoClientes
                                    Left reason -> do putStrLn("Um cliente com o mesmo login foi detectado, cadastro não realizado.")
                                                      return clientes


{-
      Recebe a string que representa o pedido e o cliente, retorna o cliente atualizado com o novo pedido.
-}
cadastraPedido :: String -> Cliente -> Cliente
cadastraPedido pedido cliente = Cliente (login cliente) (senha cliente) (nome cliente) (cpf cliente) (endereco cliente) (telefone cliente) ((pedidos cliente) ++ [pedido])

{-
      Recebe uma tentativa de login representada pelas strings de loginUser e senhaUser e o array atual de clientes.

      Retorna
      Left: mensagem de erro, login não teve sucesso.
      Right: Cliente com login e senha repassados, login teve sucesso.
-}
loginCliente :: String -> String -> [Cliente] -> Either String Cliente
loginCliente loginUser senhaUser [] = Left "Login e senha inválidos."
loginCliente loginUser senhaUser [a] = Right a
loginCliente loginUser senhaUser clientes = loginCliente (loginUser) (senhaUser) [y | y <- clientes, (login y) == (loginUser), (senha y) == (senhaUser)]