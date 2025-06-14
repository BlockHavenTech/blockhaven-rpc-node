#!/bin/bash
LOGFILE="system_health_$(date +%Y%m%d_%H%M%S).log"

echo "📊 System Health Snapshot - $(date)" | tee $LOGFILE
echo "----------------------------------------" | tee -a $LOGFILE

echo -e "\n🧠 CPU Load (all cores, 1s avg):" | tee -a $LOGFILE
mpstat -P ALL 1 1 | tee -a $LOGFILE

echo -e "\n🧬 Memory Usage:" | tee -a $LOGFILE
free -h | tee -a $LOGFILE

echo -e "\n💽 Disk I/O (iostat, per-device, 2s avg):" | tee -a $LOGFILE
iostat -xk 2 3 | tee -a $LOGFILE

echo -e "\n📦 Mounted Volumes:" | tee -a $LOGFILE
df -h | tee -a $LOGFILE

echo -e "\n🔍 RAID0 Read Performance (fio 2GB, 1M blocks, 8 jobs):" | tee -a $LOGFILE
fio --name=raidtest --rw=read --bs=1M --numjobs=8 --size=2G --filename=/mnt/solana-ledger/testfile --group_reporting | tee -a $LOGFILE

echo -e "\n🌐 Network Interface Stats:" | tee -a $LOGFILE
ip -s link | tee -a $LOGFILE

echo -e "\n✅ Done. Output saved to $LOGFILE"