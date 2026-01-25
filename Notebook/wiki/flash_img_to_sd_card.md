```shell
cd ~

diskutil list

# dev/disk2
# /Users/jaclynm/Downloads/2024-07-04-raspios-bookworm-armhf-lite.img
# /Users/jaclynm/Downloads/MPI3501-3.5inch-ubuntu-mate-22.04-desktop-armhf+raspi.img

diskutil unmountDisk /dev/disk2
sudo dd if=/Users/jaclynm/Downloads/MPI3501-3.5inch-ubuntu-mate-22.04-desktop-armhf+raspi.img of=/dev/rdisk2 bs=1m

sudo diskutil eject /dev/rdisk2
```
