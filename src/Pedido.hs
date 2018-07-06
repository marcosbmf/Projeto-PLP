{-# LANGUAGE OverloadedStrings #-}

{- Módulo que define o que é um pedido e funções relacionadas.

   @author Gustavo
-}

module Pedido
( criaPedido,
  listaPedidos,
  pedidoToString
) where

import Estruturas
import Arquivos
import Util
import Restaurante
import Cliente
import Item

-- text
import Data.Text
import qualified Data.Text as Text


criaPedido :: Cliente -> Restaurante -> [Item] -> Pedido
criaPedido clt rst items = Pedido (Text.pack(listaItems items 1)) (nomeRst rst) (rstToString rst) (nome clt) (Text.pack(cltToString clt)) (getPrecoTotal items)

getPrecoTotal :: [Item] -> Float
getPrecoTotal [] = 0
getPrecoTotal (x:xs) = (itemPreco x) + getPrecoTotal xs

pedidoToString :: Pedido -> String
pedidoToString x = "\n" ++ Text.unpack(estabelecimentoId x) ++ " - " ++ Text.unpack(clienteId x) ++ " - R$" ++ show (preco x)

listaPedidos :: [Pedido] -> Int -> String
listaPedido [] _= ""
listaPedido [x] indice =  show(indice) ++ ". " ++ pedidoToString x  ++ "\n"
listaPedidos (x:xs) indice =  show(indice) ++ ". " ++ pedidoToString x  ++ "\n" ++ listaPedidos xs (indice+1)