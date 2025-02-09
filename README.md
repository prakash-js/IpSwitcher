#Description:

This tool allows you to automatically change your IP address at user-defined intervals by restarting the Tor service. It uses iptables to redirect all system TCP traffic to Tor’s Transparent Proxy port (9040) and DNS queries (UDP port 53) through port 9040, ensuring that both web traffic and DNS requests are routed through Tor.

#Usage Instructions:

Before using the tool, ensure the following lines are added to the end of your /etc/tor/torrc file:

```bash

AutomapHostsOnResolve 1
TransPort 9040
DNSPort 53
```
