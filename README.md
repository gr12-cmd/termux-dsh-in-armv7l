# termux-dsh-in-armv7l

> 四年级 · 电视 Termux · armv7l 上折腾 dsh

## 背景

官方 `@deepseek-ai/dsh` 在 Termux (armv7l) 上安装失败。  
这个仓库记录了我踩过的坑和补丁方案。

## 测试环境

- 设备：小米电视 A43  
- 架构：armv7l  
- 系统：Android TV  
- Termux：0.118.0  
- 编译器：clang（Termux 默认）

## 当前状态

- ✅ 已完成：分析报错原因
- ✅ 已完成：搜集社区补丁方案
- ⏳ 待完成：实测安装流程

## 已知问题

| 问题 | 说明 | 状态 |
|------|------|------|
| `node-pty` | 需要 patch node-gyp | 🟡 待测 |
| `koffi` | `statx()` 问题，需要 target API 30 | 🟡 待测 |
| `sharp` | 无 android-arm64 预编译包 | 🟡 待测 |

## 安装
输入命令：
```bash
pkg install nodejs git
git clone https://github.com/gr12-cmd/termuux-dsh-in-armv7l.git
```
小提示：国内用户可以用`https://ghproxy.net/https://github.com/gr12-cmd/termux-dsh-in-armv7l.git`加速
