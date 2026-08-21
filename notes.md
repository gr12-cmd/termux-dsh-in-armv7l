# 踩坑记录

## 2026-08-21

### 目标
在小米电视 A43（armv7l）Termux 上安装 `@deepseek-ai/dsh`

### 操作
1. 克隆仓库 `termux-dsh-in-armv7l`
2. 运行 `./scripts/install.sh`

### 结果
安装失败，报错：
```
E: Write error - write (28: No space left on device)
npm error code ENOSPC
npm error syscall write
npm error errno -28
npm error nospc ENOSPC: no space left on device, write
npm error nospc There appears to be insufficient space on your system to finish.
npm error nospc Clear up some disk space and try again.
npm error A complete log of this run can be found in: /data/data/com.termux/files/home/.npm/_logs/2026-08-21T03_34_14_218Z-debug-0.log
```

### 原因分析
- 电视可用存储空间：216MB
- dsh 及其依赖（sharp、node-pty 等）在编译时需要额外空间
- 预估需要：至少 300MB 以上

### 解决方案（待执行）
1. 清理 npm 缓存：`npm cache clean --force`
2. 清理 Termux 包缓存：`pkg clean`
3. 删除无用的大文件（如旧 rootfs 镜像）
4. 腾出空间后重试

### 备注
- 设备：小米电视 A43
- 架构：armv7l
- Termux：0.118.0
- 记录人：fireblb（四年级）