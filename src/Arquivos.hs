{-# LANGUAGE ScopedTypeVariables, DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

{- Módulo que gerencia os arquivos do programa.
 
   @author Marcos Barros
-}
module Arquivos (
    getRestaurantes,
    getMenu,
    saveRestaurants,
    saveItems,
    saveClientes,
    getClientes,
    savePedidos,
    getPedidos
) where

-- base
import Control.Exception (IOException)
import qualified Control.Exception as Exception
import qualified Data.Foldable as Foldable
import qualified Control.Monad as Monad
import qualified System.Exit as Exit

-- bytestring
import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as BL

-- cassava
import Data.Csv

-- text
import Data.Text (Text)
import qualified Data.Text as Text

-- vector
import Data.Vector (Vector)
import qualified Data.Vector as V

import GHC.Generics
import Estruturas

{-
    Funções referentes a item.
-}

decodeItems :: ByteString -> Either String (Vector Item)
decodeItems =
  fmap snd . decodeByName

loadItems :: FilePath -> IO(Either String (Vector Item))
loadItems path = catchShowIO (BL.readFile path)
                                >>= return . either Left decodeItems

{-
    Adiciona um item ao arquivo do restaurante.
-}
saveItems :: Item -> Restaurante -> IO()
saveItems item restaurante = do let fileName = "Data/Items" ++ Text.unpack(nomeRst restaurante) ++ ".csv"
                                eitherItems <- loadItems fileName
                                case eitherItems of
                                    Left reason -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName [item])
                                    Right items -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName (V.toList(items) ++ [item]))

{-
    Retorna o array de items do restaurante.
-}
getMenu :: Restaurante -> IO([Item])
getMenu restaurante = do let fileName = "Data/Items" ++ Text.unpack(nomeRst restaurante) ++ ".csv"
                         eitherItems <- loadItems fileName
                         case eitherItems of
                            Left reason -> return []
                            Right menu -> return (V.toList(menu))



{-
    Funções referentes a Restaurante.
-}

decodeRestaurants :: ByteString -> Either String (Vector Restaurante)
decodeRestaurants =
  fmap snd . decodeByName

loadRestaurants :: IO(Either String (Vector Restaurante))
loadRestaurants = catchShowIO (BL.readFile "Data/Restaurants.csv")
                                >>= return . either Left decodeRestaurants


{-
   Adiciona um restaurante à lista.
-}
saveRestaurants :: Restaurante -> IO()
saveRestaurants restaurante = do let fileName = "Data/Restaurants.csv"
                                 eitherRestaurants <- loadRestaurants
                                 case eitherRestaurants of
                                    Left reason -> do BL.writeFile fileName $ (encodeDefaultOrderedByName [restaurante])
                                    Right restaurants -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName (V.toList(restaurants) ++ [restaurante]))

{-
  Retorna lista de restaurantes.
-}
getRestaurantes :: IO([Restaurante])
getRestaurantes = do eitherRestaurants <- loadRestaurants
                     case eitherRestaurants of
                        Left reason -> do return []
                        Right restaurants -> do return (V.toList(restaurants))


{-
    Funções relativas ao cliente.
-}

decodeClients :: ByteString -> Either String (Vector Cliente)
decodeClients =
  fmap snd . decodeByName

loadClients :: IO(Either String (Vector Cliente))
loadClients = catchShowIO (BL.readFile "Data/Clients.csv")
                                >>= return . either Left decodeClients

{-
   Adiciona um cliente à lista.
-}
saveClientes :: Cliente -> IO()
saveClientes cliente = do let fileName = "Data/Clients.csv"
                          eitherClientes <- loadClients
                          case eitherClientes of 
                            Left reason -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName [cliente])
                            Right clientes -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName (V.toList(clientes) ++ [cliente]))

getClientes :: IO([Cliente])
getClientes = do eitherClientes <- loadClients
                 case eitherClientes of
                  Left reason -> return []
                  Right clientes -> return (V.toList(clientes))


{-
  Funções referentes aos pedidos
-}

decodeOrders :: ByteString -> Either String (Vector Pedido)
decodeOrders =
  fmap snd . decodeByName

loadOrders :: IO(Either String (Vector Pedido))
loadOrders = catchShowIO (BL.readFile "Data/Orders.csv")
                                >>= return . either Left decodeOrders

savePedidos :: Pedido -> IO()
savePedidos order = do let fileName = "Data/Orders.csv" 
                       eitherOrders <- loadOrders
                       case eitherOrders of 
                            Left reason -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName [order])
                            Right orders -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName (V.toList(orders) ++ [order]))

getPedidos :: IO([Pedido])
getPedidos = do eitherPedidos <- loadOrders
                case eitherPedidos of
                  Left reason -> return []
                  Right pedidos -> return (V.toList(pedidos))

{-
    Exceção.
-}
catchShowIO :: IO a -> IO (Either String a)
catchShowIO action =
  fmap Right action
    `Exception.catch` handleIOException
  where
    handleIOException
      :: IOException
      -> IO (Either String a)
    handleIOException =
      return . Left . show