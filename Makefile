.PHONY: install config overwrite emacs mac-optional apt
install:
	bash install.sh
config:
	bash config.sh
overwrite:
	overwrite=yes bash config.sh
emacs:
	overwrite=yes bash emacs/config.sh
mac-optional:
	git submodule update --init --recursive
	bash macos/optional/config.sh
apt:
	bash core.apt.sh
extra:
	bash extra.sh
dev:
	bash dev.sh
