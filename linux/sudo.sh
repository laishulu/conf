#!/usr/bin/env bash

if [[ $LANG != *UTF-8* ]]; then
	sudo locale-gen en_US.UTF-8
	sudo update-locale
	echo 'LANG=en_US.UTF-8' | sudo tee /etc/default/locale
	echo 'LANGUAGE=en_US:en' | sudo tee /etc/default/locale
fi
