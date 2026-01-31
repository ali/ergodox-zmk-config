Personal ZMK configuration for my SliceMK ErgoDox Wireless.

## My Hardware

| Component | Model | Board ID |
|-----------|-------|----------|
| Dongle | Raytac MDBT50Q-RX | `nRF52840-MDBT50Q_RX-verD` |
| Left half | SliceMK ErgoDox 202108 Green | `nRF52840-slicemk-ergodox-202108-green` |
| Right half | SliceMK ErgoDox 202108 Green | `nRF52840-slicemk-ergodox-202108-green` |

## Building Firmware

### Local Build (Docker)

```bash
./build.sh                              # build dongle (default)
./build.sh raytac_mdbt50q_rx slicemk_ergodox_dongle  # explicit
ZMK_BRANCH=feat/battery-reporting ./build.sh        # use battery branch
```

Output goes to `output/` directory.

### GitHub Actions

Push to trigger a build. Download artifact from Actions tab.

### ZMK Fork

Uses [`ali/zmk`](https://github.com/ali/zmk) fork with SliceMK fixes from xudongzheng.

| Branch | Description |
|--------|-------------|
| `main` | SliceMK base (stable) |
| `feat/battery-reporting` | USB HID battery reporting for split keyboards |

## Firmware Files

| File | Source |
|------|--------|
| Dongle | Built from this repo |
| `firmware/ergodox-202108_green-peripheral_ble-left.uf2` | [SliceMK](https://docs.slicemk.com/keyboard/ergodox/peripheral/) |
| `firmware/ergodox-202108_green-peripheral_ble-right.uf2` | [SliceMK](https://docs.slicemk.com/keyboard/ergodox/peripheral/) |
| `firmware/nvsclear.uf2` | [SliceMK](https://docs.slicemk.com/firmware/zmk/wireless/nvsclear/) |

## Troubleshooting

### Pairing Issues (Red LED stuck on peripheral)

Flash nvsclear to **all three** devices, then re-flash normal firmware:

```bash
# 1. Put each device in bootloader (double-tap reset)
# 2. Copy firmware/nvsclear.uf2 to each
# 3. Wait 15 seconds
# 4. Flash dongle firmware
# 5. Flash peripheral firmware to left and right
```

Docs: [SliceMK NVS Clear](https://docs.slicemk.com/firmware/zmk/wireless/nvsclear/)

### Button Reference

| Button | Function |
|--------|----------|
| Right (Reset) | Single press = reboot · Double press = bootloader |
| Left (User) | Single press = power off (wake with reset button) |

Tip: **R**ight = **R**eset

## Customization

- Keymap: `config/slicemk_ergodox.keymap`
- Dongle config: `config/slicemk_ergodox_dongle.conf`
- ZMK fork: `config/west.yml`
