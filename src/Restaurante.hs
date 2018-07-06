{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

{- Módulo responsável por definir o que é um restaurante e as funções
   relacionadas a ele.
   
   @author Gustavo
-}
module Restaurante
(
    rstToString,
    cadastraRestaurante,
    cadastraItem
) where

-- Estruturas
import Estruturas

-- Utilidades
import Util
import Arquivos

--Generics e CSV
import GHC.Generics
import Data.Csv

-- text
import Data.Text
import qualified Data.Text as Text

{- Cadastra um restaurante e o salva na lista de restaurantes. -} 
cadastraRestaurante :: IO()
cadastraRestaurante = do putStr "Nome: "
                         nm <- getTextLine
                         putStr "CNPJ: "
                         cn <- getTextLine
                         putStr "Senha: "
                         sn <- getTextLine
                         putStr "Tipo de cozinha: "
                         cz <- getTextLine
                         putStr "Telefone: "
                         tel <- getTextLine
                         putStr "Horário de funcionamento: "
                         hr <- getTextLine
                         saveRestaurants $ Restaurante nm cn sn cz tel hr

{- Cadastra um item em um restaurante -}
cadastraItem :: Restaurante -> IO()
cadastraItem rst = do putStr "Nome: "
                      nm <- getTextLine
                      putStr "Descrição: "
                      ds <- getTextLine
                      putStr "Preço: R$ "
                      tmp <- getLine
                      let pc = read tmp
                          novo = Item nm ds pc
                      saveItems novo rst

{- Representação textual de um restaurante

   ex.:
        Seu Olavo
        Tipo de cozinha: fast-food
        Telefone: 95555-1234
        Aberto entre 07h30 - 19h00
-}
rstToString :: Restaurante -> Text
rstToString x = Text.pack(nm ++ cz ++ tel ++ hr)
                where nm = show (nomeRst x) ++ "\n"
                      cz = "Tipo de cozinha: " ++ show (culinariaRst x) ++ "\n"
                      tel = "Telefone: " ++ show (telefoneRst x) ++ "\n"
                      hr =  "Aberto entre " ++ show (horario x) ++ "\n"