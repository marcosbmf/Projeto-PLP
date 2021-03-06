#ifndef PLP_MENUCLIENTE_H
#define PLP_MENUCLIENTE_H

#endif //PLP_MENUCLIENTE_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <ctype.h>

extern ui::UserInterface tela;
const char CONFIRMAR_ALTA = 'S';
const char CANCELAR_CHAR = 'N';
const int PROSSEGUIR = 0;

void confirmaPedido(ord::Order ord, rst::Restaurant &rest, clt::Client &cliente){
    ui::defTitulo(tela, "CONFIRMAR PEDIDO");
    ui::limpaTela(tela);
    char choice;

    ord.estabelecimento = rest.name;
    ord.usuario = cliente.name;
    ord.endereco = cliente.address;
    ord.userPhone = cliente.phone;
    ord.restPhone = rest.phone;

    std::cout << ord::orderToString(ord);

    while (choice != CONFIRMAR_ALTA  && choice != CANCELAR_CHAR){
        std::cout << "Confirmar pedido (S/n)? ";
        std::cin >> choice;
        std::cin.get();
        std::cout << std::endl;

        choice = toupper(choice);

        switch (choice) {
            case CONFIRMAR_ALTA:
                std::cout << "Pedido confirmado com sucesso! Pressione ENTER para continuar.";
                clt::addOrder(ord, cliente);
                rst::addOrder(ord, rest);
                std::cin.ignore();
                break;

            case CANCELAR_CHAR:
                std::cout << "Pedido cancelado com sucesso! Pressione ENTER para continuar.";
                std::cin.ignore();
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
    int adicionar;
    bool contemItem = false;

    while (selecionado != 0){
        ui::limpaTela(tela);
        std::cout << rst::showMenu(rest) << std::endl;
        std::cout << "Digite o numero do item a ser adicionado ao pedido ou 0 para ir para a pagina de confirmacao: ";
        std::cin >> selecionado;
        std::cin.get();
        if (selecionado == 0){
            break;
        } else if (selecionado <= rest.menu.size() && selecionado > 0){
            ui::limpaTela(tela);
            std::cout << "\n" << item::toString(rest.menu[selecionado-1]) << "\n\n";
            std::cout << "(1) Adicionar ao carrinho.\n";
            std::cout << "(2) Cancelar.\n\n";
            std::cout << ">";
            std::cin >> adicionar;
            std::cin.get();
            if (adicionar == 1){
                ord::addItem(ord, rest.menu[selecionado-1]);
                contemItem = true;
                std::cout << "\n Produto adicionado ao carrinho, pressione ENTER para continuar.";
                std::cin.ignore();
            } else {
                std::cout << "\nCancelado. Pressione ENTER para continuar.";
                std::cin.ignore();
            }
        }
    }
    if (contemItem){
        confirmaPedido(ord, rest, cliente);
        return;
    } else {
        std::cout << "Pedido vazio. Pressione ENTER para continuar." << std::endl;
        std::cin.ignore();
    }
    
}

void cardapioRestaurante(rst::Restaurant &rest, clt::Client &cliente){
    const char REALIZAR_PEDIDO = '1';
    const char CANCELAR_PEDIDO = '2';
    char choice = '0';
    
    while (choice != CANCELAR_PEDIDO){
        ui::defTitulo(tela, "CARDAPIOS");
        ui::limpaTela(tela);
        std::cout << rst::showMenu(rest)
                  << "Selecione uma opcao" << std::endl
                  << "(1) Realizar Pedido" << std::endl
                  << "(2) Voltar a lista de restaurantes" << std::endl << std::endl
                  << "> ";

        std::cin >> choice;

        if (choice == REALIZAR_PEDIDO){
            realizarPedido(rest, cliente);
            return;
        }
    }
}

void exibirRestaurantes(std::vector<rst::Restaurant> &restaurantes, clt::Client &cliente){
    const char VER_CARDAPIO = '1';
    const char CANCELAR = '2';
    char choice = '0';
    int escolheRestaurante;

    while (choice != CANCELAR) {
        ui::defTitulo(tela, "FAZER PEDIDO");
        ui::limpaTela(tela);

        std::cout << "RESTAURANTES CADASTRADOS:" << std::endl << std::endl;
        std::cout << rst::listaRestaurantes(restaurantes) << std::endl;

        std::cout << "Selecione uma opcao:" << std::endl
                  << "(1) Ver cardapio" << std::endl
                  << "(2) Voltar ao menu" << std::endl << std::endl
                  << "> ";
        std::cin >> choice;
        std::cin.get();
        if (choice == VER_CARDAPIO){
            ui::limpaTela(tela);

            std::cout << "Restaurantes cadastrados no sistema:" << std::endl << std::endl
                      << rst::listaRestaurantes(restaurantes) << std::endl
                      << "Escolha o restaurante: ";

            std::cin >> escolheRestaurante;
            std::cin.get();
            cardapioRestaurante(restaurantes[escolheRestaurante - 1], cliente);
            return;
        }
    }
}

void verMeusPedidos(clt::Client &cliente){
    
    if (cliente.orders.size() == 0){
        std::cout << std::endl << std::endl << "Nenhum pedido foi realizado ainda!" << std::endl << std::endl
        << "Pressione ENTER para voltar ao menu.";
        std::cin.ignore();
        return;
    }

    int choice = -1;
    int confirma = -1;
    
    while (choice != 0){
        ui::limpaTela(tela);
        std::cout<< ord::listOrders(cliente.orders) << std::endl;

        std::cout << "Digite o numero do pedido que deseja acessar ou 0 para voltar ao menu: ";
        std::cin >> choice;
        std::cin.get();
        if (choice == 0){
            break;
        } else if (choice <= cliente.orders.size() && choice > 0){
            ui::limpaTela(tela);
            std::cout << ord::orderToString(cliente.orders[choice - 1]) << std::endl;
            std::cout << "Digite 1 para confirmar o recebimento do pedido ou 0 para voltar aos pedidos: ";
            std::cin >> confirma;
            std::cin.get();
            std::cout << std::endl;

            if (confirma == 1){
                ord::changeSituation(cliente.orders[choice - 1], 2);
                std::cout << "Entrega do pedido confirmada com sucesso! Pressione enter para voltar aos seus pedidos.";
                std::cin.ignore();
            }
        }
    }


}

void avaliar(std::vector<rst::Restaurant> &rest){
    int choice = -1;
    int nota;
    while (choice != 0){
        ui::defTitulo(tela, "AVALIAR RESTAURANTE");
        ui::limpaTela(tela);
        std::cout << rst::listaRestaurantes(rest) << std::endl << std::endl;
        std::cout << "Selecione o restaurante que deseja avaliar ou digite 0 para voltar ao menu: " << std::endl << std::endl;
        std::cin >> choice;
        std::cin.get();

        if (choice <= rest.size() && choice > 0){
            std::cout << "Qual nota gostaria de dar ao restaurante " << rest[choice - 1].name << "? (Nota entre 0 e 5)" << std::endl
            << "> ";
            std::cin >> nota;
            if (nota >= 0 && nota <= 5){
                rest[choice - 1].reviewSum += nota;
                rest[choice - 1].numReviews += 1;
                ui::defFeedback(tela, ui::ICN_SUCESSO, "Restaurante avaliado com sucesso.");
                std::cin.ignore();
                break;
            } else {
                ui::defFeedback(tela, ui::ICN_ERRO, "Nota invalida");
            }

            std::cin;
            std::cin.ignore();
        }
    }

}

void menuCliente(std::vector<rst::Restaurant> &restaurantes, clt::Client &cliente){
    const char EXIBIR = '1';
    const char VER_PEDIDOS = '2';
    const char AVALIAR = '3';
    const char SAIR = '4';

    
    char opMenuCliente;
    ui::defFeedback(tela, ui::ICN_SUCESSO, "Login realizado com sucesso.");

    while(opMenuCliente != SAIR) {
        ui::defTitulo(tela, "SISTEMA DE DELIVERY ONLINE");
        ui::limpaTela(tela);

        std::cout <<  "Bem vindo, " << cliente.name << "." << std::endl << std::endl
        << "MENU" << std::endl
        << "(1) Exibir todos restaurantes" << std::endl
        << "(2) Ver pedidos" << std::endl
        << "(3) Avaliar restaurante" << std::endl
        << "(4) Sair" << std::endl << std::endl
        << "> ";
        std::cin >> opMenuCliente;
        std::cin.get();

        switch (opMenuCliente) {
            case EXIBIR:
                exibirRestaurantes(restaurantes, cliente);
                break;

            case SAIR:
                ui::defFeedback(tela, ui::ICN_NADA, "logout realizado com sucesso");
                break;

            case VER_PEDIDOS:
                verMeusPedidos(cliente);
                break;

            case AVALIAR:
                avaliar(restaurantes);
                break;

            default:
                ui::defFeedback(tela, ui::ICN_ERRO, "Comando invalido");
                break;

        }
    }
}
