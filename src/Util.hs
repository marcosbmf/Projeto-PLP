{-# LANGUAGE OverloadedStrings #-}

module Util (
    getTextLine,
    clearScreen,
    pressEnter
) where

-- text
import Data.Text
import qualified Data.Text as Text
import qualified System.Process as SP

pressEnter :: IO()
pressEnter = do putStr("\n\nDigite enter para continuar!\n\n")
                _ <- getLine
                return()

clearScreen :: IO ()
clearScreen = do _ <- SP.system "reset"
                 return ()

getTextLine :: IO(Text)
getTextLine = do line <- getLine
                 return (Text.pack(line))