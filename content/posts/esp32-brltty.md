---
title: "Esp32 & brltty"
date: 2023-05-25T15:42:20+10:00
draft: false
tags: ["esp32", "embedded", "debugging"]
---

Having recently obtained a small esp32 based gadget (Holocube, more on that in another post). I obviously wanted to see if I could at least get some of the details via the `esptool.py`.

This unfortunately didn't work. There was not `/dev/ttyUSB*` device that mapped to the gadget available.

Scanning the `dmesg` output does confirm this:

    [59386.304049] usb 1-2: new full-speed USB device number 26 using xhci_hcd
    [59386.473422] usb 1-2: New USB device found, idVendor=1a86, idProduct=7523, bcdDevice=a2.33
    [59386.473427] usb 1-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
    [59386.473429] usb 1-2: Product: USB Serial
    [59386.478475] ch341 1-2:1.0: ch341-uart converter detected
    [59386.492526] usb 1-2: ch341-uart converter now attached to ttyUSB0
    [59387.073354] input: BRLTTY 6.5 Linux Screen Driver Keyboard as /devices/virtual/input/input68
    [59387.083431] usb 1-2: usbfs: interface 0 claimed by ch341 while 'brltty' sets config #1
    [59387.086554] ch341-uart ttyUSB0: ch341-uart converter now disconnected from ttyUSB0

After some searching and testing, it turns out, that by default Ubuntu installs a package called `brltty`, which implements support for a Braille interface, so that blind people can use Ubuntu out of the box.

Unfortunately that means that my esp32 device get wrongly identified, as it uses the same usb uart chip for serial communication (maybe even the same esp32 chip, I don't know enough about this subject).

So for me the easiest thing to do, was to remove that package via: `sudo apt remove brltty`. And reconnect the gadget device.

And this resulted in success. `dmesg` output:

    [60753.914727] usb 1-2: USB disconnect, device number 26
    [60756.232016] usb 1-2: new full-speed USB device number 27 using xhci_hcd
    [60756.394353] usb 1-2: New USB device found, idVendor=1a86, idProduct=7523, bcdDevice=a2.33
    [60756.394362] usb 1-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
    [60756.394366] usb 1-2: Product: USB Serial
    [60756.399313] ch341 1-2:1.0: ch341-uart converter detected
    [60756.413380] usb 1-2: ch341-uart converter now attached to ttyUSB0

And with the `ttyUSB0` device present I can query the gadget:

    $ esptool.py --chip esp32 -p /dev/ttyUSB0 flash_id
    esptool.py v4.5.1
    Serial port /dev/ttyUSB0
    Connecting....
    Chip is ESP32-PICO-D4 (revision v1.0)
    Features: WiFi, BT, Dual Core, 240MHz, Embedded Flash, VRef calibration in efuse, Coding Scheme None
    Crystal is 40MHz
    MAC: d4:d4:da:97:d8:d4
    Uploading stub...
    Running stub...
    Stub running...
    Manufacturer: c8
    Device: 4016
    Detected flash size: 4MB
    Hard resetting via RTS pin...
