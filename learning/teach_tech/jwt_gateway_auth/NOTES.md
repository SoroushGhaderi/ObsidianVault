# JWT Gateway Auth — Teaching Notes

## Vault Path
`/Users/soroush/Documents/ObsidianVault`

## Topic
JWT-based authentication using the gateway-trust pattern with HashId identity decoding.

## Context
Extracted from real implementation in TapsiFood support chatbot (`supportchatbot` project). The chatbot previously accepted `user_id` in the request body. Changed to extract from JWT `Authorization` header.

## Teaching Approach
- Code-first, architecture-focused.
- Use actual codebase as examples.
- Interactive exercises with show/hide answers.
- Reference concepts filed into the wiki.

## Session History
- 2026-06-27: Session 1 — JWT extraction pattern, HashId decoding, FastAPI dependency injection. Created lessons, reference docs, learning record.
- 2026-06-27: Session 2 — claim validation, fail-closed auth dependency design, and testable backend ownership.
- 2026-06-27: Session 3 — added a code-like diagram for the core gateway-trust auth flow.
