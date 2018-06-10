#include <string>
#include <iostream>

#ifndef PLP_USER_INTERFACE_H
#define PLP_USER_INTERFACE_H

#endif //PLP_USER_INTERFACE_H

namespace ui {
    const std::string ICN_SUCESSO = "o";
    const std::string ICN_ERRO = "!";
    const std::string ICN_NOVO = "+";
    const std::string ICN_NADA = "_";

    /**
     * estrutura UserInterface.
     *      mensagem: feedback apos execucao de funcao
     *      icone: char que categoriza feedback (um caractere)
     *      titulo: titulo da sessao (cadastro, login de usuario, pedido, etc)
     *
     */
    struct UserInterface {
        std::string icone = "_";
        std::string mensagem = "";
        std::string titulo = "SISTEMA DE DELIVERY";
    };

    /**
     * Define titulo da sessao
     * @param u UserInterface em que o titulo sera impresso
     * @param titulo
     */
    void defTitulo(UserInterface &u, std::string titulo) {
        u.titulo = titulo;
    }

    /**
     * Define feedback a ser impresso.
     *
     * @param u UserInterface em que o feedback sera impresso
     * @param mensagem mensagem do feedback
     * @param icone categoria do feedback
     */
    void defFeedback(UserInterface &u, std::string icone, std::string mensagem) {
        u.icone = icone;
        u.mensagem = mensagem;
    }

    /**
     * Define a mensagem de feedback como vazia.
     * @param u UserInterface cujo feedback sera apagado
     */
    void blankFeedback(UserInterface &u) {
        u.icone = ICN_NADA;
        u.mensagem = "";
    }

    /**
     * Limpa tela do programa e imprime template basico da UserInterface
     * @param u UserInterface cujo template sera impresso
     */
    void limpaTela(UserInterface &u) {
        std::cout << "\033c";
        std::cout << "------------------------------------------------" << std::endl;
        std::cout << "|[" << u.icone << "] " << u.mensagem << std::endl;
        std::cout << "------------------------------------------------" << std::endl;
        std::cout << "| " << u.titulo << std::endl;
        std::cout << "------------------------------------------------" << std::endl;
    }

    /**
     * Imprime prompt.
     */
    void imprimePrompt() {
        std::cout << "> ";
    }
    /**
     * Limpa tela antes de sair do programa
     */
    void sair() {
        std::cout << "\033c";
    }
}