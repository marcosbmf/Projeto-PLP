#include <iostream>
#include <string>
#include <vector>
#include "item.h"

typedef struct Restaurante {
  std::string nome;
  std::string cnpj;
  std::string telefone;
  std::string horarioFuncionamento;
  std::string tipoCozinha;
  std::vector<Item> cardapio;
} Restaurante;

Restaurante newRestaurante() {
  Restaurante rest;

  std::cout << "Digite o nome do estabelecimento: ";
  std::getline(std::cin, rest.nome);
  std::cout << "Digite o cnpj do estabelecimento: ";
  std::getline(std::cin, rest.cnpj);
  std::cout << "Digite o telefone do estabelecimento: ";
  std::getline(std::cin, rest.telefone);
  std::cout << "Digite o horario de funcionamento (hh:mm hh:mm): ";
  std::getline(std::cin, rest.horarioFuncionamento);
  std::cout << "Digite o tipo de cozinha do estabelecimento: ";
  std::getline(std::cin, rest.tipoCozinha);
  
  return rest;
}

void adicionaItem(Restaurante rest) {
  Item item = newItem();
  rest.cardapio.push_back(item);
}

void removeItem(Restaurante rest, const_iterator indice) {
  rest.cardapio.erase(indice);
}

void listaCardapio(Restaurante rest){
  std::string saida = "";
  
  for(auto i = rest.cardapio.begin(); i + 1 != rest.cardapio.end(); ++it) {
    saida << item::toString(rest.cardapio[i]) << '\n';
  }
  
  saida << item::toString(rest.cardapio[rest.cardapio.end() - 1]);
}