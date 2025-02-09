#!/bin/bash

# Function to get valid time input from user
get_valid_time() {
  while true; do
    echo -n "Enter the seconds to change the IP: "
    read tor_seconds
    if (( tor_seconds > 1 )); then
      echo "Tor will change your IP every $tor_seconds seconds."
      break
    else
      echo "Please enter a valid number greater than 1."
    fi
  done
}

# Request user input for seconds to change IP
get_valid_time

# Display message to user
echo "Press Ctrl+C to stop the script."

# Start Tor service
echo "Starting Tor service..."
service tor start

# Set up iptables rules for Tor
echo "Setting up iptables rules..."
iptables -t nat -A OUTPUT -p tcp --dport 1:6500 -j REDIRECT --to-ports 9040
iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 9040



# Trap SIGINT (Ctrl+C) to clean up and stop Tor service
trap 'iptables -tnat -F && iptables -F && echo "Exiting Tor"; service tor stop; exit' SIGINT

# Continuously restart Tor service every $tor_seconds seconds

while true; do
  sleep $tor_seconds
  echo "Tor IP changed. Waiting for next interval."
  sudo kill -HUP $(pidof tor)
done
