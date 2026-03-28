# ASF Framework — Agent Security Framework

**Version:** 1.1.0  
**Category:** Security / DevOps / AI Agents  
**Platform:** OpenClaw  
**License:** Apache 2.0

---

## What It Does

ASF (Agent Security Framework) is an enterprise-grade security orchestration framework for AI agent deployments. It provides:

- **Credential Scanning** — Detect exposed API keys, passwords, tokens
- **Fake Agent Detection** — Identify impersonators and honeypots via cryptographic attestation
- **Egress Controls** — Tiered network egress policies (L0–L4) with namespace isolation
- **Trust Scoring** — 7-dimension trust evaluation with behavioral fingerprinting
- **Neuro-Symbolic Verification** — Hybrid reasoning layer that catches reasoning-output inconsistencies
- **YARA Rule Engine v3** — Real-time in-memory scanning with <10ms overhead
- **Compliance Mapping** — Pre-built coverage matrices for SOC 2, HIPAA, FedRAMP, and PCI-DSS

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

# Check agent trust score
asf trust-score --agent <agent-id>

# Run compliance check
asf compliance --framework SOC2

# Run nightly security audit
asf audit nightly
```

---

## Version 1.1 Release Notes — Security Hardening

Version 1.1 is a security hardening release with significant operational resilience improvements:

### New Features
- **YARA Rule Engine v3** — Real-time in-memory scanning during agent execution with less than 10ms overhead. Streaming scan mode for large files without loading full file into memory. Community rules automatically imported from YARA ruleset repository daily.
- **ML Syscall Anomaly Detection v10** — Per-agent syscall fingerprint with behavioral baseline. Novel attack patterns detected using isolation forest + transformer model. Real-time alerting with less than 5s latency from anomaly to alert.
- **Zero-Trust Architecture v2** — Mutual TLS (mTLS) enforced on all inter-agent communication. Service mesh with automatic certificate rotation. Device trust scoring — assess agent host security posture before granting access.
- **Credential Rotation Engine v3** — Zero-downtime credential rotation for all agent API keys and secrets. AES-256 encrypted keychain storage. Atomic old-to-new credential swap with rollback on failure.
- **Nightly Security Audit v11** — Automated penetration testing against internal ASF components. CVE database real-time integration with CVSS 9+ auto-escalation. Red team simulation — agent attempts to exfiltrate data, results logged.

### Security Hardening
- **Secret Scanning Pipeline** — Pre-commit hook preventing credential commits. Real-time Slack alert when secret detected. Automatic credential rotation triggered on detection.
- **Agent Identity Attestation v3** — Hardware-backed key pairs (TPM/HSM) for each agent. Continuous attestation protocol — agents prove identity every 60 seconds. Automatic revocation if attestation fails 3 consecutive times.
- **Egress Controls v2** — Per-domain egress policies with allow/deny/restricted flags. DNS-based egress filtering with cached allowlist. TLS inspection for restricted domains with certificate pinning.

---

## Key Features

| Feature | Description |
|---------|-------------|
| Docker-Native | Official image: `docker.io/jeffsutherland/asf-framework:v3.2` |
| Neuro-Symbolic v2 | Hybrid reasoning + symbolic logic verification |
| Tiered Egress L0–L4 | Granular outbound traffic control |
| Compliance Matrix | SOC 2 (92%), HIPAA (95%), FedRAMP (88%), PCI-DSS (85%) |
| Grok Integration | `/asf-scan` command on Grok marketplace |
| Agent Trust Scoring | 7-dimension behavioral evaluation |
| YARA v3 Scanning | Real-time in-memory with <10ms overhead |

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
- Pre-commit hooks prevent credential exposure

---

## Documentation

Full documentation at: https://sandbox.jvsmanagement.com/agentsecurityframework/

---

## Support

- GitHub Issues: https://github.com/jeffsutherland/asf-distro/issues
- Security Disclosures: security@agentsecurityframework.com

---

*ASF — Secure your AI agents, starting at the foundation.*
