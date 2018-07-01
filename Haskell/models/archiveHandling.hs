{-# LANGUAGE ScopedTypeVariables, DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

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
import DataTypes

-----

saveClients :: Client -> IO()
saveClients cliente = do let fileName = "Data/Clients.csv"
                         eitherClientes <- loadClients
                         case eitherClientes of 
                            Left reason -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName [cliente])
                            Right clientes -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName (V.toList(clientes) ++ [cliente]))

saveOrders :: Order -> IO()
saveOrders order = do let fileName = "Data/Orders.csv" 
                      eitherOrders <- loadOrders
                      case eitherOrders of 
                            Left reason -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName [order])
                            Right orders -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName (V.toList(orders) ++ [order]))


saveItems :: Item -> Restaurant -> IO()
saveItems item restaurant = do let fileName = "Data/Items" ++ Text.unpack(restaurantName restaurant) ++ ".csv"
                               eitherItems <- loadItems fileName
                               case eitherItems of
                                Left reason -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName [item])
                                Right items -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName (V.toList(items) ++ [item]))

saveRestaurants :: Restaurant -> IO()
saveRestaurants restaurant = do let fileName = "Data/Restaurants.csv"
                                eitherRestaurants <- loadRestaurants
                                case eitherRestaurants of
                                  Left reason -> do BL.writeFile fileName $ (encodeDefaultOrderedByName [restaurant])
                                  Right restaurants -> do BL.writeFile (fileName) $ (encodeDefaultOrderedByName (V.toList(restaurants) ++ [restaurant]))


decodeClients :: ByteString -> Either String (Vector Client)
decodeClients =
  fmap snd . decodeByName

loadClients :: IO(Either String (Vector Client))
loadClients = catchShowIO (BL.readFile "Data/Clients.csv")
                                >>= return . either Left decodeClients

decodeItems :: ByteString -> Either String (Vector Item)
decodeItems =
  fmap snd . decodeByName

loadItems :: FilePath -> IO(Either String (Vector Item))
loadItems path = catchShowIO (BL.readFile path)
                                >>= return . either Left decodeItems

decodeRestaurants :: ByteString -> Either String (Vector Restaurant)
decodeRestaurants =
  fmap snd . decodeByName

loadRestaurants :: IO(Either String (Vector Restaurant))
loadRestaurants = catchShowIO (BL.readFile "Data/Restaurants.csv")
                                >>= return . either Left decodeRestaurants

decodeOrders :: ByteString -> Either String (Vector Order)
decodeOrders =
  fmap snd . decodeByName

loadOrders :: IO(Either String (Vector Order))
loadOrders = catchShowIO (BL.readFile "Data/Orders.csv")
                                >>= return . either Left decodeOrders

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

      
{-
main :: IO()
main = do let cliente = Client "Joca" "Rua da Mata" "(83) 99192-7566" "097650" "joaozinho" "123456" 
              restaurant = Restaurant "Olavo's" "1" "83 99999" "fRENCH" 10 10
              item = Item "Maça" "Suculenta" (restaurantName restaurant) 10.99
              order = Order "clientNameRestaurantName" "clientName" "restaurantName" "Items" "Recebido." 
          saveItems item restaurant
          saveRestaurants restaurant
          saveClients cliente
          saveOrders order
-}
