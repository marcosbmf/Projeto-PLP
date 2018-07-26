:-initialization(main).

:- use_module(cliente).
:- use_module(restaurante).
:- use_module(items).
:- use_module(pedido).
:- use_module(util).


main:-
	tty_clear,
	write(Clientes),
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
	read_line_to_codes(user_input, OP),nl,
	(OP =:= "1" -> menuLoginCliente;
	OP =:= "2" -> menuLoginRestaurante;
	OP =:= "3" -> menuCadastrarCliente;
	OP =:= "4" -> menuCadastrarRestaurante;
	OP =:= "5" -> halt(0)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% PARTES DO CLIENTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imprimirElementos([]):- write("Kkk").
imprimirElementos([H|T]) :-
	write(H),
	write("Llll"),
	imprimirElementos(T).
	


menuCadastrarCliente:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| CADASTRAR NOVO CLIENTE"),nl,
	write("---------------------------------------------"),nl,nl,
	cliente:newCliente(R),
	main.

menuLoginCliente:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| LOGIN CLIENTE"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Nome de usuario: "),nl,nl,
	read_line_to_codes(user_input, USER),nl,
	write("Senha: "),nl,
	read_line_to_codes(user_input, PASSWORD),nl,
	%% %% %% %% %% %%
	%% AGORA TEM QUE VERIFICAR SE O USUARIO EXISTE E SE
	%% A SENHA ESTA CORRECTA
	%% E ENTAO FAZER O LOGIN
	%% %% %% %% %% %%
	menuClienteLogado.

menuClienteLogado:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,
	write("| Bem vindo, FULANO DE TAL."),nl,nl,
	write("MENU: "),nl,
	write("(1) Exibir todos os restaurantes"),nl,
	write("(2) Ver Pedidos"),nl,
	write("(3) Sair"),nl,nl,
	read_line_to_codes(user_input, OP),nl,
	(OP =:= "1" -> exibirRestaurantes;
	OP =:= "2" -> verPedidos;
	OP =:= "3" -> main).

exibirRestaurantes:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,
	%%%%%%%%%%%%%%%%%%%%
	%% AGORA SAO EXIBIDOS OS RESTAURANTES
	%%%%%%%%%%%%%%%%%%%%
	write("Restaurantes cadastrados no sistema: "),nl,
	write("Restaurante 1"),nl,
	write("Restaurante 2"),nl,
	write("Restaurante 3"),nl,
	write("Restaurante 4"),nl,nl,nl,
	write("Selecione uma opcao: "),nl,
	write("(1) Ver Cardapio"),nl,
	write("(2) Voltar ao menu"),nl,nl,
	read_line_to_codes(user_input, OP),nl,
	(OP =:= "1" -> verCardapio;
	OP =:= "2" -> menuClienteLogado).

verCardapio:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,
	%%%%%%%%%%%%%%%%%%%%
	%% AGORA SAO EXIBIDOS OS RESTAURANTES
	%%%%%%%%%%%%%%%%%%%%
	write("Restaurantes cadastrados no sistema: "),nl,
	write("Restaurante 1"),nl,
	write("Restaurante 2"),nl,
	write("Restaurante 3"),nl,
	write("Restaurante 4"),nl,nl,nl,
	write("Escolha um restaurante: "),nl,
	read_line_to_codes(user_input, REST),nl.
	%%%%%%%%%%%%% NESSA PARTE VEM UM METODO QUE EXIBE ALGUM RESTAURANTE
	%%%%%%%%%%%%% AINDA PRECISA SER BEM IMPLEMENTADO

realizarPedido:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| CARDAPIOS"),nl,
	write("---------------------------------------------"),nl,
	%%%%%%%%%%%%%
	%%% INFORMACOES DO RESTAURANTE SAO MOSTRADAS
	%%%%%%%%%%%%%
	write("1 - COXINHA"),nl,
	write("2 - PASTEL"),nl,
	write("3 - HAMBURGEUR"),nl,nl,
	write("Selecione uma opcao:"),nl,
	write("(1) Realizar Pedido"),nl,
	write("(2) Voltar a lista de restaurantes"),nl,nl
	read_line_to_codes(user_input, OP),nl,
	(OP =:= "2" -> exibirRestaurantes;
	 OP =:= "1" ->	finalizarPedido).

finalizarPedido:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| CARDAPIOS"),nl,
	write("---------------------------------------------"),nl,
	%%%%%%%%%%%%%
	%%% INFORMACOES DO RESTAURANTE SAO MOSTRADAS
	%%%%%%%%%%%%%
	write("1 - COXINHA"),nl,
	write("2 - PASTEL"),nl,
	write("3 - HAMBURGEUR"),nl,nl,
	write("Digite o numero do item a ser adicionado ao pedido, ou 0 para confirmar o pedido."),nl,
	read_line_to_codes(user_input, OP),nl,
	main.
	%%%%%%% AQUI FALTA FAZER %%%%%%%%

