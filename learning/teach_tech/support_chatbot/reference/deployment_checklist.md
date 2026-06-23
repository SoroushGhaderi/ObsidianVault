# Deployment Checklist

## Backend Deployment

### Infrastructure Checklist

- ☐ Kubernetes cluster provisioned
- ☐ Container images built and pushed
- ☐ Secrets management (Vault, AWS Secrets Manager)
- ☐ Database migrations tested
- ☐ Load balancers configured
- ☐ SSL certificates installed
- ☐ DNS records updated
- ☐ CDN configured for static assets

### Service Configuration

```yaml
# Chat Service
replicas: 3
resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "512Mi"
    cpu: "500m"
env:
  - name: DATABASE_URL
    valueFrom:
      secretKeyRef:
        name: db-secret
        key: url
  - name: KAFKA_BROKERS
    value: "kafka:9092"
  - name: REDIS_URL
    value: "redis://redis:6379"
```

### Scaling Policies

```yaml
# Horizontal Pod Autoscaler
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: chat-service-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: chat-service
  minReplicas: 3
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

### Database Setup

```sql
-- Primary (WAL enabled for replication)
ALTER SYSTEM SET wal_level = logical;
ALTER SYSTEM SET max_wal_senders = 10;
ALTER SYSTEM SET max_replication_slots = 10;

-- Read replica
ALTER SYSTEM SET hot_standby = on;
SELECT pg_create_physical_replication_slot('replica_1');
```

## Monitoring & Alerting

### Key Metrics

```yaml
# Prometheus rules
groups:
- name: chatbot_alerts
  rules:
  - alert: HighErrorRate
    expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.05
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "High error rate detected"
      
  - alert: HighLatency
    expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 0.5
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "High latency detected"
      
  - alert: KafkaConsumerLag
    expr: kafka_consumer_group_lag > 1000
    for: 10m
    labels:
      severity: warning
    annotations:
      summary: "Kafka consumer lag high"
```

### Dashboard Panels

- Request rate (req/s)
- Error rate (%)
- Latency percentiles (p50, p95, p99)
- Active connections
- Memory/CPU usage
- Kafka consumer lag
- Database connection pool
- AI response latency

## Rollback Procedures

### Backend Services

```bash
# 1. Rollback Kubernetes deployment
kubectl rollout undo deployment/chat-service

# 2. Verify rollback
kubectl rollout status deployment/chat-service

# 3. Check logs
kubectl logs -f deployment/chat-service --tail=100
```

### Database

```sql
# 1. Stop writes to affected tables
BEGIN;
LOCK TABLE messages IN ACCESS EXCLUSIVE MODE;

# 2. Restore from backup
pg_restore -d chatbot backup.dump

# 3. Resume operations
COMMIT;
```

## Security Checklist

- ☐ Secrets not in code or git
- ☐ HTTPS enforced everywhere
- ☐ CORS configured properly
- ☐ Rate limiting enabled
- ☐ Input validation on all endpoints
- ☐ SQL injection prevention
- ☐ XSS protection
- ☐ CSRF tokens
- ☐ Audit logging enabled
- ☐ Penetration testing completed

## Performance Testing

### Load Test Scenarios

```bash
# 1. Normal load (1000 concurrent users)
k6 run --vus 1000 --duration 10m normal_load.js

# 2. Peak load (5000 concurrent users)
k6 run --vus 5000 --duration 5m peak_load.js

# 3. Stress test (find breaking point)
k6 run --vus 10000 --duration 2m stress_test.js
```

### Performance Targets

| Metric | Target | Acceptable |
|--------|--------|------------|
| Response time (p95) | <200ms | <500ms |
| Error rate | <0.1% | <1% |
| Throughput | >1000 req/s | >500 req/s |
| AI response time | <1s | <3s |
| Memory usage | <80% | <90% |

## Related Lessons

- [[0004_deployment_scaling|Lesson 4: Deployment and Scaling]]
- [[0002_event_driven_backend|Lesson 2: Event-Driven Backend]]