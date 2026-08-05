# Core code verification

Release: `CUCoreLib.KrokMP.SaveHotfix 1.0.1`

The 1.0.1 release DLL was produced from the corrected, working 1.0.0 DLL by equal-length replacement of version strings only:

- one UTF-8 `BepInPlugin` version string: `1.0.0` → `1.0.1`;
- three UTF-16 log-message version strings: `1.0.0` → `1.0.1`.

No method body, Harmony operation, plugin GUID, display name, namespace, type definition, custom-attribute association, metadata-table layout, or assembly identity was changed.

The CLR assembly identity remains `3.0.0.0`, matching the tested working binary. The public BepInEx plugin/release version is `1.0.1`.
