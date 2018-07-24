:- module(items, []).
:- use_module(restaurante).
:- use_module(util).

/*
    item(Nome, Descrição, Preço, CNPJRestaurante).
*/
:- dynamic(item/4).

cadastraItem(CNPJ, Senha) :-
    restaurante:restauranteLogin(CNPJ, Senha) ->
    write("Insira o nome do item: \n"), read(Name),
    write("Insira a descrição do item: \n"), read(Descricao),
    write("Insira o preço do item: \n"), read(Preco),
    assert(item(Name, Descricao, Preco, CNPJ)).


 /*

 	ItemtoString(CNPJ, algumaCOisa, String)
 	listaItemToString(CNPJ, String)
 	listaItems(CNPJ, Lista)
 	removeItem(CNPJ, X,)





 */