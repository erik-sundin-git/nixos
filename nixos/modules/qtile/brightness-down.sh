#!/bin/sh

echo $(($(cat /sys/class/backlight/intel_backlight/brightness) - 2000)) >/sys/class/backlight/intel_backlight/brightness
