Documentação de Arquitetura

Este documento descreve a arquitetura de software do projeto "Descarte Vivo", detalhando sua estrutura, componentes, padrões de design e as decisões técnicas que guiaram o seu planejamento.

## 1. Descrição da Arquitetura

A arquitetura do "Descarte Vivo" evoluiu para um Monólito Modular baseado em camadas. Diferente da abordagem inicial de microsserviços, esta estrutura consolida a lógica de negócios em uma única unidade de deploy (API Node.js), mantendo, contudo, uma rigorosa separação de responsabilidades interna através de Módulos (Services e Controllers).

Essa abordagem foi escolhida para garantir a consistência transacional (ACID) do sistema financeiro (modelo Escrow), simplificar a infraestrutura de deploy e acelerar o desenvolvimento do MVP, sem sacrificar a organização do código.

A arquitetura é dividida em três camadas lógicas:

- **Camada de Apresentação (Frontend):** Uma Single Page Application (SPA) responsiva que atende tanto usuários Desktop quanto Mobile através do mesmo código-base.

- **Camada de Aplicação (Backend):** Uma API RESTful que orquestra as regras de negócio, autenticação e integrações.

- **Camada de Dados e Infraestrutura:** Persistência relacional, armazenamento de mídia em nuvem e serviços de geolocalização.

## 2. Componentes do Sistema

###2.1 Frontend (Cliente)

- **Tecnologia:** React.js + Vite + Tailwind CSS.

- **Descrição:** Uma interface única desenvolvida com a filosofia "Mobile First". Ela se adapta dinamicamente para oferecer uma experiência de aplicativo em smartphones e um dashboard completo em desktops. Consome a API Backend via HTTP/REST.

###2.2 Backend (Servidor)

- **Tecnologia:** Node.js + Express.

- **Descrição:** O núcleo do sistema. Está estruturado internamente nos seguintes módulos lógicos:

- Auth Module: Gerencia JWT (Access/Refresh tokens) e criptografia (Bcrypt).
- User Module: Gestão de perfis e dados cadastrais.
- Package Module: Máquina de estados dos pacotes (Logística Reversa) e upload de imagens.
- Finance Module: Gestão da carteira digital, transações de crédito/débito e lógica de Escrow (custódia de valores).
- Notification Module: Sistema de observadores que dispara alertas baseados em eventos do sistema.

###2.3 Persistência de Dados

- **Tecnologia:** PostgreSQL + Prisma ORM.

- **Descrição:** Banco de dados relacional robusto para garantir a integridade das transações financeiras e relacionamentos complexos entre usuários e pacotes.

###2.4 Serviços Externos (Integrações)

- **Cloudinary:** Serviço de armazenamento em nuvem (CDN) para as imagens dos pacotes, contornando a limitação de sistemas de arquivos efêmeros em ambientes Serverless.

- **OpenStreetMap (Nominatim):** API de geocodificação para converter coordenadas GPS em endereços legíveis e vice-versa.


## 3. Padrões Arquiteturais Utilizados

- **MVC (Model-View-Controller):** Adaptado para API.
- Model: Definido pelos schemas do Prisma.
- Controller: Gerencia a entrada/saída HTTP e validação básica.
- Service (Lógica): Contém as regras de negócio puras, separadas dos controladores.

- **RESTful API:** Padrão de comunicação utilizando verbos HTTP (GET, POST, PUT, DELETE) e retorno em JSON.

- **Singleton:** Utilizado na instância do banco de dados (Prisma Client) para gerenciar o pool de conexões.

- **Middleware Chain:** Utilizado para processamento sequencial de requisições (ex: validação de CORS -> Autenticação -> Upload de Arquivo -> Controller).

## 4. Diagrama de Arquitetura

Este diagrama reflete a comunicação centralizada na API e as integrações externas implementadas.


    graph TD
    subgraph Cliente [Frontend - React/Vite]
        A[Interface Responsiva Web/Mobile]
    end

    subgraph Servidor [Backend - Node.js/Express]
        API[API Monolítica]
        
        subgraph Módulos Internos
            Auth[Autenticação & JWT]
            Logistica[Gestão de Pacotes]
            Financeiro[Transações & Escrow]
            Notif[Notificações]
        end
    end

    subgraph Infraestrutura [Persistência & Nuvem]
        DB[(PostgreSQL)]
        Cloud[Cloudinary - Imagens]
        Maps[OpenStreetMap - Geo]
    end

    %% Fluxos
    A -- "HTTPS / JSON (REST)" --> API
    
    API -- "Roteamento" --> Auth
    API -- "Roteamento" --> Logistica
    API -- "Roteamento" --> Financeiro
    API -- "Roteamento" --> Notif

    %% Acesso a Dados
    Auth & Logistica & Financeiro & Notif -- "Prisma ORM" --> DB

    %% Integrações Externas
    Logistica -- "Upload / Armazenamento" --> Cloud
    Logistica -- "Geocoding API" --> Maps

## 5. Evolução da Arquitetura e Decisões Técnicas

Esta seção justifica as alterações realizadas em relação ao planejamento inicial (Etapa 1) para a entrega da implementação (Etapa 2).

### De Microserviços para Monólito Modular

- **Planejamento Inicial:** Arquitetura de microsserviços distribuídos.

- **Implementação:** Monólito Modular.

- **Justificativa:** A complexidade de orquestrar múltiplos serviços e garantir consistência de dados distribuída (Saga Pattern) se mostrou desnecessária para o volume de dados do MVP. A migração para um Monólito Modular permitiu o uso de Transações de Banco de Dados (ACID) nativas, garantindo que o dinheiro nunca seja perdido em uma falha de sistema (ex: débito do comprador e crédito do vendedor ocorrem atomicamente), o que é crítico para a confiança na plataforma.

### Armazenamento: De Local para Cloudinary

- **Planejamento Inicial:** Armazenamento local ou Blob no banco.

- **Implementação:** Integração com Cloudinary.

- **Justificativa:** A plataforma de hospedagem escolhida (Render.com) possui sistema de arquivos efêmero. O uso do Cloudinary garante a persistência das imagens, além de oferecer otimização automática e CDN, melhorando a performance no mobile.

### Escolha do Banco de Dados Relacional (PostgreSQL):

- **Justificativa:** As transações de moedas verdes e o gerenciamento de usuários e pacotes exigem integridade e consistência de dados. O PostgreSQL, com sua capacidade de garantir atomicidade em transações, é a escolha ideal para um sistema que lida com dados financeiros.

### Frontend: De React Native para React Responsivo (PWA)

- **Planejamento Inicial:** App Nativo separado da Web.

- **Implementação:** Aplicação Web Responsiva única.

- **Justificativa:** A unificação do código permitiu um desenvolvimento mais ágil e manutenção simplificada. Através do uso de Tailwind CSS e design Mobile First, a aplicação oferece uma experiência próxima à nativa em celulares, sem a necessidade de manter dois repositórios distintos.

