#ifndef PLP_MENURESTAURANTE_H
#define PLP_MENURESTAURANTE_H

#endif //PLP_MENURESTAURANTE_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>

void adicionarItem(rst::Restaurant &rest) {
    int confirma = -1;

	system("clear");
    std::cout <<  " ---------- ADICIONAR ITEM ---------- " << std::endl << std::endl;
    item::Item item = item::newItem();

    system("clear");
    std::cout <<  " ---------- ADICIONAR ITEM ---------- " << std::endl << std::endl;
    std::cout << item::toString(item) << std::endl << std::endl;
    std::cout << "Digite 1 para confirmar a adicao ou 0 para cancelar: ";
    std::cin >> confirma;
    std::cin.get();

    if (confirma == 1){
        rest.menu.push_back(item);
        std::cout <<  " =>       Item adicionado com sucesso! :D       <= " << std::endl << "Pressione enter para continuar!";
        std::cin.ignore();
    } else {
        std::cout <<  " =>       Adição de item cancelada!      <= " << std::endl << "Pressione enter para continuar!";
        std::cin.ignore();
    }
}

void confirmaRemocao(rst::Restaurant &rest, int itemRemovido){
    int confirma = -1;
    while (confirma != 0){
        system("clear");
        std::cout <<  " ---------- REMOVER ITEM ---------- " << std::endl << std::endl
        << "Lista de Pratos: ";
        std::cout << rst::showMenu(rest);

        std::cout << std::endl << std::endl << "Voce deseja remover o seguinte item? Digite 1 para remover ou 0 para cancelar!";

        std::cout<< std::endl << std::endl << item::toString(rest.menu[itemRemovido-1]) << std::endl << std::endl << ">";
        std::cin >> confirma;
        std::cin.get();
        if (confirma == 1){
            rest.menu.erase(rest.menu.begin() + itemRemovido - 1);
            std::cout << " --- Removido com sucesso! --- " << std::endl;
            std::cout << "Pressione enter para continuar!" << std::endl;
            std::cin.ignore();
            break;
        } else if (confirma == 0){
            std::cout << " --- Remoacao cancelada! --- " << std::endl;
            std::cout << "Pressione enter para continuar!" << std::endl;
            std::cin.ignore();
        }
    }
}

 void removerItem(rst::Restaurant &rest) {
     int itemRemovido = -1;

    if(rest.menu.size() == 0){
        std::cout << std::endl << std::endl << " ---------- CARDAPIO VAZIO ---------- " << std::endl;
        std::cout << " ---------- ADICIONE PRATOS OU ESCOLHA OUTRA OPCAO ---------- " << std::endl << std::endl;
    }
    while (rest.menu.size() > 0){
        system("clear");
        std::cout <<  " ---------- REMOVER ITEM ---------- " << std::endl << std::endl
        << "Lista de Pratos: ";

        std::cout << rst::showMenu(rest);

        std::cout << std::endl << std::endl << "Digite o numero do prato que voce deseja deletar, ou 0 para Cancelar:";
        std::cin >> itemRemovido;
        std::cin.get();

        if(itemRemovido != 0) {
            if(itemRemovido <= rest.menu.size() && itemRemovido > 0) {
                confirmaRemocao(rest, itemRemovido);
                itemRemovido = -1;
            } else {
                std::cout << " --- ERRO: Numero do Prato invalido --- ";
                std::cout << "Pressione enter para continuar!" << std::endl;
                std::cin.ignore();
            }
        }
    }
 }

void verPedidos(rst::Restaurant &rest){
    
    if (rest.orders.size() == 0){
        std::cout << std::endl << std::endl << "Nenhum pedido foi realizado ainda!" << std::endl << std::endl
        << "Pressione enter para voltar ao menu.";
        std::cin.ignore();
        return;
    }

    int choice = -1;
    int confirma = -1;
    
    while (choice != 0){
        system("clear");
        std::cout<< ord::listOrders(rest.orders) << std::endl;

        std::cout << "Digite o número do pedido que deseja acessar ou 0 para voltar ao menu: ";
        std::cin >> choice;
        std::cin.get();
        if (choice == 0){
            break;
        } else if (choice <= rest.orders.size() && choice > 0){
            system("clear");
            std::cout << ord::orderToString(rest.orders[choice - 1]) << std::endl;
            std::cout << "Pressione 1 para mudar o estado do pedido ou 0 para voltar aos seus pedidos: " << std::endl;
            std::cin >> confirma;
            std::cin.get();
            if (confirma == 1){
                system("clear");
                std::cout << ord::orderToString(rest.orders[choice - 1]) << std::endl
                << "Digite 1 para confirmar o envio do pedido ou 0 para voltar aos seus pedidos: ";
                std::cin >> confirma;
                std::cin.get();
                if (confirma == 1){
                    ord::changeSituation(rest.orders[choice - 1], 1);
                    std::cout << std::endl << "Mudança realizada com sucesso! Pressione enter para voltar aos seus pedidos";
                    std::cin.ignore();
                } else {
                    std::cout << std::endl << "Mudança Cancelada! Pressione enter para voltar aos seus pedidos";
                    std::cin.ignore();
                }
            }
        }
    }


}

void menuRestaurante (rst::Restaurant &rest) {

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

        switch (opMenuRestaurante) {
            case ADICIONAR_ITEM:
                adicionarItem(rest);
                break;

            case REMOVER_ITEM:
            	removerItem(rest);
                break; 

            case VER_PEDIDOS:
                verPedidos(rest);
                break;

            case SAIR:
                break;
        }

    }

}