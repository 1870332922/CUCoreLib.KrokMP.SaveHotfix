// SPDX-License-Identifier: LGPL-3.0-only
using System;
using System.Collections;
using System.Reflection;
using BepInEx;
using HarmonyLib;
using UnityEngine;

namespace CUCoreLibKrokMPSaveSystemBypassHotfix
{
    [BepInPlugin(
        "net.cucorelib.krokmp.savesystembypass.hotfix",
        "CUCoreLib KrokMP SaveSystem Bypass Hotfix",
        "1.0.0")]
    public sealed class Plugin : BaseUnityPlugin
    {
        private void Start()
        {
            Type saveSystem = Type.GetType("SaveSystem, Assembly-CSharp", false);
            if (saveSystem == null)
            {
                Debug.LogError("[CUCoreLib KrokMP SaveSystem Bypass 1.0.0] SaveSystem type not found; no patches were removed.");
                return;
            }

            const BindingFlags allMethods = BindingFlags.Public | BindingFlags.NonPublic |
                                            BindingFlags.Static | BindingFlags.Instance;
            MethodInfo saveGame = saveSystem.GetMethod("SaveGame", allMethods);
            MethodInfo tryLoadGame = saveSystem.GetMethod("TryLoadGame", allMethods);
            var harmony = new Harmony("net.cucorelib.krokmp.savesystembypass.hotfix");

            // SaveGame only has CUCoreLib's unsafe extension-payload postfix.
            if (saveGame != null)
                harmony.Unpatch(saveGame, HarmonyPatchType.All, "net.cucorelib");

            // Remove the unsafe restore prefix only. This intentionally preserves
            // SaveSystemCustomItemLoadPatch.Transpiler, which resolves CUCoreLib items.
            // The remaining CUCoreLib postfix is harmless after PendingRestore is cleared.
            if (tryLoadGame != null)
                harmony.Unpatch(tryLoadGame, HarmonyPatchType.Prefix, "net.cucorelib");

            DisableSaveSnapshotModule();
            ClearPendingRestore();

            if (saveGame != null && tryLoadGame != null)
                Debug.Log("[CUCoreLib KrokMP SaveSystem Bypass 1.0.0] Removed bad net.cucorelib Harmony patches from SaveSystem.SaveGame and TryLoadGame; disabled the CUCoreLib save snapshot module.");
            else
                Debug.LogWarning("[CUCoreLib KrokMP SaveSystem Bypass 1.0.0] SaveGame or TryLoadGame was not found. Check game/mod versions.");
        }

        private static void DisableSaveSnapshotModule()
        {
            Type registry = Type.GetType("CUCoreLib.Networking.MultiplayerSyncRegistry, CUCoreLib", false);
            if (registry == null) return;
            const BindingFlags flags = BindingFlags.Static | BindingFlags.NonPublic;
            foreach (string fieldName in new[] { "CaptureModules", "ApplyModules" })
            {
                IDictionary modules = registry.GetField(fieldName, flags)?.GetValue(null) as IDictionary;
                modules?.Remove("save");
            }
            registry.GetField("_cachedSnapshot", flags)?.SetValue(null, null);
        }

        private static void ClearPendingRestore()
        {
            Type coordinator = Type.GetType("CUCoreLib.Saving.SaveCoordinator, CUCoreLib", false);
            coordinator?.GetMethod("ClearPendingRestore",
                BindingFlags.Static | BindingFlags.NonPublic)?.Invoke(null, null);
        }
    }
}
