#ifndef PLP_ITEM_H
#define PLP_ITEM_H

#endif //PLP_ITEM_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>

namespace item {

    /**
     * Um item. Possui um nome, descrição e preco.
     */
    struct Item {
        std::string name;
        std::string description;
        double price;
    };

    /**
     * Cria um novo item.
     * @return item novo item.
     */
    Item newItem() {
        Item n;

        std::cout << "Insira um nome: ";
        std::getline(std::cin, n.name);

        std::cout << "Escreva uma descricao para \"" << n.name << "\": ";
        std::getline(std::cin, n.description);

        std::cout << "Escolha um preco para \"" << n.name << "\": ";
        std::cin >> n.price;
        std::cin.get();
        std::cout << std::endl;

        return n;
    }

    /**
     * Representacao resumida de um item, mostrando seu nome e preco.
     * @param obj um item.
     * @return string nome e preco de um item.
     */
    std::string info(Item obj) {
        std::ostringstream output;
        output << obj.name << " - R$ " << obj.price;
        return output.str();
    }

    /**
     * Representacao textual completa de um item.
     *
     * @param obj um item.
     * @return string representando um item.
     */
    std::string toString(Item obj) {
        std::ostringstream output;
        output << obj.name << " - R$ " << obj.price << std::endl;
        output << "\t" << obj.description;
        return output.str();
    }
}
