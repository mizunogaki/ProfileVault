# Консольные команды — настройки графики

Подборка консольных команд для тонкой настройки графики в WoW Forever за пределами лимитов игрового меню.

[English](COMMANDS.md) | Русский

> **Примечание:** Названия CVar и диапазоны значений могут отличаться в зависимости от сборки WoW Forever. Если команда не применяется или сбрасывается после перезапуска, вероятно, клиент её не поддерживает либо лаунчер перезаписывает конфигурацию.

---
# Полный гайд по графике WoW Forever

Гайд разбит на четыре блока: **ландшафт и вода**, **тени и объёмное освещение**, **свет и эффекты**, **текстуры и постобработка**. Команды можно вводить по очереди, чтобы понять, какой именно блок сильнее всего влияет на FPS и качество картинки.

> **Важно:** часть команд может отсутствовать или работать иначе на конкретной сборке WoW Forever. Если команда не дала эффекта или параметра нет в меню — не используй её.

***

## 1. Дальность, трава и вода

Этот блок отвечает за то, **сколько мира рисуется**: дальность обзора, объекты, трава, вода и облака. Обычно он сильнее всего влияет на FPS в открытых локациях и во время полёта.

### Видимость и ландшафт

```text
/console graphicsViewDistance 9
```

**Видимость.** Основная дальность прорисовки мира.

- Диапазон: `0–9`
- В меню: `1–10`
- По умолчанию: `5`
- Нагрузка: высокая

```text
/console farclip 10000
```

**Ручная дальность обзора.** Используй, только если максимума `graphicsViewDistance` недостаточно.

Ставить **после** `graphicsViewDistance`, потому что пресет видимости может перезаписать это значение.

Проверить текущее значение:

```text
/dump GetCVar("farclip")
```

- Диапазон: `1000–19600`
- По умолчанию: `1000`
- `10000` — хороший максимум для мощного ПК
- `19600` — экстремальное значение, может сильно снизить FPS

```text
/console graphicsEnvironmentDetail 9
```

**Детализация ландшафта.** Дальность, на которой видны объекты окружения: деревья, строения, скалы и декорации.

- Диапазон: `0–9`
- По умолчанию: `5`
- Нагрузка: средняя

```text
/console graphicsGroundClutter 9
```

**Объекты ландшафта.** Базовая плотность и дальность травы и мелких деталей.

Ставить **до** `groundEffectDensity` и `groundEffectDist`, потому что эти команды могут поднять фактическое значение выше максимума обычного меню.

- Диапазон: `0–9`
- По умолчанию: `5`
- Нагрузка: средняя

### Растительность

```text
/console groundEffectDensity 256
```

**Плотность наземных деталей.** Количество травы, цветов, мелких камней и кустов.

- Диапазон: `16–256`
- По умолчанию: `16`
- `16` — редкая трава
- `256` — очень густая растительность
- Нагрузка: высокая

```text
/console groundEffectDist 400
```

**Дальность прорисовки наземных деталей.** Трава видна дальше, а не появляется кольцом вокруг персонажа.

- Рекомендуемый практический максимум: `400`
- Экспериментальное значение: `600`
- Минимум и значение по умолчанию: `70`
- Нагрузка: высокая

Для большинства систем лучше начинать с `200–300`. Значение `600` стоит использовать только на мощном железе.

### Вода

```text
/console graphicsLiquidDetail 3
```

**Старая детализация воды.** Качество волн и отражений.

- `0` — без отражений
- `1` — отражается небо
- `2` — отражается то, что на экране
- `3` — отражаются все объекты
- Диапазон: `0–3`
- По умолчанию: `2`

```text
/console waterDetail 3
```

**Детализация поверхности воды на уровне движка.** Влияет на сложность и геометрию поверхности воды.

Ставить **после** `graphicsLiquidDetail`, чтобы настройка из меню не перезаписала её.

- Диапазон: `0–3`
- По умолчанию: `0`

```text
/console graphicsPBRLiquidDetail 2
```

**Физически корректный рендеринг воды.** Более новая система воды с реалистичными отражениями и течением.

- `0` — отражения низкого разрешения
- `1` — высокое разрешение и течение
- `2` — ультра
- Диапазон: `0–2`
- По умолчанию: `1`

Работает только при поддержке видеокартой. Если пункта нет в меню — команду лучше не использовать.

### Небо

```text
/console SkyCloudLOD 3
```

**Разрешение текстур облаков.** Чем выше значение, тем детальнее облака.

- Диапазон: `0–3`
- По умолчанию: `0`
- Нагрузка: небольшая

