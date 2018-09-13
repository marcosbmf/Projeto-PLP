import System.IO
import System.Exit

import Control.Monad

-- MAIN --
main = forever (printMenuPrincipal >> readChoice >>= menuPrincipalAction)

-- MENU PRINCIPAL
printMenuPrincipal = putStr "(1) Login (cliente)\n(2) Login (restaurante)\n(3) Cadastrar-se (cliente)\n(4) Cadastrar-se (restaurante)\n(5) Sair\n\n" >> hFlush stdout

menuPrincipalAction '1' = loginCliente
menuPrincipalAction '2' = loginRestaurante
menuPrincipalAction '3' = cadastraCliente
menuPrincipalAction '4' = cadastraRestaurante
menuPrincipalAction '5' = exitSuccess
menuPrincipalAction _ = hPutStrLn stderr "\nInvalid choice."

-- LOGIN CLIENTE

loginCliente = putStr"login cliente\n"

-- LOGIN RESTAURANTE

loginRestaurante = putStr "login restaurante\n"

-- MENU CADASTRO CLIENTE

cadastraCliente = putStr "------------------------------------------------\n| CADASTRAR NOVO CLIENTE ------------------------------------------------"


--MENU CADASTRO RESTAURANTE

cadastraRestaurante = putStr "------------------------------------------------\n| CADASTRAR NOVO RESTAURANTE ------------------------------------------------"


readChoice = hSetBuffering stdin NoBuffering >> hSetEcho stdin False >> getChar



