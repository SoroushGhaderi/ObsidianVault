---
type: concept
tags: [work, ai]
updated: 2026-06-24
---

# RAG Pipeline

Retrieval-Augmented Generation (RAG) combines language models with external knowledge retrieval for grounded, factual responses.

## Components
1. **Query Processing**: Rewriting, classification, decomposition.
2. **Retrieval**: Vector search, keyword search, hybrid.
3. **Generation**: LLM with retrieved context.
4. **Post-processing**: Hallucination filtering, citation.

## Key Patterns
- **HyDE**: Hypothetical document embeddings for better retrieval.
- **Semantic Chunking**: Split documents by meaning, not fixed size.
- **Cross-Encoder Re-ranking**: Improve relevance scoring.
- **Confidence Scoring**: Measure answer reliability.

## Performance Optimization
- **Caching**: Store frequent query results.
- **Batch Processing**: Handle multiple queries efficiently.
- **Streaming**: Token-by-token response delivery.

## Use in Chatbots
- Ground AI responses in knowledge base.
- Provide citations for transparency.
- Handle domain-specific questions.

## Related Entities
- [[wiki/entities/pgvector|pgvector]]
- [[wiki/entities/pinecone|Pinecone]]

## Sources
- [RAG Architecture Guide](https://www.pinecone.io/learn/retrieval-augmented-generation/)
- [Production AI chatbot system design](https://www.learnwithparam.com/blog/system-design-building-production-ready-ai-chatbot-end-to-end)