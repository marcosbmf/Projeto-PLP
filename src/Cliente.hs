{- Módulo com a definição do tipo Cliente e funções relacionadas a ele.
 
   @author Gustavo
-}
module Cliente
( Cliente(..)
, toString
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
               where name = "Nome: " ++ login clt ++ "\n"
                     address = "Endereço: " ++ endereco clt ++ "\n"
                     ssn = "CPF: " ++ cpf clt ++ "\n"
                     lgin = "Login: " ++ login clt ++ "\n"
