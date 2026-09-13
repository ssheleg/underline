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

## CI после первого пуша (2026-09-14)

Семь job'ов в трёх репозиториях, все `success`. Вердикты прочитаны, а не
предположены: `gh api repos/ssheleg/<repo>/actions/runs/<id>/jobs`.

| Репозиторий | Коммит | Job | Вывод |
|---|---|---|---|
| `underline` | `e5c8c47` | documentation gate | success |
| `underline-cli` | `8f1696c` | fmt + clippy | success |
| `underline-cli` | `8f1696c` | test (ubuntu-latest) | success |
| `underline-cli` | `8f1696c` | test (macos-latest) | success |
| `underline-chat` | `1b8ac1c` | typecheck + test + build | success |
| `underline-chat` | `1b8ac1c` | rust (ubuntu-latest) | success |
| `underline-chat` | `1b8ac1c` | rust (macos-latest) | success |

Прогон на `ubuntu-latest` снял часть сомнений о Linux: тесты прав `0700`/`0600`
выполнились там по-настоящему, а не только на macOS.

## Что не проверено ни разу

| Строка | Почему | Статус |
|---|---|---|
| Сборка `npm run tauri build` | приложение ни разу не собиралось в дистрибутив — ни локально, ни в CI | never |
| Путь каталога состояния по умолчанию на Linux | измерен только путь macOS; на Linux он выведен из правил крейта `directories`, а не наблюдался | never |
| Окно Underline Chat на экране | нативная часть компилируется и тестируется, но `npm run tauri dev` человеком не запускался | never |
