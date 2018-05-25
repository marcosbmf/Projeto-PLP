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

    item::Item hotdog;
    coxinha.name = "Hot-Dog";
    coxinha.price = 2.5;
    coxinha.description = "Melhor Cachorro-Quente da regiao";

    item::Item minipizza;
    pastel.name = "MiniPizza";
    pastel.price = 3.0;
    pastel.description = "Pizza quentinha saindo do forno";

    item::Item mistoCaixa;
    alfajor.name = "Misto no Caixa";
    alfajor.price = 3.5;
    alfajor.description = "Misto no caixa muito bom";

    item::Item mistoFrances;
    alfajor.name = "Misto no frances";
    alfajor.price = 3.5;
    alfajor.description = "Misto no frances muito bom";

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
    seuOlavo.menu.push_back(minipizza);
    seuOlavo.menu.push_back(hotdog);
    seuOlavo.menu.push_back(mistoCaixa);
    seuOlavo.menu.push_back(mistoFrances);

    item::Item pizzabacon;
    coxinha.name = "Pizza de Bacon";
    coxinha.price = 20;
    coxinha.description = "O melhor bacon do mundo";

    item::Item pizza4queijos;
    pastel.name = "Pizza 4 Queijos";
    pastel.price = 17;
    pastel.description = "Melhor selecao de queijos de campina grande";

    item::Item pizzacalabresa;
    alfajor.name = "Pizza de Calabresa";
    alfajor.price = 20;
    alfajor.description = "Calabresa Quentinha saindo do abatedouro";

    item::Item pizzamisto;
    coxinha.name = "Pizza de Misto";
    coxinha.price = 25;
    coxinha.description = "Presunto. Queijo. Simples assim.";

    item::Item pizzafrango;
    pastel.name = "Pizza de Frango";
    pastel.price = 20;
    pastel.description = "Pizza de quem nao vai pra academia";

    item::Item pizzachocolate;
    alfajor.name = "Pizza de Chocolate";
    alfajor.price = 15;
    alfajor.description = "Pra comer de sobremesa";

    item::Item pizzafitness;
    alfajor.name = "Pizza de Fitness";
    alfajor.price = 10;
    alfajor.description = "Pizza de salada pra quem nao quer ganhar calorias";
    
    rst::Restaurant pizzariaDoCarvalho;
    pizzariaDoCarvalho.name = "Pizzaria Nota 10";
    pizzariaDoCarvalho.cnpj = 2;
    pizzariaDoCarvalho.cuisine = "Pizzaria";
    pizzariaDoCarvalho.phone = "4002-8922";
    pizzariaDoCarvalho.password = "carvalho";
    pizzariaDoCarvalho.opensAt[0] = 16;
    pizzariaDoCarvalho.opensAt[1] = 0;
    pizzariaDoCarvalho.closesAt[0] = 23;
    pizzariaDoCarvalho.closesAt[1] = 30;
    pizzariaDoCarvalho.menu.push_back(pizzabacon);
    pizzariaDoCarvalho.menu.push_back(pizza4queijos);
    pizzariaDoCarvalho.menu.push_back(pizzacalabresa);
    pizzariaDoCarvalho.menu.push_back(pizzamisto);
    pizzariaDoCarvalho.menu.push_back(pizzafrango);
    pizzariaDoCarvalho.menu.push_back(pizzachocolate);
    pizzariaDoCarvalho.menu.push_back(pizzafitness);

    item::Item docedeleite;
    coxinha.name = "Doce de Leite";
    coxinha.price = 30;
    coxinha.description = "O melhor doce de leite da terrinha";

    item::Item goiabada;
    pastel.name = "Goiabada";
    pastel.price = 40;
    pastel.description = "Pra comer com queijo coalho";

    item::Item petitgateau;
    alfajor.name = "Petit Gateau";
    alfajor.price = 50;
    alfajor.description = "Petit Gateau do chef Jacquin";

    item::Item brigadeirogourmet;
    coxinha.name = "Brigadeiro Gourmet";
    coxinha.price = 5;
    coxinha.description = "A melhor sobremesa brasileira";

    item::Item suflair;
    pastel.name = "Suflair";
    pastel.price = 20;
    pastel.description = "Sobremesa chique de rico";

    item::Item trufaItaliana;
    alfajor.name = "Trufa Italiana";
    alfajor.price = 25;
    alfajor.description = "Outra sobremesa de rico";

    item::Item churrosGourmet;
    alfajor.name = "Churros Gourmet";
    alfajor.price = 30;
    alfajor.description = "Sobremesa de pobre com o preco de rico";
    
    rst::Restaurant lasuissa;
    lasuissa.name = "La Suissa";
    lasuissa.cnpj = 3;
    lasuissa.cuisine = "Sobremesas";
    lasuissa.phone = "1234-1234";
    lasuissa.password = "suissa";
    lasuissa.opensAt[0] = 07;
    lasuissa.opensAt[1] = 0;
    lasuissa.closesAt[0] = 20;
    lasuissa.closesAt[1] = 00;
    lasuissa.menu.push_back(docedeleite);
    lasuissa.menu.push_back(goiabada);
    lasuissa.menu.push_back(petitgateau);
    lasuissa.menu.push_back(brigadeirogourmet);
    lasuissa.menu.push_back(suflair);
    lasuissa.menu.push_back(trufaItaliana);
    lasuissa.menu.push_back(churrosGourmet);

    std::cout << "Open? " << rst::isOpen(seuOlavo) << std::endl;
    std::cout << "Menu:" << std::endl << rst::showMenu(seuOlavo) << std::endl << std::endl;

    clt::Client client;
    client.name = "Melina Mongiovi";
    client.login = "Melina";
    client.password = "Melina";

    clientes.push_back(client);
    rests.push_back(seuOlavo);
    rests.push_back(pizzariaDoCarvalho);
    rests.push_back(lasuissa);

}