#ifndef PLP_MENUCLIENTE_H
#define PLP_MENUCLIENTE_H

#endif //PLP_MENUCLIENTE_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>

void confirmaPedido(ord::Order &ord, rst::Restaurant &rest, clt::Client &cliente){
    std::string choice;
    std::string confirma;
    system("clear");
    std::cout << "Deseja confirmar esse pedido: ";
    std::cout << ord::orderToString(ord);

    while (choice != "1" && choice != "2"){
        std::cout << "\n\n=====> Digite uma opcao para continuar <====="
                  <<   "\nConfirmar pedido ---->                  ( 1 )"
                  <<   "\nCancelar pedido ---->                   ( 2 )\n\n";

        if (choice == "1"){
            std::cout << "\n\nPedido confirmado com sucesso! Digite enter para continuar.";
            ord.usuario = cliente.login;
            ord.estabelecimento = rest.name;
            clt::addOrder(ord, cliente);
            rst::addOrder(ord, rest);
            getline(std::cin, confirma);
        } else if (choice == "2"){
            std::cout << "Pedido cancelado com sucesso! Digite enter para continuar.";
            getline(std::cin, confirma);
        }
    }
}

void realizarPedido(rst::Restaurant &rest, clt::Client &cliente){
    ord::Order ord;
    int selecionado = -1;
    int adicionar;
    std::string enter;
    bool contemItem = false;
    while (selecionado != 0){
        system("clear");
        std::cout << rst::showMenu(rest);
        std::cout << "Digite o número do item a ser adicionado ao pedido ou 0 para ir para a página de confirmação: ";
        std::cin >> selecionado;
        std::cin.get();
        if (selecionado == 0){
            break;
        } else if (selecionado <= rest.menu.size() && selecionado > 0){
            std::cout << item::toString(rest.menu[selecionado-1]) << "\n\n";
            std::cout << "(1) Adicionar ao carrinho.\n";
            std::cout << "(2) Cancelar.\n";
            std::cin >> adicionar;
            std::cin.get();
            if (adicionar == 1){
                ord::addItem(ord, rest.menu[selecionado-1]);
                std::cout << "\n Produto adicionado ao carrinho, pressione enter para continuar.";
                std::cin >> enter;
                std::cin.get();
            } else {
                std::cout << "\nCancelado. Pressione enter para continuar.";
                std::cin >> enter;
                std::cin.get();
            }
        }
    }
    confirmaPedido(ord, rest, cliente);
}

void cardapioRestaurante(rst::Restaurant &rest, clt::Client &cliente){
    std::string choice = "0";
    
    while (choice != "2"){
        system("clear");
        std::cout << rst::showMenu(rest)
                << "\n\n=====> Digite uma opcao para continuar <====="
                <<   "\n(1) Realizar Pedido"
                <<   "\n(2) Voltar à lista de restaurates\n\n";

        getline(std::cin, choice);

        if (choice == "1"){
            realizarPedido(rest, cliente);
        }
    }
}

void exibirRestaurantes(std::vector<rst::Restaurant> &restaurantes, clt::Client &cliente){
    int escolheRestaurante;
    std::string choice = "0";

    while (choice != "2"){
        system("clear");
        std::cout << "\n\n=====> Lista de Restaurantes Cadastrados <=====\n\n";
        std::cout << rst::listaRestaurantes(restaurantes);

        std::cout <<     "=====> Digite uma opcao para continuar <====="
                  << "\n\n(1) Ver cardapio"
                  <<   "\n(2) Voltar ao menu\n\n";

        getline(std::cin, choice);

        if (choice == "1"){
            system("clear");
            std::cout << "\n\nRestaurantes cadastrados no sistema:\n\n"
                    << rst::listaRestaurantes(restaurantes)
                    << "\n Escolha o restaurante: ";
            std::cin >> escolheRestaurante;
            cardapioRestaurante(restaurantes[escolheRestaurante - 1], cliente);
        }
    }
}

void menuCliente(std::vector<rst::Restaurant> &restaurantes, clt::Client &cliente){
    
    system("clear");
    std::string opMenuCliente;

    while(opMenuCliente != "4") {

        std::cout <<  "\n\nSeja bem vindo ao Sistema de Delivery, " << cliente.name << "."
        << "\n\n=====> Digite uma opcao para continuar <====="
        << "\n\n(1) Exibir todos restaurantes"
        << "\n(2) Pesquisar restaurantes"
        << "\n(3) Ver pedidos"
        << "\n(4) Sair\n";
        std::cin >> opMenuCliente;


        if (opMenuCliente == "1"){
            exibirRestaurantes(restaurantes, cliente);
        } else if (opMenuCliente == "2"){
            //pesquisarRestaurantes(restaurantes, cliente);
        } else if (opMenuCliente == "3"){
            //verMeusPedidos(cliente);
        } else if (opMenuCliente == "4"){
            break;
        }
    }
    
    system("clear");
}

