# RAG Pipeline Reference

## RAG Architecture Components

```
Query Processing
├── Query Rewriter
└── Query Classifier

Retrieval
├── Vector Database
├── Knowledge Base
└── Cross-Encoder

Generation
├── Language Model
├── Prompt Constructor
└── Cache Store

Post-processing
├── Hallucination Filter
└── Citation System
```

## Query Rewriting Patterns

### 1. HyDE (Hypothetical Document Embeddings)

```python
async def rewrite_query_hyde(query, llm):
    prompt = f"Write a passage that would answer this question: {query}"
    hypothetical_doc = await llm.generate(prompt)
    return hypothetical_doc  # Use for embedding search
```

### 2. Step-back Prompting

```python
async def rewrite_query_stepback(query, llm):
    prompt = f"""
    Given this specific question, generate a more general, higher-level question 
    that would help answer it: {query}
    """
    return await llm.generate(prompt)
```

### 3. Sub-question Decomposition

```python
async def decompose_query(query, llm):
    prompt = f"""
    Break this complex question into 2-3 simpler sub-questions:
    {query}
    """
    sub_questions = await llm.generate(prompt)
    return sub_questions.split('\n')
```

## Vector Database Optimization

### Embedding Models

| Model | Dimensions | Speed | Quality | Use Case |
|-------|------------|-------|---------|----------|
| text-embedding-3-small | 1536 | Fast | Good | General purpose |
| text-embedding-3-large | 3072 | Slow | Excellent | High accuracy |
| all-MiniLM-L6-v2 | 384 | Very Fast | Fair | Local/edge |
| BGE-large-en | 1024 | Medium | Very Good | Enterprise |

### Chunking Strategies

```python
class SemanticChunker:
    def __init__(self, embedding_model, threshold=0.7):
        self.embedding_model = embedding_model
        self.threshold = threshold
    
    def chunk(self, text):
        sentences = split_sentences(text)
        chunks = []
        current_chunk = [sentences[0]]
        
        for i in range(1, len(sentences)):
            prev_embedding = self.embedding_model.encode(current_chunk[-1])
            curr_embedding = self.embedding_model.encode(sentences[i])
            similarity = cosine_similarity(prev_embedding, curr_embedding)
            
            if similarity < self.threshold:
                chunks.append(' '.join(current_chunk))
                current_chunk = [sentences[i]]
            else:
                current_chunk.append(sentences[i])
        
        chunks.append(' '.join(current_chunk))
        return chunks
```

## Prompt Construction

### System Prompt Template

```python
def build_rag_prompt(query, documents, history=None):
    doc_context = "\n\n".join([
        f"Document {i+1} (relevance: {doc.score:.2f}):\n{doc.content}"
        for i, doc in enumerate(documents)
    ])
    
    history_context = ""
    if history:
        history_context = "\n".join([
            f"{'User' if msg.role == 'user' else 'Assistant'}: {msg.content}"
            for msg in history[-5:]  # Last 5 messages
        ])
    
    return f"""You are a helpful support assistant. Answer based ONLY on the provided documents.

DOCUMENTS:
{doc_context}

CONVERSATION HISTORY:
{history_context}

RULES:
1. If the answer isn't in the documents, say "I don't have that information."
2. Cite documents using [1], [2], etc.
3. Be concise and factual.
4. If multiple documents conflict, mention both perspectives.

USER QUESTION: {query}

ANSWER:"""
```

## Performance Optimization

### Caching Strategy

```python
class RAGCache:
    def __init__(self, ttl=3600):
        self.cache = {}
        self.ttl = ttl
    
    def get(self, query):
        query_hash = hashlib.md5(query.encode()).hexdigest()
        if query_hash in self.cache:
            entry = self.cache[query_hash]
            if time.time() - entry['timestamp'] < self.ttl:
                return entry['result']
        return None
    
    def set(self, query, result):
        query_hash = hashlib.md5(query.encode()).hexdigest()
        self.cache[query_hash] = {
            'result': result,
            'timestamp': time.time()
        }
```

## Evaluation Metrics

| Metric | Description | Target |
|--------|-------------|--------|
| **Relevance** | How relevant are retrieved documents? | >0.8 |
| **Faithfulness** | Is answer grounded in documents? | >0.9 |
| **Answer Relevance** | Does answer address the question? | >0.85 |
| **Context Recall** | Are all relevant docs retrieved? | >0.7 |
| **Latency** | End-to-end response time | <500ms |

## Related Lessons

- [[0003_ai_nlp_integration|Lesson 3: AI/NLP Integration]]
- [[0002_event_driven_backend|Lesson 2: Event-Driven Backend]]