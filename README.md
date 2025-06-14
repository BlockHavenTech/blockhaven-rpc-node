
# 🔗 BlockHaven Solana RPC, Powered by $BLOCK

🚀 **High-performance, low-latency Solana RPC endpoint** designed for traders, devs & power users.

🟣 **Live from Sunday 15/06/2025 @ 8PM EST**

---

## ✅ Features

- 🌐 Full RPC API enabled (advanced query support)
- 🔒 Private RPC mode to prevent gossip-based IP leaks
- 🧠 CPI & Log Storage enabled for contract visibility
- 🧾 RPC Transaction History support
- 📡 WebSocket enabled (logs, account, block, and signature subscriptions)
- ⚙️ Built for trading bots, dashboards, explorers, analytics & infra

---

## 💻 Baremetal Infrastructure

| Component     | Spec Description                                   |
|---------------|----------------------------------------------------|
| CPU           | AMD EPYC 7443P (24 cores / 48 threads)             |
| Memory        | 1TB ECC RAM                                        |
| Ledger Disk   | 8x NVMe RAID0, ultra-fast ledger/account access   |
| OS/WAL        | 480GB SATA SSD + WAL in `tmpfs` for max IOPS       |
| Network       | 10Gbps unmetered dedicated uplink                  |

---


## 📂 Scripts Included

> ⚙️ These helper tools are built for Solana RPC node deployers, making monitoring and management faster, cleaner, and more automated.

### 🔍 `healthcheck.sh`

📈 Generates a full system health snapshot:

- CPU core load
- RAM usage
- Disk I/O + RAID benchmark
- Network stats
- Mounted volumes
- Optional: system temps (with `lm-sensors`)

▶ **Usage:**
```bash
chmod +x healthcheck.sh
./healthcheck.sh
```

---

### 📊 `monitor.sh`

📡 Live snapshot of sync rate & system stats:

- Solana slot sync performance (vs mainnet)
- Slot rate/sec (local)
- Disk I/O, memory, CPU, top processes
- Network throughput

▶ **Usage:**
```bash
chmod +x monitor.sh
./monitor.sh
```

---

### ♻️ `restart-agave-validator.sh`

Reloads systemd, restarts Agave Validator, and shows service status.

▶ **Usage:**
```bash
chmod +x restart-agave-validator.sh
sudo ./restart-agave-validator.sh
```

---

## ⚙️ Optional: Set Up systemd Timer for Auto Health Logging

To automate running `healthcheck.sh` daily and store logs in `/var/log/agave-health/`:

1. Create log directory:
```bash
sudo mkdir -p /var/log/agave-health/
sudo chown $USER /var/log/agave-health/
```

2. Edit script to write logs there:
```bash
LOGFILE="/var/log/agave-health/system_health_$(date +%Y%m%d_%H%M%S).log"
```

3. Create a systemd service (e.g., `/etc/systemd/system/agave-health.service`):
```ini
[Unit]
Description=Agave Daily Healthcheck

[Service]
ExecStart=/root/healthcheck.sh
```

4. Create a timer unit `/etc/systemd/system/agave-health.timer`:
```ini
[Unit]
Description=Run Agave Healthcheck Daily

[Timer]
OnCalendar=*-*-* 04:00:00
Persistent=true

[Install]
WantedBy=timers.target
```

5. Enable it:
```bash
sudo systemctl daemon-reload
sudo systemctl enable --now agave-health.timer
```

---

## 🛠️ Required Libraries & Installation

To run the helper scripts, install:

### 📦 Packages

| Package      | Description                            |
|--------------|----------------------------------------|
| `sysstat`    | For `mpstat` (CPU stats)               |
| `jq`         | JSON parsing in Bash                   |
| `iostat`     | Disk performance statistics            |
| `fio`        | RAID/disk benchmarking                 |
| `net-tools`  | Basic networking commands              |
| `ifstat`     | Live network stats (optional)          |
| `lm-sensors` | Temp/thermal sensor readings (optional)|
| `bc`         | Floating point arithmetic              |
| `curl`       | HTTP requests to RPC                   |

### 📥 Install (Ubuntu/Debian):
```bash
sudo apt update && sudo apt install -y   sysstat jq iostat fio net-tools ifstat lm-sensors bc curl
```

> 💡 Run `sudo sensors-detect` after installing `lm-sensors`.

---

## 🧪 Quick RPC Health Test (PowerShell)

```powershell
$body = @{
  jsonrpc = "2.0"
  id = 1
  method = "getHealth"
  params = @()
} | ConvertTo-Json -Depth 10

$response = Invoke-RestMethod -Uri "https://solana-us.blockhaven.tech" -Method Post -Body $body -ContentType "application/json"
$response
```

---

## 🧑‍💻 About BlockHaven

We’re building fast, scalable, and token-gated infrastructure for the next wave of Web3 builders.

💜 Powered by $BLOCK, the key to premium access.

---

## 📫 Feedback & Contributions

Have suggestions, want to add alerting, or improve logs? PRs welcome.  
Join our community on X / Telegram to get involved.
