#!/bin/bash

# Enable Transparent Huge Pages (THP)
echo "Enabling Transparent Huge Pages (THP)..."
echo "always" > /sys/kernel/mm/transparent_hugepage/enabled

# Set THP defrag mode to "defer" for better performance
echo "Setting THP defrag mode to 'defer'..."
echo "defer" > /sys/kernel/mm/transparent_hugepage/defrag

# Check current THP settings
echo "Current THP settings:"
cat /sys/kernel/mm/transparent_hugepage/enabled
cat /sys/kernel/mm/transparent_hugepage/defrag

# Dynamically change memory page sizes
echo "Dynamically changing memory page sizes..."

# Allocate memory using the default page size
echo "Allocating memory using default page size..."
stress-ng --vm 1 --vm-bytes 1G --vm-keep

# Allocate memory using huge pages (2MB)
echo "Allocating memory using huge pages (2MB)..."
stress-ng --vm 1 --vm-hang 0 --vm-hugepages 1 --vm-hugepages-size 2MB --vm-keep

# Check the current memory page size
echo "Checking current memory page size..."
grep Hugepagesize /proc/meminfo

# Disable Transparent Huge Pages (THP) after the program completes (optional)
# echo "Disabling Transparent Huge Pages (THP)..."
# echo "never" > /sys/kernel/mm/transparent_hugepage/enabled

echo "Done."
