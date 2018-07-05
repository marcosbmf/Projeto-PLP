{- Módulo responsável por definir o que é um restaurante e as funções
   relacionadas a ele.
   
   @author Gustavo
-}
module Restaurante
( Restaurante(..)
, Horario(..)
, vaiProMenu
, removeDoMenu
) where

import Item
import Data.List

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
data Restaurante = Restaurante { nomeRst :: String
                               , cnpjRst :: String
                               , senhaRst :: String
                               , culinariaRst :: String
                               , menuRst :: [String]
                               , pedidosRst :: [String]
                               , horarioRst :: Horario
                               , telefoneRst :: String
                               } deriving (Show)

{- Construtor de um horário de funcionamento
-}
data Horario = Horario { abre :: (Int, Int)
                       , fecha :: (Int, Int)
                       } deriving (Show)

{- Adiciona item ao menu de um restaurante.
   
   Retorna o mesmo restaurante com o menu atualizado
-}
vaiProMenu :: Item -> Restaurante -> Restaurante
it `vaiProMenu` Restaurante n c s l menu p h t = Restaurante n c s l (menu ++ [toString it]) p h t

{- Retira um item do menu de um restaurante.

   Retorna o mesmo restaurante com o menu atualizado
-}
removeDoMenu :: Item -> Restaurante -> Restaurante
removeDoMenu it (Restaurante n c s l menu p h t) = Restaurante n c s l (delete (toString it) menu) p h t
