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
        std::cin >> c.name;
        std::cout << "Insira seu CPF: ";
        std::cin >> c.cpf;
        std::cout << "Seu numero de telefone: ";
        std::cin >> c.phone;
        std::cout << "Seu endereco: ";
        std::cin >> c.address;
        std::cout << "=========================\n";
        std::cout << "Escolha um nome de usuario: ";
        std::cin >> c.login;
        std::cout << "=========================\n";
        std::cout << "Digite uma senha: ";
        std::cin >> c.password;

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
    
}