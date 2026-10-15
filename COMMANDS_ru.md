# Консольные команды — настройки графики

Подборка консольных команд для тонкой настройки графики в WoW Forever за пределами лимитов игрового меню.

> **Примечание:** Названия CVar и диапазоны значений могут отличаться в зависимости от сборки WoW Forever. Если команда не применяется или сбрасывается после перезапуска, вероятно, клиент её не поддерживает либо лаунчер перезаписывает конфигурацию.

---

## Видимость и ландшафт

| Команда | Описание |
|---|---|
| `/console graphicsViewDistance 9` | **Видимость** — основная дальность обзора: расстояние, на котором мир рисуется полностью. Самая «тяжёлая» настройка. Диапазон: 0–9 (в меню 1–10), по умолчанию: 5. |
| `/console farclip 10000` | Ручная дальность обзора — на случай, если максимума «Видимости» не хватает. Ставить **после** `graphicsViewDistance`, так как та перезаписывает это значение. Проверить текущее значение: `/dump GetCVar("farclip")` — если там больше 10000, команда не нужна. Диапазон: 1000–19600, по умолчанию: 1000. Очень сильно снижает FPS. |
| `/console graphicsEnvironmentDetail 9` | **Детализация ландшафта** — дальность, на которой видны объекты окружения. Нагрузка средняя. Диапазон: 0–9, по умолчанию: 5. |
| `/console graphicsGroundClutter 9` | **Объекты ландшафта** — плотность и дальность травы и мелких деталей. Ставить **первым**, так как две команды ниже поднимают то же значение выше максимума меню. Диапазон: 0–9, по умолчанию: 5. |

## Растительность

| Команда | Описание |
|---|---|
| `/console groundEffectDensity 256` | Плотность наземных деталей: трава, цветы, мелкие камни, кустики. Сильно влияет на FPS в локациях с густой растительностью. Диапазон: 16–256, по умолчанию: 16 (16 — редкая трава). |
| `/console groundEffectDist 600` | Дальность прорисовки наземных деталей — трава видна вдалеке, а не появляется кольцом вокруг персонажа. Нагрузка высокая, особенно вместе с высокой плотностью. Минимум: 70, по умолчанию: 70. Поднимайте постепенно и следите за FPS. |

## Вода

| Команда | Описание |
|---|---|
| `/console graphicsLiquidDetail 3` | **Старая детализация воды** — качество обычной воды, её волн и отражений. 0 — без отражений, 1 — отражается небо, 2 — отражается то, что на экране, 3 — отражаются все объекты. Диапазон: 0–3, по умолчанию: 2. |
| `/console waterDetail 3` | Детализация поверхности той же старой воды на уровне движка. Ставить **после** `graphicsLiquidDetail`, чтобы пункт меню её не перезаписал. Диапазон: 0–3, по умолчанию: 0. |
| `/console graphicsPBRLiquidDetail 2` | **Физически корректный рендеринг воды** — новая вода WoW Forever с реалистичными отражениями и течением. 0 — отражения низкого разрешения, 1 — высокое разрешение + течение, 2 — ультра. Диапазон: 0–2, по умолчанию: 1. Работает только если видеокарта поддерживает (тогда пункт есть в меню). |

## Небо

| Команда | Описание |
|---|---|
| `/console SkyCloudLOD 3` | Разрешение текстур облаков — чем выше, тем детальнее облака. Нагрузка небольшая. Диапазон: 0–3, по умолчанию: 0. |

---

## Рекомендуемый порядок применения

Вводите команды в таком порядке, чтобы настройки не перезаписывали друг друга:

```text
/console graphicsViewDistance 9
/console farclip 10000
/console graphicsEnvironmentDetail 9
/console graphicsGroundClutter 9
/console groundEffectDensity 256
/console groundEffectDist 600
/console graphicsLiquidDetail 3
/console waterDetail 3
/console graphicsPBRLiquidDetail 2
/console SkyCloudLOD 3
/reload
```

## Готовые пресеты

### Максимальная красота
```text
/console graphicsViewDistance 9
/console farclip 19600
/console graphicsEnvironmentDetail 9
/console graphicsGroundClutter 9
/console groundEffectDensity 256
/console groundEffectDist 600
/console graphicsLiquidDetail 3
/console waterDetail 3
/console graphicsPBRLiquidDetail 2
/console SkyCloudLOD 3
/reload
```

### Баланс
```text
/console graphicsViewDistance 7
/console graphicsEnvironmentDetail 7
/console graphicsGroundClutter 7
/console groundEffectDensity 128
/console groundEffectDist 300
/console graphicsLiquidDetail 2
/console graphicsPBRLiquidDetail 1
/console SkyCloudLOD 2
/reload
```

### Максимальный FPS
```text
/console graphicsViewDistance 5
/console graphicsEnvironmentDetail 5
/console graphicsGroundClutter 5
/console groundEffectDensity 16
/console groundEffectDist 70
/console graphicsLiquidDetail 1
/console waterDetail 0
/console graphicsPBRLiquidDetail 0
/console SkyCloudLOD 0
/reload
```

---

*Часть проекта [ProfileVault](https://github.com/mizunogaki/ProfileVault).*
