#include <iostream>
#include <sstream>
#include <string>
#include <vector>

typedef struct {
  std::string nome;
  std::string cnpj;
  std::string telefone;
  std::string horarioFuncionamento;
  std::string tipo_de_cozinha;
  std::vector<Item> cardapio;
} Restaurante;

Restaurante newRestaurante(){
  Restaurante R;

  std::cout << "Digite o nome do estabelecimento: ";
	getline(std::cin, R.nome);
  std::cout << "Digite o cnpj do estabelecimento: ";
	getline(std::cin, R.cnpj);
  std::cout << "Digite o telefone do estabelecimento: ";
	getline(std::cin, R.telefone);
  std::cout << "Digite o horario de funcionamento (hh:mm hh:mm): ";
	getline(std::cin, R.horarioFuncionamento);
  std::cout << "Digite o tipo de cozinha do estabelecimento: ";
	getline(std::cin, R.tipo_de_cozinha);
}

void adicionaItem(Restaurante R){
  Item item = newItem();
  R.cardapio.push_back(item);
}

void listaCardapio(Restaurante R){
  listaItem(R.cardapio[0]);
}
