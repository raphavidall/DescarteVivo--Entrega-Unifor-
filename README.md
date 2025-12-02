# Descarte Vivo: Seu Descarte Movimenta Fortaleza!

## 1. Título e Descrição do Projeto

O **Descarte Vivo** é uma plataforma digital projetada para aprimorar a logística de resíduos recicláveis e orgânicos na cidade de Fortaleza. Através de um sistema de moedas verdes, a plataforma conecta a população, catadores e empresas, incentivando a separação, coleta e destinação correta dos resíduos. A solução busca fortalecer a economia circular e promover a autonomia e a sustentabilidade no descarte de resíduos urbanos.

Atualmente, o descarte incorreto de resíduos sólidos gera graves problemas ambientais e desperdício de recursos econômicos. A cadeia de reciclagem é fragmentada, informal e carece de confiança. O Descarte Vivo soluciona isso ao:

- **Centralizar a oferta e demanda de resíduos recicláveis em um marketplace geolocalizado.

- **Garantir a segurança financeira através de um modelo de custódia (Escrow), onde o pagamento só é liberado mediante confirmação de entrega.

- **Formalizar a coleta, permitindo que coletores encontrem oportunidades de frete próximas a eles.

Este projeto está alinhado com o **Objetivo de Desenvolvimento Sustentável (ODS) 11: Cidades e Comunidades Sustentáveis**, contribuindo para tornar os assentamentos humanos mais resilientes e sustentáveis.

## 2. Funcionalidades Implementadas

- **Autenticação:** Cadastro, Login e Sessão segura (JWT + Refresh Token).
- **Marketplace:** Listagem de pacotes disponíveis e filtros de visibilidade.
- **Logística (Descarte):** Criação de pacotes com foto (Cloudinary) e Geolocalização (GPS/Endereço).
- **Logística (Fluxo):** Máquina de estados completa (Solicitar -> Aprovar -> Coletar -> Entregar).
- **Carteira Digital:** Saldo em moedas, histórico de transações e modelo de pagamento seguro (Escrow).
- **Notificações:** Alertas em tempo real sobre status do pacote com ações rápidas (Aceitar/Rejeitar).
- **Comunicação:** Chat integrado contextualizado por pacote.
- **Perfil:** Visualização de saldo e histórico pessoal.

### Screenshots das Telas Principais

#### **Mobile**

![Mobile-Perfil](images/mobile-profile.png)
![Mobile-Movimentar](images/mobile-move.png)
![Mobile-Loja](images/mobile-store.png)
![Mobile-Extrato](images/mobile-movement-statement.png)
![Mobile-Navegação](images/mobile-nav.png)

#### **Desktop**

![Desktop-Movimentar](images/desktop-move.png)
![Desktop-Loja](images/desktop-store.png)
![Desktop-Notificações](images/desktop-notifications.png)
![Desktop-Detalhes do pacote](images/desktop-package-details.png)
![Desktop-Extrato](images/desktop-movement-statement.png)
![Desktop-Novidades](images/desktop-news.png)

## 3. Tecnologias Utilizadas

O projeto foi desenvolvido utilizando uma stack moderna em JavaScript/TypeScript.

- **Linguagens:** JavaScript (ES6+).

- **Frontend:** 
    - React.js (Vite): Biblioteca de interface.
    - Tailwind CSS: Estilização utilitária e responsiva (Mobile First).
    - Axios: Consumo de API.
    - Lucide React: Biblioteca de ícones.
 
- **Backend:** 
    - Node.js & Express: Servidor e API RESTful.
    - Prisma ORM: Abstração e gerenciamento do banco de dados.
    - JSON Web Token (JWT): Autenticação stateless.
    - Multer & Cloudinary: Upload e armazenamento de imagens na nuvem.
    - Jest & Supertest: Testes automatizados.
     
- **Banco de Dados:** 
    - PostgreSQL (Hospedado no Render).
    
