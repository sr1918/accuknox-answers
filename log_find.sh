#!/bin/bash

# THIS IS THE SCRIPT FOR FINDING 404 AND OTHER KIND OF PATTERNS IN LOGS

LOG_FILE="/var/log/nginx/access.log"  # Change this to the path of your log file

# Check if the log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file not found at $LOG_FILE"
    exit 1
fi

echo "Analyzing log file: $LOG_FILE"

# Count the number of 404 errors
echo "Number of 404 errors:"
grep "404" $LOG_FILE | wc -l

# Find the most requested pages (top 10)
echo "Top 10 most requested pages:"
awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10

# Find the IP addresses with the most requests (top 10)
echo "Top 10 IP addresses with the most requests:"
awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10

# Find the top 10 user-agents
echo "Top 10 User-Agents:"
awk -F'"' '{print $6}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10

# Find the top 10 referrers
echo "Top 10 Referrers:"
awk -F'"' '{print $4}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10

# Find the busiest hour (top 5)
echo "Busiest hours (Top 5):"
awk '{print $4}' $LOG_FILE | cut -d: -f2 | sort | uniq -c | sort -nr | head -n 5

echo "Log analysis complete."

