{-# LANGUAGE OverloadedStrings #-}

{- Módulo que define o que é um pedido e funções relacionadas.

   @author Gustavo
-}

module Pedido
( criaPedido,
  listaPedidos,
  pedidoToString,
  exibePedidoCompleto
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
criaPedido clt rst items = Pedido (Text.pack(listaItems items 1)) (nomeRst rst) (Text.pack(rstToString rst)) (nome clt) (Text.pack(cltToString clt)) (getPrecoTotal items)

getPrecoTotal :: [Item] -> Float
getPrecoTotal [] = 0
getPrecoTotal (x:xs) = (itemPreco x) + getPrecoTotal xs

pedidoToString :: Pedido -> String
pedidoToString x = "\n" ++ Text.unpack(estabelecimentoId x) ++ " - " ++ Text.unpack(clienteId x) ++ " - R$" ++ show (preco x)

exibePedidoCompleto :: Pedido -> String
exibePedidoCompleto x = clt ++ rst ++ items
                        where clt = Text.unpack(cliente x)
                              rst = Text.unpack(estabelecimento x)
                              items = Text.unpack(itens x)


listaPedidos :: [Pedido] -> Int -> String
listaPedidos [] indice = "\n\nNenhum Pedido Cadastrado."
listaPedidos [a] indice =  show(indice) ++ ". " ++ pedidoToString a  ++ "\n"
listaPedidos (y:ys) indice =  show(indice) ++ ". " ++ pedidoToString y  ++ "\n" ++ (listaPedidos ys (indice+1))