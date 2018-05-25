#ifndef PLP_CLIENT_H
#define PLP_CLIENT_H

#endif //PLP_CLIENT_H

#include <iostream>
#include <sstream>
#include <string>

namespace clt {
    struct Client {
        std::string login;
        std::string password;
        std::string name;
        std::string cpf;
        std::string address;
        std::string phone;
        std::vector<ord::Order> orders;
    };

    Client newCliente() {
        Client c;

        std::cout << "Digite seu nome: ";
        getline(std::cin, c.name);
        std::cout << "Insira seu CPF: ";
        getline(std::cin, c.cpf);
        std::cout << "Seu numero de telefone: ";
        getline(std::cin, c.phone);
        std::cout << "Seu endereco: ";
        getline(std::cin, c.address);
        std::cout << "=========================\n";
        std::cout << "Escolha um nome de usuario: ";
        getline(std::cin, c.login);
        std::cout << "=========================\n";
        std::cout << "Digite uma senha: ";
        getline(std::cin, c.password);

        return c;
    }

    void toString(Client cliente) {
        std::cout << "Nome: " << cliente.name << "\n";
        std::cout << "Endereco: " << cliente.address << "\n";
        std::cout << "Numero de telefone: " << cliente.phone << "\n";
        std::cout << "CPF: " << cliente.cpf << "\n";
        std::cout << "Login: " << cliente.login << "\n";
    }

    void addOrder(ord::Order &order, Client &cliente){
        cliente.orders.push_back(order);
    }

    std::string listOrders(Client &cliente){
        std::ostringstream output;
        if (cliente.orders.size() == 0){
            output << "Nenhum pedido realizado!" << std::endl;
            return output.str();
        }

        int i = 0;
        output << "Meus pedidos: " << std::endl << std::endl;
        
        for (auto it = cliente.orders.begin(); it != cliente.orders.end(); it++){
            i++;
            output << i << " - " << ord::listOrder(*it) << std::endl; 
        }

        output << std::endl;

        return output.str();
    }
    
}