import System.IO

data Cliente = Cliente {
	name :: String,
	login :: String,
	password :: String,
	address :: String,
	phone :: String,
	cpf :: String
	--orders :: [Order]
} deriving (Show)

newCliente :: Cliente
newCliente  = do
	name <- getLine
	login <- getLine
	password <- getLine
	address <- getLine
	phone <- getLine
	cpf <- getLine
	return (Cliente name login password address phone cpf)


main :: IO()
main = do let cliente = newCliente
          putStrLn(show (name cliente))