### Макрос: дальность, трава и вода

```text
/console graphicsViewDistance 9
/console graphicsEnvironmentDetail 9
/console graphicsGroundClutter 9
/console groundEffectDensity 256
/console groundEffectDist 400
/console graphicsLiquidDetail 3
/console waterDetail 3
/console graphicsPBRLiquidDetail 2
/console SkyCloudLOD 3
/reload
```

***

## 2. Тени и SSAO

Этот блок отвечает за тени от объектов, персонажей и окружения, а также за объёмное затенение. Тени — одна из самых тяжёлых графических настроек, поэтому при проблемах с FPS начинай оптимизацию именно с неё.

### Тени

```text
/console graphicsShadowQuality 5
```

**Общее качество теней.** Главный пресет теней.

- Чем выше значение, тем детальнее и стабильнее тени
- Нагрузка: очень высокая

```text
/console shadowMode 3
```

**Режим теней.** Определяет, какие тени вообще рассчитываются.

- `3` — полноценные динамические тени
- Более низкие значения упрощают или ограничивают тени
- Нагрузка: высокая

```text
/console shadowTextureSize 2048
```

**Разрешение карты теней.** Чем выше значение, тем чётче тени, но тем больше нагрузка на видеокарту.

- `1024` — производительный вариант
- `2048` — качественный стандарт
- `4096` — очень тяжёлый вариант

```text
/console shadowNumCascades 4
```

**Количество каскадов теней.** Каскады отвечают за качество теней на разных дистанциях: рядом с персонажем и вдалеке.

- `4` — максимум качества
- Меньшее значение снижает нагрузку, но ухудшает тени вдали

```text
/console shadowSoft 1
```

**Мягкие тени.** Делает границы теней менее резкими.

- `0` — выключено
- `1` — включено

```text
/console shadowBlendCascades 1
```

**Смешивание каскадов.** Уменьшает резкие переходы между ближними и дальними тенями.

- `0` — выключено
- `1` — включено

### SSAO

```text
/console graphicsSSAO 4
```

**Объёмное затенение.** Добавляет мягкие тени в углах, у объектов и в местах соприкосновения поверхностей. Делает картинку объёмнее.

- `0` — выключено
- `4` — максимальное качество
- Нагрузка: средняя или высокая

### Макрос: тени и SSAO

```text
/console graphicsShadowQuality 5
/console shadowMode 3
/console shadowTextureSize 2048
/console shadowNumCascades 4
/console shadowSoft 1
/console shadowBlendCascades 1
/console graphicsSSAO 4
/reload
```

***

## 3. Свет, туман, небо и эффекты

Этот блок отвечает за атмосферу: вычислительные эффекты, глубину сцены, солнечные лучи, облака, погоду, частицы и детали боевых эффектов. В основном нагружает видеокарту.

### Свет и эффекты

```text
/console graphicsComputeEffects 4
```

**Вычислительные эффекты.** Современные эффекты, рассчитываемые на видеокарте.

- `0` — выключено
- `4` — максимальное качество
- Нагрузка: высокая

```text
/console graphicsDepthEffects 3
```

**Эффекты глубины.** Влияют на восприятие глубины сцены, туман, дымку и подобные визуальные эффекты.

- Диапазон: `0–3`
- Нагрузка: средняя

```text
/console sunShafts 2
```

**Солнечные лучи.** Добавляет видимые лучи света от солнца.

- `0` — выключено
- `2` — максимальное качество

```text
/console graphicsParticleDensity 5
```

**Плотность частиц.** Количество визуальных частиц: искр, дыма, магии, пыли и других эффектов.

- `0` — минимум
- `5` — максимум
- Нагрузка: высокая в бою

```text
/console weatherDensity 3
```

**Плотность погодных эффектов.** Дождь, снег, пыль и другие погодные частицы.

- `0` — минимум
- `3` — максимум

```text
/console violenceLevel 5
```

**Уровень визуальной детализации боевых эффектов.** Влияет на насыщенность и количество эффектов в бою.

- `0` — минимум
- `5` — максимум

### Макрос: свет, туман, небо и эффекты

```text
/console graphicsComputeEffects 4
/console graphicsDepthEffects 3
/console sunShafts 2
/console SkyCloudLOD 3
/console waterDetail 3
/console graphicsParticleDensity 5
/console weatherDensity 3
/console violenceLevel 5
/reload
```

> `SkyCloudLOD` и `waterDetail` уже описаны в первом блоке. Здесь они повторяются, потому что входят в общий пресет атмосферы.

***

## 4. Текстуры, сглаживание и подсветка

