# ONIE Packer

A tool to create ONIE installer image from regular Linux OS image files (ISO, IMG, etc.).

This tool can be used to create a specialized [ONIE installer](https://opencomputeproject.github.io/onie/overview/index.html) for whitebox switches from regular ISO images of various popular Linux distributions.

## Usage

`./onie_pack.sh [-i installer] os_image`

**installer** - is a script in `installers` directory, which will handle OS installation from a regular ISO image when it is launched by ONIE environment on a switch.
Default installer: `ubuntu18xx-iso`

## Currently supported installers

### Ubuntu

* Supported versions: 18.04, 18.10
* Supported OS images:
  * ubuntu-18.04-live-server-amd64.iso
  * ubuntu-18.10-live-server-amd64.iso
* Default credentials:
  * admin/admin
  * root/Password1

## Currently supported switches

* Mellanox SN2100
* Mellanox SN2010

## Examples

### Creating ONIE installer from Ubuntu Server ISO image

* Clone this repo: `git clone https://github.com/kvadrage/onie-packer`
* `cd onie-packer`
* Download ISO file: `wget http://releases.ubuntu.com/18.10/ubuntu-18.10-live-server-amd64.iso`
* Pack it into ONIE installer: `./onie_pack.sh ubuntu-18.10-live-server-amd64.iso`
* ONIE installer is ready: `onie-installer-x86_64-<date>.bin`

### Installing OS on a switch

* Boot to ONIE Rescue shell
* `onie-nos-install http://<ip>/onie-installer-x86_64-<date>.bin`
* Wait until OS is installed
* `ssh admin@<switch_ip>`

## Credits

* Pavel Fiskovich ([@khannz](https://github.com/khannz)) - for sharing some ideas about ONIE installer script for Ubuntu