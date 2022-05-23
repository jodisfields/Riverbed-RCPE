# Housekeeping

## Licensing Structure

- Licenses are small strings of text tied to the HW
  - Example: LK1-SH40SSL-0000-0000-5-8B40-0361-F11D

- Basic Licenses plus options and sizing can be added by:
  - CLI
  - GUI
  - Call Home function

---

## Export Flow Statistics

- NetFlow and other Flow Data Collectors gather network statistics about network hosts, protocols and ports, peak usage times, traffic paths, and others
- The flow data collectors update flow records with information pertaining to each packet traversing a specified network interface

---

## Flow Data Component Basics

- Exporter: A device that sees the data flows going through the network, such as a SteelHead or a router
- Collector: A server or appliance designed to aggregate data sent to it by NetFlow Exporter, such as Steel Central Flow Gateway
- Analyzer: A collection of tools (usually provided in conjunction with a collector) used to analyze the data and provide relevant data summaries and graphs, such as SteelCentral NetProfiler

---

## Configuration Management

- The Configuration is held in binary format
- Pasting a text file to the CLI is NOT recommended
- Configuration files are backed up locally with a .bak copy and can be uploaded manually to a server: Files are also regularly backed up to the SCC
- Files can be saved locally before every change
- Creates an easy rollback if required in a service window
