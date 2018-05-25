#ifndef PLP_MENUCLIENTE_H
#define PLP_MENUCLIENTE_H

#endif //PLP_MENUCLIENTE_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>

const char CONFIRMAR_ALTA = 'S';
const char CONFIRMAR_BAIXA = 's';
const char CANCELAR_CHAR = 'n';
const int PROSSEGUIR = 0;

void confirmaPedido(ord::Order ord, rst::Restaurant &rest, clt::Client &cliente){
    system("clear");
    char choice;

    ord.estabelecimento = rest.name;
    ord.usuario = cliente.name;
    ord.endereco = cliente.address;
    ord.userPhone = cliente.phone;
    ord.restPhone = rest.phone;

    std::cout << ord::orderToString(ord);

    while (choice != CONFIRMAR_ALTA && choice != CONFIRMAR_BAIXA && choice != CANCELAR_CHAR){
        std::cout << "Confirmar pedido (S/n)? ";
        std::cin >> choice;
        std::cout << std::endl;

        switch (choice) {
            case CONFIRMAR_ALTA:
                std::cout << "Pedido confirmado com sucesso! Pressione ENTER para continuar.";
                clt::addOrder(ord, cliente);
                rst::addOrder(ord, rest);
                std::cin.ignore();

            case CONFIRMAR_BAIXA:
                std::cout << "Pedido confirmado com sucesso! Pressione ENTER para continuar.";
                clt::addOrder(ord, cliente);
                rst::addOrder(ord, rest);
                std::cin.ignore();

            case CANCELAR_CHAR:
                std::cout << "Pedido cancelado com sucesso! Pressione ENTER para continuar.";
                std::cin.ignore();

            default:
                std::cout << "Comando invalido.";
                break;
        }
    }
}

void realizarPedido(rst::Restaurant &rest, clt::Client &cliente){
    ord::Order ord;
    int selecionado = -1;
    int adicionar;
    bool contemItem = false;

    while (selecionado != 0){
        system("clear");
        std::cout << rst::showMenu(rest) << std::endl;
        std::cout << "Digite o número do item a ser adicionado ao pedido ou 0 para ir para a página de confirmação: ";
        std::cin >> selecionado;
        std::cin.get();
        if (selecionado == 0){
            break;
        } else if (selecionado <= rest.menu.size() && selecionado > 0){
            std::cout << "\n" << item::toString(rest.menu[selecionado-1]) << "\n\n";
            std::cout << "(1) Adicionar ao carrinho.\n";
            std::cout << "(2) Cancelar.\n\n";
            std::cout << ">";
            std::cin >> adicionar;
            std::cin.get();
            if (adicionar == 1){
                ord::addItem(ord, rest.menu[selecionado-1]);
                contemItem = true;
                std::cout << "\n Produto adicionado ao carrinho, pressione enter para continuar.";
                std::cin.ignore();
            } else {
                std::cout << "\nCancelado. Pressione enter para continuar.";
                std::cin.ignore();
            }
        }
    }
    if (contemItem){
        confirmaPedido(ord, rest, cliente);
    } else {
        std::cout << "Pedido vazio. Pressione enter para continuar." << std::endl;
        std::cin.ignore();
    }
    
}

void cardapioRestaurante(rst::Restaurant &rest, clt::Client &cliente){
    const char REALIZAR_PEDIDO = '1';
    const char CANCELAR_PEDIDO = '2';
    char choice = '0';
    
    while (choice != CANCELAR_PEDIDO){
        system("clear");
        std::cout << rst::showMenu(rest)
                  << "Selecione uma opcao" << std::endl
                  << "(1) Realizar Pedido" << std::endl
                  << "(2) Voltar a lista de restaurantes" << std::endl << std::endl
                  << "> ";

        std::cin >> choice;

        if (choice == REALIZAR_PEDIDO){
            realizarPedido(rest, cliente);
        }
    }
}

void exibirRestaurantes(std::vector<rst::Restaurant> &restaurantes, clt::Client &cliente){
    const char VER_CARDAPIO = '1';
    const char CANCELAR = '2';
    char choice = '0';
    int escolheRestaurante;

    while (choice != CANCELAR) {
        system("clear");
        std::cout << "RESTAURANTES CADASTRADOS:" << std::endl << std::endl;
        std::cout << rst::listaRestaurantes(restaurantes) << std::endl;

        std::cout << "Selecione uma opcao:" << std::endl
                  << "(1) Ver cardapio" << std::endl
                  << "(2) Voltar ao menu" << std::endl << std::endl
                  << "> ";
        std::cin >> choice;
        std::cin.get();
        if (choice == VER_CARDAPIO){
            system("clear");

            std::cout << "Restaurantes cadastrados no sistema:" << std::endl << std::endl
                      << rst::listaRestaurantes(restaurantes) << std::endl
                      << "Escolha o restaurante: ";

            std::cin >> escolheRestaurante;
            std::cin.get();
            cardapioRestaurante(restaurantes[escolheRestaurante - 1], cliente);
        }
    }
}

void verMeusPedidos(clt::Client &cliente){
    
    if (cliente.orders.size() == 0){
        std::cout << "Nenhum pedido foi realizado ainda!" << std::endl << std::endl
        << "Pressione enter para voltar ao menu.";
        std::cin.ignore();
    }

    int choice = -1;
    
    while (choice != 0){
        system("clear");
        std::cout<< clt::listOrders(cliente) << std::endl;

        std::cout << "Digite o número do pedido que deseja acessar ou 0 para voltar ao menu: ";
        std::cin >> choice;
        std::cin.get();
        if (choice == 0){
            break;
        } else if (choice <= cliente.orders.size() && choice > 0){
            system("clear");
            std::cout << ord::orderToString(cliente.orders[choice - 1]) << std::endl;
            std::cout << "Pressione enter para voltar aos seus pedidos." << std::endl;
            std::cin.ignore();
        }
    }


}

void menuCliente(std::vector<rst::Restaurant> &restaurantes, clt::Client &cliente){
    const char EXIBIR = '1';
    const char PESQUISAR = '2';
    const char VER_PEDIDOS = '3';
    const char SAIR = '4';

    
    char opMenuCliente;

    while(opMenuCliente != SAIR) {
        system("clear");
        std::cout <<  "Bem vindo, " << cliente.name << "." << std::endl << std::endl
        << "MENU" << std::endl
        << "(1) Exibir todos restaurantes" << std::endl
        << "(2) Pesquisar restaurantes" << std::endl
        << "(3) Ver pedidos" << std::endl
        << "(4) Sair" << std::endl << std::endl
        << "> ";
        std::cin >> opMenuCliente;
        std::cin.get();

        switch (opMenuCliente) {
            case EXIBIR:
                exibirRestaurantes(restaurantes, cliente);
                break;

            case SAIR:
                break;

            case VER_PEDIDOS:
                verMeusPedidos(cliente);
                break;

            case PESQUISAR:
                //pesquisarRestaurantes(restaurantes, cliente);
                break;

            default:
                std::cout << "Comando invalido.";
                break;

        }
    }

    system("clear");
}
