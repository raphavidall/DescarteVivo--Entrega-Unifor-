Documento de Requisitos e Regras de Negócio

Este documento detalha os requisitos funcionais, não-funcionais, regras de negócio e casos de uso implementados na plataforma "Descarte Vivo".

## 1. Perfis de Usuários

A plataforma utiliza um modelo unificado de usuário. Qualquer conta cadastrada pode transitar dinamicamente entre os seguintes papéis operacionais:

- **Descartador (Ponto de Descarte):** Gera e cadastra resíduos na plataforma.

- **Coletor (Ponto de Coleta):** Realiza o serviço logístico de transporte (opcional).

- **Destinador (Ponto de Destino):** Adquire o material para reciclagem ou reuso e financia a operação.

- **Vendedor/Comprador da Loja:** Comercializa produtos sustentáveis na loja interna.

## 2. Requisitos Funcionais (RF)

Estes requisitos descrevem o que o sistema deve fazer.

### RF01: Gerenciamento de Usuários:

- **RF01.1:** O sistema deve permitir o cadastro de novos usuários com e-mail, senha, nome completo, tipo de documento (CPF/CNPJ) e endereço.

- **RF01.2:** O sistema deve permitir o login e logout de usuários.

- **RF01.3:** O sistema deve permitir que o usuário visualize seus dados de perfil e saldo de moedas verdes.


### RF02: Gerenciamento de Pacotes de Resíduos:

- **RF02.1:** O sistema deve permitir que um usuário crie um novo pacote, especificando o tipo de material, peso e localização.

- **RF02.2:** O sistema deve exibir pacotes disponíveis em forma de lista, permitindo a visualização por localização, tipo de material e status.

- **RF02.3:** O sistema deve permitir que um usuário adquira um pacote disponível.

- **RF02.4:** O sistema deve permitir que um usuário confirme a coleta de um pacote.

- **RF02.5:** O sistema deve permitir que um usuário confirme o recebimento de um pacote.

- **RF02.6:** O sistema deve permitir a troca de mensagens entre os envolvidos na transação de um pacote (descarte, coleta, destino).

### RF03: Sistema de Transações Financeiras (Moedas Verdes):

- **RF03.1:** O sistema deve processar a aquisição de um pacote, debitando moedas do "Ponto de Destino" e creditando-as no "Ponto de Descarte".

- **RF03.2:** O sistema deve processar o pagamento da coleta, debitando moedas do "Ponto de Destino" e creditando-as no "Ponto de Coleta".

### RF03: Comunicação e Notificações

- **RF03.1:** O sistema deve enviar notificações automáticas para os usuários envolvidos sempre que houver mudança de status relevante no pacote (ex: "Solicitação Recebida", "Pacote a Caminho").

- **RF03.2:** O sistema deve exibir um contador (badge) de notificações não lidas na navegação.

- **RF03.3:** O sistema deve permitir que usuários tomem ações (Aceitar/Rejeitar) diretamente através do card de notificação.

- **RF03.4:** O sistema deve oferecer um chat interno vinculado a cada pacote para alinhamento de detalhes logísticos.

## 3. Requisitos Não-Funcionais (RNF)

Estes requisitos descrevem como o sistema deve funcionar, não o que ele deve fazer.

- **RNF01:** Responsividade (Mobile First): A interface deve se adaptar fluidamente entre dispositivos móveis (foco em lista/modal) e desktops (foco em dashboard).

- **RNF02:** Persistência de Mídia: Imagens devem ser armazenadas em serviço de nuvem (Cloudinary) para garantir disponibilidade e otimização.

- **RNF03:** Segurança: Senhas devem ser armazenadas com hash (Bcrypt) e rotas críticas protegidas por token.

- **RNF04:** Integridade de Dados: Transações financeiras devem ser atômicas (ACID) para evitar perdas de saldo.


## 4. Regras de Negócio

- **RN01 (Cálculo do Pacote):** O valor base do pacote é calculado automaticamente: Peso (Kg) * Valor do Material (Tabela).

- **RN02 (Taxa de Coleta)**: Se houver coleta terceirizada, o valor do serviço é fixado em 25% do valor do material, pago integralmente pelo Destinador.

- **RN03 (Trava de Auto-Negociação):** Um usuário não pode comprar ou coletar seu próprio pacote.

- **RN04 (Reserva de Fundos):** Uma negociação só pode ser iniciada se o Destinador tiver saldo suficiente para cobrir o custo total (Material + Taxa).

- **RN05 (Visibilidade):** Pacotes em negociação (AGUARDANDO_APROVACAO) desaparecem da lista pública para evitar conflitos de interesse (Race Conditions).

- **RN06 (Imutabilidade):** Uma vez que o pacote é marcado como ENTREGUE e o pagamento distribuído, a transação não pode ser revertida.

## 5. Casos de Uso


### CU01: Descartar Material

- **Ator:** Usuário Geral (com papel "Ponto de Descarte").

- **Fluxo:** Acessa "Movimentar" > Clica em "Descartar" > Preenche formulário > Tira foto > Confirma.

- **Resultado:** Pacote criado com status DISPONIVEL e visível no marketplace.

### CU02: Solicitar e Aprovar Destinação

- **Ator:** Destinador e Descartador.

- **Fluxo:** Destinador clica em "Solicitar Destinação" (Saldo é verificado). Descartador recebe notificação e clica em "Aceitar".

- **Resultado:** Valor do material é debitado do Destinador e reservado. Status muda para AGUARDANDO_COLETA.

### CU03: Logística Terceirizada

- **Ator:** Destinador e Coletor.

- **Fluxo:** Destinador solicita "Motorista" (Status vira A_COLETAR). Coletor vê oferta verde na lista e clica em "Aceitar Corrida".

- **Resultado:** Valor do serviço (25%) é debitado do Destinador. Coletor recebe instruções de retirada.

### CU04: Finalização e Pagamento

- **Ator:** Destinador.

- **Fluxo:** Após receber o material físico, o Destinador acessa o pacote e clica em "Confirmar Recebimento".

- **Resultado:** O sistema transfere os valores custodiados para as carteiras do Descartador e do Coletor. Pacote é arquivado como DESTINADO.
