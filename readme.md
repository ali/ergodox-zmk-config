Personal ZMK configuration for my SliceMK ErgoDox Wireless.

## My Hardware

| Component | Model | Board ID |
|-----------|-------|----------|
| Dongle | Raytac MDBT50Q-RX | `nRF52840-MDBT50Q_RX-verD` |
| Left half | SliceMK ErgoDox 202108 Green | `nRF52840-slicemk-ergodox-202108-green` |
| Right half | SliceMK ErgoDox 202108 Green | `nRF52840-slicemk-ergodox-202108-green` |

## Firmware Sources

- **Dongle**: Built via GitHub Actions from this repo
- **Peripherals**: Pre-built from [SliceMK peripheral page](https://docs.slicemk.com/keyboard/ergodox/peripheral/) (202108 Green)
- **Stock firmware**: Kept in `firmware/` directory for convenience

## Troubleshooting

If pairing breaks between halves:
1. Flash `firmware/nvsclear.uf2` to all three devices (dongle, left, right)
2. Wait 15 seconds
3. Flash normal firmware to each device
4. Docs: [SliceMK NVS Clear](https://docs.slicemk.com/firmware/zmk/wireless/nvsclear/)

## Button Reference

| Button | Function |
|--------|----------|
| Right (Reset) | Single press = reboot · Double press = bootloader |
| Left (User) | Single press = power off (wake with reset button) |

---

*Based on the [SliceMK ErgoDox Wireless](https://www.slicemk.com/pages/ergodox-wireless) default config.*

# Getting Started

- Fork this repository on GitHub.
- Modify the `board` and `shield` values in `build.yaml` to match the ZMK build
  target based on your hardware (see below).

# Customization

- To modify your keymap, edit `config/slicemk_ergodox.keymap`.
- If you are using a dongle, add custom ZMK configuration options to
  `config/slicemk_ergodox_dongle.conf`. If you are not using a dongle, custom
  options should instead go in `config/slicemk_ergodox_leftcentral.conf`.
- To use with a custom ZMK fork, edit `config/west.yml`.

# Board/Shield

If you are not sure which dongle or PCB version you have, please put your
dongle/PCB into bootloader mode and check the "Model" value within the
`INFO_UF2.TXT` file.

GitHub Actions will only build the firmware for your central. Please download
the firmware for your peripheral(s)
[here](https://www.slicemk.com/pages/ergodox-wireless-peripheral).

Here are some of the common dongle options:

- **Raytac MDBT50Q-RX Green**
	- Board `raytac_mdbt50q_rx_green`
	- Shield `slicemk_ergodox_dongle`
- **Raytac MDBT50Q-RX** (if it does not say "green")
	- Board `raytac_mdbt50q_rx`
	- Shield `slicemk_ergodox_dongle`
- **Nordic nRF52840 Dongle**
	- Board `nordic_nrf52840_dongle_slicemk`
	- Shield `slicemk_ergodox_dongle`
- **SliceMK USB C Dongle MDBT50Q Blue**
	- Board `slicemk_usbc_mdbt50q_blue`
	- Shield `slicemk_ergodox_dongle`

Here are some of the common dongleless options:

- **SliceMK ErgoDox Wireless 202104**
	- Board `slicemk_ergodox_202104`
	- Shield `slicemk_ergodox_leftcentral`
- **SliceMK ErgoDox Wireless 202108 Blue**
	- Board `slicemk_ergodox_202108_blue_left`
	- Shield `slicemk_ergodox_leftcentral`
- **SliceMK ErgoDox Wireless 202108 Green**
	- Board `slicemk_ergodox_202108_green_left`
	- Shield `slicemk_ergodox_leftcentral`
- **SliceMK ErgoDox Wireless 202109**
	- Board `slicemk_ergodox_202109`
	- Shield `slicemk_ergodox_leftcentral`
- **SliceMK ErgoDox Wireless 202205 Green**
	- Board `slicemk_ergodox_202205_green_left`
	- Shield `slicemk_ergodox_leftcentral`
- **SliceMK ErgoDox Wireless 202207 Green**
	- Board `slicemk_ergodox_202207_green_left`
	- Shield `slicemk_ergodox_leftcentral`
