# MacOS VPN Reconnect

Simple bash script to restore VPN connection from terminal.

## Setup

```
# 1. Download script and inspect code, to be sure there is nothing criminal
curl -o ~/vpnReconnect.sh \
https://raw.githubusercontent.com/eugenezadorin/macos-vpn-reconnect/main/vpnReconnect.sh

# 2. Make script executable
chmod +x ~/vpnReconnect.sh

# 3. Add an alias to your .bashrc/.zshrc file, specifying your connection name
echo "alias vpn='~/vpnReconnect.sh --name MyNetworkName'" >> ~/.zshrc
source ~/.zshrc
```

## Usage

```
vpn # reconnect if not connected
vpn connect # works the same
vpn disconnect # close connection
vpn status # show connection status
vpn toggle # connect if disconnected, disconnect otherwize
```

You can use `--name MyOtherNetwork` to run command with other network.

## Upgrade

Just remove old script, then see Setup. Step 3 (making alias) can be skipped.

## Notes

Script uses `networksetup` under the hood.

Configuration profile name for your network must be default.

Tested on MacOS 12.1 (Monterey)