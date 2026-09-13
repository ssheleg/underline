# Карта документации — Underline

## Режим

`governed` — установлен 2026-08-30 решением DEC-0001.

## Реестры

| Register | File | ID scheme | Append-only | Guarded |
|---|---|---|---|---|
| Decisions | `docs/DECISIONS.md` | `DEC-####` | yes | no coordination mechanism |
| Open questions | `docs/OPEN_QUESTIONS.md` | `OQ-####` | yes | no coordination mechanism |
| Backlog | `docs/evidence/backlog.md` | `BL-####` | no — rows close | no coordination mechanism |
| Verification | `docs/evidence/verification.md` | one row per REQ | no — status moves | no coordination mechanism |
| Retrospective | `docs/evidence/retro.md` | standing instructions, max 10 | no — instructions retire | no coordination mechanism |

## Единственные источники истины

| Fact | Home | Other documents |
|---|---|---|
| Product intent and MVP boundary | `docs/PRODUCT.md` | link to it |
| Architecture and domain terms | `docs/ARCHITECTURE.md` | link to the section |
| User-visible CLI behaviour | `docs/ux/scenarios.md` | link to the scenario |
| Settled decision | `docs/DECISIONS.md` | cite `DEC-####` |
| Unsettled question | `docs/OPEN_QUESTIONS.md` | cite `OQ-####` |
| Whether a scenario is actually implemented | `docs/evidence/verification.md` | link to the row |
| Open work not yet started | `docs/evidence/backlog.md` | cite `BL-####` |
| State of the client repositories | `README.md` | link to it |
| Standing instruction for future runs | `docs/evidence/retro.md` | cite the numbered instruction |
| Documentation navigation | `README.md` | links only |

## Матрица распространения изменений

| Change type | Update these | Checked by |
|---|---|---|
| New document or rule | `README.md`, `docs/DOCMAP.md` | `scripts/check-docs.sh` required-file and link checks |
| New or changed decision | `docs/DECISIONS.md` and every path in its consequences | review — semantic impact cannot be inferred reliably |
| Resolved question | `docs/OPEN_QUESTIONS.md`, `docs/DECISIONS.md`, owning topic document | `scripts/check-docs.sh` status and id checks |
| Product scope | `docs/PRODUCT.md`, decision or open question | review — scope is a product judgement |
| Architecture or domain term | `docs/ARCHITECTURE.md`, relevant decision | review — meaning is not a mechanical property |
| User-visible CLI behaviour | `docs/ux/scenarios.md`, CLI help/tests once code exists | dormant until CLI exists |
| Scenario becomes implemented | `docs/evidence/verification.md`, `README.md` state column | review — a green test is not a satisfied scenario |
| New client repository | `README.md` repository table, `docs/DOCMAP.md` | review |

## Gates

| Gate | Command | When | Blocking |
|---|---|---|---|
| Documentation | `bash scripts/check-docs.sh` | before commit | yes |
| Documentation (CI) | `bash scripts/check-docs.sh` via `.github/workflows/docs.yml` | every push and pull request | yes |

Проверка подтверждает наличие канонических файлов, ссылки навигации, формат
идентификаторов и закрытый словарь статусов. Она не доказывает корректность
архитектуры, криптографии или полноту сценариев.

## Термины

| Term | Definition |
|---|---|
| Identity | `docs/ARCHITECTURE.md#identity` |
| Device / Node | `docs/ARCHITECTURE.md#device--node` |
| Space | `docs/ARCHITECTURE.md#space` |
| Event | `docs/ARCHITECTURE.md#event` |
| Replica | `docs/ARCHITECTURE.md#replica` |
