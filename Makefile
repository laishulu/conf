.PHONY: install config overwrite emacs mac-optional apt
help:
	@echo "help         -- print help"
	@echo "install      -- install and config packages"
	@echo "overwrite    -- just overwrite local config"
	@echo "emacs        -- install and config emacs"
	@echo "mac-optional -- install and config optional packages for macos"
	@echo "apt          -- install packages by apt without config"
	@echo "extra        -- install extra packages by apt without config"
	@echo "dev          -- install packages for development"
install:
	bash install.sh
config:
	bash config.sh
overwrite:
	overwrite=yes bash config.sh
emacs:
	overwrite=yes bash emacs/install.sh
mac-optional:
	git submodule update --init --recursive
	bash macos/optional/config.sh
apt:
	bash core.apt.sh
extra:
	bash extra.sh
dev:
	bash dev.sh
