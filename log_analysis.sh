#!/bin/bash -
# Author:       Christo Deale                  
# Date  :       2023-12-13            
# log_analysis: Utility to parse & analyse log files & extract

if [ $# -ne 1 ]; then
    echo "Usage: $0 /path/to/logfile_or_directory"
    exit 1
fi

LOG_PATH=$1

# Function to parse log files
function parse_logfile {
    awk '{print "[" strftime("%Y-%m-%d %H:%M:%S", $1) "] " $0}' "$1"
}

# Function to find messages based on log level
function find_log_messages {
    local log_level="$1"
    parse_logfile | grep -i "$log_level"
}

# Display the results for each log level
for log_level in "error" "warning" "info" "debug"; do
    echo "$log_level messages:"
    find_log_messages "$log_level"
    echo
done

# Function to find performance metrics
function find_performance_metrics {
    parse_logfile | grep -i 'performance metrics'
}

# Display performance metrics
echo "Performance Metrics:"
find_performance_metrics
