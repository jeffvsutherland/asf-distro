# ASF Framework — Agent Security Framework

**Version:** v3.2.0  
**Category:** Security / DevOps / AI Agents  
**Platform:** OpenClaw  
**License:** Apache 2.0  

---

## What It Does

ASF (Agent Security Framework) is an enterprise-grade security orchestration framework for AI agent deployments. It provides:

- **Fake Agent Detection** — Identify malicious or unauthorized AI agents in your infrastructure
- **Skill Security Scanning** — Audit agent skills for credential leaks, malicious dependencies, and egress violations
- **Egress Controls** — Tiered network egress policies (L0–L4) with namespace isolation
- **Compliance Mapping** — Pre-built coverage matrices for SOC 2, HIPAA, FedRAMP, and PCI-DSS
- **Neuro-Symbolic Verification** — Hybrid reasoning layer that catches reasoning-output inconsistencies

---

## Installation

```bash
# Install via install script
curl -s https://raw.githubusercontent.com/jeffsutherland/asf-distro/main/install.sh | bash

# Or clone and run manually
git clone https://github.com/jeffsutherland/asf-distro.git
cd asf-distro
./install.sh
```

---

## Quick Start

```bash
# Verify ASF installation
asf verify

# Scan a skill for security issues
asf scan --skill ./my-skill

# Check agent status
asf agent status

# Run compliance check
asf compliance --framework SOC2
```

---

## Key Features

| Feature | Description |
|---------|-------------|
| Docker-Native | Official image: `docker.io/jeffsutherland/asf-framework:v3.2` |
| Neuro-Symbolic v2 | Hybrid reasoning + symbolic logic verification |
| Tiered Egress L0–L4 | Granular outbound traffic control |
| Compliance Matrix | SOC 2 (92%), HIPAA (95%), FedRAMP (88%), PCI-DSS (85%) |
| Grok Integration | `/asf-scan` command on Grok marketplace |

---

## Configuration

Configuration files in `configs/`:
- `docker-security.json` — Docker security profile settings
- `egress-whitelist.json` — Egress allowlist rules
- `credential-vault.json` — Credential management configuration

---

## Security

- Zero hard-coded credentials in this repository
- All secrets managed via credential vault
- Egress whitelist-first security model
- Regular security audits via `nightly-security-audit`

---

## Documentation

Full documentation at: https://sandbox.jvsmanagement.com/

---

## Support

- GitHub Issues: https://github.com/jeffsutherland/asf-distro/issues
- Security Disclosures: security@agentsecurityframework.com

---

*ASF Framework — Secure your AI agents, starting at the foundation.*
