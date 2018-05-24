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
        int phone;
    };

    Client newCliente() {
        Client c;

        std::cout << "Insert your name: ";
        std::getline(std::cin, c.name);
        std::cout << "Insert your CPF: ";
        std::getline(std::cin, c.cpf);
        std::cout << "Insert your phone number: ";
        std::cin >> c.phone;
        std::cin.get();
        std::cout << "Insert your address: ";
        std::getline(std::cin, c.address);
        std::cout << "Choose a username: ";
        std::getline(std::cin, c.login);
        std::cout << "Choose your password: ";
        std::getline(std::cin, c.password);

        return c;
    }

    void toString(Client cliente) {
        std::cout << "Name: " << cliente.name << "\n";
        std::cout << "Address: " << cliente.address << "\n";
        std::cout << "Phone number: " << cliente.phone << "\n";
        std::cout << "CPF: " << cliente.cpf << "\n";
        std::cout << "Login: " << cliente.login << "\n";
    }
}