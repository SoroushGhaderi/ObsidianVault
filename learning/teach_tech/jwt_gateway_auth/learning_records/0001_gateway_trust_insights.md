---
type: logic
tags: [work, authentication]
updated: 2026-06-27
---

# Gateway-Trust Auth: Session Insights

Date: 2026-06-27

## Context
Implemented JWT extraction with HashId decoding for the TapsiFood support chatbot. Previously the API accepted `user_id` in the request body (no auth). Changed to extract identity from the JWT `Authorization` header.

## Insight 1: Auth Boundary is a Design Choice, Not a Requirement
The chatbot API previously had zero authentication — anyone could send any `user_id`. The new pattern trusts the gateway to validate JWTs, and the chatbot only extracts identity. This is a deliberate architectural decision, not a security gap.

## Insight 2: Breaking API Changes Require Simultaneous Deploy
Removing `user_id` from the request body broke the frontend contract. Backend and frontend must deploy together. Existing sessions break (acceptable with short TTL).

## Insight 3: HashIds Are Obfuscation, Not Encryption
HashIds use a salt-based reversible encoding. With the salt, anyone can decode. The value is preventing casual enumeration (sequential IDs → random strings), not cryptographic security.

## Insight 4: FastAPI Dependency Overrides Are the Testing Pattern
Mocking `get_current_user_id` via `app.dependency_overrides` is cleaner than patching internal functions. The `patch.dict` approach ensures cleanup between tests.

## Evidence
- Implemented in `app/core/jwt_auth.py`
- Endpoints updated in `app/api/v1/endpoints/chat.py`
- 137 tests passing after migration

## Implications
- Future services behind the same gateway can reuse `jwt_auth.py`.
- HashIds config must be env-configurable for rotation.
- Consider adding a lesson on JWT claim validation (exp, aud) for defense-in-depth.
