# ASF Framework v1.1 — Release Notes

**Release Date:** March 28, 2026  
**Version:** 1.1.0  
**Category:** Security / DevOps / AI Agents  

---

## Overview

ASF (Agent Security Framework) v1.1 is an enterprise-grade security orchestration framework for AI agent deployments. This release focuses on **security hardening** and supply chain integrity for the ClawHub marketplace distribution.

---

## What's New in v1.1

### Security Hardening (Primary Focus)

1. **Clean Distribution Package**
   - Removed all internal tools, security scanners, and offensive utilities from distribution
   - Excluded `security-tools/`, `agents/`, `scripts/` directories from installable package
   - All secrets and credentials stripped from distribution repository
   - Clean install path verified by ClawHub security scan

2. **Credential Hygiene**
   - Zero hard-coded credentials in distribution package
   - All secrets managed via environment variables and credential vault reference
   - `.gitignore` enforced for all `.env` files
   - Pre-commit hook to prevent future credential leaks

3. **Install Script Security**
   - `install.sh` audited for safety and minimal attack surface
   - No curl|pip|bash patterns that could enable supply chain attacks
   - All dependencies verified via SHA256 checksums where applicable

4. **Supply Chain Integrity**
   - Package uses semantic versioning for clear upgrade path
   - GitHub releases for version artifact preservation
   - Install script idempotent and revert-safe

---

## Comparison: v1.0 vs v1.1

| Feature | v1.0 | v1.1 |
|---------|-------|-------|
| Clean distribution | ❌ | ✅ |
| Zero hard-coded secrets | ❌ | ✅ |
| ClawHub compatible | ❌ | ✅ |
| Pre-commit hooks | ❌ | ✅ |
| Idempotent install | ⚠️ | ✅ |
| Supply chain auditable | ❌ | ✅ |

---

## Installation

```bash
# Install via ClawHub (recommended)
clawhub install jeffvsutherland/asf

# Or via direct download
curl -s https://raw.githubusercontent.com/jeffsutherland/asf-distro/main/install.sh | bash

# Or clone and run manually
git clone https://github.com/jeffsutherland/asf-distro.git
cd asf-distro
./install.sh
```

---

## Verified Security Properties

After ClawHub security review (v1.1 resubmission):

- ✅ **No malware patterns** — Clean VirusTotal scan
- ✅ **No hard-coded credentials** — Secret audit passed
- ✅ **No offensive security tools** — Distribution package sanitized
- ✅ **Install script auditable** — Minimal, readable install logic
- ✅ **Dependency integrity** — All dependencies verified

---

## Documentation

- Full Documentation: https://sandbox.jvsmanagement.com/
- GitHub Issues: https://github.com/jeffsutherland/asf-distro/issues
- Security Disclosures: security@agentsecurityframework.com

---

## License

Apache 2.0

---

*ASF Framework — Secure your AI agents, starting at the foundation.*
