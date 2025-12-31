#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Script for Monitor backlights (if supported) using brightnessctl

step=2  # INCREASE/DECREASE BY THIS VALUE

# Get current brightness as an integer (without %)
get_brightness() {
    brightnessctl -m | cut -d, -f4 | tr -d '%'
}

# Change brightness and notify
change_brightness() {
    local delta=$1
    local current new icon

    current=$(get_brightness)
    new=$((current + delta))

    # Clamp between 5 and 100
    (( new < 0 )) && new=5
    (( new > 100 )) && new=100

    brightnessctl set "${new}%"
}

# Main
case "$1" in
    "--get")
        get_brightness
        ;;
    "--inc")
        change_brightness "$step"
        ;;
    "--dec")
        change_brightness "-$step"
        ;;
    *)
        get_brightness
        ;;
esac