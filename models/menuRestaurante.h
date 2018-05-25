#ifndef PLP_MENUCLIENTE_H
#define PLP_MENUCLIENTE_H

#endif //PLP_MENUCLIENTE_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>


void menuRestaurante (rst::Restaurant rest, std::vector<clt::Client> clientes) {

    const char ADICIONAR_ITEM = '1';
    const char REMOVER_ITEM = '2';
    const char VER_PEDIDOS = '3';
    const char SAIR = '4';

    char opMenuRestaurante;

    while(opMenuRestaurante != SAIR) {

    	system("clear");
        std::cout <<  "Bem vindo, " << rest.name << "." << std::endl << std::endl
        << "OPCOES PARA RESTAURANT" << std::endl
        << "(1) Adicionar Prato ao seu cardapio" << std::endl
        << "(2) Remover Prato do seu cardapio" << std::endl
        << "(3) Ver Pedidos Feitos por Clientes" << std::endl
        << "(4) Sair" << std::endl << std::endl
        << "> ";
        std::cin >> opMenuRestaurante;
        std::cin.get();

        switch (opMenuCliente) {
            case ADICIONAR_ITEM:
                adicionarItem(rest);
                break;

            case REMOVER_ITEM:
            	removerItem();
        
                avaliar(restaurantes);
                break;       break;

            case VER_PEDIDOS:
                verPedidos(rest, clientes);
                break;

            case SAIR:
                break;
        }

    }

}
 void adicionarItem(rst::Restaurant rest) {

	system("clear");
    std::cout <<  " ---------- ADICIONAR ITEM ---------- " << std::endl << std::endl
    item::Item item = newItem();
    rest.menu.push_back(item);
    std::cout <<  " =>       Item adicionado com sucesso! :D       <= " << std::endl
}

 void removerItem() {

	system("clear");
    std::cout <<  " ---------- REMOVER ITEM ---------- " << std::endl << std::endl
    << "Lista de Pratos: ";

    std::cout << rst::showMenu(rest);

    int itemRemovido;

    std::cout << std::endl << std::endl << "Digite o numero do prato que voce deseja deletar, ou 0 para Cancelar:"
    std::cin >> itemRemovido;

    if(itemRemovido != 0) {
    	// verifica se o tamanho eh valido
    	if(itemRemovido <= rest.menu.size()) {
			rest.menu.erase(rest.menu.begin() + itemRemovido - 1);
			std::cout >> " --- Removido com sucesso! --- ";
    	} else {
    		std::cout >> " --- ERRO: Numero do Prato invalido --- ";
    	}
    }
 }

 void verPedidos(rst::Restaurant &restaurante, std::vector<clt::Client> clientes) {

 	std::vector<item::Item> 
    for (auto it = cliente.orders.begin(); it != cliente.orders.end(); it++){

    	if (it->estabelecimento == restaurante.nome) {

    	} 
    }






}