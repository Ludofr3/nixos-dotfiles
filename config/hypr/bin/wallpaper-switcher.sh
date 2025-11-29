#!/usr/bin/env bash

# Wallpaper paths for each workspace
declare -A wallpapers=(
    [1]="/home/ludofr3/Wallpapers/flying_city.jpg"
    [2]="/home/ludofr3/Wallpapers/girl_city.jpg"
    [3]="/home/ludofr3/Wallpapers/girl_with_rabbits.jpg"
    # Add more as needed...
)

# Get current workspace - with error handling
current_workspace=$(hyprctl activeworkspace -j 2>/dev/null | jq -r '.id' 2>/dev/null)

# Fallback if jq fails
if [[ -z "$current_workspace" || "$current_workspace" == "null" ]]; then
    current_workspace=$(hyprctl activeworkspace | grep -oP 'workspace ID \K\d+' | head -1)
fi

# Debug output (optional, remove if not needed)
echo "Current workspace: $current_workspace" >> /tmp/wallpaper-debug.log

# Set wallpaper for current workspace
if [[ -n "${wallpapers[$current_workspace]}" ]]; then
    # Check if wallpaper file exists
    if [[ -f "${wallpapers[$current_workspace]}" ]]; then
        swww img "${wallpapers[$current_workspace]}" --transition-type wipe --transition-duration 0.3
        echo "Set wallpaper: ${wallpapers[$current_workspace]}" >> /tmp/wallpaper-debug.log
    else
        echo "Wallpaper file not found: ${wallpapers[$current_workspace]}" >> /tmp/wallpaper-debug.log
    fi
else
    echo "No wallpaper defined for workspace $current_workspace" >> /tmp/wallpaper-debug.log
fi
