#!/bin/env bash

LOGFILE="/var/log/sysmon.log"

while true; do
  echo "--- $(date) ---" >> "$LOGFILE"

  echo "CPU:" >> "$LOGFILE"
  mpstat 1 1 | awk '/Average:/ && $12 ~ /[0-9.]+/ {print 100 - $12"%"}' >> "$LOGFILE"

  echo "MEMORY:" >> "$LOGFILE"
  free -h >> "$LOGFILE"

  echo "DISK:" >> "$LOGFILE"
  df -h / >> "$LOGFILE"

  echo "NET:" >> "$LOGFILE"
  cat /sys/class/net/eth0/statistics/rx_bytes >> "$LOGFILE"
  cat /sys/class/net/eth0/statistics/tx_bytes >> "$LOGFILE"

  echo "" >> "$LOGFILE"
  
  sleep 300

done

