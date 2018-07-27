:-initialization(main).

:- use_module(cliente).
:- use_module(restaurante).
:- use_module(items).
:- use_module(pedido).
:- use_module(util).


main:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Bem vindo ao Sistema de Delivery"),nl,
	write("---------------------------------------------"),nl,nl,
	write("MENU: "),nl,nl,
	write("(1) Login (Cliente)"),nl,
	write("(2) Login (Restaurante)"),nl,
	write("(3) Cadastrar-se (Cliente)"),nl,
	write("(4) Cadastrar-se (Restaurante)"),nl,
	write("(5) Sair())"),nl,nl,nl,
	read_line_to_codes(user_input, OP),
	(name("1", OP) -> menuLoginCliente;
	 name("2", OP) -> menuLoginRestaurante;
	 name("3", OP) -> menuCadastrarCliente;
	 name("4", OP) -> menuCadastrarRestaurante;
	 name("5", OP) -> halt(0); main).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% PARTES DO CLIENTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imprimirElementos([]):- write("Kkk").
imprimirElementos([H|T]) :-
	write(H),
	write("Llll"),
	imprimirElementos(T).
	

%FUNCIONANDO!
menuCadastrarCliente:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| CADASTRAR NOVO CLIENTE"),nl,
	write("---------------------------------------------"),nl,nl,
	cliente:newCliente -> write("\n\nCadastro realizado com sucesso!\n"), util:press_enter, main;
	write("\nFalha no cadastro: Login já está sendo utilizado, tente novamente.\n"), util:press_enter, main.

%FUNCIONANDO!
menuLoginCliente :-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| LOGIN CLIENTE"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Nome de usuario: "),nl,nl,
	read_line_to_codes(user_input, USER),nl,
	write("Senha: "),nl,
	read_line_to_codes(user_input, PASSWORD),nl,
	cliente:login(USER, PASSWORD) -> menuClienteLogado(USER);
	write("\n\nLogin ou senha inválidos!\n"), util:press_enter, main.

%FUNCIONANDO
menuClienteLogado(USER):-
	tty_clear, cliente:getName(USER, ClientName),
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,
	format("| Bem vindo, ~w.", [ClientName]),nl,nl,
	write("MENU: "),nl,
	write("(1) Exibir todos os restaurantes"),nl,
	write("(2) Ver Pedidos"),nl,
	write("(3) Sair"),nl,nl,
	read_line_to_codes(user_input, OP),
	(name("1", OP) -> exibirRestaurantes(USER);
	 name("2", OP) -> verPedidos(USER);
	 name("3", OP) -> main;
	 menuClienteLogado(USER)).

%Funcionando
exibirRestaurantes(USER):-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,
	write("Restaurantes cadastrados no sistema: "),nl,
	restaurante:getRestaurantes(Restaurantes), write(Restaurantes),
	write("Selecione uma opcao: "),nl,
	write("(1) Ver Cardapio"),nl,
	write("(2) Voltar ao menu"),nl,nl,
	read_line_to_codes(user_input, OP),
	(name("1", OP) -> verCardapio(USER);
	 name("2", OP) -> menuClienteLogado(USER);
	 write("\nOpção inválida!"), util:press_enter, exibirRestaurantes(USER)).

%Funcionando.
verCardapio(USER):-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,
	write("Restaurantes cadastrados no sistema: "),nl,nl,
	restaurante:getRestaurantes(Restaurantes), write(Restaurantes),nl,nl,
	write("Digite 0 para voltar ao menu ou o número de um restaurante: \n"),
	read_line_to_codes(user_input, REST),
	(name("0", REST) -> menuClienteLogado(USER);
	 restaurante:restaurante(_,_,_,REST,_) -> verCardapioRest(USER, REST);
	 write("Opção inválida!\n"), util:press_enter, verCardapio(USER)).

%Funcionando
verCardapioRest(USER, CNPJ) :-
	tty_clear, restaurante:getName(CNPJ, RSTName),
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	format("| Cardápio do restaurante ~w", [RSTName]),nl,
	write("---------------------------------------------"),nl,
	items:getCardapio(CNPJ, Cardapio), write(Cardapio),
    write("Digite 1 para realizar um pedido ou 0 para voltar ao menu: \n"),
    read_line_to_codes(user_input, OP),
    (name("0", OP) -> verCardapio(USER);
	 name("1", OP) -> true; %FUNÇÃO DE GUSTAVO.
     write("Opção inválida!\n"), util:press_enter, verCardapioRest(USER, CNPJ)).

