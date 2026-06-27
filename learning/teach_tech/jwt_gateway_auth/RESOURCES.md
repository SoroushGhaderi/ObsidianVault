# JWT Gateway Auth Resources

## Knowledge
- [PyJWT Documentation](https://pyjwt.readthedocs.io/)
  Use for: JWT decoding API, algorithm support, claims extraction.
- [hashids Documentation](https://hashids.org/python/)
  Use for: HashId encoding/decoding, salt/alphabet configuration.
- [RFC 7519: JWT](https://datatracker.ietf.org/doc/html/rfc7519)
  Use for: JWT specification, claims structure, token format.
- [FastAPI Dependencies](https://fastapi.tiangolo.com/tutorial/dependencies/)
  Use for: Dependency injection pattern for auth extraction.
- [OWASP: Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
  Use for: Authentication security best practices.

## Wisdom (Communities)
- [FastAPI Discord](https://discord.gg/fastapi)
  Use for: FastAPI dependency injection patterns, auth implementation questions.
- [Security StackExchange](https://security.stackexchange.com/)
  Use for: JWT security model questions, gateway-trust pattern validation.

## Gaps
- No official docs on the specific "gateway-trust, no-verification" pattern — it's an architectural choice, not a standard.
- HashId is not a standard; it's a reversible encoding, not encryption. Need to emphasize this distinction.
