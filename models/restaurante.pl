:- module(restaurante, []).

/*
    restaurante(Nome, TipoCozinha, HorarioFuncionamento, CNPJ, Senha)
*/
:- dynamic(restaurante/5).

restaurante("Olavo's Bistro", "Cozinha Estudantil", "O dia Todo", [50], 1).

%
% Cria um restaurante se o CNPJ estiver disponível.
%
newRestaurante :-
    write("Insira o nome do estabelecimento: \n"), read_line_to_codes(user_input, Nome),
    write("Insira o tipo de cozinha do estabelecimento: \n"), read_line_to_codes(user_input, TipoCozinha),
    write("Insira o horario de funcionamento: \n"), read_line_to_codes(user_input, HorarioFuncionamento),
    write("Insira o CNPJ do estabelecimento: (Este será seu login)\n"), read_line_to_codes(user_input, CNPJ),
    write("Insira uma senha: \n"), read_line_to_codes(user_input, Senha),
    verificaCNPJ(CNPJ) -> assert(restaurante(Nome, TipoCozinha, HorarioFuncionamento, CNPJ, Senha)), true; false.

%
% Verifica se o CNPJ não está cadastrado no sistema.
%
verificaCNPJ(CNPJ) :-
    not(restaurante(_,_,_,CNPJ,_)).

%
% Verifica se o login e senha estão corretos.
%
login(CNPJ, Senha) :-
    restaurante(_,_,_,CNPJ,Senha).

% Retorna string do nome do Restaurante.
getName(CNPJ, StrName):-
    restaurante(Name, _, _, CNPJ, _),
    name(StrName, Name).

% Retorna string do tipo de cozinha do Restaurante.
getTipoCozinha(CNPJ, StrTipo):-
    restaurante( _, TipoCozinha, _, CNPJ, _),
    name(StrTipo, TipoCozinha).

% Retorna string do horario do Restaurante.
getHorario(CNPJ, StrHorario):-
    restaurante( _, _, HorarioFuncionamento, CNPJ, _),
    name(StrHorario, HorarioFuncionamento).

% Retorna string do CNPJ do Restaurante.
getCNPJ(CNPJ, StrCNPJ):-
    restaurante( _, _, _, CNPJ, _),
    name(StrCNPJ, CNPJ).

% Retorna string do Restaurante.
toString(CNPJ, Resultado) :-
    getName(CNPJ, Nome),
    getTipoCozinha(CNPJ, TipoCozinha),
    getHorario(CNPJ, HorarioFuncionamento),
    getCNPJ(CNPJ, StrCNPJ),
    format(atom(R), "Nome: ~w - CNPJ: ~w\nHorario de Funcionamento: ~w\nTipo de Cozinha: ~w", [Nome, StrCNPJ, HorarioFuncionamento, TipoCozinha]),
    Resultado = R.

% Retorna a string pra ser usada em listagem.
toStringListagem(CNPJ, Resultado) :-
  getName(CNPJ, Nome),
  getTipoCozinha(CNPJ, TipoCozinha),
  getHorario(CNPJ, HorarioFuncionamento),
  getCNPJ(CNPJ, CNPJStr),
  format(atom(R), "~w. ~w, Aberto entre: ~w, Culinária: ~w", [CNPJStr, Nome, HorarioFuncionamento, TipoCozinha]),
  Resultado = R.

%
% Retorna uma string com a lista de restaurantes cadastrados.
%
getRestaurantes(Retorno) :-
    findall(Restaurante, toStringListagem(X, Restaurante), Lista),
    atomic_list_concat(Lista, '\n', Atom),
    atom_string(Atom, Retorno).
