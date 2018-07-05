{- Módulo que define o que é um item e as funções relacionadas a ele.
   
   @author Gustavo
-}
module Item
( Item(..)
, info
, toString
) where

{- Construtor de um item.
   
   Um item pode ser um lanche, doce, água, refrigerante, cerveja, etc.
   
   nome: nome do item
   descricao: breve descricao sobre o que é o item
   preco: preco em reais do item
-}
data Item = Item { nome :: String
                 , descricao :: String
                 , preco :: Float
                 } deriving (Show)

{- Representação textual resumida de um item.

   Retorna uma informação resumida de um item, com seu nome e preço.
   ex.: "Bolovo - R$ 3.5"
-}
info :: Item -> String
info x = nome x ++ " - R$ " ++ show (preco x)

{- Representação textual completa de um item.
   
   Retorna uma descrição completa de um item, com seu nome, descrição e preço.
   ex.:
        Nome: Bolovo
        Descrição: Típico quitute de bar. Um ovo cozido envolto em massa
        de batata e trigo empanada e frita em óleo muito quente.
        Preço: R$ 3.5
-}
toString :: Item -> String
toString x = name ++ dsc ++ price
             where name = "Nome: " ++ nome x ++ "\n"
                   dsc = "Descrição: " ++ descricao x ++ "\n"
                   price = "Preço: R$ " ++ show (preco x) ++ "\n"