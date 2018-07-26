:- module(cliente, []).
:- use_module(util).

% Cliente(Nome, Endereco, CNPJ, Login, Senha).
:- dynamic(cliente/5).

cliente("Marcos Barros", "Rua Joao Luis Pereira", "097650704", [50], marcos).

%
% Cria um cliente se o Login não existir ainda.
%
newCliente :-
    write('Insira o seu nome: '), nl, read_line_to_codes(user_input, Name),
    write('Insira o seu endereço: '), nl, read_line_to_codes(user_input, Endereco),
    write('Insira o seu CPF: '), nl, read_line_to_codes(user_input, CPF),
    write('Insira o seu login: '), nl, read_line_to_codes(user_input, Login),
    write('Insira a sua senha: '), nl, read_line_to_codes(user_input, Senha),
    validLogin(Login) -> assert(cliente(Name, Endereco, CPF, Login, Senha)), true; false.

validLogin(Login) :-
    not(cliente(_,_,_,Login,_)).

login(Login, Senha) :-
    cliente(_,_,_,Login, Senha).

toString(Login, Resultado) :-
    getName(Login, Name),
    getCPF(Login, CPF),
    getEndereco(Login, Endereco),
    util:concatenate_string("Nome: ", Name, X),
    util:concatenate_string("Endereço: ", Endereco, Y),
    util:concatenate_string("CPF: ", CPF, Z),
    format(atom(R), "~w\n~w\n~w\n", [X, Y, Z]),
    Resultado = R.

getName(Login, StrName) :-
    cliente(Name, _, _, Login, _),
    name(StrName, Name).

getCPF(Login, StrCPF) :-
    cliente(_, _, CPF, Login, _),
    name(StrCPF, CPF).

getEndereco(Login, StrEndereco) :-
    cliente(_, Endereco, _, Login, _),
    name(StrEndereco, Endereco).
