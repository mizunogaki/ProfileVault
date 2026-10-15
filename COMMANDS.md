# Console Commands — Graphics Settings

A curated list of console commands for fine-tuning graphics in WoW Forever beyond the in-game menu limits.

> **Note:** Values and CVar names may vary depending on the WoW Forever build. If a command doesn't apply or resets after restart, the client may not support it or the launcher may overwrite the config.

---

## View Distance & Terrain

| Command | Description |
|---|---|
| `/console graphicsViewDistance 9` | **View Distance** — main world render distance. The heaviest setting. Range: 0–9 (menu shows 1–10), default: 5. |
| `/console farclip 10000` | Manual render distance, for when max menu View Distance isn't enough. Set **after** `graphicsViewDistance`, as it overwrites this value. Check current value with `/dump GetCVar("farclip")` — if it's already above 10000, skip this command. Range: 1000–19600, default: 1000. Very heavy on FPS. |
| `/console graphicsEnvironmentDetail 9` | **Environment Detail** — distance at which surrounding objects are visible. Medium load. Range: 0–9, default: 5. |
| `/console graphicsGroundClutter 9` | **Ground Clutter** — density and draw distance of grass and small details. Set this **first**, as the two commands below raise the same value above the menu limit. Range: 0–9, default: 5. |

## Vegetation

| Command | Description |
|---|---|
| `/console groundEffectDensity 256` | Density of ground details: grass, flowers, small rocks, bushes. Heavily impacts FPS in lush zones. Range: 16–256, default: 16 (16 = sparse grass). |
| `/console groundEffectDist 600` | Draw distance for ground details — grass visible far away instead of a ring around the character. High load, especially combined with high density. Minimum: 70, default: 70. Increase gradually and monitor FPS. |

## Water

| Command | Description |
|---|---|
| `/console graphicsLiquidDetail 3` | **Legacy Water Detail** — quality of standard water waves and reflections. 0 = no reflections, 1 = sky only, 2 = screen contents, 3 = all objects. Range: 0–3, default: 2. |
| `/console waterDetail 3` | Engine-level detail for the same legacy water surface. Set **after** `graphicsLiquidDetail` so the menu doesn't overwrite it. Range: 0–3, default: 0. |
| `/console graphicsPBRLiquidDetail 2` | **Physically Based Rendering Water** — WoW Forever's new water with realistic reflections and flow. 0 = low-res reflections, 1 = high-res + flow, 2 = ultra. Range: 0–2, default: 1. Only works if your GPU supports it (the menu option appears in that case). |

## Sky

| Command | Description |
|---|---|
| `/console SkyCloudLOD 3` | Cloud texture resolution — higher = more detailed clouds. Low load. Range: 0–3, default: 0. |

---

## Recommended Apply Order

Enter commands in this order so settings don't overwrite each other:

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

## Presets

### Maximum Beauty
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

### Balanced
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

### Maximum FPS
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

*Part of the [ProfileVault](https://github.com/mizunogaki/ProfileVault) project.*
