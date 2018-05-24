#ifndef PLP_MENUCLIENTE_H
#define PLP_MENUCLIENTE_H

#endif //PLP_MENUCLIENTE_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>

void cardapioRestaurante(rst::Restaurant &rest, clt::Client &cliente){
    std::string choice = "0";
    
    while (choice != "2"){
        std::cout << rst::showMenu(rest)
                << "\n\n=====> Digite uma opcao para continuar <====="
                <<   "\nRealizar Pedido ---->                   ( 1 )"
                <<   "\nVoltar à lista de restaurates ---->     ( 2 )\n\n";

        getline(std::cin, choice);

        if (choice == "1"){
            //realizarPedido(rest, cliente);
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
                  << "\n\nVer cardapio ---->                      ( 1 )"
                  <<   "\nVoltar ao menu ---->                    ( 2 )\n\n";

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
        << "\n\n- Exibir todos restaurantes ---->         (  1  )"
        << "\n- Pesquisar restaurantes ---->            (  2  )"
        << "\n- Ver pedidos ---->                       (  3  )"
        << "\n- Sair ---->                              (  4  )\n";
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

