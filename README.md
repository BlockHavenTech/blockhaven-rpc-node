# BlockHaven Solana RPC — Powered by $BLOCK

🚀 High-performance, low-latency Solana RPC endpoint designed for traders, developers, and power users.
**Live from Sunday 15/06/2025, 8PM EST**

## ✅ Features

- 🌐 **Full RPC API** support (including advanced methods)
- 🔒 **Private RPC** mode to prevent leakage via gossip
- 🧠 **CPI & Log Storage** enabled
- 🧾 **Transaction History** enabled
- ⚡ **High Throughput WebSocket** (log subscriptions, block, signature, account updates)
- 🚀 Built for trading bots, dashboards, explorers, and token analytics

---

## 💻 Infrastructure Specs (Baremetal)

🔹 **1TB RAM**, **AMD EPYC 7443P CPU**  
🔹 **8x NVMe RAID0** ⛓️ Ultra-fast ledger and account access  
🔹 **480GB SATA SSD** for OS and WAL in `tmpfs`  
🔹 **10Gbps unmetered bandwidth**  

---

## 📂 Scripts Included

### `healthcheck.sh`
Creates a timestamped system health report with:
- CPU load per core
- RAM usage
- Disk I/O stats
- RAID performance benchmark
- Network traffic
- Mounted volumes

### `monitor.sh`
Monitors sync performance:
- Slot difference vs. mainnet
- Local slots/sec
- I/O, memory, and network stats
- Validator CPU usage and top memory consumers

### `restart-agave-validator.sh`
Safe script to reload and restart Agave Validator:
```bash
systemctl daemon-reexec
systemctl daemon-reload
systemctl restart agave-validator.service
```

---

## 🧪 Example Usage (PowerShell)

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

### 🧑‍💻 Built by the BlockHaven Infra Team  
💜 Empowering builders, enabling scale.