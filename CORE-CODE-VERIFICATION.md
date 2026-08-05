# Core code verification

Release: `CUCoreLib.KrokMP.SaveHotfix 1.0.1`

The release DLL changes only four equal-length version-string characters relative to the metadata-repaired build:

- one UTF-8 `BepInPlugin` version string;
- three UTF-16 log-message version strings.

No method body, Harmony operation, save-bypass logic, plugin GUID, display name, namespace, assembly identity, metadata-table row, or custom-attribute association was changed.

The repaired `CustomAttribute` table ordering remains:

```text
39, 67
```

The CLR assembly identity remains `3.0.0.0`. The public BepInEx plugin and release version is `1.0.1`.
