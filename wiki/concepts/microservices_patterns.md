---
type: concept
tags: [work, architecture]
updated: 2026-06-24
---

# Microservices Patterns

Microservices architecture structures applications as small, independent services that communicate via APIs.

## Core Patterns
1. **API Gateway**: Single entry point, routing, authentication.
2. **Service Discovery**: Dynamic service location.
3. **Circuit Breaker**: Prevent cascade failures.
4. **Saga Pattern**: Distributed transactions.
5. **CQRS**: Separate read/write models.

## Communication Patterns
- **Synchronous**: REST, gRPC for request-response.
- **Asynchronous**: Message queues for event-driven.
- **Event Streaming**: Kafka for real-time data.

## Deployment Patterns
- **Containerization**: Docker for consistency.
- **Orchestration**: Kubernetes for scaling.
- **Service Mesh**: Istio, Linkerd for observability.
- **CI/CD**: Automated deployment pipelines.

## Use in Chatbots
- Independent scaling of chat, AI, analytics services.
- Fault isolation between components.
- Technology diversity (different languages/frameworks).

## Related Concepts
- [[wiki/concepts/event_driven_architecture|Event-Driven Architecture]]
- [[wiki/concepts/containerization|Containerization]]

## Sources
- [Microservices.io Patterns](https://microservices.io/patterns/)
- [AI Chatbot Architecture Guide](https://www.nadcab.com/blog/ai-chatbot-architecture-guide)