{-# LANGUAGE OverloadedStrings #-}

{- Módulo que define o que é um pedido e funções relacionadas.

   @author Gustavo
-}

module Pedido
( cadastraPedido
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

{-
  Verifica se já existe um pedido daquele cliente para o restaurante.
-}
verificaPedidoValido :: Cliente -> Restaurante -> [Pedido] -> Bool
verificaPedidoValido clt rst [] = True
verificaPedidoValido clt rst [a] = False
verificaPedidoValido clt rst xs = verificaPedidoValido clt rst [y | y <- xs, show(clienteId y) == show(nome clt), show(estabelecimentoId y) == show(nomeRst rst)]

cadastraPedido :: Cliente -> Restaurante -> [Item] -> IO()
cadastraPedido cliente restaurante [] = putStrLn("\n\nNenhum item no pedido. Pedido cancelado\n")
cadastraPedido clt rst items = do pedidos <- getPedidos
                                  if verificaPedidoValido clt rst pedidos
                                    then do savePedidos (criaPedido clt rst items)
                                            putStrLn ("Pedido realizado com sucesso!")
                                    else putStrLn ("Já existe um pedido deste cliente para o mesmo restaurante.")


getPrecoTotal :: [Item] -> Float
getPrecoTotal [] = 0
getPrecoTotal (x:xs) = (itemPreco x) + getPrecoTotal xs

pedidoToString :: Pedido -> String
pedidoToString x = "\n" ++ Text.unpack(estabelecimentoId x) ++ " - " ++ Text.unpack(clienteId x) ++ " - R$" ++ show (preco x)

listaPedidos :: [Pedido] -> Int -> String
listaPedido [] _= ""
listaPedido [x] indice =  show(indice) ++ ". " ++ pedidoToString x  ++ "\n"
listaPedidos (x:xs) indice =  show(indice) ++ ". " ++ pedidoToString x  ++ "\n" ++ listaPedidos xs (indice+1)