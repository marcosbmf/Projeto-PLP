:- module(items, []).
:- use_module(restaurante).
:- use_module(util).

%
%    item(Nome, Descrição, Preço, CNPJRestaurante, Identificador).
%
:- dynamic(item/5).

%
% Cadastra item no menu de um restaurante. Cada item possui nome, descrição,
% preço e um identificador. Cadastra apenas se o identificador for único para o CNPJ.
%
cadastraItem(CNPJ) :-
    write("Insira o nome do item: \n"), read_line_to_codes(user_input, Nome),
    write("Insira a descrição do item: \n"), read_line_to_codes(user_input, Descricao),
    write("Insira o preço do item: \n"), read_line_to_codes(user_input, Preco),
    write("Insira um identificador númerico para o item: \n"), read_line_to_codes(user_input, Identificador),
    verificaIdentificadorUnico(Identificador, CNPJ) -> assert(item(Nome, Descricao, Preco, CNPJ, Identificador)), true; false.

%
%  Verifica se o identificador do item é único para o CNPJ.
%
verificaIdentificadorUnico(Identificador, CNPJ) :-
    not(item(_,_,_,CNPJ,Identificador)).

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

%ToString para ser usado em lista. Id - Nome - Preço: R$XX,XX.
toStringListagem(CNPJ, Identificador, Retorno) :-
  getNome(CNPJ, Identificador, Nome),
  getPreco(CNPJ, Identificador, Preco),
  getIdentificador(CNPJ, Identificador, Id),
  format(atom(Resultado), "~w. ~w - R$~w\n", [Id, Nome, Preco]),
  Retorno = Resultado.

%
% Salva em Retorno o nome de um item a partir de seu conjunto CNPJ
% + Identificador.
%
getNome(CNPJ, Identificador, Retorno) :-
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

% Retorna Identificador
getIdentificador(CNPJ, Identificador, Retorno) :-
    item(_, _, _, CNPJ, Identificador),
    name(Retorno, Identificador).

%
% Remove um item a partir do CNPJ e Identificador.
%
removeItem(CNPJ, Identificador) :-
    item(_,_,_,CNPJ,Identificador) -> retract(item(_,_,_,CNPJ,Identificador)), true; false.

%
% Retorna string com cardápio do restaurante.
%
getCardapio(CNPJ, Cardapio) :-
    findall(Item, toStringListagem(CNPJ, X, Item), Lista),
    atomic_list_concat(Lista, '\n', Atom),
    atom_string(Atom, Cardapio).

 /*
 	listaItemToString(CNPJ, String)
 	listaItems(CNPJ, Lista)
  */
