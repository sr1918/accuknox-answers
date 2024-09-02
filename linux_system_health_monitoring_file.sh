#!/bin/bash

# Thresholds
CPU_THRESHOLD=80   # CPU usage percentage
MEMORY_THRESHOLD=80  # Memory usage percentage
DISK_THRESHOLD=90  # Disk usage percentage
PROCESS_THRESHOLD=300  # Number of running processes

# Log file
LOG_FILE="/var/log/system_health.log"

log_alert() {
    local message=$1
    echo "$(date): $message" | tee -a $LOG_FILE
}

# Check CPU usage
check_cpu() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        log_alert "Alert: High CPU usage detected: $cpu_usage%"
    fi
}

# Check memory usage
check_memory() {
    memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
        log_alert "Alert: High memory usage detected: $memory_usage%"
    fi
}

# Check disk space usage
check_disk() {
    disk_usage=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
    if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
        log_alert "Alert: High disk usage detected: $disk_usage%"
    fi
}

# Check number of running processes
check_processes() {
    process_count=$(ps aux | wc -l)
    if [ "$process_count" -gt "$PROCESS_THRESHOLD" ]; then
        log_alert "Alert: High number of running processes detected: $process_count processes"
    fi
}

# Run checks
check_cpu
check_memory
check_disk
check_processes
