#include <iostream>
#include <sstream>
#include <string>

namespace item {
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
    std::ostringstream saida;
    saida << item.nome << " - R$ " << std::to_string(item.preco);
    return saida.str();
  }

  /**
    * Retorna descrição detalhada do item passado como argumento.
    */
  std::string toString(Item item) {
    std::ostringstream saida;
    saida << item.nome << " - R$ " << std::to_string(item.preco) << std::endl;
    saida << "Descrição: " << item.descricao;
    return saida.str();
  }
}