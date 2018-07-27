:- module(pedido, []).

:- use_module(cliente).
:- use_module(restaurante).
:- use_module(items).
:- use_module(library(random)).

%Pedido(loginCliente, CNPJRestaurante, ListaItems, ID(RANDOM)) -- A lista de items é em string, loginCliente e CNPJRestaurante como array de char.
:- dynamic(pedido/4).

pedido([50], [50], [], 4).

newPedido(Login, CNPJ) :-
  getRandomNumber(CNPJ, ID),assert(pedido(Login, CNPJ, [], ID)),
  interfacePedido(CNPJ, ID).

%
% Interface para criação de novo pedido.
%
% CNPJ - CNPJ do restaurante
% ID_PEDIDO - ID do pedido
%
interfacePedido(CNPJ, ID_PEDIDO) :-
  tty_clear,
  write("(A)dicionar, (r)emover itens do pedido, ou (c)onfirmá-lo? \n\n"),
  read_line_to_codes(user_input, INPUT),
  ((name("A", INPUT); name("a", INPUT)) -> adicionarAoPedido(CNPJ, ID_PEDIDO);
  (name("R", INPUT); name("r", INPUT)) -> removerDoPedido(CNPJ, ID_PEDIDO);
  (name("C", INPUT); name("c", INPUT)) -> finalizar(CNPJ, ID_PEDIDO);
  (write("Comando inválido.\n"), util:press_enter, interfacePedido(CNPJ, ID_PEDIDO))).

%
% Finaliza um pedido.
%
finalizar(CNPJ, ID_PEDIDO) :-
  tty_clear,
  toString(ID_PEDIDO),nl,
  write("Deseja finalizar ou cancelar o pedido? (F/c) \n\n"),
  read_line_to_codes(user_input, INPUT),
  ((name("F", INPUT); name("f", INPUT)) -> true;
  (name("C", INPUT); name("c", INPUT)) -> (retract(pedido(_, CNPJ, _, ID_PEDIDO)), writeln("Pedido cancelado com sucesso. "), util:press_enter);
  (write("Comando inválido\n"), util:press_enter, finalizar(CNPJ, ID_PEDIDO))).

%
% Interface para adicionar item a um pedido.
%
adicionarAoPedido(CNPJ, ID_PEDIDO) :-
  tty_clear,
  restaurante:getName(CNPJ, Nome),
  format(atom(R), "Cardápio de ~w:\n", [Nome]),
  atom_string(R, Header),
  writeln(Header),
  items:getCardapio(CNPJ, Cardapio),
  writeln(Cardapio), nl,
  adicionarAoPedido_(CNPJ, ID_PEDIDO).

adicionarAoPedido_(CNPJ, ID_PEDIDO) :-
  write("Que item você deseja adicionar? Digite o identificador do item ou 0 para voltar ao menu do pedido.\n\n"),
  read_line_to_codes(user_input, INPUT), nl,
  (name("0", INPUT) -> interfacePedido(CNPJ, ID_PEDIDO);
  items:item(_, _, _, CNPJ, INPUT) -> adicionarConfirmacao(CNPJ, ID_PEDIDO, INPUT);
  (writeln("Identificador de item inválido"), util:press_enter, adicionarAoPedido(CNPJ, ID_PEDIDO))).

%
% Confirma se o cliente quer adicionar o item ao pedido.
%
adicionarConfirmacao(CNPJ, ID_PEDIDO, ID_ITEM) :-
  tty_clear,
  items:getNome(CNPJ, ID_ITEM, Nome),
  format(atom(R), "Deseja adicionar ~w? (S/n)", [Nome]),
  atom_string(R, Header),
  writeln(Header),
  items:toString(CNPJ, ID_ITEM, DESC),
  nl, writeln(DESC), nl,
  read_line_to_codes(user_input, INPUT), nl,
  ((name("S", INPUT); name("s", INPUT)) -> (pedido(LOGIN, CNPJ, LISTA, ID_PEDIDO),
                                    append(LISTA, [ID_ITEM], NOVA_LISTA),
                                    retract(pedido(LOGIN, CNPJ, LISTA, ID_PEDIDO)),
                                    assert(pedido(LOGIN, CNPJ, NOVA_LISTA, ID_PEDIDO))),
                                    interfacePedido(CNPJ, ID_PEDIDO));
   (name("N", INPUT); name("n", INPUT)) -> (write("Adição cancelada. "), util:press_enter, interfacePedido(CNPJ, ID_PEDIDO));
   (write("Comando inválido\n\n"), util:press_enter, adicionarConfirmacao(CNPJ, ID_PEDIDO, ID_ITEM)).


%
% Remove item do pedido.
%
removerDoPedido(CNPJ, ID_PEDIDO) :-
  tty_clear,
  toString(ID_PEDIDO), nl,
  removerDoPedido_(CNPJ, ID_PEDIDO).