verPedidos:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,
	write("Meus pedidos:"),nl,
	write("1 - COXINHA - SEU OLAVO DE CARVALHO"),nl,
	write("2 - PASTEL - PASTELARIA DOIS IRMAOS"),nl,
	write("Meus pedidos:"),nl,
	write("Digite o numero do pedido que deseja acessar ou 0 para voltar ao menu:"),nl,
	read_line_to_codes(user_input, NUM),nl,
	main.
	%%%%%%%%%% AQUI TBM FALTA



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% PARTES DO RESTAURANTE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



menuCadastrarRestaurante:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| CADASTRAR NOVO RESTAURANTE"),nl,
	write("---------------------------------------------"),nl,nl,
	restaurante:newRestaurante,
	%% write("Digite seu CNPJ (Este sera seu login): "),nl,nl,
	%% read_line_to_codes(user_input, CNPJ),nl,
	%% %% %% %% %% %% %% %% %% %% %% %%
	%% %% VERIFICA SE CNPJ JA EXISTE
	%% %% %% %% %% %% %% %% %% %% %% %%
	%% write("Digite seu telefone: "),nl,
	%% read_line_to_codes(user_input, TELEFONE),nl,
	%% write("Estilo de cozinha: "),nl,
	%% read_line_to_codes(user_input, COZINHA),nl,
	%% write("Horario que abre: "),nl,
	%% read_line_to_codes(user_input, ABRE),nl,
	%% write("Horario que fecha: "),nl,
	%% read_line_to_codes(user_input, FECHA),nl,
	%% write("Escolha uma senha: "),nl,
	%% read_line_to_codes(user_input, PASSWORD),nl,
	%% %% %% %% %% %%
	%% NESSA PARTE CRIA O OBJECTO E ARMAZENA DE ALGUMA FORMA
	%% %% %% %% %% %%
	main.

menuLoginRestaurante:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| LOGIN RESTAURANTE"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Digite seu CNPJ: "),nl,
	read_line_to_codes(user_input, CPPJlogin),nl,
	write("Senha: "),nl,
	read_line_to_codes(user_input, PASSWORDlogin),nl,
	%%%%
	%%%%%%%%%%%%%%%%%%%%% CHECA SE LOGIN EXISTE E SENHA ESTA CORRECTA
	%%%%
	restauranteLogado.

restauranteLogado:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| SISTEMA DE DELIVERY ONLINE"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Bem vindo, restaurante TAL."),nl,nl,nl,
	write("OPCOES PARA RESTAURANTE:"),nl,
	write("(1) Adicionar Prato ao seu cardapio"),nl,
	write("(2) Remover Prato do seu cardapio"),nl,
	write("(3) Ver Pedidos Feitos por Clientes"),nl,
	write("(4) Sair"),nl,nl,
	read_line_to_codes(user_input, OP),nl,
	(OP =:= "4" -> main;
	OP =:= "1" -> adicionarPrato;
	OP =:= "2" -> removerPrato;
	OP =:= "3" -> verPedidosClientes).

adicionarPrato:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| ADICIONAR PRATO"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Digite o nome do prato: "),nl,
	read_line_to_codes(user_input, NOMEPRATO),nl,
	write("Escreva uma descricao para o prato: "),nl,
	read_line_to_codes(user_input, DESCRICAO),nl,
	write("Escolha um preco: "),nl,
	read_line_to_codes(user_input, PRECO),nl,
	write(NOMEPRATO), write(" - R$"), write(PRECO),nl,nl,
	write("Digite 1 para confirmar ou 0 para cancelar: "),nl,
	read_line_to_codes(user_input, OP),nl,
	(OP =:= "0" -> restauranteLogado).
	%%%%%%%%%ESTA PARTE FALTA IMPLEMENTAR PARA ADICIONAR OS DADOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

removerPrato:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| REMOVER PRATO"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Lista de pratos de restaurante tal"),nl,nl,
	write("1 - COXINHA"),nl,
	write("2 - PASTEL"),nl,nl,nl,nl,
	write("Digite o numero do prato que voce deseja deletar, ou 0 para cancelar:"),nl,
	read_line_to_codes(user_input, NUM),nl,
	(NUM =:= "0" -> restauranteLogado).
	%%%%%%%%%%%%% FALTA TERMINAR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

verPedidosClientes:-
	tty_clear,
	write("---------------------------------------------"),nl,
	write("---------------------------------------------"),nl,nl,
	write("| VER PEDIDOS DOS CLIENTES"),nl,
	write("---------------------------------------------"),nl,nl,
	write("Meus pedidos:"),nl,nl,
	write("1 - COXINHA - FULANO DE TALLSSSS"),nl,nl,
	write("Digite o número do pedido que deseja acessar ou 0 para voltar ao menu:"),nl,
	read_line_to_codes(user_input, NUM),nl,
	restauranteLogado.
