:- module(pedido, []).

:- use_module(cliente).
:- use_module(restaurante).
:- use_module(items).
:- use_module(library(random)).

%Pedido(loginCliente, CNPJRestaurante, ListaItems, ID(RANDOM)) -- A lista de items é em string, loginCliente e CNPJRestaurante como array de char.
:- dynamic(pedido/4).

novoPedido(Login, CNPJ, ListaItems) :-
  getRandomNumber(CNPJ, ID),assert(pedido(Login, CNPJ, ListaItems, ID)).

%Gera um identificador unico.
getRandomNumber(CNPJ, Result) :-
  random:random_between(0, 100, R), checkRandomUnico(R, CNPJ) -> Result is R; getRandomNumber(CNPJ, Result).

%Verifica se o identificador é único.
checkRandomUnico(CNPJ, ID) :-
  not(pedido(_,CNPJ,_,ID)).
