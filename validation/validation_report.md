# Relatório de Validação com o Público-Alvo – DescarteVivo Fortaleza

## 1. Contexto da validação

- **Data da apresentação:** 01/12/2025
- **Local:** Online
- **Participantes:**
  - Moradores dos bairros Aerolândia e Jangurussu

O objetivo da validação foi apresentar o sistema DescarteVivo Fortaleza ao público-alvo definido e coletar feedbacks sobre a utilidade, usabilidade e possíveis melhorias.

Foram realizados testes de usabilidade com 5 usuários potenciais utilizando o protótipo funcional no celular. O foco foi validar o fluxo de "Descartar um Pacote", "Aceitar uma Coleta", até "Destinar um Pacote". Também a consulta de movimentação financeira, registro e login.

### Público-Alvo: 
Moradores de Fortaleza (CE), especificamente da região da Aerolândia e Jangurussu, conscientes sobre a necessidade de reciclagem mas que carecem de meios logísticos fáceis. Inclui também catadores autônomos que buscam otimizar suas rotas.

---

## 2. Roteiro da apresentação

1. Explicação do objetivo do sistema (ODS 11, reciclagem, controle de resíduos).

2. Demonstração das telas:
   - Cadastro e Login
   - Onboarding
   - Listagem de pacotes disponíveis para compra e transporte
   - Solicitação e aprovação de solicitações de pacotes
   - Descarte de pacotes
   - Recebimento e visualização de notificações
   - Visualização do Perfil com saldo de moedas
   - Visualização do extrato de movimentações de moedas
   
3. Discussão com o público sobre:
   - Se o sistema se encaixa na realidade deles.
   - O que facilita.
   - O que está faltando.

---

## 3. Feedbacks recebidos

### Principais Feedbacks Recebidos:

- Confusão nos Status: Usuários não entendiam quando o pacote estava "vendido" ou "aguardando". Ajuste: Implementação de mensagens descritivas nas notificações e botões bloqueados com cadeado para indicar status de espera.

- Medo de errar: Usuários tinham receio de aceitar uma coleta sem querer. Ajuste: Implementação de Modais de Confirmação com botão de fechar (X) explícito.

- Visibilidade: Motoristas queriam identificar rápido o que era "trabalho". Ajuste: Criação de diferenciação visual (Card Verde) para oportunidades de coleta.

### Outros Feedbacks Relevantes:

- **Simplicidade da interface**
  - Os usuários consideraram a interface simples e fácil de entender.

- **Histórico de Movimentações**
  - Foi sugerida a possibilidade de visualizar as movimentações de pacotes em ordem cronológica.

- **Filtro na Busca de Materiais**
  - Sugeriu ser útil ter opções de filtros para buscar apenas produtos que intressam, por tipo de material, bairro, ou status.

---

## 4. Ajustes realizados após a validação

- Implementação de um **filtro** na tela de busca:
  - Status do pacote (disponível para compra ou oportunidade de coleta);
  - Tipo de material;

- Aprimoramento da **barra de busca** para capturar por bairro, material ou palavra chave (título ou descrição).
  

---

## 5. Possíveis evoluções futuras

- Histórico de movimentações de pacotes em ordem cronológica com filtros de tipos de movimentações como descartes realizados, destinações feitas, etc.

---

## 6. Evidências

As evidências da validação (fotos, prints, anotações de reuniões) estão armazenadas na pasta:

```text
/validation/evidence
