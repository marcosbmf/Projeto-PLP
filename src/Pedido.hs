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

{-
{- Definição da situação em que um pedido pode estar.

   Um pedido pode estar como recebido (pelo restaurante), enviado ou entregue. 
-}
data Situacao = Recebido | Enviado | Entregue deriving (Bounded)

{- Adicionar um item ao pedido.
   
   Adiciona um item ao pedido, onde ped é um pedido e x o item a ser adicionado.
   Retorna um IO Pedido com a lista de itens atualizada.
-}
adicionar :: Pedido -> Item -> IO Pedido
ped `adicionar` x = Pedido (newItens, est, clt, sit)
                    where newItens = itens ped ++ [x]
                          est = estabelecimento ped
                          clt = cliente ped
                          sit = situacao ped

{- Remove um item do pedido.

   Remove um item do pedido, onde ped é um pedido e x o item a ser adicionado.
   Retorna um IO Pedido com a lista de itens atualizada.
-}
remover :: Pedido -> Item -> IO Pedido
ped `remover` x = Pedido (newItens, est, clt, sit)
                  where newItens = delete x $ itens ped
                        est = estabelecimento ped
                        clt = cliente ped
                        sit = situacao ped

{- Retorna o preço total do pedido.

   Retorna o preço total do pedido, que é a soma dos valores dos itens
   adicionados.
-}
precoTotal :: Pedido -> Float
precototal [] = 0
precoTotal x = sum $ itens x

{- Representação textual do pedido.

   Retorna uma representação textual do pedido.
   ex.:
        Pedido:
          > Pastel de vento - R$ 4.0
          > Caldo de cana - R$ 2.0
          > Cocada de leite condensado - R$ 2.0
        Estabelecimento: Pastelaria do Beiçola
        Cliente: Haskell Curry
        Endereço: Rua Jaiminho, 35, Tangamandapio
-}
toString :: Pedido -> String
pedido x = "Pedido:\n" ++ it ++ est ++ clt ++ end
           where it = intercalate "\n" $ map (" >" ++) info . itens x
                 est = "Estabelecimento: " ++ toString . estabelecimento x ++ "\n"
                 clt = "Cliente: " ++ toString . cliente x ++ "\n"
                 end = "Endereço: " ++ endereco . cliente x
-}