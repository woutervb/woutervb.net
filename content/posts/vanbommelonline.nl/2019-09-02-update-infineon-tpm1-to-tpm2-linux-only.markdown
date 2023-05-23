---
layout: post
title: "Update infineon TPM 1.2 to TPM 2.0 from linux"
date: "2019-09-02 08:58:02 +1000"
categories:
  - ubuntu
tags: {"HP Probook 440 G3", "TPM", "Wine"}
---

# Introduction

If you, like me have a linux only environment running on your system, you will run into upgrade issues once in a while.
I recently found that I wanted to use the tpm chip on my laptop, a HP Probook 440 G3, to decrypt my luks partition in an automated way.
And knowing that things will benefit me, from using the latest standard, it found that I should upgrade my tpm chip from 1.2 to the 2.0 standard, which is apparently possible with some of the chips.

I was lucky, I thought, as I got a laptop that supports the upgrade operation according to the support document from hp [link](https://support.hp.com/us-en/document/c05381064/).

Installing the tpm-tools on my Ubuntu 18.04 installation, quickly pointed me to the fact that I was running firmware version 1.2.6.40, so that meant I could upgrade.

# Prepare the upgrade

Great that HP has a firmware upgrade available for windows with a windows installer, but how to use it on Linux? This turned out to be a bit of a challenge.

Extracting the firmware was simple, my wine installation was perfectly capable of running the installer package from hp, that gave me a directory with the various firmware files.
The tricky part was, how to perform the actual upgrade. This turned out to be a bit of an issue, but solvable.

# Failed attempts

Initially I thought, that I could tread the bin file as a regular bios upgrade. So placed it in the various possible directories where a bios upgrade should be placed, so that the uefi can pick it up. But none of the worked.

I started looking into a usb stick based windows installation, so that I could run the installer, but all I read about that, was a lot of trouble.

Even started thinking of just accepting the fact that a upgrade is not possible from linux and started reading about luks tpm1.2 options.

# Final solution

By accident, I found that Chromebooks run a same brand tpm, as that my computer has. So that means that it should be possible to get the system upgraded in some way.
Searching github, finally gave me the following [repo](https://github.com/iavael/infineon-firmware-updater)

And this tool worked perfectly, using the following steps. The limitation is, that it only builds against openssl 1.0 and not 1.1, as far as I could tell.

    # Make sure build tools are installed
    sudo apt install build-essentials libssl-dev git-core

    # Clone, I forked so I have a stable reference for this blog
    git clone https://github.com/woutervb/infineon-firmware-updater.git
    cd infineon-firmware-update/TPMFactoryUpd
    make

This did work for me, so it is doable on at least a Ubuntu 18.04 installation.

Then I copied the correct BIN file from the wine directory to the directory I performed the build and executed the following command:

    sudo ./TPMFactoryUpd -update tpm12-PP -firmware TPM12_6.40.190.0_to_TPM20_7.62.3126.0.BIN

Crossed my fingers and the upgrade succeeded. Went into the bios to validate and indeed it is now marked as a TPM 2.0 compatible device. Since I was in the bios, took the options to clear the content of the chip, so I could use it for another project.

