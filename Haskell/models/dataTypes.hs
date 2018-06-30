import System.IO

data Item = Item {
    itemName :: String,
    itemDescription :: String,
    itemPrice :: Double
} deriving (Show)

data Order = Order {
    orderClient :: Cliente,
    orderRestaurant :: Restaurant,
    orderSituation :: String,
    orderItem :: [Item]
} deriving (Show)

data Cliente = Cliente {
    clienteName :: String,
    clienteAddress :: String,
    clientePhone :: String,
    clienteCpf :: String,
    clienteLogin :: String,
    clientePassword :: String,
    clienteOrders :: [Order]
} deriving (Show)

data Restaurant = Restaurant {
    restaurantName :: String,
    restaurantCNPJ :: String,
    restaurantPhone :: String,
    restaurantCuisine :: String,
    restaurantMenu :: [Item],
    restaurantOrders :: [Order],
    reviewSum :: Integer,
    numReviews :: Integer
} deriving (Show)


main :: IO()
main = do let cliente = Cliente "Joao" "Rua da Mata" "(83) 99192-7566" "097650" "joaozinho" "123456" []
              item = Item "Maça" "Suculenta" 10.99
              restaurant = Restaurant "Olavo's" "1" "83 99999" "fRENCH" [item] [] 10 10
              order = Order cliente restaurant "Realizado" [item]
          putStrLn (show cliente)
          putStrLn (show (itemName item))
          putStrLn (show order)