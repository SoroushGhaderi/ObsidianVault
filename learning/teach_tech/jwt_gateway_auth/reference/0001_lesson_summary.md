---
type: source
tags: [work, authentication, learning]
updated: 2026-06-27
---

# Lesson 0001: JWT Extraction from Authorization Header

**Goal:** Extract a numeric user_id from a Bearer JWT token using the gateway-trust pattern.

## Architecture Flow

```
Client → Gateway (validates JWT) → Backend (extracts identity, skips verification)
```

## Key Steps

1. **Extract Bearer token** from `Authorization` header: `Bearer eyJhbGci...` → split on space.
2. **Decode JWT** without signature verification (`verify_signature: False`).
3. **Extract HashId** from `UserId` claim.
4. **Decode HashId** to numeric string using shared salt/alphabet config.

## Code Pattern

```python
# Extract
auth = request.headers.get("authorization")
token = auth.split(" ", 1)[1]

# Decode JWT
payload = jwt.decode(token, options={"verify_signature": False}, algorithms=["HS256", "RS256"])

# Decode HashId
user_id = str(hashids.decode(payload["UserId"])[0])
```

## Security Model
- Trust boundary is the private network between gateway and backend.
- Gateway handles cryptographic verification.
- Backend relies on network isolation, service mesh policy, or mTLS where available.
- Backend still performs basic input validation and claim presence checks.

## Related Pages
- [[jwt_gateway_trust_pattern]]
- [[jwt_glossary]]
- [[hashid_identity_pattern]]
- [[fastapi_dependency_auth]]

## Full Lesson
See HTML version: `lessons/0001_jwt_extraction_from_header.html`
