#include <iostream>
#include <stdlib.h>
#include <string>
#include <vector>
#include <sstream>
#include "models/item.h"
#include "models/pedido.h"
#include "models/restaurant.h"
#include "models/client.h"
#include "models/menuCliente.h"
#include "models/pre.h"

/*
    Este eh o menu principal com as funcoes de 
    cadastrar um novo cliente restaurantem, e
    fazer login como cliente ou restaurante
*/

std::string msgSistema = "";
std::string icnSistema = "_";
std::string tituloSessao = "SISTEMA DE DELIVERY";
const std::string SUCESSO = "_";
const std::string ERRO = "!";

void limpaTela() {
    system("clear");
    std::cout << "[" << icnSistema << "] " << msgSistema << std::endl;
    std::cout << "----------------------------------------------------------------" << std::endl;
    std::cout << tituloSessao << std::endl;
    std::cout << "----------------------------------------------------------------" << std::endl << std::endl;

}

namespace fn {
    void cadastrarNovoCliente(std::vector<clt::Client> &clientes) {
        icnSistema = SUCESSO;
        msgSistema = "";
        tituloSessao = "CADASTRAR NOVO CLIENTE";
        limpaTela();

        bool cadastroValido = true;
        clt::Client cliente = clt::newCliente();

        for (auto it = clientes.begin(); it != clientes.end(); ++it) {
            if (it->login == cliente.login) {
                cadastroValido = false;
            }
        }

        if (cadastroValido) {
            clientes.push_back(cliente);
            icnSistema = SUCESSO;
            msgSistema = "Cadastro efetuado com sucesso.";

        } else {
            icnSistema = ERRO;
            msgSistema = "Erro ao cadastrar: login ja existe.";
        }
    }

    void cadastrarNovoRestaurante(std::vector<rst::Restaurant> &restaurantes) {
        icnSistema = SUCESSO;
        msgSistema = "";
        tituloSessao = "CADASTRAR NOVO RESTAURANTE";
        limpaTela();

        bool cadastroValido = true;
        rst::Restaurant r = rst::newRestaurant();

        for (auto it = restaurantes.begin(); it != restaurantes.end(); ++it) {
            if (it->cnpj == r.cnpj) {
                cadastroValido = false;
            }
        }

        if (cadastroValido) {
            restaurantes.push_back(r);
            icnSistema = SUCESSO;
            msgSistema = "Cadastro efetuado com sucesso.";
        } else {
            icnSistema = ERRO;
            msgSistema = "Erro no cadastro: CNPJ ja existe.";
        }

    }

    int loginCliente(std::vector<clt::Client> clientes, std::string login, std::string senha){

        for (auto it = clientes.begin(); it != clientes.end(); it++) {
            if (it->login == login) {
                if (it->password == senha) {
                    return 1;
                } else {
                    icnSistema = ERRO;
                    msgSistema = "Erro no login: senha incorreta.";
                    return 0;
                }
            }
        }

        icnSistema = ERRO;
        msgSistema = "Erro no login: usuario nao existe.";
        return 0;
    }

    int loginRestaurante(std::vector<rst::Restaurant> restaurantes, std::string cnpj, std::string senha){

        for (auto it = restaurantes.begin(); it != restaurantes.end(); it++) {
            if (it->cnpj == cnpj) {
                if (it->password == senha) {
                    return 1;
                } else {
                    icnSistema = ERRO;
                    msgSistema = "Erro no login: senha incorreta.";
                    return 0;
                }
            }
        }

        icnSistema = ERRO;
        msgSistema = "Erro no login: usuario nao encontrado.";
        return 0;
    }

    clt::Client * getClient(std::string login, std::vector<clt::Client> &clientes){
        for (auto it = clientes.begin(); it != clientes.end(); it++) {
            if (it->login == login) {
                return &*it;
            }
        }
    }

    rst::Restaurant * getRestaurante(std::string cnpj, std::vector<rst::Restaurant> &restaurantes){
        for (auto it = restaurantes.begin(); it != restaurantes.end(); it++) {
            if (it->cnpj == cnpj) {
                return &*it;
            }
        }
    }
}

namespace menu {
    void printMenu() {
        std::cout << "MENU:" << std::endl << std::endl
                  << "(1) Login (cliente)" << std::endl
                  << "(2) Login (restaurante)" << std::endl
                  << "(3) Cadastrar-se (cliente)" << std::endl
                  << "(4) Cadastrar-se (restaurante)" << std::endl
                  << "(5) Sair" << std::endl << std::endl;
    }

    void loginClt(std::vector<clt::Client> &clientes, std::vector<rst::Restaurant> &restaurantes) {
        limpaTela();
        std::string login, senha;

        std::cout << "Nome de usuario: ";
        std::getline(std::cin, login);
        std::cout << "Senha: ";
        std::getline(std::cin, senha);

        if (fn::loginCliente(clientes, login, senha)){
            icnSistema = SUCESSO;
            msgSistema = "Sucesso no login.";
            menuCliente(restaurantes, *fn::getClient(login, clientes));
        }
    }

    void loginRst(std::vector<rst::Restaurant> &restaurantes) {
        limpaTela();
        std::string cnpj;
        std::string senha;
        std::cout << "CNPJ: ";
        std::getline(std::cin, cnpj);
        std::cout << "Senha: ";
        std::getline(std::cin, senha);

        if (fn::loginRestaurante(restaurantes, cnpj, senha)) {
            icnSistema = SUCESSO;
            msgSistema = "Sucesso no login";
            //menuRestaurante(cnpj);
        }
    }
}

int main() {
    const int LOGIN_CLT = 1;
    const int LOGIN_RST = 2;
    const int CDST_CLT = 3;
    const int CDST_RST = 4;
    const int SAIR = 5;

    std::vector<clt::Client> clientes;
    std::vector<rst::Restaurant> restaurantes;
    int opMenuInicial = 6;

    //Precadastro para testes.
    preCadastro(restaurantes, clientes);

    while (opMenuInicial != SAIR) {
        std::string entrada;
        tituloSessao = "SISTEMA DE DELIVERY";
        limpaTela();
        menu::printMenu();
        std::cout << "> ";
        std::cin >> entrada;
        std::cin.get();
        opMenuInicial = std::stoi(entrada);

        switch (opMenuInicial) {
            case LOGIN_CLT:
                menu::loginClt(clientes, restaurantes);
                break;

            case LOGIN_RST:
                menu::loginRst(restaurantes);
                break;

            case CDST_CLT:
                fn::cadastrarNovoCliente(clientes);
                break;

            case CDST_RST:
                fn::cadastrarNovoRestaurante(restaurantes);
                break;

            default:
                icnSistema = ERRO;
                msgSistema = "Comando invalido.";
                break;
        }
    }

    system("clear");

    return 0;
}