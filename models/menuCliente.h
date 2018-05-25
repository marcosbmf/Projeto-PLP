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
    char choice;
    char confirma;
            //IMpressão do pedido

    while (choice != CONFIRMAR_ALTA && choice != CONFIRMAR_BAIXA && choice != CANCELAR_CHAR){
        std::cout << "Confirmar pedido (S/n)? ";
        std::cin >> choice;
        std::cout << std::endl;

        switch (choice) {
            case CONFIRMAR_ALTA || CONFIRMAR_BAIXA:
                std::cout << "Pedido confirmado com sucesso! Pressione ENTER para continuar.";
                clt::addOrder(ord, cliente);
                rst::addOrder(ord, rest);
                std::cin >> confirma;
                break;

            case CANCELAR_CHAR:
                std::cout << "Pedido cancelado com sucesso! Pressione ENTER para continuar.";
                std::cin >> confirma;
                break;

            default:
                std::cout << "Comando invalido.";
                break;
        }
    }
}

void realizarPedido(rst::Restaurant &rest, clt::Client &cliente){
    ord::Order ord;
    int selecionado = -1;
    bool contemItem = false;
    std::cout << rst::showMenu(rest);

    while (selecionado != PROSSEGUIR){
            std::cout << "Digite o número do item a ser adicionado ao pedido ou digite 0 para ir para a pagina de confirmacao: ";
            std::cin >> selecionado;
            std::cin.get();

            if (selecionado <= rest.menu.size() && selecionado > 0){
                ord::addItem(ord, rest.menu[selecionado - 1]);
            }
    }

    confirmaPedido(ord, rest, cliente);
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
        std::cout << rst::listaRestaurantes(restaurantes);

        std::cout << "Selecione uma opcao:" << std::endl
                  << "(1) Ver cardapio" << std::endl
                  << "(2) Voltar ao menu" << std::endl << std::endl
                  << "> ";
        std::cin >> choice;

        if (choice == VER_CARDAPIO){
            system("clear");

            std::cout << std::endl
                      << "Restaurantes cadastrados no sistema:" << std::endl
                      << rst::listaRestaurantes(restaurantes) << std::endl
                      << "Escolha o restaurante: ";

            std::cin >> escolheRestaurante;
            cardapioRestaurante(restaurantes[escolheRestaurante - 1], cliente);
        }
    }
}

void menuCliente(std::vector<rst::Restaurant> &restaurantes, clt::Client &cliente){
    const char EXIBIR = '1';
    const char PESQUISAR = '2';
    const char VER_PEDIDOS = '3';
    const char SAIR = '4';

    system("clear");
    char opMenuCliente;

    while(opMenuCliente != SAIR) {

        std::cout <<  "Bem vindo, " << cliente.name << "." << std::endl
        << "MENU" << std::endl
        << "(1) Exibir todos restaurantes" << std::endl
        << "(2) Pesquisar restaurantes" << std::endl
        << "(3) Ver pedidos" << std::endl
        << "(4) Sair" << std::endl << std::endl
        << "> ";
        std::cin >> opMenuCliente;

        switch (opMenuCliente) {
            case EXIBIR:
                exibirRestaurantes(restaurantes, cliente);
                break;

            case SAIR:
                //pesquisarRestaurantes(restaurantes, cliente);
                break;

            case VER_PEDIDOS:
                //verMeusPedidos(cliente);
                break;

            case PESQUISAR:
                break;

            default:
                std::cout << "Comando invalido.";
                break;

        }
    }

    system("clear");
}