- **Ferramentas:** 
    - Git, GitHub, Postman, VS Code.

## 4. Arquitetura do Sistema

**Visão Geral:** A arquitetura evoluiu de microserviços (planejamento inicial) para um Monólito Modular na implementação. Essa decisão foi estratégica para garantir a consistência transacional (ACID) das operações financeiras e simplificar a infraestrutura de deploy do MVP.

### Componentes Principais:

- **Frontend (SPA):** Aplicação única responsiva que atende Web e Mobile. Comunica-se com o Backend via HTTP/JSON.

- **Backend (API Layer):** Centraliza as regras de negócio, dividida em camadas (Controllers, Services, Repositories).

- **Database (Persistence):** Banco relacional PostgreSQL garantindo a integridade dos relacionamentos Usuário-Pacote-Transação.

### Integrações Realizadas:

- **Cloudinary:** Armazenamento externo de imagens (contornando limitações de sistemas de arquivos efêmeros em PaaS).

- **OpenStreetMap (Nominatim):** API de Geocodificação reversa e busca de endereços.

## 5. Instruções de Instalação e Execução

### 5.1 Pré-requisitos

- **Node.js (v18 ou superior).

- **Gerenciador de pacotes npm.

- **PostgreSQL instalado localmente (para rodar fora do Docker/Render).

### 5.2 Passo a Passo

#### 5.2.1. Clonar os Repositórios:

- Frontend: git@github.com:raphavidall/DescarteVivoFront.git
- Backend: git@github.com:raphavidall/DescarteVivoApp.git

#### 5.2.2 Configurar o Backend:
```bash
cd backend
npm install

# Preencha o .env na pasta backend com dados válidos para as chaves:

NODE_ENV="development"
PORT=3000

DATABASE_URL="postgresql://user:pass@localhost:5432/descarte_db"
JWT_SECRET="minha_chave_secreta_super_segura"
JWT_REFRESH_SECRET="minha_chave_refresh_mais_segura"
JWT_EXPIRES_IN="15m"
JWT_REFRESH_EXPIRES_IN="7d"

CLOUDINARY_CLOUD_NAME="nome"
CLOUDINARY_API_KEY="suaApiKeyCloudinary"
CLOUDINARY_API_SECRET="suaApiSecretCloudinary"


# Migrar o banco e popular dados iniciais de Materiais (via Postman)
npx prisma migrate dev

# Rodar o servidor
npm run dev
```
#### 5.2.3 Configurar o Frontend:
```bash
# Em outro terminal
cd frontend
npm install

# Verifique em src/services/api.js se a URL aponta para http://localhost:3000

# Rodar a aplicação
npm run dev
```
#### 5.2.4 Acessar:

O frontend estará disponível em http://localhost:5173.

## 6. Acesso ao Sistema (Deploy)

O sistema encontra-se implantado e acessível publicamente através da plataforma Render.

- URL da Aplicação Web/Mobile: https://descarte-app.onrender.com

- URL da API: https://descarte-api.onrender.com

**OBS:** Por estar hospedado em um serviço gratuito, o servidor pode entrar em modo de repouso após algum tempo sem receber requisições. Por isso, caso ocorra algum erro ao listar e descartar pacotes ou ao visualizar o perfil ou notificações, aguarde alguns segundos e tente novamente.


## 7. Validação com o Público-Alvo

### Definição do Público-Alvo: Moradores de Fortaleza (CE), especificamente da região da Aerolândia e Jangurussu, conscientes sobre a necessidade de reciclagem mas que carecem de meios logísticos fáceis. Inclui também catadores autônomos que buscam otimizar suas rotas.

### Resumo da Validação: Foram realizados testes de usabilidade com 5 usuários potenciais utilizando o protótipo funcional no celular. O foco foi validar o fluxo de "Descartar um Pacote", "Aceitar uma Coleta", até "Destinar um Pacote". Também a consulta de movimentação financeira, registro e login.

