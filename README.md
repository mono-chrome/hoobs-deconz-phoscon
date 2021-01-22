## Homebridge | HOOBS DeConz-Phoscon Installer

### Info
This script will install DeConz and Phoscon for Homebridge | HOOBS 3 for v3.1.1 or higher

Go to hoobs.local -> ••• -> Terminal 

![](https://raw.githubusercontent.com/mono-chrome/hoobs-deconz-phoscon/master/terminal.png)

This works on the HOOBS Image, baseline Homebridge, Raspbian (headless), all other Linux Distros and MacOS. 

This does not work on Docker

### Installation
Run the following command:

```
  wget -q -O - https://raw.githubusercontent.com/mono-chrome/hoobs-deconz-phoscon/blob/master/update_deconz-phoscon-hoobs-beta.sh | sudo bash -
```

This is to be executed, all in one line. DeConz and Phoscon will be installed for you.
DeConz will run as a Daemon, where Phoscon UI is available via port `1881`.

**Phoscon UI is reachable at "hoobs.local:1881"**


### Troubleshooting
In case the installation did not entirely complete (this can happen depending on user-rights/auth) you may need to run the following after installation completes:

```shell
  sudo apt install -f
  sudo apt update
```
