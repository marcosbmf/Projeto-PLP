#ifndef PLP_PRE_H
#define PLP_PRE_H

#endif //PLP_PRE_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>


void preCadastro(std::vector<rst::Restaurant> &rests, std::vector<clt::Client> &clientes){
    item::Item coxinha;
    coxinha.name = "Coxinha";
    coxinha.price = 2.5;
    coxinha.description = "God's favourite snack";

    item::Item pastel;
    pastel.name = "Pastel";
    pastel.price = 3.0;
    pastel.description = "Tropical spring roll";

    item::Item alfajor;
    alfajor.name = "Alfajor";
    alfajor.price = 3.5;
    alfajor.description = "Tasty Argentinian cookies";

    rst::Restaurant seuOlavo;
    seuOlavo.name = "Seu Olavo's";
    seuOlavo.cnpj = 1;
    seuOlavo.cuisine = "Fast-food";
    seuOlavo.phone = "1234-5678";
    seuOlavo.password = "Olavo";
    seuOlavo.opensAt[0] = 8;
    seuOlavo.opensAt[1] = 0;
    seuOlavo.closesAt[0] = 19;
    seuOlavo.closesAt[1] = 0;
    seuOlavo.menu.push_back(coxinha);
    seuOlavo.menu.push_back(pastel);
    seuOlavo.menu.push_back(alfajor);
    std::cout << "Open? " << rst::isOpen(seuOlavo) << std::endl;
    std::cout << "Menu:" << std::endl << rst::showMenu(seuOlavo) << std::endl << std::endl;

    clt::Client client;
    client.name = "Melina Mongiovi";
    client.login = "Melina";
    client.password = "Melina";
    client.address = "Rua Rodrigues Alves, 1400";
    client.phone = "(83) 9999-9999";

    clientes.push_back(client);
    rests.push_back(seuOlavo);
}