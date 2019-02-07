# vi: set ft=make noexpandtab ts=2 sw=2 sts=0:
IMAGE   := yokogawa/debian
SUITE   := lenny
MIRROR   = http://archive.debian.org/debian/
GIT_HASH = b877fc31c51baaf1ec42501ab366dd05a5b6bb21

default: mkimage

mkimage: keyrings/debian-archive-keyring.gpg
	./mkimage-debootstrap.sh -k keyrings/debian-archive-keyring.gpg -s $(IMAGE) $(SUITE) $(MIRROR)

#mkimage: keyrings/debian-archive-keyring.gpg mkimage.sh
#	sudo ./mkimage.sh -t $(IMAGE) debootstrap --keyring=keyrings/debian-archive-keyring.gpg $(SUITE) $(MIRROR)
#
#mkimage.sh: mkimage/debootstrap
#	wget https://raw.githubusercontent.com/moby/moby/master/contrib/mkimage.sh -O mkimage.sh
#	chmod +x mkimage.sh
#
#mkimage/debootstrap:
#	mkdir -p mkimage
#	wget https://raw.githubusercontent.com/moby/moby/$(GIT_HASH)/contrib/mkimage/debootstrap -O mkimage/debootstrap
#	chmod +x mkimage/debootstrap

keyrings/debian-archive-keyring.deb: 
	mkdir -p keyrings
	wget http://archive.debian.org/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2010.08.28~lenny1_all.deb -O keyrings/debian-archive-keyring.deb

keyrings/debian-archive-keyring.gpg: keyrings/debian-archive-keyring.deb
	ar x keyrings/debian-archive-keyring.deb data.tar.gz
	tar --strip-components=3 -xzf data.tar.gz ./usr/share/keyrings/debian-archive-keyring.gpg
	rm data.tar.gz

mkimage-debootstrap.sh.orginal:
	wget https://raw.githubusercontent.com/moby/moby/$(GIT_HASH)/contrib/mkimage-debootstrap.sh -O mkimage-debootstrap.sh.orginal
	chmod +x mkimage-debootstrap.sh.orginal

clean:
	rm -vfr data.tar.gz mkimage.sh mkimage-debootstrap.sh keyrings mkimage

.PHONY: mkimage clean

