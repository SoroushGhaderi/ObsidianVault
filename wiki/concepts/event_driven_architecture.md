---
type: concept
tags: [work, architecture]
updated: 2026-06-24
---

# Event-Driven Architecture

Event-driven architecture (EDA) uses asynchronous events to decouple components and enable scalable, real-time systems.

## Core Patterns
1. **Message Queues**: Kafka, RabbitMQ, SQS for reliable delivery.
2. **Event Streaming**: Real-time data pipelines.
3. **CQRS**: Separate read/write models.
4. **Saga Pattern**: Orchestrate multi-step workflows.

## Benefits for Chatbots
- **Scalability**: Independent scaling of services.
- **Resilience**: Queue messages during downtime.
- **Real-time**: Stream responses without blocking.
- **Auditability**: Event sourcing provides history.

## Implementation Considerations
- **Partitioning**: Ensure ordering per user/session.
- **Consumer Groups**: Parallel processing.
- **Dead Letter Queues**: Handle failed messages.
- **Circuit Breakers**: Prevent cascade failures.

## Use in Chatbots
- Backend service communication.
- AI response streaming.
- Analytics and monitoring.

## Related Entities
- [[wiki/entities/kafka|Kafka]]
- [[wiki/entities/rabbitmq|RabbitMQ]]

## Sources
- [Production AI chatbot system design](https://www.learnwithparam.com/blog/system-design-building-production-ready-ai-chatbot-end-to-end)
- [Event-Driven Architecture for Chatbot APIs](https://chatspark.io/blog/event-driven-architecture-for-chatbot-apis)