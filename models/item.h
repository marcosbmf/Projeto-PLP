#ifndef PLP_ITEM_H
#define PLP_ITEM_H

#endif //PLP_ITEM_H

#include <iostream>
#include <string>
#include <vector>
#include <sstream>

namespace item {

    /**
     * An item. It has a name, a description and a price.
     */
    struct Item {
        std::string name;
        std::string description;
        double price;
    };

    /**
     * Create a new item.
     * @return item new item.
     */
    Item newItem() {
        Item n;

        std::cout << "Insert new name: ";
        std::getline(std::cin, n.name);

        std::cout << "Write a description for \"" << n.name << "\": ";
        std::getline(std::cin, n.description);

        std::cout << "Choose a price for \"" << n.name << "\": ";
        std::cin >> n.price;
        std::cin.get();
        std::cout << std::endl;

        return n;
    }

    /**
     * Resumed representation of an item showing its name and price.
     * @param obj an item.
     * @return string showing item's name and price.
     */
    std::string info(Item obj) {
        std::ostringstream output;
        output << obj.name << " - R$ " << obj.price;
        return output.str();
    }

    /**
     * Full textual representation of an item.
     *
     * @param obj an item.
     * @return string representing an item.
     */
    std::string toString(Item obj) {
        std::ostringstream output;
        output << obj.name << " - R$ " << obj.price << std::endl;
        output << "\t" << obj.description;
        return output.str();
    }
}
