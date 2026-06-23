---
type: entity
tags: [work, infrastructure]
updated: 2026-06-24
---

# Redis

Redis is an in-memory data store used as a database, cache, message broker, and streaming engine.

## Key Features
- **Performance**: Microsecond response times.
- **Data structures**: Strings, hashes, lists, sets, sorted sets, streams.
- **Persistence**: Optional disk persistence.
- **Clustering**: Horizontal scaling with Redis Cluster.

## Use in Chatbots
- Caching frequent RAG queries.
- Session storage for user conversations.
- Rate limiting and circuit breaker state.
- Real-time leaderboards and analytics.

## Related Concepts
- [[wiki/concepts/caching_patterns|Caching Patterns]]
- [[wiki/concepts/session_management|Session Management]]

## Sources
- [Redis Documentation](https://redis.io/documentation)
- [Production AI chatbot system design](https://www.learnwithparam.com/blog/system-design-building-production-ready-ai-chatbot-end-to-end)