#include <iostream>
#include "cliente.h"
#include "item.h"
#include "restaurante.h"

int main() {
  //Cliente cliente = newCliente();
	//clienteToString(cliente);
  //Item item = newItem();
  //itemToString(item);
  //std::cout << "\n";
  //listaItem(item);

  Restaurante r = newRestaurante();
  adicionaItem(r);
  adicionaItem(r);
  listaCardapio(r);
}