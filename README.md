# MacOS VPN Reconnect

Simple bash script to restore VPN connection from terminal.

## Setup

```
# 1. Download script
curl -o ~/vpnReconnect.sh https://raw.githubusercontent.com/eugenezadorin/macos-vpn-reconnect/main/vpnReconnect.sh

# 2. Inspect code, to be sure there is nothing criminal

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

## Notes

Script uses `networksetup` under the hood.

Configuration profile name for your network must be default.

Tested on MacOS 12.1 (Monterey)