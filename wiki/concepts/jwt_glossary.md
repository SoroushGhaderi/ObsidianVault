---
type: concept
tags: [work, authentication]
updated: 2026-06-27
---

# JWT Glossary

## Token Structure
- **Header**: Algorithm (`alg`) and token type (`typ`). Example: `{"alg": "HS256", "typ": "JWT"}`.
- **Payload**: Claims. Registered (`iss`, `exp`, `sub`, `aud`), public, private.
- **Signature**: Cryptographic proof over the header and payload. It verifies integrity and provenance.

## Claims
- **iss** (Issuer): Who issued the token. Example: `https://auth.tapsi.food`.
- **exp** (Expiration): Unix timestamp when token expires.
- **sub** (Subject): Who the token represents. Example: user ID.
- **aud** (Audience): Who the token is intended for. Example: `https://api.tapsi.food`.
- **iat** (Issued At): When the token was issued.

## Encoding
- Base64url encoding (no padding): `base64url(header).base64url(payload).signature`
- `PyJWT`: `jwt.decode(token, algorithms=["HS256"])` returns a claims dictionary when verification is enabled with the proper key.

## Operational Notes
- `alg` must be treated as an input to policy, not a value to trust blindly.
- `exp` is a required guardrail for most application tokens.
- `sub` is usually the canonical subject identifier when the issuer follows JWT conventions.

## Related
- [[jwt_gateway_trust_pattern]]
- [[hashid_identity_pattern]]
