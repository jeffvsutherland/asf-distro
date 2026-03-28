#!/bin/bash
# ASF Framework v1.1 — Clean Install Script
set -e
ASF_VERSION="v1.1.0"
ASF_INSTALL_DIR="${HOME}/.asf"
REPO_URL="https://github.com/jeffsutherland/asf-distro.git"
echo "ASF Framework v1.1.0 Enterprise Install"
check_dependencies() {
    for cmd in git curl; do command -v "$cmd" &>/dev/null || { echo "Missing: $cmd"; exit 1; }; done
}
setup_directories() {
    mkdir -p "$ASF_INSTALL_DIR" "${ASF_INSTALL_DIR}/configs" "${HOME}/.config/asf"
}
install_repo() {
    if [ -d "${ASF_INSTALL_DIR}/.git" ]; then cd "${ASF_INSTALL_DIR}" && git pull; else git clone "$REPO_URL" "$ASF_INSTALL_DIR"; fi
}
install_configs() {
    local src="${ASF_INSTALL_DIR}/configs" dest="${HOME}/.config/asf"
    [ -d "$src" ] && cp "$src/"*.json "$dest/" 2>/dev/null || true
    [ ! -f "${dest}/egress-whitelist.json" ] && cat > "${dest}/egress-whitelist.json" << 'EOFE'
{"version":"1.0","egress_policy":"whitelist","default_action":"deny","rules":[{"dest":"api.openai.com","ports":[443],"tier":"L3"},{"dest":"api.anthropic.com","ports":[443],"tier":"L3"},{"dest":"api.x.ai","ports":[443],"tier":"L3"},{"dest":"github.com","ports":[443],"tier":"L2"},{"dest":"docker.io","ports":[443],"tier":"L2"}],"excluded":["localhost","127.0.0.1","0.0.0.0"]}
EOFE
    [ ! -f "${dest}/docker-security.json" ] && cat > "${dest}/docker-security.json" << 'EOFD'
{"version":"1.0","security_profile":"enterprise","cap_drop":["ALL"],"cap_add":["NET_BIND_SERVICE","CHOWN","SETGID","SETUID"],"network_mode":"bridge","privileged":false}
EOFD
    [ ! -f "${dest}/credential-vault.json" ] && cat > "${dest}/credential-vault.json" << 'EOFV'
{"version":"1.0","vault_type":"keychain","audit_log":true,"hardcoded_creds_detected":"block"}
EOFV
}
verify_installation() { [ -d "$ASF_INSTALL_DIR" ] && echo "Verified"; }
main() { check_dependencies; setup_directories; install_repo; install_configs; verify_installation; }
main "$@"
