{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

{- Módulo que define o que é um item e as funções relacionadas a ele.
   
   @author Gustavo
-}
module Item
( Item(..)
, info
, toString
, novoItem
) where

--Generics e CSV
import GHC.Generics
import Data.Csv

-- text
import Data.Text
import qualified Data.Text as Text

{- Construtor de um item.
   
   Um item pode ser um lanche, doce, água, refrigerante, cerveja, etc.
   
   nome: nome do item
   descricao: breve descricao sobre o que é o item
   preco: preco em reais do item
-}
data Item = Item { nome :: Text
                 , descricao :: Text
                 , preco :: Float
                 } deriving (Show, Generic)

instance FromNamedRecord Item
instance ToNamedRecord Item
instance DefaultOrdered Item

{- Representação textual resumida de um item.

   Retorna uma informação resumida de um item, com seu nome e preço.
   ex.: "Bolovo - R$ 3.5"
-}
info :: Item -> String
info x = show (nome x) ++ " - R$ " ++  show (preco x)

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
             where name = "Nome: " ++ show (nome x) ++ "\n"
                   dsc = "Descricao: " ++ show (descricao x) ++ "\n"
                   price = "Preco: R$ " ++ show (preco x) ++ "\n"


novoItem :: IO (Item)
novoItem = do putStrLn("Insira o nome do item:")
              nome <- getLine
              putStrLn("Insira a descrição do item:")
              descricao <- getLine
              putStrLn("Insira o preço do item em R$:")
              preco <- getLine
              return (Item (Text.pack(nome)) (Text.pack(descricao)) (read preco))

