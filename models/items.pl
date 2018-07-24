:- module(items, []).
:- use_module(restaurante).
:- use_module(util).

/*
    item(Nome, Descrição, Preço, CNPJRestaurante, Identificador).
*/
:- dynamic(item/5).

%
% Cadastra item no menu de um restaurante. Cada item possui nome, descrição,
% preço e um identificador.
%
cadastraItem(CNPJ, Senha) :-
    restaurante:restauranteLogin(CNPJ, Senha) ->
    write("Insira o nome do item: \n"), read_line_to_codes(user_input, Nome),
    write("Insira a descrição do item: \n"), read_line_to_codes(user_input, Descricao),
    write("Insira o preço do item: \n"), read_line_to_codes(user_input, Preco),
    write("Insira um identificado para o item: \n"), read_line_to_codes(user_input, Identificador),
    assert(item(Nome, Descricao, Preco, CNPJ, Identificador)).

%
% Salva em Retorno a descrição textual de um item a partir de
% seu conjunto CNPJ + Identificador.
%
toString(CNPJ, Identificador, Retorno) :-
    getNome(CNPJ, Identificador, Nome),
    getDescricao(CNPJ, Identificador, Descricao),
    getPreco(CNPJ, Identificador, Preco),
    format(atom(Resultado), "Nome: ~w\nDescrição: ~w\nPreço: ~w\n", [Nome, Descricao, Preco]),
    Retorno = Resultado.

%
% Salva em Retorno o nome de um item a partir de seu conjunto CNPJ
% + Identificador.
%
getName(CNPJ, Identificador, Retorno) :-
    item(Nome, _, _, CNPJ, Identificador),
    name(Retorno, Nome).

%
% Salva em Retorno a descrição de um item a partir de seu conjunto CNPJ
% + Identificador.
%
getDescricao(CNPJ, Identificador, Retorno) :-
    item(_, Descricao, _, CNPJ, Identificador),
    name(Retorno, Descricao).

%
% Salva em Retorno a descrição de um item a partir de seu conjunto CNPJ
% + Identificador.
%
getPreco(CNPJ, Identificador, Retorno) :-
    item(_, _, Preco, CNPJ, Identificador),
    name(Retorno, Preco).

 /*

 	listaItemToString(CNPJ, String)
 	listaItems(CNPJ, Lista)
 	removeItem(CNPJ, X,)
 */
