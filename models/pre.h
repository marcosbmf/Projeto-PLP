#ifndef PLP_PRE_H
#define PLP_PRE_H

#endif //PLP_PRE_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>


void preCadastro(std::vector<rst::Restaurant> &rests, std::vector<clt::Client> &clientes){


/*
    CRIANDO ITENS DO RESTAURANTE SEU OLAVO
*/
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
////////////////// CRIANDO RESTAURANTE SEU OLAVO ///////////////////////
    rst::Restaurant seuOlavo;
    seuOlavo.name = "Seu Olavo's";
    seuOlavo.cnpj = "1";
    seuOlavo.cuisine = "Fast-food";
    seuOlavo.phone = "1234-5678";
    seuOlavo.password = "Olavo";
    seuOlavo.lastReview = 5;
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
 /*

    CRIANDO ITENS DA PIZZARIA

 */
    item::Item pizzabacon;
    pizzabacon.name = "Pizza de Bacon";
    pizzabacon.price = 20;
    pizzabacon.description = "O melhor bacon do mundo";

    item::Item pizza4queijos;
    pizza4queijos.name = "Pizza 4 Queijos";
    pizza4queijos.price = 17;
    pizza4queijos.description = "Melhor selecao de queijos de campina grande";

    item::Item pizzacalabresa;
    pizzacalabresa.name = "Pizza de Calabresa";
    pizzacalabresa.price = 20;
    pizzacalabresa.description = "Calabresa Quentinha saindo do abatedouro";

    item::Item pizzamisto;
    pizzamisto.name = "Pizza de Misto";
    pizzamisto.price = 25;
    pizzamisto.description = "Presunto. Queijo. Simples assim.";

    item::Item pizzafrango;
    pizzafrango.name = "Pizza de Frango";
    pizzafrango.price = 20;
    pizzafrango.description = "Pizza de quem nao vai pra academia";

    item::Item pizzachocolate;
    pizzachocolate.name = "Pizza de Chocolate";
    pizzachocolate.price = 15;
    pizzachocolate.description = "Pra comer de sobremesa";

    item::Item pizzafitness;
    pizzafitness.name = "Pizza de Fitness";
    pizzafitness.price = 10;
    pizzafitness.description = "Pizza de salada pra quem nao quer ganhar calorias";
/////////////////////////// CRIANDO PIZZARIA /////////////////////////////
    rst::Restaurant pizzariaDoCarvalho;
    pizzariaDoCarvalho.name = "Pizzaria Nota 10";
    pizzariaDoCarvalho.cnpj = 2;
    pizzariaDoCarvalho.cuisine = "Pizzaria";
    pizzariaDoCarvalho.phone = "4002-8922";
    pizzariaDoCarvalho.password = "carvalho";
    pizzariaDoCarvalho.lastReview = 3; 
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

/*

    CRIANDO ITENS DO LA SUISSA

*/

    item::Item docedeleite;
    docedeleite.name = "Doce de Leite";
    docedeleite.price = 30;
    docedeleite.description = "O melhor doce de leite da terrinha";

    item::Item goiabada;
    goiabada.name = "Goiabada";
    goiabada.price = 40;
    goiabada.description = "Pra comer com queijo coalho";

    item::Item petitgateau;
    petitgateau.name = "Petit Gateau";
    petitgateau.price = 50;
    petitgateau.description = "Petit Gateau do chef Jacquin";

    item::Item brigadeirogourmet;
    brigadeirogourmet.name = "Brigadeiro Gourmet";
    brigadeirogourmet.price = 5;
    brigadeirogourmet.description = "A melhor sobremesa brasileira";

    item::Item suflair;
    suflair.name = "Suflair";
    suflair.price = 20;
    suflair.description = "Sobremesa chique de rico";

    item::Item trufaItaliana;
    trufaItaliana.name = "Trufa Italiana";
    trufaItaliana.price = 25;
    trufaItaliana.description = "Outra sobremesa de rico";

    item::Item churrosGourmet;
    churrosGourmet.name = "Churros Gourmet";
    churrosGourmet.price = 30;
    churrosGourmet.description = "Sobremesa de pobre com o preco de rico";
///////////////////////// CRIANDO LA SUISSA ///////////////////////////////// 
    rst::Restaurant lasuissa;
    lasuissa.name = "La Suissa";
    lasuissa.cnpj = 3;
    lasuissa.cuisine = "Sobremesas";
    lasuissa.phone = "1234-1234";
    lasuissa.password = "suissa";
    lasuissa.lastReview = 2;
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

/*

    CRIANDO ITENS DO YOI

*/

    item::Item sushi;
    sushi.name = "Sushi";
    sushi.price = 20;
    sushi.description = "6 sushis simples";

    item::Item hotroll;
    hotroll.name = "Hot-Roll";
    hotroll.price = 25;
    hotroll.description = "6 Hot-Rolls com molho shoyu gratis";

    item::Item temaki;
    temaki.name = "Temaki";
    temaki.price = 8;
    temaki.description = "Temaki simples";

    item::Item ramen;
    ramen.name = "Ramen";
    ramen.price = 15;
    ramen.description = "Ramen apimentado acompanhado de molho shoyu";

    item::Item tempura;
    tempura.name = "Tempura";
    tempura.price = 20;
    tempura.description = "Tempura com shoyu e teriyaki";
///////////////////////////// CRIANDO YOI /////////////////////////// 
    rst::Restaurant YOI;
    YOI.name = "YOI";
    YOI.cnpj = 4;
    YOI.cuisine = "Japones";
    YOI.phone = "3333-3333";
    YOI.password = "sushi";
    YOI.opensAt[0] = 10;
    YOI.opensAt[1] = 0;
    YOI.closesAt[0] = 23;
    YOI.closesAt[1] = 00;
    YOI.menu.push_back(tempura);
    YOI.menu.push_back(ramen);
    YOI.menu.push_back(temaki);
    YOI.menu.push_back(hotroll);
    YOI.menu.push_back(sushi);

    std::cout << "Open? " << rst::isOpen(seuOlavo) << std::endl;
    std::cout << "Menu:" << std::endl << rst::showMenu(seuOlavo) << std::endl << std::endl;

/*

    CRIANDO ITENS DO MCDONALDS

*/
    item::Item bigmac;
    bigmac.name = "Big-Mac";
    bigmac.price = 20;
    bigmac.description = "Sanduiche gigante cheio de gordura";

    item::Item mclanchefeliz;
    mclanchefeliz.name = "Hot-Roll";
    mclanchefeliz.price = 25;
    mclanchefeliz.description = "Hamburguer das criancas (vem com brinquedo aleatorio)";

    item::Item milkshake;
    milkshake.name = "Milk Shake";
    milkshake.price = 8;
    milkshake.description = "Bebida pra acompanhar os sanduiches";

    item::Item whooper;
    whooper.name = "Whooper";
    whooper.price = 15;
    whooper.description = "Hambuguer roubado do Burguer king";

    item::Item mcweed;
    mcweed.name = "McWeed";
    mcweed.price = 20;
    mcweed.description = "Hamburguer Natural feito de ervas";
/////////////// CRIANDO O MC DONALDS ////////////////    
    rst::Restaurant mcdonalds;
    mcdonalds.name = "Mc Donalds";
    mcdonalds.cnpj = 5;
    mcdonalds.cuisine = "fast-food";
    mcdonalds.phone = "666-666-666";
    mcdonalds.password = "gordura";
    mcdonalds.opensAt[0] = 6;
    mcdonalds.opensAt[1] = 0;
    mcdonalds.closesAt[0] = 22;
    mcdonalds.closesAt[1] = 00;
    mcdonalds.menu.push_back(bigmac);
    mcdonalds.menu.push_back(mclanchefeliz);
    mcdonalds.menu.push_back(milkshake);
    mcdonalds.menu.push_back(whooper);
    mcdonalds.menu.push_back(mcweed);

// CRIANDO UM CLIENTE PROVISORIO

    clt::Client client;
    client.name = "Melina Mongiovi";
    client.login = "Melina";
    client.password = "Melina";
    client.address = "Rua Rodrigues Alves, 1400";
    client.phone = "(83) 9999-9999";

// ADICIONANDO RESTAURANTES EXISTENTES AO SISTEMA

    clientes.push_back(client);
    rests.push_back(seuOlavo);
    rests.push_back(pizzariaDoCarvalho);
    rests.push_back(lasuissa);

}