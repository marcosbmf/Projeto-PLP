{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module DataTypes where

import GHC.Generics
import Data.Csv

-- base
import Control.Exception (IOException)
import qualified Control.Exception as Exception
import qualified Data.Foldable as Foldable

-- bytestring
import Data.ByteString.Lazy (ByteString)
import qualified Data.ByteString.Lazy as BL

-- cassava
import Data.Csv

-- text
import Data.Text (Text)
import qualified Data.Text.Encoding as Text

-- vector
import Data.Vector (Vector)
import qualified Data.Vector as V

data Item = Item {
    --Nome do item.
    itemName :: Text,
    -- Informações do item.
    itemDescription :: Text,
    --Informações do restaurante.
    itemRestaurant :: Text,
    -- Preço do item.
    itemPrice :: Double
} deriving (Eq, Generic, Show)

data Order = Order {
    --A ideia é que orderId seja uma combinação.
    orderId :: Text,
    orderClient :: Text,
    orderRestaurant :: Text,
    orderItems :: Text,
    orderSituation :: Text
} deriving (Eq,Generic, Show)

data Client = Client {
    clientName :: Text,
    clientAddress :: Text,
    clientPhone :: Text,
    clientCpf :: Text,
    clientLogin :: Text,
    clientPassword :: Text
} deriving (Eq,Generic, Show)

data Restaurant = Restaurant {
    restaurantName :: Text,
    restaurantCNPJ :: Text,
    restaurantPhone :: Text,
    restaurantCuisine :: Text,
    reviewSum :: Integer,
    numReviews :: Integer
} deriving (Eq, Generic, Show)

instance FromNamedRecord Item
instance ToNamedRecord Item
instance DefaultOrdered Item

instance FromNamedRecord Restaurant
instance ToNamedRecord Restaurant
instance DefaultOrdered Restaurant

instance FromNamedRecord Client
instance ToNamedRecord Client
instance DefaultOrdered Client

instance FromNamedRecord Order
instance ToNamedRecord Order
instance DefaultOrdered Order