# Enhanced Auto Discovery (EAD)

#### Why Use EAD?

- Default since RIOS version 5.5.4
- Used to find the LAST Steel Head, not the first
- Useful on double WAN hops
  - Also useful in serial deployments, but peering rules are much better
  - Faster to fail when the server is not available
  - Faster to detect network asymmetry

![auto-discovery-flow](images/ead-probe.png)

#### Why Not Use EAD?

- May need to be disabled in certain SaaS backhaul deployments, or when overcoming egregious WAN latency such as double satellite

![layer2](images/auto-discovery--note.png)

---

## Wireshark PCAP of EAD traffic

```log
Options: (28 bytes), Maximum segment size, No-Operation (NOP)
Maximum segment size: 1460 bytes
No-Operation (NOP) Window scale: 8 (multiply by 256)
No-Operation (NOP),
No-Operation (NOP)
TCP SACK Permitted Option: Truel
Riverbed Probe: Probe Query, CSH IP: 10.1.120.21
    Length: 10
    Kind: Riverbed Probe (76)
    Length: 10
    0000... Type: 0
    .... 0001 Version: 1
    Reserved: 0x01
    CSH IP: 10.1.120.21 Application Version: 5
Riverbed Probe: Probe Query Info Length: 4
    Kind: Riverbed Probe (76) Length: 4
    0000 110. Type: 6
    .......8 Version: 2
  Probe Flags: 0x21
No-Operation (NOP) End of Option List (EOL)
```

![ead-probe](images/ead-probe.png)
