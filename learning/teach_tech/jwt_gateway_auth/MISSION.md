# Mission: JWT Gateway Authentication Pattern

## Why
I implemented a JWT extraction pattern where the chatbot service trusts the gateway's JWT validation, decodes the token without signature verification, and extracts a HashId-based user identity. I want to deeply understand this authentication pattern, its security model, and when to use it versus alternatives.

## Success looks like
- I can explain the gateway-trust JWT pattern and its security boundary.
- I can implement JWT extraction with HashId decoding in Python/FastAPI.
- I can identify when this pattern is appropriate versus full JWT verification.
- I can design the auth flow across gateway → backend service boundaries.

## Constraints
- Backend developer background; prefer concrete code from our chatbot implementation.
- Working with FastAPI, PyJWT, hashids libraries.
- Learning style: code-first, architecture-focused, interactive exercises.

## Out of scope
- OAuth2/OIDC flow implementation details (gateway handles that).
- JWT signature cryptography deep dive.
- Frontend token storage strategies.
