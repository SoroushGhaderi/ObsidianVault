# Event-Driven Patterns Reference

## Message Broker Comparison

| Broker | Use Case | Throughput | Latency | Persistence |
|--------|----------|------------|---------|-------------|
| **Kafka** | High-throughput event streaming | 100K+ msg/sec | ms | Disk (durable) |
| **RabbitMQ** | Complex routing, task queues | 10K msg/sec | μs | Memory/Disk |
| **AWS SQS** | Managed queue, simple use cases | 3K msg/sec | 100ms | Disk |
| **Redis Streams** | Lightweight, in-memory | 1M+ msg/sec | μs | Memory (AOF) |

## Kafka Topics Design for Chatbots

```
# Core topics
chat.message.sent.{userId}          # User messages (partitioned by user)
chat.ai.request.{priority}          # AI processing requests
chat.ai.response.{messageId}        # AI streaming responses
chat.system.notification            # Typing indicators, errors

# Supporting topics
chat.user.activity                  # User online/offline events
chat.analytics.events               # All events for analytics
chat.system.audit                   # Security audit trail
chat.system.dead-letter             # Failed messages for retry
```

## Consumer Group Patterns

### Chat Service Group

```javascript
// Handles message storage and routing
consumer.subscribe({ topics: ['chat.message.sent', 'chat.ai.response'] });
consumer.run({
  eachMessage: async ({ topic, message }) => {
    if (topic === 'chat.message.sent') {
      await storeMessage(message);
      await forwardToAI(message);
    } else if (topic === 'chat.ai.response') {
      await streamToClient(message);
    }
  }
});
```

### AI Service Group

```javascript
// Processes AI requests (multiple instances)
consumer.subscribe({ topic: 'chat.ai.request' });
consumer.run({
  eachMessage: async ({ message }) => {
    const request = JSON.parse(message.value);
    const stream = await generateAIResponse(request);
    for await (const chunk of stream) {
      await publishResponse(request.messageId, chunk);
    }
  }
});
```

## Error Handling Patterns

### Dead Letter Queue

```javascript
consumer.run({
  eachMessage: async ({ message }) => {
    try {
      await processMessage(message);
    } catch (error) {
      if (message.headers.attempts < 3) {
        // Retry with exponential backoff
        await retryWithBackoff(message);
      } else {
        // Send to dead letter queue
        await producer.send({
          topic: 'chat.system.dead-letter',
          messages: [{ value: message.value, headers: { error: error.message } }]
        });
      }
    }
  }
});
```

### Circuit Breaker

```javascript
class CircuitBreaker {
  constructor(fn, options = {}) {
    this.fn = fn;
    this.failureThreshold = options.failureThreshold || 5;
    this.resetTimeout = options.resetTimeout || 30000;
    this.failures = 0;
    this.state = 'CLOSED';
  }
  
  async call(...args) {
    if (this.state === 'OPEN') {
      if (Date.now() > this.nextAttempt) {
        this.state = 'HALF';
      } else {
        throw new Error('Circuit breaker is OPEN');
      }
    }
    
    try {
      const result = await this.fn(...args);
      this.reset();
      return result;
    } catch (error) {
      this.failures++;
      if (this.failures >= this.failureThreshold) {
        this.state = 'OPEN';
        this.nextAttempt = Date.now() + this.resetTimeout;
      }
      throw error;
    }
  }
  
  reset() {
    this.failures = 0;
    this.state = 'CLOSED';
  }
}
```

## Performance Optimization

- **Batch publishing:** Send multiple messages in one Kafka produce call.
- **Compression:** Use gzip/snappy for large messages.
- **Partitioning:** Ensure even distribution across partitions.
- **Consumer parallelism:** Multiple consumer instances per group.
- **Memory management:** Use streaming for large payloads.

## Monitoring Metrics

- **Consumer lag:** Messages pending per partition.
- **Throughput:** Messages per second per topic.
- **Latency:** End-to-end message delivery time.
- **Error rate:** Failed messages per consumer group.
- **Circuit breaker state:** OPEN/CLOSED/HALF.

## Related Lessons

- [[0002_event_driven_backend|Lesson 2: Event-Driven Backend]]
- [[0003_ai_nlp_integration|Lesson 3: AI/NLP Integration]]