Этот блок не добавляет новые объекты или эффекты, а улучшает качество уже нарисованной картинки: чёткость текстур, сглаживание, освещение и резкость. Текстуры в первую очередь расходуют видеопамять, а сглаживание и резкость — ресурсы постобработки.

### Текстуры

```text
/console graphicsTextureResolution 2
```

**Разрешение текстур.** Качество поверхностей объектов, земли, одежды и окружения.

- Чем выше значение, тем чётче текстуры
- Нагрузка: в первую очередь на VRAM

```text
/console textureFilteringMode 5
```

**Анизотропная фильтрация.** Сохраняет чёткость текстур, когда ты смотришь на них под углом: дорогу, пол, стены, землю.

- `0` — выключено
- `5` — максимальное качество
- Нагрузка: обычно небольшая

### Сглаживание

```text
/console ffxAntiAliasingMode 4
```

**Сглаживание FFX.** Убирает «лесенку» на краях объектов.

- `0` — выключено
- Более высокие значения — более качественное сглаживание
- Нагрузка: средняя

### Освещение и подсветка

```text
/console graphicsLightMode 2
```

**Модель освещения.** Определяет общий стиль и качество света в мире.

- Более высокие значения дают более современную картинку
- Нагрузка: средняя или высокая

```text
/console graphicsProjectedTextures 1
```

**Проецируемые текстуры.** Добавляет декали, световые пятна, тени от объектов и подобные детали.

- `0` — выключено
- `1` — включено

```text
/console ResampleAlwaysSharpen 1
```

**Постоянное повышение резкости.** Применяет sharpening после масштабирования изображения.

- `0` — выключено
- `1` — включено

```text
/console ResampleSharpness 0.7
```

**Сила резкости.** Работает вместе с `ResampleAlwaysSharpen`.

- `0.0` — без усиления
- `0.7` — заметное, но обычно не чрезмерное повышение резкости
- Слишком высокое значение может дать «перешарп» и артефакты

### Макрос: текстуры, сглаживание и подсветка

```text
/console graphicsTextureResolution 2
/console textureFilteringMode 5
/console ffxAntiAliasingMode 4
/console graphicsLightMode 2
/console graphicsProjectedTextures 1
/console ResampleAlwaysSharpen 1
/console ResampleSharpness 0.7
/reload
```

***

## Рекомендуемый порядок применения

Вводи блоки именно в таком порядке:

1. **Дальность, трава и вода** — задаёт, сколько мира будет нарисовано.
2. **Тени и SSAO** — определяет освещение и одну из самых тяжёлых частей картинки.
3. **Свет, туман, небо и эффекты** — добавляет атмосферу поверх мира и теней.
4. **Текстуры, сглаживание и подсветка** — улучшает финальное изображение.

Так проще найти причину просадки FPS:

- Просадка после первого блока — виноваты дальность, трава или вода.
- После второго — тени или SSAO.
- После третьего — эффекты, погода или частицы.
- После четвёртого — текстуры, VRAM или сглаживание.

***

## Дополнительные настройки

Эти команды лучше вводить отдельно, а не добавлять в общие макросы: они могут очень сильно повлиять на FPS или конфликтовать с другими параметрами.

```text
/console RenderScale 1.0
```

**Внутреннее разрешение рендера.**

- `1.0` — нативное разрешение
- Меньше `1.0` — больше FPS, но картинка менее чёткая
- Больше `1.0` — выше чёткость, но сильнее нагрузка

```text
/console shadowRt 1
```

**Трассировка теней.** Может дать более реалистичные тени, но требует современной видеокарты и сильно снижает FPS.

- `0` — выключено
- `1` — включено

```text
/console physicsLevel 5
```

**Уровень физики.** Влияет на сложность физических эффектов.

```text
/console graphicsSpellDensity 5
```

**Плотность заклинаний и боевых эффектов.** Особенно важна в рейдах, аренах и массовом PvP.

- `0` — минимум эффектов
- `5` — максимум

***

## Готовые пресеты

### Максимальная красота

Для мощных ПК. Сохраняет высокую детализацию без экстремального `farclip`.

