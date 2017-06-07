# vi: set ft=make noexpandtab ts=2 sw=2 sts=0:
IMAGE := yokogawa/debian
SUITE := lenny
MIRROR = http://archive.debian.org/debian/

mkimage: mkimage-debootstrap.sh
	./mkimage-debootstrap.sh -s $(IMAGE) $(SUITE) $(MIRROR)

mkimage-debootstrap.sh:
	wget https://raw.githubusercontent.com/moby/moby/master/contrib/mkimage-debootstrap.sh
	chmod +x mkimage-debootstrap.sh

.PHONY: mkimage

