#!/bin/bash

# Get the number of available CPU cores
num_cores=$(nproc)

# Check if the system has AMD Ryzen CPU
if [[ $(lscpu | grep 'Vendor ID:' | awk '{print $3}') != "AuthenticAMD" ]]; then
  echo "This script is intended for AMD Ryzen CPUs only."
  exit 1
fi

# Check if the required command line tools are installed
if ! command -v corectrl &>/dev/null; then
  echo "Please install corectrl to use this script."
  exit 1
fi

# Set the process ID (PID) of the target process
target_pid=<your_process_id_here>

# Check if the target process ID is valid
if ! ps -p $target_pid >/dev/null; then
  echo "Invalid process ID: $target_pid"
  exit 1
fi

# Get the CPPC values for each CPU core
cppc_values=()
for ((core = 0; core < num_cores; core++)); do
  cppc_values+=($(corectrl --cppc-get-core-value $core))
done

# Sort the cores based on CPPC values in descending order
sorted_cores=()
for ((core = 0; core < num_cores; core++)); do
  max_value=-1
  max_index=-1

  for ((i = 0; i < num_cores; i++)); do
    if [[ ${cppc_values[$i]} -gt $max_value ]]; then
      max_value=${cppc_values[$i]}
      max_index=$i
    fi
  done

  sorted_cores+=($max_index)
  cppc_values[$max_index]=-1
done

# Lock the target process to the sorted cores
for core in "${sorted_cores[@]}"; do
  corectrl --cppc-set-core-mask $core --pid $target_pid
done

echo "Process $target_pid locked to the cores with the best CPPC values."

###To use this script, follow these steps:

  #  Open a text editor and create a new file.
   # Copy and paste the script into the file.
    # Replace <your_process_id_here> with the actual process ID of the target process you want to lock to the cores.
    # Save the file with a .sh extension (e.g., cpu_lock_script.sh).
    # Open a terminal and navigate to the directory where you saved the script.
    # Make the script executable by running the command: chmod +x cpu_lock_script.sh.
    # Run the script using the command: ./cpu_lock_script.sh.

Please note that this script requires the corectrl command-line tool to be installed on your system. Make sure it is installed before running the script.