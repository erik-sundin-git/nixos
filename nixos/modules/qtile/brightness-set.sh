read -p 'value: ' val
echo $val

echo $val > /sys/class/backlight/intel_backlight/brightness
