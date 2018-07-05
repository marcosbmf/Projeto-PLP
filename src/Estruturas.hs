{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Estruturas (
  Item(..),
  Restaurante(..),
  Cliente(..),
  Pedido(..)
) where

--Generics e CSV
import GHC.Generics
import Data.Csv

-- text
import Data.Text
import qualified Data.Text as Text

{- Construtor de um item.
   
   Um item pode ser um lanche, doce, água, refrigerante, cerveja, etc.
   
   nome: nome do item
   descricao: breve descricao sobre o que é o item
   preco: preco em reais do item
-}
data Item = Item { itemNome :: Text
                 , itemDescricao :: Text
                 , itemPreco :: Float
                 } deriving (Show, Generic)

instance FromNamedRecord Item
instance ToNamedRecord Item
instance DefaultOrdered Item

{- Construtor de um restaurante.

   nome: nome do restaurante
   cnpj: CNPJ do restaurante
   senha: senha do restaurante
   culinaria: tipo de cozinha que o restaurante trabalha (ex.: mexicana)
   menu: os pratos que o restaurante vende
   pedidos: uma lista de pedidos feitos pelo restaurante
   resenha: a nota do restaurante dada pelos seus frequentadores
   horario: horário de funcionamento do restaurante
   telefone: número de telefone do estabelecimento
-}
data Restaurante = Restaurante { nomeRst :: Text
                               , cnpjRst :: Text
                               , senhaRst :: Text
                               , culinariaRst :: Text
                               , telefoneRst :: Text
                               , horario :: Text
                               } deriving (Show, Generic)


instance FromNamedRecord Restaurante
instance ToNamedRecord Restaurante
instance DefaultOrdered Restaurante



{- Construtor do tipo Cliente.
   
   login: login do Cliente no sistema de delivery
   senha: a senha do Cliente para acessar o sistema de delivery
   nome: nome do cliente
   cpf: cadastro de pessoa física
   endereco: endereço para entrega
   pedidos: lista de pedidos realizados pelo cliente 
-}
data Cliente = Cliente { login :: Text
                       , senha :: Text
                       , nome :: Text
                       , cpf :: Text
                       , endereco :: Text
                       , telefone :: Text
                       } deriving (Show, Generic)

instance FromNamedRecord Cliente
instance ToNamedRecord Cliente
instance DefaultOrdered Cliente


{- Construtor de um pedido.

   Um pedido feito por um cliente em um restaurante possui um ou mais itens.
   Além disto, nas informações do pedido temos algumas informações sobre o
   estabelecimento e o cliente.
   
   itens: lista dos itens incluídos no pedido
   estabelecimento: estabelecimento em que o pedido foi feito
   cliente: cliente que fez o pedido
   situacao: situação do pedido
-}
data Pedido = Pedido { itens :: Text
                     , estabelecimento :: Text
                     , cliente :: Text
                     , situacao :: Text
                     } deriving (Show, Generic)

instance FromNamedRecord Pedido
instance ToNamedRecord Pedido
instance DefaultOrdered Pedido
