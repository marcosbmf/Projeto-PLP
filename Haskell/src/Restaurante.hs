{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

{- Módulo responsável por definir o que é um restaurante e as funções
   relacionadas a ele.
   
   @author Gustavo
-}
module Restaurante where

-- Estruturas
import Estruturas
import Item

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
cadastraRestaurante = do putStrLn "Nome: "
                         nm <- getTextLine
                         putStrLn "CNPJ: "
                         cn <- getTextLine
                         putStrLn "Senha: "
                         sn <- getTextLine
                         putStrLn "Tipo de cozinha: "
                         cz <- getTextLine
                         putStrLn "Telefone: "
                         tel <- getTextLine
                         putStrLn "Horário de funcionamento: "
                         hr <- getTextLine
                         let restaurante = Restaurante nm cn sn cz tel hr
                         rsts <- getRestaurantes
                         if (verificaCadastroRestaurante restaurante rsts)
                            then do saveRestaurants $ restaurante
                                    putStrLn ("\n\nCadastro realizado com sucesso!\n")
                                    return()
                            else do putStrLn ("\n\nErro no cadastro, CNPJ já cadastrado!")
                                    return()

verificaCadastroRestaurante :: Restaurante -> [Restaurante] -> Bool
verificaCadastroRestaurante rst [] = True
verificaCadastroRestaurante rst [a] = False
verificaCadastroRestaurante rst rsts = verificaCadastroRestaurante rst [y | y <- rsts, Text.unpack(cnpjRst y) == Text.unpack(cnpjRst rst)]

{- Cadastra um item em um restaurante -}
cadastraItem :: Restaurante -> IO()
cadastraItem rst = do putStrLn "Nome: "
                      nm <- getTextLine
                      putStrLn "Descrição: "
                      ds <- getTextLine
                      putStrLn "Preço em R$: "
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
rstToString :: Restaurante -> String
rstToString x = nm ++ cz ++ tel ++ hr
                where nm = Text.unpack(nomeRst x) ++ ", "
                      cz = "Tipo de cozinha: " ++ Text.unpack(culinariaRst x) ++ ", "
                      tel = "Telefone: " ++ Text.unpack(telefoneRst x) ++ ", "
                      hr =  "Aberto entre " ++ Text.unpack(horario x) ++ ", "

{- Representação textual de um cardápio de um restaurante
   
   ex.:
        Cardápio de Seu Olavo
        ---
        1. Coxinha - R$ 2.0
        2. Franburguer - R$ 4.0
        3. Biscoito Treloso - R$ 2.0
        ---
-}
exibeCardapio :: Restaurante -> IO()
exibeCardapio rst = do menu <- getMenu rst
                       putStrLn ("Cardápio de " ++ Text.unpack(nomeRst rst) ++ "\n---\n" ++ listaItems menu 1 ++ "---")

listaRestaurantes :: [Restaurante] -> Int -> String
listaRestaurantes [] _ = "\n\n\nNenhum restaurante cadastrado!\n\n\n"
listaRestaurantes [a] indice = "\n" ++ show(indice) ++ " - " ++ show(rstToString a)
listaRestaurantes (x:xs) indice = "\n" ++ show(indice) ++ " - " ++ show(rstToString x) ++ listaRestaurantes xs (indice+1)

getPedidosRestaurante :: Restaurante -> IO([Pedido])
getPedidosRestaurante rst = do ords <- getPedidos
                               return [y | y <- ords, Text.unpack(estabelecimentoId y) == Text.unpack(nomeRst rst)]


rstLoginRestaurante :: String -> String -> [Restaurante] -> [Restaurante]
rstLoginRestaurante loginUser senhaUser [] = []
rstLoginRestaurante loginUser senhaUser [a] = [a]
rstLoginRestaurante loginUser senhaUser xs = rstLoginRestaurante loginUser senhaUser [y | y <- xs, loginUser == Text.unpack(cnpjRst y), senhaUser == Text.unpack(senhaRst y)]