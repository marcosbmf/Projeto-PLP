{-# LANGUAGE OverloadedStrings #-}

module Util (
    getTextLine
) where

-- text
import Data.Text
import qualified Data.Text as Text

getTextLine :: IO(Text)
getTextLine = do line <- getLine
                 return (Text.pack(line))