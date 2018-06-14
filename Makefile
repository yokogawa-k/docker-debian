# vi: set ft=make noexpandtab ts=2 sw=2 sts=0:
IMAGE := yokogawa/debian
SUITE := lenny
MIRROR = http://archive.debian.org/debian/

default: mkimage

mkimage: mkimage.sh
	sudo ./mkimage.sh -t $(IMAGE) debootstrap $(SUITE) $(MIRROR)

mkimage.sh: mkimage/debootstrap
	wget https://raw.githubusercontent.com/moby/moby/master/contrib/mkimage.sh -O mkimage.sh
	chmod +x mkimage.sh

mkimage/debootstrap:
	mkdir -p mkimage
	wget https://raw.githubusercontent.com/moby/moby/master/contrib/mkimage/debootstrap -O mkimage/debootstrap
	chmod +x mkimage/debootstrap

# deprecated
mkimage-debootstrap.sh:
	wget https://raw.githubusercontent.com/moby/moby/master/contrib/mkimage-debootstrap.sh
	chmod +x mkimage-debootstrap.sh

.PHONY: mkimage

