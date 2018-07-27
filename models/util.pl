:- module(util, [concatenate_string/3]).

concatenate_string(String1, String2, Resultado) :-
	name(String1, X), name(String2, Y), append(X, Y, Z), name(Resultado, Z).

press_enter :-
	write("Pressione enter para continuar!\n"), read_line_to_codes(user_input, ENTER), true.