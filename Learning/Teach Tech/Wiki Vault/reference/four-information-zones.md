# Four Information Zones

| Zone | Purpose | Mutation rule |
|---|---|---|
| `raw/` | Original evidence | Read-only after capture |
| `wiki/` | Durable synthesized knowledge | Schema-controlled |
| `journal/` | Free-form human activity and observations | Human-first |
| `log/` | Audit trail of system operations | Append-only |

The architecture separates evidence, interpretation, experience, and operations. This keeps original sources checkable, allows synthesized claims to evolve, preserves informal work notes, and makes automated changes visible.

## Classification heuristic

1. Original evidence → `raw/`
2. Durable reusable claim → `wiki/`
3. What happened or what you are thinking today → `journal/`
4. Record of a system operation → `log/`

Workspace lesson: `/Users/soroush/Documents/Codex/2026-06-24/downloads-v3-skills/lessons/0001-four-information-zones.html`
