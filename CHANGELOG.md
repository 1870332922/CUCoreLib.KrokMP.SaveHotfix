# Changelog

## 1.0.1

- 修复 1.0.0 发布包中无效的 `BepInPlugin` 运行时元数据问题。
- 保持已验证的插件 GUID、显示名称、程序集身份和核心补丁逻辑不变。
- 仅将 BepInEx 插件版本及日志版本更新为 `1.0.1`。

## 1.0.0

- 正式项目名称改为 `CUCoreLib.KrokMP.SaveHotfix`。
- 插件版本改为 `1.0.0`；CLR 程序集身份保持为 `3.0.0.0`。
- 保留实测通过版本的 BepInEx GUID、显示名、内部程序集身份、命名空间和核心补丁逻辑。
- 发布 DLL 文件名简化为 `CUCoreLib.KrokMP.SaveHotfix.dll`。
- 安装脚本自动清理旧热修复 DLL 和 BepInEx 缓存，避免重复 GUID/旧版本覆盖。
- 多人背包隔离与 CUCoreLib 自定义物品保存/载入逻辑保持不变。
