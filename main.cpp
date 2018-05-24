#include <iostream>
#include <stdlib.h>
#include <string>
#include <vector>
#include <sstream>
#include "models/restaurant.h"
#include "models/client.h"
#include "models/pedido.h"

/*
    Este eh o menu principal com as funcoes de 
    cadastrar um novo cliente restaurantem, e
    fazer login como cliente ou restaurante
*/

void cadastrarNovoCliente(std::vector<clt::Client> clientes) {

    system("clear");
    bool cadastroValido = true;

    std::cout << "===> Cadastrar Novo Cliente <===\n";
    clt::Client cliente = clt::newCliente(); 

    
    // esse for vai apenas checar se ja existe alguem com o mesmo login
    // se nao, nao sera adicionado e voltara pro menu principal

    // NESSA PARTE da erro de segmentacao, nao sei  o q poha eh isso, so sei que eh
    // no size, ai procurei na net e vi esse static_cast que resolve mas nao sei se funciona
    for (int i = 0; i < static_cast<int>(clientes.size())-1; i++) {
        if (clientes[i].login == cliente.login) {
            cadastroValido = false;
        } 
        std::cout << clientes[i].login;
    }

    if (cadastroValido) {
        clientes.push_back(cliente);
        std::cout << "======== CADASTRO EFETUADO COM SUCESSO :D =========\n\n";
    } else {
        std::cout << "!!!!!!!!! ERRO NO CADASTRO: LOGIN JA EXISTE !!!!!!!!!";
    }
}

void cadastrarNovoRestaurante(std::vector<rst::Restaurant> restaurantes) {

    system("clear");
    std::cout << "===> Cadastrar Novo Restaurante <===\n";
    bool cadastroValido = true;
    rst::Restaurant r = rst::newRestaurant();

    for (int i = 0; i < static_cast<int>(restaurantes.size())-1; i++) {
        if (restaurantes[i].cnpj == r.cnpj) {
            cadastroValido = false;
        }
    }

    if (cadastroValido) {
        restaurantes.push_back(r);
        std::cout << "======== CADASTRO EFETUADO COM SUCESSO :D =========\n\n";
    } else {
        std::cout << "!!!!!!!!! ERRO NO CADASTRO: CNPJ JA EXISTE !!!!!!!!!";
    }

}

int main() {

    std::vector<clt::Client> clientes;
    std::vector<rst::Restaurant> restaurantes;

    std::string opMenuInicial;

    while(opMenuInicial != "5") {

        std::cout <<  "\n\nSeja bem vindo ao Sistema de Delivery."
        << "\n\n=====> Digite uma opcao para continuar <====="
        << "\n\n- Fazer login com,o Cliente ---->         (  1  )"
        << "\n- Fazer login como Restaurante ---->      (  2  )"
        << "\n- Criar nova conta como Cliente ---->     (  3  )"
        << "\n- Criar nova conta como Restaurante ----> (  4  )\n"
        << "\n- Sair ---->                              (  5  )\n";
        std::cin >> opMenuInicial;
        
        if (opMenuInicial == "1") {

        } else if (opMenuInicial == "2") {

        } else if (opMenuInicial == "3") {
            cadastrarNovoCliente(clientes);
        } else if (opMenuInicial == "4") {
            cadastrarNovoRestaurante(restaurantes);
        }

        //system("clear");
    }
    

    return 0;
}



////////////////////////////ANTIGO MAIN////////////////////////////////////////
// item::Item coxinha;
// coxinha.name = "Coxinha";
// coxinha.price = 2.5;
// coxinha.description = "God's favourite snack";

// item::Item pastel;
// pastel.name = "Pastel";
// pastel.price = 3.0;
// pastel.description = "Tropical spring roll";

// item::Item alfajor;
// alfajor.name = "Alfajor";
// alfajor.price = 3.5;
// alfajor.description = "Tasty Argentinian cookies";

// rst::Restaurant seuOlavo;
// seuOlavo.name = "Seu Olavo's";
// seuOlavo.cnpj = 1;
// seuOlavo.cuisine = "Fast-food";
// seuOlavo.phone = "1234-5678";
// seuOlavo.opensAt[0] = 8;
// seuOlavo.opensAt[1] = 0;
// seuOlavo.closesAt[0] = 19;
// seuOlavo.closesAt[1] = 0;
// seuOlavo.menu.push_back(coxinha);
// seuOlavo.menu.push_back(pastel);
// seuOlavo.menu.push_back(alfajor);
// std::cout << "Open? " << rst::isOpen(seuOlavo) << std::endl;
// std::cout << "Menu:" << std::endl << rst::showMenu(seuOlavo) << std::endl << std::endl;

// clt::Client client;
// client.name = "Melina Mongiovi";

// ord::Order order;
// rst::Restaurant *sO = &seuOlavo;
// clt::Client *s1 = &client;
// order.restaurant = sO;
// order.client = s1;
// ord::addItem(order, seuOlavo.menu[0]);
// ord::addItem(order, seuOlavo.menu[0]);
// ord::addItem(order, seuOlavo.menu[2]);
// ord::addItem(order, seuOlavo.menu[2]);
// ord::removeItem(order, 3);
// std::cout << "Is sent? " << ord::isSent(order) << std::endl;
// ord::changeSituation(order, ord::SENT);
// std::cout << "Is sent? " << ord::isSent(order) << std::endl;
// std::cout << "Order made by: " << ord::getClient(order).name << std::endl;
// std::cout << "Order made at " << ord::getRestaurant(order).name << std::endl;
// std::cout << "Total price: R$" << ord::getTotalPrice(order) << std::endl;