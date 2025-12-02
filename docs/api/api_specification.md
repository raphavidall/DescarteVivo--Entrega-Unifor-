# Documentação da API Descarte Vivo

contém o servidor e a lógica de negócios da plataforma Descarte Vivo, uma solução de logística reversa focada em conectar geradores de resíduos, coletores e pontos de destino em Fortaleza.

---

## 1. Serviço de Usuários e Autenticação

Este serviço gerencia o cadastro, login e perfis de todos os usuários do sistema.

### `POST /auth/register`
- **Função:** Cadastra um novo usuário no sistema.
- **Requisição (Exemplo de JSON - Usuário Comum):**

  ```json
  {
    "nome_completo": "Amanda Freire",
    "email": "amanda@test.com",
    "senha": "123456",
    "tipo_documento": "CPF",
    "documento": "30000000000",
    "endereco": {
     "cep": "60000-000",
     "rua": "Rua da Coleta",
     "numero": "321",
     "bairro": "Edson Queiroz",
     "cidade": "Fortaleza",
     "uf": "CE"
     }
  }
  ```

- **Resposta de Sucesso (201 Created):**

  ```json
  {
    "id": 7,
    "nome_completo": "Amanda Freire",
    "email": "amanda@test.com",
    "senha_hash": "$2b$10$MzhpyV5MjNobHceDc2XMvedLwEzexprR75xXjJCSxUSTRll1glwge",
    "tipo_documento": "CPF",
    "documento": "10000000000",
    "saldo_moedas": 100,
    "endereco": {
        "uf": "CE",
        "cep": "60000-000",
        "rua": "Rua da Coleta",
        "bairro": "Edson Queiroz",
        "cidade": "Fortaleza",
        "numero": "321"
    },
    "refresh_token": null
    }
```

- **Resposta de Erro (409 Conflict):**

  ```json
  {
    "status": "error",
    "message": "Dados duplicados (ex: email ou documento já existente)."
    }
```

### `POST /auth/login`
- **Função:** Autentica um usuário e retorna um token de acesso JWT.
- **Requisição (Exemplo de JSON):**

  ```json
  {
    "email": "email@exemplo.com",
    "senha": "senhaSegura123"
  }
  ```

- **Resposta de Sucesso (200 OK):**

  ```json
  {
  "token": "seuTokenDeAcessoJWT"
  }
  ```

### `GET /usuarios/{id}`

- **Função:** Retorna os dados básicos e o saldo de moedas de um usuário específico.
- **Parâmetros de URL:** `id` (integer, obrigatório)

- **Resposta de Sucesso (200 OK):**

  ```json
  {
    "id": 4,
    "nome_completo": "Batalzar",
    "email": "baltazar@test.com",
    "senha_hash": "seuaSenhaHash",
    "tipo_documento": "CPF",
    "documento": "05563258963",
    "saldo_moedas": 0,
    "endereco": null,
    "refresh_token": "seuTokenDeAcessoJWT"
}
```

## 2. Serviço de Pacotes e Logística

Este serviço gerencia o ciclo de vida dos pacotes de resíduos.

### `POST /pacotes`

- **Função:** Cria um novo pacote de resíduos.

- **Requisição (Exemplo de JSON):**

  ```json
  {
    "titulo": "Título Provisório",
    "id_material": 1,
    "peso_kg": 10,
    "localizacao": { "lat": -3.7, "lng": -38.5 }
}
```

- **Resposta de Sucesso (201 Created):**
  ```json
  {
    "id": 6,
    "id_ponto_descarte": 1,
    "id_ponto_coleta": null,
    "id_ponto_destino": null,
    "titulo": "Título Provisório",
    "descricao": null,
    "imagemUrl": null,
    "status": "DISPONIVEL",
    "valor_pacote_moedas": 60,
    "valor_coleta_moedas": null,
    "peso_kg": 10,
    "localizacao": null,
    "id_material": 1,
    "data_criacao": "2025-11-30T16:18:37.870Z",
    "data_coleta": null,
    "data_destino": null
}
```

### `PUT /pacotes/{id}`

- **Função:** Atualização do status de um pacote.
- **Parâmetros de URL:** `id` (integer, obrigatório)

- **Requisição (Exemplo de JSON):**
  ```json
  {
    "status": "AGUARDANDO_APROVACAO",
    "id_ponto_destino": 2345 // id do usuário que está solicitando a destinação
  }
```

- **Resposta de Sucesso (201 Created):**
  ```json
  {
    "mensagem": "Destinacao solicitada com sucesso.",
    "status": "aguardando_confirmacao"
  }
  ```

### `GET /pacotes/{userId}`

