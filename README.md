# Agenda de Contatos CLI

Este projeto é uma aplicação de linha de comando (CLI) para gerenciamento de contatos pessoais, desenvolvida como projeto prático para a disciplina de **Programação Funcional** na **Universidade de Fortaleza (Unifor)**.

O objetivo principal é aplicar conceitos do paradigma funcional, como imutabilidade, funções puras, recursão de cauda e pattern matching, utilizando a linguagem **Elixir**.

## Tecnologias Utilizadas

* **Elixir**: Linguagem de programação funcional.
* **Mix**: Gerenciador de projetos e dependências do Elixir.
* **Jason**: Biblioteca para serialização e desserialização de dados em formato JSON.

## Especificações do Sistema

Cada contato na agenda possui os seguintes campos:

* **ID**: Gerado automaticamente com base no timestamp em milissegundos.
* **Nome**: Nome completo do contato.
* **Empresa**: Nome da empresa ou local de trabalho.
* **Telefone**: Formato DDD + número (ex: 85912345678).
* **E-mail**: Endereço de e-mail válido.

## Instalação e Execução

### Pré-requisitos

* Erlang/OTP 26 ou superior.
* Elixir 1.15 ou superior.

### Passo a Passo

1. **Clone o repositório** (ou extraia os arquivos).
2. **Instale as dependências**:
   ```bash
   mix deps.get
   ```
3. **Execute a aplicação**:
   ```bash
   mix run -e "AgendaCli.main([])"
   ```

## Comandos Disponíveis

A aplicação funciona em um loop interativo. Abaixo estão os comandos suportados:

* **Adicionar**: `add --name "João Silva" --company "Unifor" --phone "85999998888" --email "joao@email.com"`
* **Listar**: `list` (Exibe todos os contatos cadastrados)
* **Exibir**: `show <id>` (Mostra detalhes de um contato específico)
* **Editar**: `edit <id> --phone "85000001111"` (Altera um ou mais campos de um contato existente)
* **Remover**: `del <id>` (Remove um contato da lista)
* **Buscar**: `search --name "João"` (Busca parcial e case-insensitive por nome, telefone ou e-mail)
* **Sair**: `exit` (Encerra o programa e salva os dados)

## Persistência de Dados

1. [](https://)Os dados são salvos automaticamente no arquivo `contacts.json` na raiz do projeto após cada operação de escrita (adição, edição ou remoção).

## Arquitetura do Projeto

O projeto segue uma separação rigorosa de responsabilidades entre os módulos:

* `AgendaCli`: Ponto de entrada, loop recursivo e parsing de comandos.
* `AgendaCli.Contacts`: Funções puras para manipulação da lista de contatos.
* `AgendaCli.Store`: Gerenciamento de leitura e escrita no arquivo JSON.

## Licença

Este projeto foi desenvolvido para fins acadêmicos na Universidade de Fortaleza.
