#!/data/data/com.termux/files/usr/bin/bash -e

# ============================================
# termux-dsh-in-armv7l
# 在 Termux (armv7l) 上尝试安装 dsh
# ============================================

VERSION="0.1.0"

# 颜色
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
reset='\033[0m'

log() {
    case "$1" in
        "INFO")  echo -e "${blue}[信息]${reset} $2" ;;
        "WARN")  echo -e "${yellow}[警告]${reset} $2" ;;
        "ERROR") echo -e "${red}[错误]${reset} $2" ;;
        "OK")    echo -e "${green}[成功]${reset} $2" ;;
        *)       echo "[$1] $2" ;;
    esac
}

# 检查命令是否存在
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# 检查架构
check_arch() {
    log "INFO" "检查设备架构..."
    ARCH=$(uname -m)
    log "INFO" "当前架构: $ARCH"
    
    if [ "$ARCH" != "armv7l" ]; then
        log "WARN" "此脚本专为 armv7l 优化，当前架构是 $ARCH"
        log "WARN" "可能仍能运行，但不保证兼容性"
    fi
}

# 安装依赖
install_dependencies() {
    log "INFO" "检查并安装依赖..."
    
    # 更新源
    apt update -y || log "WARN" "apt update 失败，继续尝试..."
    
    # 检查 Node.js
    if command_exists node; then
        log "OK" "Node.js 已安装: $(node --version)"
    else
        log "WARN" "Node.js 未安装，正在安装..."
        apt install -y nodejs-lts || {
            log "ERROR" "Node.js 安装失败，请手动安装: pkg install nodejs-lts"
            exit 1
        }
    fi
    
    # 检查 npm
    if command_exists npm; then
        log "OK" "npm 已安装: $(npm --version)"
    else
        log "ERROR" "npm 未安装，请检查 Node.js 安装"
        exit 1
    fi
}

# 安装 dsh
install_dsh() {
    log "INFO" "开始安装 @deepseek-ai/dsh..."
    
    # 设置 npm 镜像（可选）
    # npm config set registry https://registry.npmmirror.com
    
    npm install -g @deepseek-ai/dsh
    
    if [ $? -eq 0 ]; then
        log "OK" "dsh 安装成功！"
        log "INFO" "运行: dsh web"
    else
        log "ERROR" "dsh 安装失败"
        echo ""
        echo "可能的原因："
        echo "  1. 架构不兼容 (armv7l 可能缺少预编译包)"
        echo "  2. 网络问题"
        echo "  3. 缺少编译工具 (pkg install clang make python)"
        echo ""
        log "INFO" "尝试安装编译工具后重试..."
        apt install -y clang make python
        npm install -g @deepseek-ai/dsh || {
            log "ERROR" "重试失败，请查看上方错误信息"
            exit 1
        }
    fi
}

# 主流程
main() {
    echo ""
    echo "============================================"
    echo "  termux-dsh-in-armv7l"
    echo "  版本: $VERSION"
    echo "  四年级 · 电视 Termux · 折腾记录"
    echo "============================================"
    echo ""
    
    check_arch
    install_dependencies
    install_dsh
    
    echo ""
    log "OK" "安装流程完成！"
    echo ""
    echo "如果安装成功，运行: dsh web"
    echo "如果失败，欢迎提交 Issue："
    echo "  https://github.com/gr12-cmd/termux-dsh-in-armv7l/issues"
}

main "$@"