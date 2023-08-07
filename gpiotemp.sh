#!/bin/sh
# dibuat oleh: arif.kholid

# PIN GPIO yang dipakai
gpio_num=480

# inisiasi GPIO
echo $gpio_num > /sys/class/gpio/unexport
echo $gpio_num > /sys/class/gpio/export
echo out > /sys/class/gpio/gpio$gpio_num/direction

# Inisiasi GPIO state
gpio_state=0

# Temperature threshold dalam mili Celsius (misal, 48000 untuk 48°C, 4900 untuk 49°C dst.)
TEMP_THRESHOLD=48000

# 1 Untuk mengaktifkan debug, 0 untuk disable
DEBUG=1

while true; do
    # Membaca temperatur cpu
    CPU_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)

    # Convert millidegrees Celsius ke degrees Celsius
    CPU_TEMP_C=$((CPU_TEMP / 1000))

    if [ $DEBUG -eq 1 ]; then
        echo "Suhu CPU Saat Ini: $CPU_TEMP_C°C"
    fi

    if [ $CPU_TEMP -ge $TEMP_THRESHOLD ]; then
        if [ $gpio_state -eq 0 ]; then
            if [ $DEBUG -eq 1 ]; then
                echo "Ambang batas suhu CPU terlampaui. Mengaktifkan GPIO $gpio_num."
            fi
            
            # GPIO ON
            echo 1 > /sys/class/gpio/gpio$gpio_num/value
            gpio_state=1
        fi
    else
        if [ $gpio_state -eq 1 ]; then
            if [ $DEBUG -eq 1 ]; then
                echo "Mematikan GPIO $gpio_num."
            fi
            
            # GPIO OFF
            echo 0 > /sys/class/gpio/gpio$gpio_num/value
            gpio_state=0
        fi
    fi

    sleep 10 # Tidur selama 10 detik sebelum memeriksa suhu lagi
done
