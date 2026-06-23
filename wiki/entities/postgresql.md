---
type: entity
tags: [work, infrastructure]
updated: 2026-06-24
---

# PostgreSQL

PostgreSQL is an advanced open-source relational database with support for JSON, full-text search, and extensions like pgvector.

## Key Features
- **ACID compliance**: Reliable transactions.
- **Extensibility**: Custom functions, types, indexes.
- **JSON support**: Store and query JSON documents.
- **Replication**: Streaming and logical replication.

## Use in Chatbots
- Primary database for user data, conversations, messages.
- pgvector extension for vector similarity search.
- Full-text search for knowledge base.
- Audit logging and compliance.

## Related Concepts
- [[wiki/concepts/database_design|Database Design]]
- [[wiki/concepts/vector_databases|Vector Databases]]

## Sources
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [pgvector Documentation](https://github.com/pgvector/pgvector)