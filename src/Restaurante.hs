import Item
import Data.List

{- Módulo responsável por definir o que é um restaurante e as funções
   relacionadas a ele.
-}
module Restaurante
( Restaurante(..)
, Horario(..)
)

{- Construtor de um restaurante.

   nome: nome do restaurante
   cnpj: CNPJ do restaurante
   senha: senha do restaurante
   culinaria: tipo de cozinha que o restaurante trabalha (ex.: mexicana)
   menu: os pratos que o restaurante vende
   pedidos: uma lista de pedidos feitos pelo restaurante
   resenha: a nota do restaurante dada pelos seus frequentadores
   horario: horário de funcionamento do restaurante
   telefone: número de telefone do estabelecimento
-}
data Restaurante = Restaurante { nome :: String
                               , cnpj :: String
                               , senha :: String
                               , culinaria :: String
                               , menu :: [Item]
                               , pedidos :: [Pedido]
                               , horario :: (Horario, Horario)
                               , telefone :: String
                               } deriving (Show)

{- Construtor de um horário de funcionamento
-}
data Horario = Horario { abre :: (Int, Int)
                       , fecha :: (Int, Int)
                       } deriving (Show)