verPedidos(USER):-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,
	write("Meus pedidos:"),nl,
	%%pedido:getPedidosCliente(USER, Pedidos), write(Pedidos),nl,nl,
	write("Digite o numero do pedido que deseja acessar ou 0 para voltar ao menu:"),nl,
	read_line_to_codes(user_input, NUM),
	(name("0", NUM) -> menuClienteLogado(USER);
	%%Falta toString do pedido.
	 pedido:pedido(USER,_,_,NUM) -> tty_clear, util:press_enter, verPedidos(USER);
	 write("Opção inválida\n\n"), util:press_enter, verPedidos(USER)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% PARTES DO RESTAURANTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Funcionando
menuCadastrarRestaurante:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| CADASTRAR NOVO RESTAURANTE"),nl,
	write("---------------------------------------------"),nl,nl,
	restaurante:newRestaurante -> write("\nCadastro realizado com sucesso! "), util:press_enter, main; 
	write("\nFalha no cadastro: CNPJ já está sendo utilizado, tente novamente.\n"), util:press_enter, main.

%Funcionando.
menuLoginRestaurante:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| LOGIN RESTAURANTE"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Digite seu CNPJ: "),nl,
	read_line_to_codes(user_input, CNPJ),nl,
	write("Senha: "),nl,
	read_line_to_codes(user_input, PASSWORD),nl,
	restaurante:login(CNPJ, PASSWORD) -> restauranteLogado(CNPJ); 
	write("\nFalha no login, usuario ou senha inválidos! "), util:press_enter, main.

%Funcionando, faltam funções.
restauranteLogado(CNPJ) :-
	tty_clear,
	restaurante:getName(CNPJ, RestName),
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,nl,
	format("Bem vindo, ~w.", [RestName]),nl,nl,nl,
	write("OPCOES PARA RESTAURANTE:"),nl,
	write("(1) Adicionar Prato ao seu cardapio"),nl,
	write("(2) Remover Prato do seu cardapio"),nl,
	write("(3) Ver Pedidos Feitos por Clientes"),nl,
	write("(4) Sair"),nl,nl,
	read_line_to_codes(user_input, OP),
	(name("4", OP) -> main;
	 name("1", OP) -> adicionarPrato(CNPJ);
	 name("2", OP) -> removerPrato(CNPJ);
	 name("3", OP) -> verPedidosClientes(CNPJ)).

%Funcionando
adicionarPrato(CNPJ) :-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| ADICIONAR PRATO"),nl,
	write("---------------------------------------------"),nl,nl,
	items:cadastraItem(CNPJ) -> restauranteLogado(CNPJ).

%FUNCIONANDO
removerPrato(CNPJ) :-
	tty_clear,
	restaurante:getName(CNPJ, RestName),
	items:getCardapio(CNPJ, Cardapio),
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| REMOVER PRATO"),nl,
	write("---------------------------------------------"),nl,nl,
	format("Lista de pratos do restaurante ~w", [RestName]),nl,nl,
	write(Cardapio),nl,nl,
	write("Digite o numero do prato que voce deseja deletar, ou 0 para cancelar:"),nl,
	read_line_to_codes(user_input, NUM),
	(name("0", NUM) -> restauranteLogado(CNPJ);
	items:confirmaRemocaoItem(CNPJ, NUM) -> removerPrato(CNPJ);
	write("Opção ou identificador inválido! "), util:press_enter, removerPrato(CNPJ)).

verPedidosClientes(CNPJ):-
		tty_clear,
		write("---------------------------------------------"),nl,
		write("---------------------------------------------"),nl,nl,
		write("| Pedidos de clientes"),nl,
		write("---------------------------------------------"),nl,
		write("Meus pedidos:"),nl,
		%%pedido:getPedidosRest(CNPJ, Pedidos), write(Pedidos),nl,nl,
		write("Digite o numero do pedido que deseja acessar ou 0 para voltar ao menu:"),nl,
		read_line_to_codes(user_input, NUM),
		(name("0", NUM) -> restauranteLogado(CNPJ);
		%%Falta toString do pedido.
		 pedido:pedido(_,CNPJ,_,NUM) -> tty_clear, util:press_enter, verPedidosClientes(CNPJ);
		 write("Opção inválida\n\n"), util:press_enter, verPedidosClientes(CNPJ)).
	