removerDoPedido_(CNPJ, ID_PEDIDO) :-
  write("Que item você deseja remover? Digite o identificador do item ou 0 para voltar ao menu do pedido.\n\n"),
  read_line_to_codes(user_input, INPUT), nl,
  (name("0", INPUT) -> interfacePedido(CNPJ, ID_PEDIDO);
  items:item(_, _, _, CNPJ, INPUT) -> removerConfirmacao(CNPJ, ID_PEDIDO, INPUT);
  writeln("Item inválido.\n\n"), util:press_enter, removerDoPedido(CNPJ, ID_PEDIDO)).


%
% Confirma a remoção do pedido.
%
removerConfirmacao(CNPJ, ID_PEDIDO, ID_ITEM) :-
  tty_clear,
  items:getNome(CNPJ, ID_ITEM, Nome),
  format(atom(R), "Deseja remover ~w do pedido? (S/n)", [Nome]),
  atom_string(R, Header),
  writeln(Header),
  items:toString(CNPJ, ID_ITEM, DESC),
  nl, writeln(DESC), nl,
  read_line_to_codes(user_input, INPUT), nl,
  ((name("S", INPUT); name("s", INPUT)) -> (pedido(LOGIN, CNPJ, LISTA, ID_PEDIDO),
                                            util:deletaUm(ID_ITEM, LISTA, [], NOVA_LISTA)),
                                            retract(pedido(_, CNPJ, _, ID_PEDIDO)),
                                            assert(pedido(LOGIN, CNPJ, NOVA_LISTA, ID_PEDIDO)),
                                            interfacePedido(CNPJ, ID_PEDIDO));
  ((name("N", INPUT); name("n", INPUT)) -> (write("Remoção cancelada."), util:press_enter, interfacePedido(CNPJ, ID_PEDIDO));
  (write("Comando inválido\n\n"), removerConfirmacao(CNPJ, ID_PEDIDO, ID_ITEM))).

%Gera um identificador unico.
getRandomNumber(CNPJ, Result) :-
  random:random_between(0, 100, R), checkRandomUnico(R, CNPJ) -> Result is R; getRandomNumber(CNPJ, Result).

%Verifica se o identificador é único.
checkRandomUnico(CNPJ, ID) :-
  not(pedido(_,CNPJ,_,ID)).


getClienteLogin(ID, StrLogin):-
	pedido(Login,_,_,ID),
	name(StrLogin, Login).

getCNPJRestaurante(ID, StrCNPJ):-
	pedido(_,CNPJ,_,ID),
	name(StrCNPJ, CNPJ).

%%IMPRIMINDO A LISTA DE ITEMS DIRETO! SEM RETORNAR STRING!
getListaItems(ID) :-
  pedido(_, CNPJ, Lista, ID),
  foreach(member(X, Lista), imprimeItemNoPedido(CNPJ, X)), true.

imprimeItemNoPedido(CNPJ, ID_ITEM) :-
  items:toStringListagem(CNPJ, ID_ITEM, Retorno), write(Retorno),nl, true.

%%Conserta-se consertando o pedido:getListaItems
toString(ID) :-
    pedido(USER,REST,_,ID),
    cliente:toString(USER, ClientePedido),
    restaurante:toString(REST, CNPJRestaurante),
    format("-- Pedido --\n\nCliente: ~w\nRestaurante: ~w\n\nItens:\n\n", [ClientePedido, CNPJRestaurante]),
    getListaItems(ID),nl,nl,
    getPrecoTotal(ID, TOTAL),
    format("Valor total: R$ ~w\n\n", [TOTAL]).

toStringListagem(ID, Retorno) :-
  pedido(_,RST,_,ID), restaurante:getName(RST, RestName),
  format(atom(R), "Pedido nº ~w. Restaurante: ~w", [ID, RestName]),
  Retorno = R.


getPrecoTotal(ID_PEDIDO, TOTAL) :-
    pedido(_, CNPJ, LISTA_ITENS, ID_PEDIDO),
    findall(Preco, (member(Y, LISTA_ITENS), items:getPreco(CNPJ, Y, Preco)), LISTA_PRECOS),
    sum_list(LISTA_PRECOS, TOTAL).

% findall(Preco, (pedido:pedido([49], [49], X, ID), member(Y, X), getPreco([49], Y, Preco)), Lista).
%Pedido(loginCliente, CNPJRestaurante, ListaItems, ID(RANDOM))

%
% Retorna uma string com a lista de restaurantes cadastrados.
%
getPedidosCliente(User, Retorno) :-
  findall(Pedido, (pedido(User, _,_,X), toStringListagem(X, Pedido)), Lista),
  atomic_list_concat(Lista, '\n', Atom),
  atom_string(Atom, Retorno).

getPedidosRestaurante(CNPJ, Retorno) :-
    findall(Pedido, (pedido(_,CNPJ,_,X), toStringListagem(X, Pedido)), Lista),
    atomic_list_concat(Lista, '\n', Atom),
    atom_string(Atom, Retorno).
