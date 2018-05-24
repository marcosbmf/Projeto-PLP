#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include "models/restaurant.h"
#include "models/client.h"
#include "models/pedido.h"

int main() {
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

    ord::Order order;
    rst::Restaurant *sO = &seuOlavo;
    clt::Client *s1 = &client;
    order.restaurant = sO;
    order.client = s1;
    ord::addItem(order, seuOlavo.menu[0]);
    ord::addItem(order, seuOlavo.menu[0]);
    ord::addItem(order, seuOlavo.menu[2]);
    ord::addItem(order, seuOlavo.menu[2]);
    ord::removeItem(order, 3);
    std::cout << "Is sent? " << ord::isSent(order) << std::endl;
    ord::changeSituation(order, ord::SENT);
    std::cout << "Is sent? " << ord::isSent(order) << std::endl;
    std::cout << "Order made by: " << ord::getClient(order).name << std::endl;
    std::cout << "Order made at " << ord::getRestaurant(order).name << std::endl;
    std::cout << "Total price: R$" << ord::getTotalPrice(order) << std::endl;

    return 0;
}