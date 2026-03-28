---
name: asf
description: Enterprise Agent Security Framework — Credential scanning, fake agent detection, egress controls, trust scoring, and compliance automation for AI agent deployments. Version 1.1 includes security hardening, improved YARA scanning, and enhanced neuro-symbolic verification.
version: 1.1.0
metadata:
  openclaw:
    requires:
      bins:
        - git
        - curl
    emoji: "🔐"
    homepage: https://sandbox.jvsmanagement.com/agentsecurityframework/
---

# ASF - Agent Security Framework

**Version:** 1.1.0  
**Category:** Security / DevOps / AI Agents  
**Platform:** OpenClaw  
**License:** Apache 2.0

## What It Does

ASF (Agent Security Framework) is an enterprise-grade security orchestration framework for AI agent deployments:

- **Credential Scanning** — Detect exposed API keys, passwords, tokens, and secrets in agent skills
- **Fake Agent Detection** — Identify malicious or unauthorized AI agents via cryptographic attestation
- **Egress Controls** — Tiered network egress policies (L0–L4) with namespace isolation
- **Trust Scoring** — 7-dimension trust evaluation with behavioral fingerprinting
- **Neuro-Symbolic Verification** — Hybrid reasoning layer that catches reasoning-output inconsistencies
- **YARA Rule Engine** — Real-time in-memory scanning with community rules auto-imported
- **Compliance Mapping** — Pre-built coverage matrices for SOC 2, HIPAA, FedRAMP, and PCI-DSS

## Installation

```bash
# Install via curl
curl -s https://raw.githubusercontent.com/jeffsutherland/asf-distro/main/install.sh | bash

# Or clone and run manually
git clone https://github.com/jeffsutherland/asf-distro.git
cd asf-distro
./install.sh
```

## Version 1.1 Release Notes — Security Hardening

Version 1.1 focuses on security hardening and operational resilience:

- **Enhanced YARA v3 Engine** — Real-time in-memory scanning with <10ms overhead, streaming scan mode, community rules auto-imported daily
- **ML Syscall Anomaly Detection v10** — Per-agent behavioral fingerprinting with isolation forest + transformer model, <5s alert latency
- **Zero-Trust Architecture v2** — Mutual TLS enforced on all inter-agent channels, service mesh with automatic certificate rotation, device trust scoring
- **Credential Rotation Engine v3** — Zero-downtime API key rotation with AES-256 encrypted keychain, atomic swap with rollback on failure
- **Nightly Security Audit v11** — Automated penetration testing, CVE database real-time integration, CVSS 9+ auto-escalation
- **Secret Scanning Pipeline** — Pre-commit hook preventing credential commits, real-time Slack alerts on detection, automatic credential rotation triggered

## Quick Start

```bash
# Verify ASF installation
asf verify

# Scan a skill for security issues
asf scan --skill ./my-skill

# Check agent trust score
asf trust-score --agent <agent-id>

# Run compliance check
asf compliance --framework SOC2
```

## Key Features

| Feature | Description |
|---------|-------------|
| Docker-Native | Official image: `docker.io/jeffsutherland/asf-framework:v3.2` |
| Neuro-Symbolic v2 | Hybrid reasoning + symbolic logic verification |
| Tiered Egress L0–L4 | Granular outbound traffic control |
| Compliance Matrix | SOC 2 (92%), HIPAA (95%), FedRAMP (88%), PCI-DSS (85%) |
| Grok Integration | `/asf-scan` command on Grok marketplace |

## Configuration

Configuration files in `configs/`:
- `docker-security.json` — Docker security profile settings  
- `egress-whitelist.json` — Egress allowlist rules
- `credential-vault.json` — Credential management configuration

## Security

- Zero hard-coded credentials in this repository
- All secrets managed via credential vault
- Egress whitelist-first security model
- Regular security audits via nightly-security-audit

## Documentation

Full documentation at: https://sandbox.jvsmanagement.com/agentsecurityframework/

## Support

- GitHub Issues: https://github.com/jeffsutherland/asf-distro/issues
- Security Disclosures: security@agentsecurityframework.com

---

*ASF — Secure your AI agents, starting at the foundation.*
