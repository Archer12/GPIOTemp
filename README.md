# GPIOTemp
Script ini berfungsi untuk mengaktifkan GPIO ketika suhu sudah mencapai ambang batas yang ditentukan

## instalasi :


    wget -q "https://raw.githubusercontent.com/Archer12/GPIOTemp/main/gpiotemp.sh" -O /usr/bin/gpiotemp.sh && chmod +x /usr/bin/gpiotemp.sh

## Cara Menjalankan :

Masuk ke Luci -> System -> Startup -> Local Startup, copy line dibawah ini sebelum exit 0
    
    /usr/bin/gpiotemp.sh -r
