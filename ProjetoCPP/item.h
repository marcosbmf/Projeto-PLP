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
  std::cout << "Digite a descri��o do produto: ";
  getline(std::cin, item.descricao);
  std::cout << "Digite o pre�o: ";
  std::cin >> item.preco;
  std::cin.get();

  return item;
}

//Nome: nome - Pre�o R$ pre�o.
void listaItem(Item item)
{
  std::cout << "\nNome: " << item.nome << " - Pre�o R$ " << item.preco;
}

//Nome + descricao + pre�o.
void itemToString(Item item){
  std::cout << "\nNome: " << item.nome << "\n";
  std::cout << "Descri��o: " << item.descricao << " - Pre�o: R$ " << item.preco;
}