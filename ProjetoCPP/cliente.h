#include <iostream>
#include <sstream>
#include <string>

typedef struct {
	std::string login;
	std::string senha;
	std::string nome;
	std::string cpf;
	std::string endereco;
	int telefone;
} Cliente;

Cliente newCliente() {
	Cliente C;

	std::cout << "Digite seu nome: ";
	getline(std::cin, C.nome);
	std::cout << "Digite seu cpf: ";
	getline(std::cin, C.cpf);
	std::cout << "Digite seu numero de telefone: ";
	std::cin >> C.telefone;
	std::cin.get();
	std::cout << "Digite seu endereço: ";
	getline(std::cin, C.endereco);
	std::cout << "Digite seu login: ";
	getline(std::cin, C.login);
	std::cout << "Digite sua senha: ";
	getline(std::cin, C.senha);

	return C;
}

void clienteToString(Cliente cliente) {
	std::cout << "\nNome: " << cliente.nome << "\n";
	std::cout << "Endereço: " << cliente.endereco << "\n";
  	std::cout << "Telefone: " << cliente.telefone << "\n";
	std::cout << "Cpf: " << cliente.cpf << "\n";
	std::cout << "Login: " << cliente.login << "\n";
}