- **Função:** Lista os pacotes disponíveis para serem comprados e/ou coletados + os pacotes que o usuário movimentou.
- **Resposta de Sucesso (200 OK):** Retorna uma lista de pacotes disponíveis para destino.
    ```json
  [
    {
        "id": 6,
        "id_ponto_descarte": 1,
        "id_ponto_coleta": null,
        "id_ponto_destino": null,
        "titulo": "Título Provisório",
        "descricao": null,
        "imagemUrl": null,
        "status": "DISPONIVEL",
        "valor_pacote_moedas": 60,
        "valor_coleta_moedas": null,
        "peso_kg": 10,
        "localizacao": null,
        "id_material": 1,
        "data_criacao": "2025-11-30T16:18:37.870Z",
        "data_coleta": null,
        "data_destino": null,
        "material": {
            "id": 1,
            "nome": "Vidro",
            "valor_por_kg": 6
        },
        "pontoDescarte": {
            "id": 1,
            "nome_completo": "Coleta",
            "email": "coleta@test.com",
            "senha_hash": "senhaHash",
            "tipo_documento": "CPF",
            "documento": "30000000000",
            "saldo_moedas": 0,
            "endereco": {
                "uf": "CE",
                "cep": "60000-000",
                "rua": "Rua da Coleta",
                "bairro": "Edson Queiroz",
                "cidade": "Fortaleza",
                "numero": "321"
            },
        },
        "pontoColeta": null,
        "pontoDestino": null
    },
    {
        "id": 5,
        "id_ponto_descarte": 5,
        "id_ponto_coleta": null,
        "id_ponto_destino": null,
        "titulo": "Teste",
        "descricao": "",
        "imagemUrl": "https://res.cloudinary.com/dna91cnga/image/upload/v1764515322/descarte-vivo-uploads/pke4eohyrvnqmlmtbwt5.png",
        "status": "DISPONIVEL",
        "valor_pacote_moedas": 65,
        "valor_coleta_moedas": null,
        "peso_kg": 5,
        "localizacao": {
            "uf": "Ceará",
            "lat": -3.7577621,
            "lng": -38.5288448,
            "rua": "",
            "bairro": "Vila União",
            "cidade": "Fortaleza",
            "numero": "380",
            "enderecoCompleto": ", 380 - Vila União, Fortaleza"
        },
        "id_material": 3,
        "data_criacao": "2025-11-30T15:08:43.053Z",
        "data_coleta": null,
        "data_destino": null,
        "material": {
            "id": 3,
            "nome": "Metal",
            "valor_por_kg": 13
        },
        "pontoDescarte": {
            "id": 5,
            "nome_completo": "Nira Vidal",
            "email": "nira@test.com",
            "senha_hash": "$2b$10$kYCKsZDdB8/mUSTUttqz8.3EFVJ3OskyyU9ca1iM5Nq6lglofe5y2",
            "tipo_documento": "CPF",
            "documento": "00000000000",
            "saldo_moedas": 100,
            "endereco": null,
            "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsImlhdCI6MTc2NDUxNTE5MSwiZXhwIjoxNzY3MTA3MTkxfQ.ONEKjUDfgW3Z9lk5vdkK765WmS51QbQf0guQY5-Noxc"
        },
        "pontoColeta": null,
        "pontoDestino": null
    },
    {
        "id": 4,
        "id_ponto_descarte": 3,
        "id_ponto_coleta": null,
        "id_ponto_destino": null,
        "titulo": "Garrafas Pets",
        "descricao": "",
        "imagemUrl": "https://res.cloudinary.com/dna91cnga/image/upload/v1764510664/descarte-vivo-uploads/pbem1vffyhcwuu17kuy7.jpg",
        "status": "DISPONIVEL",
        "valor_pacote_moedas": 2.1,
        "valor_coleta_moedas": null,
        "peso_kg": 1.5,
        "localizacao": {
            "uf": "Ceará",
            "lat": -3.8515321,
            "lng": -38.5166309,
            "rua": "Rua 44",
            "bairro": "Jangurussu",
            "cidade": "Fortaleza",
            "numero": "",
            "enderecoCompleto": "Rua 44,  - Jangurussu, Fortaleza"
        },
        "id_material": 2,
        "data_criacao": "2025-11-30T13:51:04.829Z",
        "data_coleta": null,
        "data_destino": null,
        "material": {
            "id": 2,
            "nome": "Plástico",
            "valor_por_kg": 1.4
        },
        "pontoDescarte": {
            "id": 3,
            "nome_completo": "Raphaela",
            "email": "rapha@test.com",
            "senha_hash": "senhaHash",
            "tipo_documento": "CPF",
            "documento": "00000000000",
            "saldo_moedas": 0,
            "endereco": null
        },
        "pontoColeta": null,
        "pontoDestino": null
    }
]
