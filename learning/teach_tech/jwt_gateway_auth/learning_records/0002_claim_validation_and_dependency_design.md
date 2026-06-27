---
type: logic
tags: [work, authentication]
updated: 2026-06-27
---

# Gateway-Trust Auth: Claim Validation and Dependency Design

Date: 2026-06-27

## Context
The first lesson covered extracting a user identity from a gateway-validated JWT. The next refinement is making the backend dependency professional: strict about request shape, explicit about ownership, and resistant to silent failures.

## Insight 1: Trust the Gateway, but Still Fail Closed
Skipping signature verification is not the same as skipping validation. The backend still owns header parsing, required claim checks, and HashId decoding.

## Insight 2: Defaults in Auth Code Are Dangerous
Returning a fallback user ID turns malformed input into impersonation risk. Auth code should reject bad inputs instead of inventing identities.

## Insight 3: One Dependency Should Own the Whole Path
FastAPI dependency injection works best when a single function handles header parsing, JWT decode, claim extraction, and HashId decoding. That makes the behavior testable and easier to reason about.

## Insight 4: Backend Validation Is About Correctness, Not Re-Authentication
The backend is not trying to become a second gateway. It is protecting itself from malformed requests, contract drift, and accidental misuse while still trusting the gateway for cryptographic verification.

## Evidence
- Added lesson 0002 in `learning/teach_tech/jwt_gateway_auth/lessons/0002_claim_validation_and_auth_dependency.html`
- Added summary in `learning/teach_tech/jwt_gateway_auth/reference/0002_lesson_summary.md`

## Implications
- Future lessons can split into HashId rotation, token claim policy, and zero-trust comparison.
- The auth dependency should stay small enough to unit test directly.
