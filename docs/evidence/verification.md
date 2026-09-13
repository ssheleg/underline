# Реестр проверок — Underline

Реестр отвечает на один вопрос: **что здесь доказано, а что только написано.**
Строка со статусом `never` означает, что изменение поставлено, но человек его не
подтверждал; такие строки не исчезают сами.

## Сценарии протокола

Ни один сценарий из [docs/ux/scenarios.md](../ux/scenarios.md) пока не выполнен.
Это не оговорка в документе, а состояние проекта на 2026-09-14.

| Сценарий | Состояние | Чем подтверждено | Разблокирует |
|---|---|---|---|
| SCN-001 создать локальную ноду | частично | `underline init` создаёт каталог `0700` и запись `0600` — тесты `state_directory_is_readable_only_by_its_owner`, `node_record_is_readable_only_by_its_owner`; идентичность и fingerprint не создаются | OQ-0006 |
| SCN-002 создать пространство и приглашение | не реализован | `space create`, `invite export` завершаются кодом 3 — тест `unimplemented_commands_exit_with_code_three` | DEC-0002 |
| SCN-003 вступить и обменяться сообщениями | не реализован | `invite accept`, `send`, `read` завершаются кодом 3 — тот же тест | DEC-0002 |
| SCN-004 догнать пропущенную историю | не реализован | `sync` завершается кодом 3 — тот же тест | OQ-0001 |
| SCN-005 отказать посторонней ноде | не реализован | `peer list` завершается кодом 3 — тот же тест | OQ-0001 |

## Инварианты, которые уже сторожатся тестами

| Инвариант | Где проверяется | Проверен подсаженным дефектом |
|---|---|---|
| Нереализованная команда не печатает в `stdout` | `underline-cli/tests/cli_surface.rs::unimplemented_commands_never_write_to_stdout` | да — `sync`, печатающий «синхронизация завершена успешно», роняет тест |
| Нереализованная команда не сообщает об успехе словами | `underline-cli/tests/cli_surface.rs::unimplemented_commands_never_claim_success` | да — тот же дефект |
| Отказ несёт сценарий и блокирующую запись реестра | `underline-cli/tests/cli_surface.rs::unimplemented_commands_exit_with_code_three` | да — тот же дефект |
| Повреждённая запись ноды не выглядит отсутствующей | `underline-cli/tests/node_state.rs::corrupted_node_record_is_an_error_not_a_fresh_node` | нет |
| Имена полей IPC не расходятся с типом TypeScript | `underline-chat/src-tauri/src/lib.rs::fields_cross_the_process_boundary_in_camel_case` | да — снятие `rename_all` роняет тест |
| Интерфейс показывает причину, а не пустой экран | `underline-chat/src/App.test.tsx` | нет |

## Проверки бутстрапа (2026-09-14)

| Что | Команда | Результат |
|---|---|---|
| Гейт документации | `bash scripts/check-docs.sh` | PASS: 7 документов, 5 решений, 7 открытых вопросов |
| Форматирование CLI | `cargo fmt --all -- --check` | чисто |
| Линт CLI | `cargo clippy --all-targets -- -D warnings` | чисто при `clippy::all` и `clippy::pedantic` на уровне deny |
| Тесты CLI | `cargo test` | 24 из 24 (2 модульных, 9 поверхности, 13 состояния) |
| Типы Chat | `npx tsc` | чисто |
| Тесты Chat | `npm test` | 6 из 6 |
| Сборка интерфейса Chat | `npx vite build` | 19 модулей, 221.94 kB |
| Линт нативной части Chat | `cargo clippy --all-targets -- -D warnings` | чисто |
| Тесты нативной части Chat | `cargo test` | 4 из 4 |

## Что не проверено ни разу

| Строка | Почему | Статус |
|---|---|---|
| CI всех трёх репозиториев | воркфлоу написаны, но на GitHub ещё не выполнялись на момент записи | never |
| Сборка `npm run tauri build` | приложение ни разу не собиралось в дистрибутив | never |
| Поведение на Linux | все локальные прогоны выполнены на macOS 25.6 | never |
