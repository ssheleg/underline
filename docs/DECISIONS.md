# Решения — Underline

Реестр ведётся только добавлением. Чтобы изменить решение, нужно создать новое и
связать его с прежним.

**Next free ID:** `DEC-0006`

### DEC-0001 — Документация проекта управляется картой, реестрами и проверкой

- **Date:** 2026-08-30
- **Status:** Accepted
- **Context:** описание проекта и архитектурные договорённости существовали только
  в разговоре.
- **Decision:** канонические документы перечислены в `docs/DOCMAP.md`; решения и
  вопросы имеют стабильные идентификаторы; `scripts/check-docs.sh` выполняется
  перед коммитом.
- **Consequences / affects:** `docs/DOCMAP.md`, `docs/OPEN_QUESTIONS.md`, `README.md`
- **Source:** разговор `underline` · commit `unavailable: repository not initialized`

### DEC-0002 — OpenMLS является криптографическим слоем групп

- **Date:** 2026-08-30
- **Status:** Accepted
- **Context:** протоколу нужны безопасное групповое членство, смена ключей и
  forward secrecy без разработки собственной криптографии.
- **Decision:** группы и личные пространства используют MLS через Rust-библиотеку
  OpenMLS; прикладные события передаются как MLS application messages.
- **Consequences / affects:** `docs/ARCHITECTURE.md`, `docs/PRODUCT.md`, `docs/ux/scenarios.md`
- **Source:** разговор `underline` · commit `unavailable: repository not initialized`

### DEC-0003 — Первый исполняемый клиент создаётся как CLI на Rust

- **Date:** 2026-08-30
- **Status:** Accepted
- **Context:** до графического клиента нужно проверить идентичности, MLS-группу,
  локальное хранение и синхронизацию между двумя процессами.
- **Decision:** первый вертикальный срез — Rust CLI; команды строятся на Clap, а
  Ratatui добавляется после работающего сквозного обмена.
- **Consequences / affects:** `README.md`, `docs/PRODUCT.md`, `docs/ARCHITECTURE.md`, `docs/ux/scenarios.md`
- **Source:** разговор `underline` · commit `unavailable: repository not initialized`

### DEC-0004 — Прикладной протокол не зависит от транспорта

- **Date:** 2026-08-30
- **Status:** Accepted
- **Context:** OpenMLS не решает peer discovery, NAT traversal, relay и доставку, а
  выбор mesh-библиотеки ещё не завершён.
- **Decision:** события, MLS и репликация зависят от внутреннего transport interface,
  но не от Iroh, libp2p или loopback напрямую.
- **Consequences / affects:** `docs/ARCHITECTURE.md`, `docs/OPEN_QUESTIONS.md`
- **Source:** разговор `underline` · commit `unavailable: repository not initialized`

### DEC-0005 — Underline Chat строится как Tauri-приложение с фронтендом на TypeScript и React

- **Date:** 2026-09-13
- **Status:** Accepted
- **Context:** `docs/PRODUCT.md` называет Chat одной из поверхностей протокола, но
  стек клиента не выбран ни одним прежним решением. Репозиторий `underline-chat`
  создаётся сейчас, и молчаливый выбор стека стал бы фактом без решения — ровно
  то, что запрещает DEC-0001.
- **Decision:** Underline Chat — desktop-клиент на Tauri v2: нативная часть на Rust
  в `src-tauri`, интерфейс на TypeScript + React + Vite. Выбор опирается на DEC-0003:
  нода и её криптография уже живут в Rust, и Tauri позволяет переиспользовать их
  вместо второй реализации протокола на другом языке.
- **Consequences / affects:** `README.md`, `docs/PRODUCT.md`, `docs/ARCHITECTURE.md`,
  репозиторий `ssheleg/underline-chat`
- **Source:** разговор `underline` · bootstrap-коммит репозитория `ssheleg/underline`
