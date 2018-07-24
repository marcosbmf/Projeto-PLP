:- module(cliente, []).
:- use_module(util).

:- dynamic(cliente/5).

cliente("Marcos Barros", "Rua Joao Luis Pereira", "097650704", marcos, marcos).

newCliente :-
    write('Insira o seu nome: '), nl, read_line_to_codes(user_input, Name),
    write('Insira o seu endereço: '), nl, read_line_to_codes(user_input, Endereco),
    write('Insira o seu CPF: '), nl, read_line_to_codes(user_input, CPF),
    write('Insira o seu login: '), nl, read_line_to_codes(user_input, Login),
    write('Insira a sua senha: '), nl, read_line_to_codes(user_input, Senha),
    validLogin(Login) -> assert(cliente(Name, Endereco, CPF, Login, Senha)); write("\nFalha no cadastro: Login já está sendo utilizado, tente novamente.\n").

validLogin(Login) :-
    not(cliente(_,_,_,Login,_)).

login(Login, Senha) :-
    cliente(_,_,_,Login, Senha).

clienteToString(Login, Resultado) :-
    clienteGetName(Login, Name),
    clienteGetCPF(Login, CPF),
    clienteGetEndereco(Login, Endereco),
    util:concatenate_string("Nome: ", Name, X),
    util:concatenate_string("Endereço: ", Endereco, Y),
    util:concatenate_string("CPF: ", CPF, Z),
    format(atom(R), "~w\n~w\n~w\n", [X, Y, Z]),
    Resultado = R.

clienteGetName(Login, StrName) :-
    cliente(Name, _, _, Login, _),
    name(StrName, Name).

clienteGetCPF(Login, StrCPF) :-
    cliente(_, _, CPF, Login, _),
    name(StrCPF, CPF).

clienteGetEndereco(Login, StrEndereco) :-
    cliente(_, Endereco, _, Login, _),
    name(StrEndereco, Endereco).
