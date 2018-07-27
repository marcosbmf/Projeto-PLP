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
  write("(A)dicionar, (r)emover itens do pedido, ou (c)onfirmá-lo? "),
  read_line_to_codes(user_input, INPUT),
  ((name("A", INPUT); name("a", INPUT)) -> adicionarAoPedido(CNPJ, ID_PEDIDO);
   (name("R", INPUT); name("r", INPUT)) -> removerDoPedido(CNPJ, ID_PEDIDO);
   (name("F", INPUT); name("f", INPUT)) -> finalizar(CNPJ, ID_PEDIDO);
   (write("Comando inválido."), interfacePedido(CNPJ, ID_PEDIDO))).

%
% Finaliza um pedido.
%
finalizar(CNPJ, ID_PEDIDO) :-
  toString(ID_PEDIDO, PED_STR),
  writeln(PED_STR), nl,
  write("Deseja finalizar o pedido? (S/n) "),
  ((name("S", INPUT); name("s", INPUT)) -> true,
   (name("N", INPUT), name("n", INPUT)) -> false;
   (write("Comando inválido"), finalizar(CNPJ, ID_PEDIDO))).

%
% Interface para adicionar item a um pedido.
%
adicionarAoPedido(CNPJ, ID_PEDIDO) :-
  restaurante:getName(CNPJ, Nome),
  format(atom(R), "Cardápio de ~w:", [Nome]),
  atom_string(R, Header),
  writeln(Header),
  items:getCardapio(CNPJ, Cardapio),
  writeln(Cardapio),
  adicionarAoPedido_(CNPJ, ID_PEDIDO).

adicionarAoPedido_(CNPJ, ID_PEDIDO) :-
  write("Que item você deseja adicionar? "),
  read_line_to_codes(user_input, INPUT), nl,
  items:item(_, _, _, CNPJ, INPUT) -> adicionarConfirmacao(CNPJ, ID_PEDIDO, INPUT);
  (writeln("Identificador de item inválido"), adicionarAoPedido_(CNPJ, ID_PEDIDO)).

%
% Confirma se o cliente quer adicionar o item ao pedido.
%
adicionarConfirmacao(CNPJ, ID_PEDIDO, ID_ITEM) :-
  items:item(Nome, _, Preco, CNPJ, ID_ITEM),
  format(atom(R), "Deseja adicionar ~w por ~w? (S/n) ", [Nome, Preco]),
  atom_string(R, Header),
  writeln(Header),
  read_line_to_codes(user_input, INPUT), nl,
  ((name("S", INPUT); name("s", INPUT)) -> (pedido(LOGIN, CNPJ, LISTA, ID_PEDIDO),
                                    append(LISTA, [ID_ITEM], NOVA_LISTA),
                                    retract(pedido(LOGIN, CNPJ, LISTA, ID_PEDIDO)),
                                    assert(pedido(LOGIN, CNPJ, NOVA_LISTA, ID_PEDIDO))),
                                    interfacePedido(CNPJ, ID_PEDIDO));
   (name("N", INPUT); name("n", INPUT)) -> interfacePedido(CNPJ, ID_PEDIDO);
   (write("Comando inválido"), adicionarConfirmacao(CNPJ, ID_PEDIDO, ID_ITEM)).


%
% Remove item do pedido.
%
removerDoPedido(CNPJ, ID_PEDIDO) :-
  toString(ID_PEDIDO, PED_STR),
  writeln(PED_STR), nl,
  removerDoPedido_(CNPJ, ID_PEDIDO).

removerDoPedido_(CNPJ, ID_PEDIDO) :-
  write("Que item você deseja remover?" ),
  read_line_to_codes(user_input, INPUT), nl,
  items:item(_, _, _, CNPJ, INPUT) -> removerConfirmacao(CNPJ, ID_PEDIDO, INPUT);
  (writeln("Item inválido."), removerDoPedido_(CNPJ, ID_PEDIDO)).


%
% Confirma a remoção do pedido.
%
removerConfirmacao(CNPJ, ID_PEDIDO, ID_ITEM) :-
  items:item(Nome, _, _, CNPJ, ID_ITEM),
  format(atom(R), "Deseja remover ~w do pedido? (S/n) ", [Nome]),
  atom_string(R, Header),
  writeln(Header),
  read_line_to_codes(user_input, INPUT), nl,
  ((name("S", INPUT); name("s", INPUT)) -> (pedido(LOGIN, CNPJ, LISTA, ID_PEDIDO),
                                            util:deletaUm(ID_PEDIDO, LISTA, [], NOVA_LISTA)),
                                            retract(pedido(LOGIN, CNPJ, LISTA, ID_PEDIDO)),
                                            assert(pedido(LOGIN, CNPJ, NOVA_LISTA, ID_PEDIDO)),
                                            interfacePedido(CNPJ, ID_PEDIDO));
  ((name("N", INPUT); name("n", INPUT)) -> interfacePedido(CNPJ, ID_PEDIDO));
  (write("Comando inválido"), removerConfirmacao(CNPJ, ID_PEDIDO, ID_ITEM)).

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

getListaItems(ID, Retorno):-
	pedido(_, _, Lista, ID),
  name(ListaSTR, Lista),
  atomic_list_concat(ListaSTR, '\n', Atom),
  atom_string(Atom, Retorno).

toString(ID, Resultado) :-
    getClienteLogin(ID, ClientePedido),
    getCNPJRestaurante(ID, CNPJRestaurante),
    getListaItems(ID, ListaItems),
    format(atom(R), "-- Pedido --\n  Cliente: ~w - \nCNPJ do restaurante: ~w\nItens: ~w", [ClientePedido, CNPJRestaurante, ListaItems]),
    Resultado = R.
