# bluetooth.sh
# The author disclaims copyright to this source code. It is placed in
# the public domain. In case this is not legally possible I grant anyone
# the right to use it for any purpose, without any conditions, unless
# such conditions are required by law.

function __bluetooth_find_device {
    DEVICE=''
    if [[ -f ~/.bluetooth_devices ]]; then
        DEVICES=`cat ~/.bluetooth_devices`
        while read -r DEV; do
            echo $DEV | grep " ${1}$" &> /dev/null
            if [[ $? -eq 0 ]]; then
                DEVICE=`echo $DEV | sed -e 's/ .*$//'`
            fi
        done <<< "$DEVICES"
    fi
}

function __bluetooth_turn_on {
    echo 'Turning bluetooth on'
    bluez-test-adapter powered on
    sudo hciconfig hci0 reset
    sudo hciconfig hci0 up
}

function __bluetooth_turn_off {
    echo 'Turning bluetooth off'
    sudo hciconfig hci0 down
    bluez-test-adapter powered off
}

function bluetooth_connect {
    __bluetooth_find_device $1
    if [[ -z $DEVICE ]]; then
        echo 'Device not found'
        return
    fi
    RET=`bluez-test-adapter powered`
    if [[ $RET -eq 0 ]]; then
        __bluetooth_turn_on
    fi
    RET=`echo 0000 | simple-agent hci0 $DEVICE`
    echo $RET | grep 'AlreadyExists' &> /dev/null
    if [[ $? -eq 0 ]]; then
        echo 'Already connected'
        return
    fi
    echo $RET | grep 'Error' &> /dev/null
    if [[ $? -eq 0 ]]; then
        echo 'Failed to pair'
        return
    fi
    bluez-test-device trusted $DEVICE yes
    bluez-test-input connect $DEVICE
    sudo hcitool enc $DEVICE
}

function bluetooth_disconnect {
    __bluetooth_find_device $1
    if [[ -z $DEVICE ]]; then
        echo 'Device not found'
        return
    fi
    bluez-test-device list | grep $DEVICE &> /dev/null
    if [[ $? -ne 0 ]]; then
        echo 'Device is not connected'
        return
    fi
    bluez-test-device remove $DEVICE
    RET=`hcitool conn | wc -l`
    if [[ $RET -eq 1 ]]; then
        __bluetooth_turn_off
    fi
}
