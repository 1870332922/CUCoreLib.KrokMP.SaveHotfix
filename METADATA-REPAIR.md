# Metadata repair verification

Version 1.0.1 retains the CLR `CustomAttribute` table repair required for Mono runtime reflection.

The invalid build stored the two custom-attribute rows with encoded Parent values in this order:

```text
67, 39
```

The repaired DLL stores them in ascending order:

```text
39, 67
```

The `BepInPlugin` attribute remains attached to `CUCoreLibKrokMPSaveSystemBypassHotfix.Plugin` and has version `1.0.1`.

No method IL or Harmony/save-bypass logic was changed.
