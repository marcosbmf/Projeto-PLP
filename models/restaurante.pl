:- module(restaurante, []).


/*
    restaurante(Nome, TipoCozinha, HorarioFuncionamento, CNPJ, Senha)
*/
:- dynamic(restaurante/5).

restaurante("Olavo's Bistro", "Cozinha Estudantil", "O dia Todo", 1, 1).

newRestaurante :-
    write("Insira o nome do estabelecimento: \n"), read(Nome), 
    write("Insira o tipo de cozinha do estabelecimento: \n"), read(TipoCozinha),
    write("Insira o horario de funcionamento: \n"), read(HorarioFuncionamento),
    write("Insira o CNPJ do estabelecimento: (Este será seu login)\n"), read(CNPJ),
    write("Insira uma senha: \n"), read(Senha),
    verificaCNPJ(CNPJ) -> assert(restaurante(Nome, TipoCozinha, HorarioFuncionamento, CNPJ, Senha)); write("\nFalha no cadastro: CNPJ já está sendo utilizado, tente novamente.\n").

verificaCNPJ(CNPJ) :-
    not(restaurante(_,_,_,CNPJ,_)).

restauranteLogin(CNPJ, Senha) :-
    restaurante(_,_,_,CNPJ,Senha).

restauranteToString(CNPJ) :-
    restaurante(Nome, TipoCozinha, HorarioFuncionamento, CNPJ, _),
    format("~w - ~w\nHorario de Funcionamento: ~w\n", [Nome, TipoCozinha, HorarioFuncionamento]).