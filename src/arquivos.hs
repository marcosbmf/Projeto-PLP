{-# LANGUAGE ScopedTypeVariables, DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Arquivos (
    getRestaurantes,
    getMenu,
    saveRestaurants,
    saveItems
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
import Item
import Restaurante

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