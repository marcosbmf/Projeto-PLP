:- module(restaurante, []).


/*
    restaurante(Nome, TipoCozinha, HorarioFuncionamento, CNPJ, Senha)
*/
:- dynamic(restaurante/5).

restaurante("Olavo's Bistro", "Cozinha Estudantil", "O dia Todo", [50], 1).

newRestaurante :-
    write("Insira o nome do estabelecimento: \n"), read_line_to_codes(user_input, Nome), 
    write("Insira o tipo de cozinha do estabelecimento: \n"), read_line_to_codes(user_input, TipoCozinha),
    write("Insira o horario de funcionamento: \n"), read_line_to_codes(user_input, HorarioFuncionamento),
    write("Insira o CNPJ do estabelecimento: (Este será seu login)\n"), read_line_to_codes(user_input, CNPJ),
    write("Insira uma senha: \n"), read_line_to_codes(user_input, Senha),
    verificaCNPJ(CNPJ) -> assert(restaurante(Nome, TipoCozinha, HorarioFuncionamento, CNPJ, Senha)); write("\nFalha no cadastro: CNPJ já está sendo utilizado, tente novamente.\n").

verificaCNPJ(CNPJ) :-
    not(restaurante(_,_,_,CNPJ,_)).

restauranteLogin(CNPJ, Senha) :-
    restaurante(_,_,_,CNPJ,Senha).

getName(CNPJ, StrName):-
    restaurante(Name, _, _, CNPJ, _),
    name(StrName, Name).

getTipoCozinha(CNPJ, StrTipo):-
    restaurante( _, TipoCozinha, _, CNPJ, _),
    name(StrTipo, TipoCozinha).

getHorario(CNPJ, StrHorario):-
    restaurante( _, _, HorarioFuncionamento, CNPJ, _),
    name(StrHorario, HorarioFuncionamento).

getCNPJ(CNPJ, StrCNPJ):-
    restaurante( _, _, _, CNPJ, _),
    name(StrCNPJ, CNPJ).

restauranteToString(CNPJ, Resultado) :-
    getName(CNPJ, Nome),
    getTipoCozinha(CNPJ, TipoCozinha),
    getHorario(CNPJ, HorarioFuncionamento),
    getCNPJ(CNPJ, StrCNPJ),
    format(atom(R), "Nome: ~w - CNPJ: ~w\nHorario de Funcionamento: ~w\nTipo de Cozinha: ~w", [Nome, StrCNPJ, HorarioFuncionamento, TipoCozinha]),
    Resultado = R.