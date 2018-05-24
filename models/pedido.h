#ifndef PLP_PEDIDO_H
#define PLP_PEDIDO_H

#endif //PLP_PEDIDO_H

#include <vector>
#include <string>
#include <iostream>

namespace ord {
    const int RECEIVED = 0;
    const int SENT = 1;
    const int ARRIVED = 2;

    /**
     * Constructs an Order made by a Client.
     */
    struct Order {
        std::vector<item::Item> items;
        int situation = 0;
    };

    /**
     * Checks if order was already sent.
     *
     * @param order Order to be checked
     * @return true if different than received
     */
    bool isSent(Order &order) {
        if (order.situation != RECEIVED) {
            return true;
        }

        return false;
    }

    /**
     * Adds item to specified order.
     * @param order
     * @param item
     */
    void addItem(Order &order, item::Item &item) {
        order.items.push_back(item);
    }

    /**
     * Remove item from Order.
     * @param order
     * @param index index of the item in the order summary.
     */
    void removeItem(Order &order, int index) {
        order.items.erase(order.items.begin() + index);
    }

    /**
     * Changes the order actual situation.
     * @param order
     * @param situation RECEIVED, SENT or ARRIVED.
     */
    void changeSituation(Order &order, int situation) {
        order.situation = situation;
    }

    /**
     * Gets order situation.
     * @param order
     * @return order situation
     */
    int getSituation(Order &order) {
       return order.situation;
    }

    /**
     * Gets order total price.
     * @param order
     * @return
     */
    double getTotalPrice(Order &order) {
        double price;

        for (int i = 0; i != order.items.size(); i++) {
          price += order.items[i].price;
        }

        return price;
    }
}