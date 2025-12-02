# projeto-streaming-sql
[Projeto de banco de dados relacional para um sistema de streaming de vídeos, modelado com 6 tabelas e relacionamentos N:M]
## streaming-service-sql

## Descrição
[Projeto de banco de dados relacional para um sistema de streaming de vídeos, modelado com 6 tabelas e relacionamentos 1:N e N:M]

## Autores
- [Matheus Marques Araujo]
- [Wesley Freitas]
- [Isaque Silva]

## Tecnologias Utilizadas
- [MySQL]
- [SQL]
- [MySQL Workbench]

## Modelo de Dados
- [Dados Lógicos]
### Entidades Principais
- **[assinantes]**: [Dados do cliente pagante]
- **[perfis]**: [Perfis de visualização de conteúdos (incluindo restrição de idade)]
- **[conteudos]**: [Catálogos de filmes, séries e documentários ]
- **[generos]**: [Categorias de Classificacão (Ação, Drama, etc.]
- **[sessoes_assistidas]**: [Tabela que registra o histórico de visualização]

### Relacionamentos
- [assinantes] → [perfis]: [1 para N]
- [perfis] → [sessoes_assistidas]: [1 para N]
- [conteudos] → [sessoes_assistidas]: [1 para N]
- [conteudos] ↔ [generos]: [N para M]

## Decisões de Design
- [**Integridade Referencial: Uso de `ON DELETE CASCADE` em chaves estrangeiras críticas (ex: entre `assinantes` e `perfis`) para que a exclusão de um		 registro principal apague automaticamente os dependentes]
- [**Segurança:** Utilização da função `SHA2` para `hash` e armazenamento seguro de senhas na tabela `assinantes`]
- [**Dados Opcionais:** A coluna "duracao_minutos" foi definida como `NULL` na tabela `conteudos` para acomodar o cadastro de **Séries** (que não têm duração final fixa).]

