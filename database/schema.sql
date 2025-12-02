-- Arquivo: schema.sql
-- Descrição: Estrutura do Banco de Dados PostgreSQL - Descarte Vivo
-- Gerado a partir do schema.prisma final

-- 1. Tabela de Usuários
CREATE TABLE "Usuario" (
    "id" SERIAL NOT NULL,
    "nome_completo" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha_hash" TEXT NOT NULL,
    "tipo_documento" TEXT NOT NULL,
    "documento" TEXT NOT NULL,
    "saldo_moedas" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "endereco" JSONB,
    "refresh_token" TEXT,
    "tutorial_visto" BOOLEAN NOT NULL DEFAULT false,
    "premio_recebido" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id")
);

-- Índices únicos para Usuário
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");
CREATE UNIQUE INDEX "Usuario_documento_key" ON "Usuario"("documento");


-- 2. Tabela de Materiais
CREATE TABLE "Material" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "valor_por_kg" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Material_pkey" PRIMARY KEY ("id")
);

CREATE UNIQUE INDEX "Material_nome_key" ON "Material"("nome");


-- 3. Tabela de Pacotes (Logística)
CREATE TABLE "Pacote" (
    "id" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT,
    "imagemUrl" TEXT,
    "id_ponto_descarte" INTEGER NOT NULL,
    "id_ponto_coleta" INTEGER,
    "id_ponto_destino" INTEGER,
    "status" TEXT NOT NULL,
    "valor_pacote_moedas" DOUBLE PRECISION NOT NULL,
    "valor_coleta_moedas" DOUBLE PRECISION,
    "peso_kg" DOUBLE PRECISION NOT NULL,
    "localizacao" JSONB,
    "id_material" INTEGER NOT NULL,
    "data_criacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_coleta" TIMESTAMP(3),
    "data_destino" TIMESTAMP(3),

    CONSTRAINT "Pacote_pkey" PRIMARY KEY ("id")
);


-- 4. Tabela de Mensagens (Chat)
CREATE TABLE "Mensagem" (
    "id" SERIAL NOT NULL,
    "id_pacote" INTEGER NOT NULL,
    "id_remetente" INTEGER NOT NULL,
    "mensagem" TEXT NOT NULL,
    "data_envio" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Mensagem_pkey" PRIMARY KEY ("id")
);


-- 5. Tabela de Itens da Loja
CREATE TABLE "ItemLoja" (
    "id" SERIAL NOT NULL,
    "id_vendedor" INTEGER NOT NULL,
    "nome_item" TEXT NOT NULL,
    "descricao" TEXT,
    "valor_moedas" DOUBLE PRECISION NOT NULL,
    "tipo_item" TEXT,
    "disponibilidade" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "ItemLoja_pkey" PRIMARY KEY ("id")
);


-- 6. Tabela de Transações (Financeiro)
CREATE TABLE "Transacao" (
    "id" SERIAL NOT NULL,
    "id_origem" INTEGER,
    "id_destino" INTEGER,
    "valor" DOUBLE PRECISION NOT NULL,
    "tipo" TEXT NOT NULL,
    "id_referencia" INTEGER,
    "data_transacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Transacao_pkey" PRIMARY KEY ("id")
);


-- 7. Tabela de Notificações
CREATE TABLE "Notificacao" (
    "id" SERIAL NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "id_remetente" INTEGER,
    "id_pacote" INTEGER,
    "tipo" TEXT NOT NULL,
    "titulo" TEXT NOT NULL,
    "mensagem" TEXT NOT NULL,
    "lida" BOOLEAN NOT NULL DEFAULT false,
    "data_criacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Notificacao_pkey" PRIMARY KEY ("id")
);


-- 8. Definição das Chaves Estrangeiras (Foreign Keys)

-- Relacionamentos de Pacote
ALTER TABLE "Pacote" ADD CONSTRAINT "Pacote_id_ponto_descarte_fkey" FOREIGN KEY ("id_ponto_descarte") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "Pacote" ADD CONSTRAINT "Pacote_id_ponto_coleta_fkey" FOREIGN KEY ("id_ponto_coleta") REFERENCES "Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Pacote" ADD CONSTRAINT "Pacote_id_ponto_destino_fkey" FOREIGN KEY ("id_ponto_destino") REFERENCES "Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Pacote" ADD CONSTRAINT "Pacote_id_material_fkey" FOREIGN KEY ("id_material") REFERENCES "Material"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- Relacionamentos de Mensagem
ALTER TABLE "Mensagem" ADD CONSTRAINT "Mensagem_id_pacote_fkey" FOREIGN KEY ("id_pacote") REFERENCES "Pacote"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- Relacionamentos de ItemLoja
ALTER TABLE "ItemLoja" ADD CONSTRAINT "ItemLoja_id_vendedor_fkey" FOREIGN KEY ("id_vendedor") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- Relacionamentos de Transacao
ALTER TABLE "Transacao" ADD CONSTRAINT "Transacao_id_origem_fkey" FOREIGN KEY ("id_origem") REFERENCES "Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Transacao" ADD CONSTRAINT "Transacao_id_destino_fkey" FOREIGN KEY ("id_destino") REFERENCES "Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- Relacionamentos de Notificacao
ALTER TABLE "Notificacao" ADD CONSTRAINT "Notificacao_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "Notificacao" ADD CONSTRAINT "Notificacao_id_remetente_fkey" FOREIGN KEY ("id_remetente") REFERENCES "Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE "Notificacao" ADD CONSTRAINT "Notificacao_id_pacote_fkey" FOREIGN KEY ("id_pacote") REFERENCES "Pacote"("id") ON DELETE SET NULL ON UPDATE CASCADE;