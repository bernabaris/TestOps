#!/bin/bash

echo "Checking server logs..."
tail -n 50 /var/log/syslog
