-----------------------------------------------------
-- 
-- Sistema de Delivery em Haskell
-- 
-- Grupo -	José Ramon Fragoso da Silva - 116210412
-- 			Marcos - 
-- 			Matheus Eduardo - 
-- 			Lucas Jhonanta - 
-- 			Gustavo - 
-----------------------------------------------------

-- printMenuHeader :: IO ()
-- printMenuHeader = do
-- 	putStr "\n|--------------------------------------------------------------------|\n|--------------------    SISTEMA DE DELIVERY    ---------------------|\n|--------------------------------------------------------------------|\nMENU\n\n"

-- printMainMenu :: IO ()
-- printMainMenu = do
-- 	putStr "(1) Login (cliente)\n(2) Login (restaurante)\n(3) Cadastrar-se (cliente)\n(4) Cadastrar-se (restaurante)\n(5) Sair\n\n"

-- printMenuCadastroCliente :: IO()
-- printMenuCadastroCliente = do
-- 	putStr "------------------------------------------------\n| CADASTRAR NOVO CLIENTE ------------------------------------------------"

-- printMenuCadastroRestaurante :: IO()
-- printMenuCadastroRestaurante = do
-- 	putStr "------------------------------------------------\n| CADASTRAR NOVO RESTAURANTE ------------------------------------------------"

mainMenu :: Int -> IO()
mainMenu 3 = "dsa3"
mainMenu op = mainMenu op
	-- printMenuHeader
	-- printMainMenu





main :: IO()
main = do
	mainMenu 4
