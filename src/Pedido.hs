import Item
import Cliente
import Restaurante
import Data.List

{- Módulo que define o que é um pedido e funções relacionadas.

   @author Gustavo
-}

module Pedido
( Pedido(..)
, adicionar
, remover
, precoTotal
, situacao
, toString
)

{- Construtor de um pedido.

   Um pedido feito por um cliente em um restaurante possui um ou mais itens.
   Além disto, nas informações do pedido temos algumas informações sobre o
   estabelecimento e o cliente.
   
   itens: lista dos itens incluídos no pedido
   estabelecimento: estabelecimento em que o pedido foi feito
   cliente: cliente que fez o pedido
   situacao: situação do pedido
-}
data Pedido = Pedido { itens :: [Item]
                     , estabelecimento :: Restaurante
                     , cliente :: Cliente
                     , situacao :: Situacao
                     } deriving (Show)

{- Definição da situação em que um pedido pode estar.

   Um pedido pode estar como recebido (pelo restaurante), enviado ou entregue. 
-}
data Situacao = Recebido | Enviado | Entregue deriving (Bounded)

{- Adicionar um item ao pedido.
   
   Adiciona um item ao pedido, onde ped é um pedido e x o item a ser adicionado.
-}
adicionar :: Pedido -> Item -> ()
ped `adicionar` x =