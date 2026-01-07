# Hardware Inventory

**Generated**: 2026-01-07

---

## System Overview

| Component | Details |
|-----------|---------|
| Motherboard | Gigabyte X570 AORUS ULTRA |
| CPU | AMD Ryzen 7 5800X (8 cores / 16 threads) |
| GPU | NVIDIA GeForce GTX 750 Ti (2GB) |
| RAM | 16GB DDR4-3600 (2x8GB) |
| Storage | 1.5TB NVMe SSD + 1TB HDD |

---

## Motherboard & BIOS

| Property | Value |
|----------|-------|
| Manufacturer | Gigabyte Technology Co., Ltd. |
| Model | X570 AORUS ULTRA |
| Chipset | AMD X570 |
| BIOS Vendor | American Megatrends International, LLC |
| BIOS Version | **F37f** |
| BIOS Date | 2023-09-20 |

**Note**: BIOS F37f is relatively recent (Sept 2023). Need to check Gigabyte support page for any newer versions.

---

## CPU

| Property | Value |
|----------|-------|
| Model | AMD Ryzen 7 5800X 8-Core Processor |
| Architecture | Zen 3 (Vermeer) |
| Cores | 8 |
| Threads | 16 |
| Base Clock | 3.8 GHz |
| Max Boost | ~4.7 GHz |

---

## GPU

| Property | Value |
|----------|-------|
| Model | NVIDIA GeForce GTX 750 Ti |
| VRAM | 2GB |
| Driver Version | 32.0.15.6094 |
| Driver Date | 2024-08-14 |
| Resolution | 1920 x 1080 |

**Note**: GTX 750 Ti is older hardware (Maxwell, 2014). Driver is from August 2024. This GPU may be a bottleneck for modern workloads but sufficient for development work.

---

## Storage Devices

| Device | Type | Capacity | Health | Bus |
|--------|------|----------|--------|-----|
| Samsung SSD 980 PRO 1TB | NVMe SSD | 931 GB | **Healthy** | NVMe |
| Samsung SSD 970 PRO 512GB | NVMe SSD | 477 GB | **Healthy** | NVMe |
| WDC WD1002FAEX-00Y9A0 | HDD | 931 GB | **Healthy** | SATA |

**Total Storage**: ~2.3 TB (1.4 TB NVMe SSD + 931 GB HDD)

**Recommendation**: All disks report healthy. The WD HDD is older (WD Black, ~2011 era) - consider full SMART diagnostics before relying on it post-install.

---

## RAM

| Slot | Capacity | Speed | Part Number |
|------|----------|-------|-------------|
| P0 CHANNEL A | 8 GB | 2133 MHz (reported) | CMK16GX4M2D3600C18 |
| P0 CHANNEL A | 8 GB | 2133 MHz (reported) | CMK16GX4M2D3600C18 |

**Total**: 16 GB DDR4

**Note**: RAM is Corsair Vengeance LPX DDR4-3600 (CMK16GX4M2D3600C18), but Windows reports 2133 MHz. This usually means XMP/DOCP profile is not enabled in BIOS. After fresh install, consider enabling DOCP to run at rated 3600 MHz speed.

---

## Network Adapters

| Adapter | Status | Speed | MAC Address |
|---------|--------|-------|-------------|
| Intel I211 Gigabit | **Up** | 1 Gbps | 18-C0-4D-84-B3-41 |
| Intel Wi-Fi 6 AX200 | Not Present | - | 70-9C-D1-65-10-AD |
| Hyper-V vEthernet (Default Switch) | Up | 10 Gbps | 00-15-5D-0D-A5-17 |
| Hyper-V vEthernet (WSL) | Up | 10 Gbps | 00-15-5D-82-5C-43 |

**Intel I211 Driver**: 12.18.11.1 (June 2020) - Check for newer driver

**Note**: Wi-Fi adapter shows "Not Present" - may be disabled in BIOS or not connected. The virtual adapters are from Hyper-V/WSL.

---

## Audio Devices

| Device | Status |
|--------|--------|
| Realtek High Definition Audio | OK |
| NVIDIA High Definition Audio | OK |

---

## USB Controllers

| Controller | Status |
|------------|--------|
| AMD USB 3.10 eXtensible Host Controller (x3) | OK |

**Note**: X570 chipset provides multiple USB 3.1 Gen 2 controllers.

---

## Key Driver Versions (For Update Research)

| Component | Current Version | Date | Notes |
|-----------|-----------------|------|-------|
| BIOS | F37f | 2023-09-20 | Check Gigabyte for updates |
| GPU (NVIDIA) | 32.0.15.6094 | 2024-08-14 | Recent |
| Intel I211 Network | 12.18.11.1 | 2020-06-14 | **Older - check for update** |
| AMD Chipset | (need to verify) | - | Check AMD for latest |

---

## Research Needed

1. **Gigabyte X570 AORUS ULTRA Support Page**
   - Check for BIOS updates newer than F37f
   - Download latest chipset drivers

2. **Intel I211 Network Driver**
   - Current driver from 2020 is old
   - Check Intel download center

3. **AMD Chipset Drivers**
   - Get latest from AMD website for X570

4. **RAM XMP/DOCP**
   - Memory capable of 3600 MHz but running at 2133 MHz
   - Enable in BIOS after fresh install for better performance

---

## Summary

**System is in good condition for fresh install:**
- All storage devices healthy
- Modern CPU (Ryzen 5800X)
- Adequate RAM (16GB, can run faster with DOCP)
- Older but functional GPU (GTX 750 Ti)
- BIOS from late 2023
- Some drivers (especially Intel NIC) could use updates
