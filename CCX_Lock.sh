#!/bin/bash

# Check if the required number of arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <cpu_affinity> <command>"
  echo "       cpu_affinity: A hexadecimal bitmask representing the desired CPU affinity"
  echo "       command: The command to be executed with the specified CPU affinity"
  exit 1
fi

# Set the CPU affinity for the process
taskset -c -p "$1" "$2"
#To use this script, you need to provide two arguments:   
# cpu_affinity: A hexadecimal bitmask representing the desired CPU affinity. You can generate this bitmask based on the CCX you want to target. Each CCX on an AMD Ryzen CPU consists of 4 cores. For example, if you want to target the first CCX (cores 0-3), the bitmask would be 0xF (which represents the binary 1111).
# command: The command you want to execute with the specified CPU affinity. For example, if you want to run the process myprocess with the specified affinity, you would provide myprocess as the command argument.
# ake sure to save the script with a .sh extension (e.g., clustered_multithreading.sh), and then you can execute it from the command line like this...

#$ bash clustered_multithreading.sh <cpu_affinity> <command>

#Replace <cpu_affinity> with the desired CPU affinity bitmask and <command> with the actual command you want to run. For example:

#$ bash clustered_multithreading.sh 0xF myprocess

#This will execute the myprocess command with the CPU affinity set to the first CCX on your AMD Ryzen CPU.

#Please note that this script requires the "taskset" command, which is typically available on Linux systems.