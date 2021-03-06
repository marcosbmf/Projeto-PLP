{-# LANGUAGE OverloadedStrings #-}

{- Módulo que define o que é um item e as funções relacionadas a ele.
   
   @author Gustavo
-}
module Item
( info
, toString
, listaItems 
) where

import Estruturas
import Arquivos
import Util

-- text
import Data.Text
import qualified Data.Text as Text


{- Representação textual resumida de um item.

   Retorna uma informação resumida de um item, com seu nome e preço.
   ex.: "Bolovo - R$ 3.5"
-}
info :: Item -> String
info x = Text.unpack (itemNome x) ++ " - R$ " ++  show (itemPreco x)

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
             where name = "Nome: " ++ Text.unpack (itemNome x) ++ "\n"
                   dsc = "Descricao: " ++ Text.unpack (itemDescricao x) ++ "\n"
                   price = "Preco: R$ " ++ show (itemPreco x) ++ "\n"


listaItems :: [Item] -> Int -> String
listaItems [] x = ""
listaItems [a] indice = show(indice) ++ ". " ++ info a ++ "\n"
listaItems (x:xs) indice = show(indice) ++ ". " ++ info x  ++ "\n" ++ listaItems xs (indice+1)