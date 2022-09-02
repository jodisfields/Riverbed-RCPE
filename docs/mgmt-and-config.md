# Management and Configuration

> Management is available on all interfaces by default

- Rest API for special purposes such as automation
- Graphical User Interface via HTTP / HTTPS
- MIB downloadable from the GUI
- Telnet *(disabled by default)*
- Rest API
- SNMP
- SSH
- BMC

> Best Practice: Always use the SCC.

#### CLI Command Entry Modes

- User
- Enable
- Config

---

## Riverbed SteelHead Show Interface

```sh
VCX255-A #sh int inpath0_0
Interface: inpath0 0
State: Up
Interface type: ethernet
IP address: 10.1.30.125
Netmask: 255.255.255.0
IPv6 link-local address: fe80::20c:29ff: fe28:b93d/64
MTU: 1500
HW address: 00:0C:29:28:B9:3D
Traffic status: Normal
HW blockable: no
Counters cleared date: 2019/12/12 11:43:00
RX bytes: 6526710
RX mcast packets: 51827
errors: 0
RX overruns: 100
TX bytes: 1548
```

---

## Riverbed SteelHead configuration wizard

```sh
VCX255-A (config) conf jump-start
Step 1: Hostname? (VCX255-A1)
Step 2: Use DHCP on primary interface? [no]
Step 3: Primary IP address? [10.1.30.25)
Step 4: Netmask? [255.255.255.0]
Step 5: Default gateway? [10.1.30.254]
Step 6: Primary DNS server? (10.1.30.102)
Step 7: Domain name? [training.local]
Step 8: Admin password?
Step 9: SMTP server?
Step 10: Notification email address?
Step 11: Set the primary interface speed? [auto]
Step 12: Set the primary interface duplex? [auto]
Step 13: Would you like to activate the in-path configuration? [yes]
Step 14: In-Path IP address? (10.1.30.125)
Step 15: In-Path Netmask? 1255.255.255.01
Step 16: In-Path Default gateway? [10.1.30.254)
Step 17: Set the in-path:LAN interface aspeed? [auto]
Step 18: Set the In-path: LAN interface duplex? [auto]
Step 19: Set the in-path:WAN interface speed? [auto]
Step 20: Set the in-path: WAN Interface duplex? [auto]
```

---

## Network interface configuration

```sh
interface aux description
interface aux dhcp
interface aux dhcp dynamic-dns
no interface aux dhcpv6
no interface aux shutdown
interface aux dhcpv6 dynamic-dns
interface aux mtu "1588"
interface aux speed "auto"
interface inpath8 8 description "" no interface inpath8_8 dhcp
no interface inpath8 8 dhcp dynamic-dns na interface inpath8_8 dhcpv6
no interface inpath8 8 dhcpv6 dynamic-dns
no interface interface
inpath0 8 force-Mdi-x enable inpath8_8 ip address 18.1.58.125 /24
interface inpath8 8 mtu "1588"
interface interface
inpath8_8 napi-weight "128" inpath8_8 shutdown
interface inpath8_8 speed "auto"
no interface shutdown
inpathB 8 txqueuelen "188" lo description
```
