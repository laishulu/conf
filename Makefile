.PHONY: install config overwrite emacs mac-optional apt
install:
	source install.sh
config:
	source config.sh
overwrite:
	overwrite=yes source config.sh
emacs:
	overwrite=yes source emacs/config.sh
mac-optional:
	git submodule update --init --recursive
	source macos/optional/config.sh
apt:
	source core.apt.sh
extra:
	source extra.sh
dev:
	source dev.sh
