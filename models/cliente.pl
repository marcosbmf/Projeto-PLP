:- module(cliente, []).

:- dynamic(cliente/5).

cliente("Marcos Barros", "Rua Joao Luis Pereira", "097650704", marcos, marcos).

newCliente :-
    write('Insira o seu nome: '), nl, read(Name), 
    write('Insira o seu endereço: '), nl, read(Endereco), 
    write('Insira o seu CPF: '), nl, read(CPF),
    write('Insira o seu login: '), nl, read(Login),
    write('Insira a sua senha: '), nl, read(Senha),
    validLogin(Login) -> assert(cliente(Name, Endereco, CPF, Login, Senha)); write("\nFalha no cadastro: Login já está sendo utilizado, tente novamente.\n").

validLogin(Login) :-
    not(cliente(_,_,_,Login,_)).

login(Login, Senha) :-
    cliente(_,_,_,Login, Senha).

clienteToString(Login, Senha) :-
    cliente(Name, Endereco, CPF, Login, Senha), 
    format("Nome: ~w\nEndereço: ~w\nCPF: ~w\n", [Name, Endereco, CPF]).