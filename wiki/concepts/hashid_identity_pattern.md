---
type: concept
tags: [work, authentication, identity]
updated: 2026-06-27
---

# HashId Identity Pattern

## What is HashIds
A reversible encoding library that converts integers to short, non-sequential strings. NOT encryption. Anyone with the salt can decode.

```python
from hashids import Hashids
h = Hashids(salt="my-salt", min_length=6, alphabet="abdfghklmnoprstwxyz123456789")
encoded = h.encode(10652)  # → "7713gkn"
decoded = h.decode("7713gkn")  # → (10652,)
```

## Use Case: Obfuscated User IDs
- Frontend/JWT carries HashId string (e.g., `"7713gkn"`).
- Backend decodes to numeric ID (e.g., `10652`).
- Numeric ID used for internal APIs (database, OMS).
- Prevents sequential ID enumeration by clients.
- Treat the encoded value as a transport-friendly identifier, not a secret or permission boundary.

## Configuration
Three parameters must match between encoder (C# backend) and decoder (Python chatbot):
- `salt`: Shared secret string. Rotate = re-encode all IDs.
- `min_length`: Minimum output length (padded with alphabet chars).
- `alphabet`: Characters used in output. Must exclude ambiguous chars.

## Failure Modes
- Wrong salt or alphabet returns an empty decode result.
- Configuration drift between services breaks identity resolution.
- Encoding changes require a migration plan if identifiers are persisted externally.

## Security Note
HashIds are **obfuscation**, not encryption. With the salt, anyone can decode. Never treat HashIds as secrets.

## Related
- [[jwt_glossary]]
- [[jwt_gateway_trust_pattern]]
