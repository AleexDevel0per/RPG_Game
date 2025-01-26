# RPG
Este projeto, é um jogo de RPG baseado em texto, onde o jogador pode criar um personagem, lutar contra inimigos, explorar fases, adquirir itens e evoluir seu personagem. O jogo é desenvolvido em Ruby, com foco em aprendizado e diversão.


# Como instalar
Esse projeto foi desenvolvido no **Ubuntu 22.04** com **Ruby 3.2.2**

Para executar este projeto em sua máquina, é necessário ter o Ruby instalado.

Para instalar o **Ruby** no **Ubuntu 22.04**, siga estas etapas a seguir:

1. Atualizar o Sistema
Primeiro, certifique-se de que o sistema está atualizado:

``` bash
sudo apt update && sudo apt upgrade -y
```


2. Instalar Dependências
Instale algumas dependências necessárias:
``` bash
sudo apt install curl gpg build-essential libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev -y
```

3. Instalar o Ruby usando o Rbenv
     - Rbenv permite gerenciar diferentes versões do Ruby no seu sistema.

a. Instalar o Rbenv e o plugin Ruby-build
```bash
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-installer | bash
```

Adicione o Rbenv ao seu shell:
```bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc
```
b. Instalar uma Versão Específica do Ruby
Liste as versões disponíveis:
```rbenv
rbenv install -l
```
Escolha uma versão estável, como 3.2.2, e instale:
``` rbenv
rbenv install 3.2.2
rbenv global 3.2.2
```

Verifique se o Ruby foi instalado:
``` ruby
ruby -v
```

4. Instalar o Bundler

    - Bundler é uma ferramenta para gerenciar as dependências da aplicação Ruby.
``` ruby
gem install bundler
```

Verifique se o Bundler foi instalado:
``` ruby
bundler --version
```

# Instruções de uso
1. Certifique-se de que o Ruby está instalado
2. Clone ou baixe o projeto
3. Rode o arquivo principal com o comando
    ``` ruby
    ruby game.rb
    ```
## Objetivo do Projeto
Este projeto é um jogo de RPG baseado em turnos, onde o jogador assume o papel de um herói enfrentando um inimigo (no caso, um dragão). O jogador pode realizar ações como atacar, usar um ataque especial, defender e curar, enquanto o inimigo também executa ações aleatórias. O objetivo é derrotar o inimigo enquanto gerencia recursos limitados (pontos especiais e curas restantes).


## Estrutura Geral do Código
O código é composto por:

- **Funções auxiliares**:

    - atraso(texto, tempo): Exibe uma mensagem na tela, letra por letra, com um atraso controlado para criar uma sensação de animação.

- **Classes principais**:

    - Personagem: Representa o herói controlado pelo jogador.
    - Inimigo: Representa o inimigo, no caso, o dragão.
    - Função de batalha: Controla o fluxo do jogo, alternando turnos entre o jogador e o inimigo até que um dos dois seja derrotado.

## Descrição das Classes e Métodos

### Classe Personagem
- Representa o herói controlado pelo jogador.

**Atributos**:

- nome: O nome do personagem.
- vida: A quantidade de pontos de vida do personagem.
- pontos_especiais: Pontos que o personagem pode usar para realizar ações especiais (como ataque especial e defesa).
- curas_restantes: Número de curas restantes que o personagem pode usar.
- defesa: A quantidade de defesa do personagem (reduz o dano recebido).

**Métodos**:

1. initialize(nome, vida, pontos_especiais, curas_restantes): Inicializa um novo personagem com nome, vida, pontos especiais, curas e defesa.
2. atacar(inimigo): Realiza um ataque normal no inimigo, causando dano aleatório.
3. ataque_especial(inimigo): Realiza um ataque especial no inimigo, consumindo pontos especiais.
4. defender: Aumenta a defesa do personagem, consumindo pontos especiais.
5. curar: Restaura a vida do personagem, consumindo uma cura restante.
status: Exibe o status atual do personagem (vida, pontos especiais, curas restantes, defesa).

---

### Classe Inimigo
- Representa o inimigo (dragão).

**Atributos**:

- nome: O nome do inimigo.
- vida: A quantidade de pontos de vida do inimigo.
- pontos_especiais: Pontos especiais do inimigo que permitem ações como ataques especiais e defesa.
- defesa: A quantidade de defesa do inimigo.


**Métodos**:

1. initialize(nome, vida, pontos_especiais): Inicializa um novo inimigo com nome, vida e pontos especiais.
2. atacar(personagem): Realiza um ataque no personagem, causando dano baseado nos pontos de defesa do personagem.
3. ataque_especial(personagem): Realiza um ataque especial no personagem, consumindo pontos especiais.
4. defender: Aumenta a defesa do inimigo, consumindo pontos especiais.
5. inteligencia: Determina a ação do inimigo com base em sua vida e pontos especiais. O inimigo pode atacar, defender ou usar um ataque especial.
6. status: Exibe o status atual do inimigo (vida, pontos especiais, defesa).
7. Função batalha

## Controle do fluxo principal do jogo

Inicia o jogo, pede o nome do herói e define os parâmetros iniciais.

Alterna os turnos entre o herói e o inimigo, permitindo que o jogador escolha suas ações e o inimigo tenha uma inteligência artificial para decidir suas ações.

Exibe os status dos personagens após cada turno e termina o jogo quando a vida de um dos personagens chega a 0.

### Fluxo do Jogo
- O jogo começa com o jogador inserindo o nome do herói.
- O herói e o dragão começam com 100 e 150 de vida, respectivamente, e ambos têm 10 pontos especiais.
- O jogador pode escolher entre atacar, usar ataque especial, defender ou curar a cada turno, gerenciando seus pontos especiais e curas restantes.
- O dragão, por sua vez, também executa ações baseadas em sua inteligência, podendo atacar, se defender ou usar um ataque especial.

- O jogo continua até que a vida de um dos personagens chegue a 0, determinando o vencedor.

### Exemplo de Execução
``` ruby
--- Status de Jogador ---
Jogador: 100 HP | Pontos Especiais: 10 | Curas Restantes: 3 | Defesa: 3
-----------------------------------

É sua vez! (Pontos Especiais: 10, Curas Restantes: 3)
Escolha uma ação:
1. Atacar
2. Ataque especial (5 pontos necessários)
3. Defender (2 pontos necessários)
4. Curar (máximo 3 vezes)

```
Após a escolha do jogador, o jogo continua, alternando entre o herói e o dragão até que um dos dois perca toda a sua vida.


## Finalização

Este projeto de RPG em texto foi desenvolvido com o objetivo de consolidar conhecimentos em Ruby e explorar a programação orientada a objetos de maneira prática e criativa.

Com classes bem definidas e funcionalidades básicas, como batalhas, evolução de personagem e sistema de fases, o jogo proporciona uma base sólida para quem deseja se aventurar no desenvolvimento de games simples.

É um projeto inicial, mas representa um grande passo no aprendizado e na aplicação de conceitos fundamentais da programação.
