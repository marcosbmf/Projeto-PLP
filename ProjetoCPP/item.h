#include <iostream>
#include <sstream>
#include <string>

typedef struct Item {
  std::string nome;
  std::string descricao;
  double preco;
} Item;

/**
  * "Constrói" novo Item.
  */
Item newItem(){
  Item item;

  std::cout << "Digite o nome do produto: ";
  std::getline(std::cin, item.nome);
  std::cout << "Digite a descrição do produto: ";
  std::getline(std::cin, item.descricao);
  std::cout << "Digite o preço: ";
  std::cin >> item.preco;
  std::cin.get();

  return item;
}

/**
  * Retorna descrição simplificada do item passado como argumento.
  */
std::string listaItem(Item item) {
  std::string saida = item.nome << " - R$ " << item.preco;
  return saida;
}

/**
  * Retorna descrição detalhada do item passado como argumento.
  */
std::string toString(Item item) {
  std::string saida = "";
  saida << item.nome << " - R$ " << item.preco << "\n";
  saida << "Descrição: " << item.descricao;
  return saida;
}