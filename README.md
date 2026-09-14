# Underline

Underline — local-first протокол общения и социальная сеть для друзей. Данные
принадлежат пользователям, хранятся на их устройствах и передаются только тем
участникам, с которыми существует общее пространство.

Проект находится на стадии архитектурного прототипа. По DEC-0003 первый
исполняемый клиент будет CLI на Rust; по DEC-0002 криптографический слой групп
строится на OpenMLS; по DEC-0005 Underline Chat строится на Tauri.

Этот репозиторий — спецификация и решения. Кода протокола здесь нет.

## Репозитории

| Репозиторий | Роль | Состояние |
|---|---|---|
| [ssheleg/underline](https://github.com/ssheleg/underline) | спецификация, архитектура, реестры решений и вопросов | этот репозиторий |
| [ssheleg/underline-cli](https://github.com/ssheleg/underline-cli) | терминальный клиент на Rust (DEC-0003) | каркас команд; протокольный слой не реализован |
| [ssheleg/underline-chat](https://github.com/ssheleg/underline-chat) | desktop-клиент на Tauri (DEC-0005) | каркас приложения; протокольный слой не реализован |

Ни один клиент пока не выполняет сценарии из [docs/ux/scenarios.md](docs/ux/scenarios.md):
оба репозитория содержат проверяемый каркас, а не работающий протокол. Что именно
не сделано, перечислено в [docs/evidence/verification.md](docs/evidence/verification.md).

## Документация

- [Описание продукта](docs/PRODUCT.md)
- [Архитектура](docs/ARCHITECTURE.md)
- [Сценарии CLI-прототипа](docs/ux/scenarios.md)
- [Принятые решения](docs/DECISIONS.md)
- [Открытые вопросы](docs/OPEN_QUESTIONS.md)
- [Карта документации](docs/DOCMAP.md)

## Безопасность

- [Модель угроз](docs/security/threat-model.md) — атаки по сценариям, правовые
  рычаги, ранжирование по (вероятность × ущерб) / стоимость
- [Метаданные и транспорт](docs/security/metadata.md)
- [Измерения MLS](docs/research/2026-09-14-mls-measurements.md) и
  [хранение ключей](docs/research/2026-09-14-key-custody.md)

Двенадцать решений DEC-0006…DEC-0017 имеют статус `Proposed`: они предложены с
обоснованием, но не приняты, и реализовывать их до принятия нельзя.

## Рабочие реестры

- [Доска задач](docs/evidence/backlog.md)
- [Реестр проверок](docs/evidence/verification.md)
- [Передача работы](docs/HANDOFF.md)
- [Ретроспектива и постоянные инструкции](docs/evidence/retro.md)

## Проверка документации

По DEC-0001 перед коммитом документация проверяется командой:

```sh
bash scripts/check-docs.sh
```

Та же команда выполняется в CI при каждом push и pull request —
[.github/workflows/docs.yml](.github/workflows/docs.yml).

## Лицензия

[MIT](LICENSE) © ssheleg
