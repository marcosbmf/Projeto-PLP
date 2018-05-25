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
        std::string usuario;
        std::string estabelecimento;
        std::string endereco;
        std::string userPhone;
        std::string restPhone;
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

    std::string orderToString(Order &order){
        std::ostringstream output;

        output << "Pedido realizado por " << order.usuario << " no estabelecimento " << order.estabelecimento << std::endl << std::endl;

        for (auto it = order.items.begin(); it != order.items.end(); it++){
            output << item::info(*it) << std::endl;
        }

        output << "\nValor total: " << getTotalPrice(order) << std::endl << std::endl;

        output << "Informações do pedido: " << std::endl
               << "Endereço: " << order.endereco << std::endl
               << "Telefone para contato: " << order.userPhone << std::endl
               << "Telefone do estabelecimento: " << order.restPhone << std::endl << std::endl;

        return output.str();

    }

    std::string listOrder(Order &order){
        return order.estabelecimento;
    }

    std::string listOrders(std::vector<Order> &orders){
        std::ostringstream output;
        if (orders.size() == 0){
            output << "Nenhum pedido realizado!" << std::endl;
            return output.str();
        }

        int i = 0;
        output << "Meus pedidos: " << std::endl << std::endl;
        
        for (auto it = orders.begin(); it != orders.end(); it++){
            i++;
            output << i << " - " << ord::listOrder(*it) << std::endl; 
        }

        output << std::endl;

        return output.str();
    }
}