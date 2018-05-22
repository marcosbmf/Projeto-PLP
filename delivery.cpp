#include <stdio.h>


typedef struct {
	int cpf;
	int telefone;

} Cliente;

int main() {
	
	Cliente cliente;

	cliente.cpf = 123;
	cliente.telefone = 5555;
	printf("%d\n", cliente.cpf);

}