```text
/console graphicsViewDistance 9
/console farclip 10000
/console graphicsEnvironmentDetail 9
/console graphicsGroundClutter 9
/console groundEffectDensity 256
/console groundEffectDist 400
/console graphicsLiquidDetail 3
/console waterDetail 3
/console graphicsPBRLiquidDetail 2
/console SkyCloudLOD 3

/console graphicsShadowQuality 5
/console shadowMode 3
/console shadowTextureSize 2048
/console shadowNumCascades 4
/console shadowSoft 1
/console shadowBlendCascades 1
/console graphicsSSAO 4

/console graphicsComputeEffects 4
/console graphicsDepthEffects 3
/console sunShafts 2
/console graphicsParticleDensity 5
/console weatherDensity 3
/console violenceLevel 5

/console graphicsTextureResolution 2
/console textureFilteringMode 5
/console ffxAntiAliasingMode 4
/console graphicsLightMode 2
/console graphicsProjectedTextures 1
/console ResampleAlwaysSharpen 1
/console ResampleSharpness 0.7
/reload
```

### Баланс

Хороший вариант для большинства систем: красивая картинка без максимальной нагрузки.

```text
/console graphicsViewDistance 7
/console graphicsEnvironmentDetail 7
/console graphicsGroundClutter 7
/console groundEffectDensity 128
/console groundEffectDist 300
/console graphicsLiquidDetail 2
/console waterDetail 1
/console graphicsPBRLiquidDetail 1
/console SkyCloudLOD 2

/console graphicsShadowQuality 3
/console shadowMode 2
/console shadowTextureSize 1024
/console shadowNumCascades 3
/console shadowSoft 1
/console shadowBlendCascades 1
/console graphicsSSAO 2

/console graphicsComputeEffects 2
/console graphicsDepthEffects 2
/console sunShafts 1
/console graphicsParticleDensity 3
/console weatherDensity 2
/console violenceLevel 3

/console graphicsTextureResolution 1
/console textureFilteringMode 4
/console ffxAntiAliasingMode 2
/console graphicsLightMode 1
/console graphicsProjectedTextures 1
/console ResampleAlwaysSharpen 1
/console ResampleSharpness 0.5
/reload
```

### Максимальный FPS

Для слабых ПК, рейдов, арен и массового PvP.

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

/console graphicsShadowQuality 0
/console shadowMode 0
/console shadowTextureSize 512
/console shadowNumCascades 1
/console shadowSoft 0
/console shadowBlendCascades 0
/console graphicsSSAO 0

/console graphicsComputeEffects 0
/console graphicsDepthEffects 0
/console sunShafts 0
/console graphicsParticleDensity 1
/console weatherDensity 0
/console violenceLevel 0

/console graphicsTextureResolution 0
/console textureFilteringMode 1
/console ffxAntiAliasingMode 0
/console graphicsLightMode 0
/console graphicsProjectedTextures 0
/console ResampleAlwaysSharpen 0
/console ResampleSharpness 0.0
/reload
```

***

## Сохранение профилей в ProfileVault

Перед экспериментами сохрани текущие настройки:

```text
/pv save before-graphics
/reload
```

После настройки желаемого пресета:

```text
/pv save graphics-ultra
/reload
```

Вернуть сохранённый профиль:

```text
/pv load before-graphics
/reload
```

Рекомендуемые названия профилей:

- `landscape-ultra` — дальность, трава, вода
- `shadows-ultra` — тени и SSAO
- `effects-ultra` — свет, погода и эффекты
- `image-ultra` — текстуры, сглаживание и резкость
- `raid-fps` — максимальный FPS для рейдов
- `pvp-fps` — максимальный FPS для PvP

***

## Как откатить настройки

Если после изменений стало хуже, верни базовые значения:

```text
/console graphicsViewDistance 5
/console farclip 1000
/console graphicsEnvironmentDetail 5
/console graphicsGroundClutter 5
/console groundEffectDensity 16
/console groundEffectDist 70
/console graphicsLiquidDetail 2
/console waterDetail 0
/console graphicsPBRLiquidDetail 1
/console SkyCloudLOD 0

/console graphicsShadowQuality 0
/console shadowMode 0
/console shadowTextureSize 512
/console shadowNumCascades 1
/console shadowSoft 0
/console shadowBlendCascades 0
/console graphicsSSAO 0

/console graphicsComputeEffects 0
/console graphicsDepthEffects 0
/console sunShafts 0
/console graphicsParticleDensity 1
/console weatherDensity 0
/console violenceLevel 0

/console graphicsTextureResolution 0
/console textureFilteringMode 1
/console ffxAntiAliasingMode 0
/console graphicsLightMode 0
/console graphicsProjectedTextures 0
/console ResampleAlwaysSharpen 0
/console ResampleSharpness 0.0
/reload
```

Если `graphicsPBRLiquidDetail` или `shadowRt` не поддерживаются твоей видеокартой, просто пропусти эти команды.

*Часть проекта [ProfileVault](https://github.com/mizunogaki/ProfileVault).*
