#include <iostream>
#include <sstream>
#include <string>

typedef struct {
  std::string nome;
  std::string descricao;
  double preco;
} Item;

//Constroi novo item.
Item newItem(){
  Item item;

  std::cout << "Digite o nome do produto: ";
  getline(std::cin, item.nome);
  std::cout << "Digite a descrição do produto: ";
  getline(std::cin, item.descricao);
  std::cout << "Digite o preço: ";
  std::cin >> item.preco;
  std::cin.get();

  return item;
}

//Nome: nome - Preço R$ preço.
void listaItem(Item item)
{
  std::cout << "\nNome: " << item.nome << " - Preço R$ " << item.preco;
}

//Nome + descricao + preço.
void itemToString(Item item){
  std::cout << "\nNome: " << item.nome << "\n";
  std::cout << "Descrição: " << item.descricao << " - Preço: R$ " << item.preco;
}