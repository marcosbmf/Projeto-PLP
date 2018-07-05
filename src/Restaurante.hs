{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

{- Módulo responsável por definir o que é um restaurante e as funções
   relacionadas a ele.
   
   @author Gustavo
-}
module Restaurante
( 
) where

--Generics e CSV
import GHC.Generics
import Data.Csv

-- text
import Data.Text
import qualified Data.Text as Text



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