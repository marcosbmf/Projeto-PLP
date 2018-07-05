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