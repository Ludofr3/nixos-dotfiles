#!/usr/bin/env bash

className=$1

running=$(hyprctl -j clients | jq -r ".[] | select(.class == \"${className}\") | .workspace.id")

if [[ $running != "" ]]; then
    hyprctl dispatch workspace $running
fi