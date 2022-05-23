# Quick Notes

- License Tiers

![license-tiers](../assets/license-levels.png)

## SteelHead-V Best Practices for Performance

- Do not share NICS and use at least 1Gbps

- Allow resources Hypervisor overhead

- Do not over provision CPU Use a Server Grade CPU for the Hypervisor

- Always reserve RAM & Virtual RAM < Physical RAM

- Use SSDs or other high speed disk for the Segstore - Do not share physical disks between hosts

- Do not use hyperthreading

- Apply BIOS power settings for maximum performance

## Steel Head-v and Riverbed Bypass NIC

Riverbed Bypass NIC-A physical card for the virtual device.

- ESX/ESXI

  - Direct Path feature

  - Allows SteelHead-v to contral the bypass hardware:

  - ESXI driver available from the support website Under related Software

- Hyper-V & KVM support
