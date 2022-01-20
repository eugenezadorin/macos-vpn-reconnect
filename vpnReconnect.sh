#!/bin/bash

name=""
operation=""

main() {
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --name) name="$2"; shift ;;
            connect) operation="connect" ;;
            disconnect) operation="disconnect" ;;
            status) operation="status" ;;
            toggle) operation="toggle" ;;
            *) echo "Unknown command: $1"; exit 1 ;;
        esac
        shift
    done

    if [[ "$name" == "" ]]
    then
        echo "Connection name must be specified"
        exit 1
    fi

    if [[ "$operation" == "disconnect" ]]
    then
        disconnect
    elif [[ "$operation" == "status" ]]
    then
        status
    elif [[ "$operation" == "toggle" ]]
    then
        toggle
    elif [[ "$operation" == "connect" ]] || [[ "$operation" == "" ]]
    then
        reconnect
    else
        echo "Unknown command"
        exit 1
    fi

    exit 0
}

disconnect() {
    networksetup -disconnectpppoeservice "${name}"
    status
}

status() {
    if isConnected
    then
        echo "${name}: connected"
    else
        echo "${name}: disconnected"
    fi
}

toggle() {
    if isConnected
    then
        disconnect
    else
        reconnect
    fi
}

reconnect() {
    if isConnected
    then
        echo "Connected to ${name}"
    else
        echo "Connecting to ${name}..."
        networksetup -connectpppoeservice "${name}"
        updateStatus
    fi
}

isConnected() {
    networksetup -showpppoestatus "${name}" | grep -q "^connected$"
}

isConnecting() {
    networksetup -showpppoestatus "${name}" | grep -q "^connecting$"
}

isDisconnected() {
    networksetup -showpppoestatus "${name}" | grep -q "^disconnected$"
}

updateStatus() {
    sleep 1
    for i in {1..10}
    do
        if isConnected
        then
            echo "Connected"
            break
        fi

        if isDisconnected
        then
            echo "Connection error"
            break
        fi

        sleep 1
    done
}


set -e 
main "${@}"
set +e