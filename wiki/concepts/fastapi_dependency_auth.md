---
type: concept
tags: [work, fastapi, authentication]
updated: 2026-06-27
---

# FastAPI Dependency Injection for Auth

## Pattern
Use `Depends()` to inject extracted identity into endpoint handlers.

```python
from fastapi import Depends, HTTPException, Request

async def get_current_user_id(request: Request) -> str:
    token = extract_bearer_token(request.headers.get("authorization"))
    payload = decode_jwt(token)
    return decode_hashid(payload["UserId"])

@router.post("/message")
async def handle_message(
    user_id: str = Depends(get_current_user_id),
    ...
):
    # user_id is already the decoded numeric string
```

## Design Notes
- Keep extraction and decoding in a single dependency so handlers stay focused on business logic.
- Raise `HTTPException` from the dependency rather than from every route.
- Prefer explicit auth dependencies over ad hoc header parsing in handlers.

## Testing
Override dependencies in tests:

```python
from app.main import app
from app.core.jwt_auth import get_current_user_id

def override_user_id(user_id: str = "user-123"):
    app.dependency_overrides[get_current_user_id] = lambda: user_id

def clear_user_id_override():
    app.dependency_overrides.pop(get_current_user_id, None)
```

## Benefits
- Auth logic centralized in one function.
- Endpoint handlers don't know about JWT mechanics.
- Easy to mock in tests.
- FastAPI handles 422 validation if dependency raises.

## Related
- [[jwt_gateway_trust_pattern]]
- [[jwt_glossary]]
