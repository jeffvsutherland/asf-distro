#!/bin/bash
# ASF Framework v3.2 — Clean Install Script
# Purpose: Enterprise-grade multi-agent security orchestration
# License: Apache 2.0

set -e

ASF_VERSION="v3.2.0"
ASF_INSTALL_DIR="${HOME}/.asf"
REPO_URL="https://github.com/jeffsutherland/asf-distro.git"

echo "╔══════════════════════════════════════════════════════╗"
echo "║  ASF Framework $ASF_VERSION — Enterprise Install       ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# Check for required tools
check_dependencies() {
    local missing=()
    for cmd in git curl; do
        if ! command -v "$cmd" &> /dev/null; then
            missing+=("$cmd")
        fi
    done
    if [ ${#missing[@]} -ne 0 ]; then
        echo "❌ Missing dependencies: ${missing[*]}"
        echo "   Install with: brew install ${missing[*]}"
        exit 1
    fi
}

# Detect platform
detect_platform() {
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "macOS detected"
        return 0
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${PRETTY_NAME} detected"
        return 0
    fi
    echo "Linux detected (generic)"
    return 0
}

# Create install directory
setup_directories() {
    echo "📁 Setting up ASF installation directory..."
    mkdir -p "$ASF_INSTALL_DIR"
    mkdir -p "${ASF_INSTALL_DIR}/configs"
    mkdir -p "${ASF_INSTALL_DIR}/skills"
    mkdir -p "${HOME}/.config/asf"
    echo "   ✓ Installation directory: $ASF_INSTALL_DIR"
}

# Clone or update repo
install_repo() {
    echo ""
    echo "📦 Installing ASF Framework..."
    if [ -d "${ASF_INSTALL_DIR}/.git" ]; then
        echo "   ↺ Updating existing installation..."
        cd "${ASF_INSTALL_DIR}" && git pull
    else
        echo "   → Cloning ASF repository..."
        git clone "$REPO_URL" "$ASF_INSTALL_DIR"
    fi
    echo "   ✓ ASF Framework installed"
}

# Install configuration files
install_configs() {
    echo ""
    echo "⚙️  Installing configuration files..."
    
    local config_src="${ASF_INSTALL_DIR}/skill-package/configs"
    local config_dest="${HOME}/.config/asf"
    
    if [ -d "$config_src" ]; then
        cp "$config_src/"*.json "$config_dest/" 2>/dev/null || true
    fi
    
    # Create default egress whitelist if none exists
    if [ ! -f "${config_dest}/egress-whitelist.json" ]; then
        cat > "${config_dest}/egress-whitelist.json" << 'EOF'
{
  "version": "1.0",
  "egress_policy": "whitelist",
  "default_action": "deny",
  "rules": [
    {"dest": "api.openai.com", "ports": [443], "tier": "L3"},
    {"dest": "api.anthropic.com", "ports": [443], "tier": "L3"},
    {"dest": "api.x.ai", "ports": [443], "tier": "L3"},
    {"dest": "github.com", "ports": [443], "tier": "L2"},
    {"dest": "docker.io", "ports": [443], "tier": "L2"}
  ],
  "excluded": ["localhost", "127.0.0.1", "0.0.0.0"]
}
EOF
    fi
    
    # Create Docker security config if none exists
    if [ ! -f "${config_dest}/docker-security.json" ]; then
        cat > "${config_dest}/docker-security.json" << 'EOF'
{
  "version": "1.0",
  "security_profile": "enterprise",
  "seccomp": "standard",
  "apparmor": "asf-profile",
  "no_new_privileges": true,
  "read_only_rootfs": false,
  "cap_drop": ["ALL"],
  "cap_add": ["NET_BIND_SERVICE", "CHOWN", "SETGID", "SETUID"],
  "network_mode": "bridge",
  "privileged": false
}
EOF
    fi
    
    # Create credential vault config
    if [ ! -f "${config_dest}/credential-vault.json" ]; then
        cat > "${config_dest}/credential-vault.json" << 'EOF'
{
  "version": "1.0",
  "vault_type": "keychain",
  "credential_sources": ["keychain", "env", "vault"],
  "auto_rotate": false,
  "audit_log": true,
  "hardcoded_creds_detected": "block"
}
EOF
    fi
    
    echo "   ✓ Configuration installed"
}

# Verify installation
verify_installation() {
    echo ""
    echo "🔍 Verifying installation..."
    
    local errors=0
    
    if [ ! -d "$ASF_INSTALL_DIR" ]; then
        echo "   ❌ Installation directory not found"
        ((errors++))
    fi
    
    if [ ! -f "${HOME}/.config/asf/egress-whitelist.json" ]; then
        echo "   ⚠️  Egress whitelist not configured (optional)"
    fi
    
    if [ $errors -eq 0 ]; then
        echo "   ✓ Installation verified"
    else
        echo "   ❌ $errors verification errors"
        return 1
    fi
}

# Print next steps
print_next_steps() {
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║  ✅ ASF Framework $ASF_VERSION installed successfully!     ║"
    echo "╚══════════════════════════════════════════════════════╝"
    echo ""
    echo "Next steps:"
    echo "  1. Review config: vim ${HOME}/.config/asf/egress-whitelist.json"
    echo "  2. Run a scan:    asf scan --skill ./your-skill"
    echo "  3. View docs:      open https://sandbox.jvsmanagement.com/"
    echo ""
    echo "For Docker-based deployment:"
    echo "  docker pull jeffsutherland/asf-framework:$ASF_VERSION"
    echo ""
}

# Main install flow
main() {
    check_dependencies
    detect_platform
    setup_directories
    install_repo
    install_configs
    verify_installation
    print_next_steps
}

main "$@"
