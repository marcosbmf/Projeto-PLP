{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

{- Módulo responsável por definir o que é um restaurante e as funções
   relacionadas a ele.
   
   @author Gustavo
-}
module Restaurante
( Restaurante(..)
) where

--Generics e CSV
import GHC.Generics
import Data.Csv

-- text
import Data.Text
import qualified Data.Text as Text

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
data Restaurante = Restaurante { nomeRst :: Text
                               , cnpjRst :: Text
                               , senhaRst :: Text
                               , culinariaRst :: Text
                               , telefoneRst :: Text
                               , horario :: Text
                               } deriving (Show, Generic)


instance FromNamedRecord Restaurante
instance ToNamedRecord Restaurante
instance DefaultOrdered Restaurante

{-
{- Adiciona item ao menu de um restaurante.
   
   it: Item a ser adicionado
   (Restaurante n c s l menu p h t): Restaurante a ser modificado.
   Retorna o mesmo restaurante com o menu atualizado
-}
vaiProMenu :: Item -> Restaurante -> Restaurante
it `vaiProMenu` (Restaurante n c s l menu p h t) | toString it `elem` menu = Restaurante n c s l menu p h t
                                                 | otherwise = Restaurante n c s l (menu ++ [toString it]) p h t

{- Retira um item do menu de um restaurante.

   Retorna o mesmo restaurante com o menu atualizado
   
   it: Item a ser removido
   (Restaurante n c s l menu p h t): Restaurante a ser modificado. 
-}
removeDoMenu :: Item -> Restaurante -> Restaurante
removeDoMenu it (Restaurante n c s l menu p h t) = Restaurante n c s l (delete (toString it) menu) p h t

{- Insere um pedido na lista de pedidos do Restaurante
   
   Retorna o mesmo restaurante com a lista de pedidos atualizada
   
   ped: Pedido a ser adicionado
   (Restaurante n c s l menu p h t): Restaurante a ser modificado.
-}
recebePedido :: Restaurante -> Item -> Restaurante
(Restaurante n c s l m p h t) `recebePedido` ped | toString ped `elem` menu = = Restaurante n c s l m (p ++ [toString ped]) h t
                                                 | otherwise = (Restaurante n c s l m p h t)

-}