- **Principais Feedbacks Recebidos:

- Confusão nos Status: Usuários não entendiam quando o pacote estava "vendido" ou "aguardando". Ajuste: Implementação de mensagens descritivas nas notificações e botões bloqueados com cadeado para indicar status de espera.

- Medo de errar: Usuários tinham receio de aceitar uma coleta sem querer. Ajuste: Implementação de Modais de Confirmação com botão de fechar (X) explícito.

- Visibilidade: Motoristas queriam identificar rápido o que era "trabalho". Ajuste: Criação de diferenciação visual (Card Verde) para oportunidades de coleta.

- **Ajustes Futuros:

- Implementação de avaliação (estrelas) para aumentar a confiança entre usuários.

- Integração real de pagamento (Gateway) para compra de moedas.


## 8. Integrantes da Equipe

Raphaela Vidal De Oliveira - 2326911 (Solo)


## 9. Responsabilidades e Atribuições

### Gerente de Projeto

- **Planejamento:** Elaborar e monitorar o cronograma do projeto, definindo prazos para cada entrega.

- **Coordenação:** Distribuir tarefas e garantir que a equipe esteja alinhada e motivada.

- **Comunicação:** Atuar como o principal ponto de contato entre a equipe e o professor, comunicando o progresso e quaisquer desafios.

- **Gerenciamento de Riscos:** Identificar possíveis problemas (como atrasos ou falhas) e planejar soluções para eles.

### Arquiteto de Software

- **Desenho do Sistema:** Propor e documentar a arquitetura completa do software (APIs, etc.).

- **Escolha de Tecnologias:** Selecionar as ferramentas e os frameworks mais adequados para a implementação.

- **Padrões de Design:** Garantir que a equipe siga os padrões arquiteturais definidos para manter a consistência e a qualidade do código.

- **Documentação Técnica:** Liderar a elaboração dos documentos técnicos, como a documentação de arquitetura e das APIs.

### Analista de Negócio

- **Levantamento de Requisitos:** Coletar e analisar as necessidades do projeto para traduzi-las em requisitos funcionais e não-funcionais.

- **Ponte de Comunicação:** Atuar como o elo entre a ideia do negócio e o time técnico, garantindo que o que será desenvolvido atenda aos objetivos do projeto.

- **Análise do Impacto:** Avaliar como a solução de software pode gerar o impacto social desejado, alinhando-se ao ODS 11.

- **Validação:** Ajudar a validar o produto final para ter certeza de que ele resolve o problema inicial.

### Designer de UX/UI

- **Design Centrado no Usuário:** Criar uma experiência de usuário (UX) intuitiva e agradável, pensando nos fluxos de interação da plataforma.

- **Prototipação:** Desenvolver os wireframes e protótipos de alta fidelidade para as interfaces web e mobile.

- **Design Visual (UI):** Definir a identidade visual do projeto, incluindo cores, tipografia e ícones.

- **Testes de Usabilidade:** Conduzir testes com usuários para validar o design e fazer melhorias.

### Desenvolvedor Backend

- **Lógica do Servidor:** Construir a API e a lógica de negócio do sistema.

- **Gestão de Dados:** Criar a estrutura do banco de dados e garantir que a comunicação com ele seja segura e eficiente.

- **Segurança:** Implementar a autenticação de usuários, a validação de dados e outras medidas de segurança.

- **Integração:** Conectar os serviços de terceiros, como as APIs de geolocalização e de upload de imagens.

### Desenvolvedor Frontend

- **Desenvolvimento da Interface:** Codificar as interfaces web e mobile, seguindo os protótipos e o design definidos.

- **Experiência do Usuário:** Garantir que a aplicação seja fluida, rápida e responsiva em diferentes dispositivos.

- **Consumo das APIs:** Integrar o frontend com o backend, fazendo as requisições corretas para obter e enviar dados.

- **Manutenção:** Resolver bugs e otimizar o desempenho das interfaces.
