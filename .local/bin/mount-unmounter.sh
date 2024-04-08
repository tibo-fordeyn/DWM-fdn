#!/bin/bash

# functies schrijven, jeej
find_mountpoint() {
	for i in {1..6}; do
		if ! mount | grep -q "/mnt/usb$i"; then
			echo "/mnt/usb$i"
			return
		fi
	done
	echo "Geen beschikbare mountpoints" >&2
	exit 1
}
list_partitions_and_mounts() {
    	echo "Niet gemounte partities: "
        lsblk -rpo "name,type,mountpoint" | awk '$2=="part" && $3=="" && $1!="/dev/nvme0n1p2"{print $1}'

    	echo "    "
        echo "Gemounte mappen: "
    	for i in {1..6}; do
       	     	if mount | grep -qw "/mnt/usb$i"; then
                	echo "/mnt/usb$i"
		fi
	done
									    
}


# start van het script
chosen=$(list_partitions_and_mounts | dmenu -i -p "Kies partitie voor mount of map voor unmount")


if mount | grep -q "$chosen"; then
    sudo umount "$chosen"
else
    mountpoint=$(find_mountpoint)
    if lsblk -rpo "fstype" "$chosen" | grep -q "crypto_LUKS"; then
    	cryptname=""
        for i in {1..6}; do
		cryptname="cryptvolume$i"
	        if [ ! -e "/dev/mapper/$cryptname"  ]; then
			sudo cryptsetup open "$chosen" "$cryptname" || exit 1
			sudo mount "/dev/mapper/$cryptname" "$mountpoint"
			break
		fi
	done
    else
	sudo mount "$chosen" "$mountpoint"
    fi
fi



