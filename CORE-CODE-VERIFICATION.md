# Core Code Verification

Baseline: user-tested `CUCoreLib.KrokMP.SelectiveSaveHotfix 4.0.0`.

## Result

**PASS — every managed method body is byte-for-byte identical to the tested baseline.**

| Method | Baseline SHA-256 | 1.0.0 SHA-256 | Identical |
|---|---|---|---|
| `.ctor` | `ec7b7435e2383fa194ac2ff064bdf8f877a687944aba9dc5fc1dbea2ebed4193` | `ec7b7435e2383fa194ac2ff064bdf8f877a687944aba9dc5fc1dbea2ebed4193` | Yes |
| `Start` | `0c42d6dd88e5754db4759bd5aa08a7debc51507e037e2f262d4d019ba8677f49` | `0c42d6dd88e5754db4759bd5aa08a7debc51507e037e2f262d4d019ba8677f49` | Yes |

## Intentionally changed metadata

- BepInEx plugin version: `4.0.0` → `1.0.0`.
- CLR assembly version: `3.0.0.0` → `1.0.0.0`.
- User-facing log version: `4.0.0` → `1.0.0`.
- External release filename: `CUCoreLib.KrokMP.SaveHotfix.dll`.

## Preserved runtime identity

- BepInEx GUID: `net.cucorelib.krokmp.savesystembypass.hotfix`.
- BepInEx display name: `CUCoreLib KrokMP SaveSystem Bypass Hotfix`.
- Internal CLR assembly name: `CUCoreLib.KrokMP.SaveSystemBypassHotfix`.
- Module name: `CUCoreLib.KrokMP.SaveSystemBypassHotfix.dll`.
- Namespace: `CUCoreLibKrokMPSaveSystemBypassHotfix`.

Binary patch counts: ASCII version=1, UTF-16 log version=3.
