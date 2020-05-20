#!/usr/bin/env bash

fail() { echo "$*" >&2; exit 1; }

if command -v nix-collect-garbage >/dev/null 2>&1; then
	have_nix=1
else
	have_nix=0
fi
initially_multiuser=0

(( have_nix )) && { nix-collect-garbage || fail; }

if (( have_nix )); then
	nix-collect-garbage || fail
	if sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist; then
		initially_multiuser=1
	fi
fi

if ! grep -e nix /etc/synthetic.conf; then
	# shellcheck disable=SC2024
	sudo tee -a /etc/synthetic.conf < <(printf 'nix\nrun\tprivate/var/run\n') >/dev/null
	[[ -d /nix && ! -d /was-nix ]] && { sudo mv /nix /was-nix || fail "Unable to move old Nix installation out-of-the-way"; }
fi

sudo mkdir -p /nix || fail "Unable to create /nix; perhaps you already installed Catalina, and need to reboot for /etc/synthetic.conf to be activated?"

passphrase=$(openssl rand -base64 32)
echo "Creating encrypted APFS volume with passphrase: $passphrase" >&2

sudo diskutil apfs addVolume disk1 'Case-sensitive APFS' Nix -mountpoint /nix -passphrase "$passphrase"

UUID=$(diskutil info -plist /nix | plutil -extract VolumeUUID xml1 - -o - | plutil -p - | sed -e 's/"//g')

security add-generic-password -l Nix -a "$UUID" -s "$UUID" -D "Encrypted Volume Password" -w "$passphrase" \
 -T "/System/Library/CoreServices/APFSUserAgent" -T "/System/Library/CoreServices/CSUserAgent"

sudo diskutil enableOwnership /nix

grep -q -e 'LABEL=Nix' /etc/fstab || { echo 'LABEL=Nix /nix apfs rw' | sudo tee -a /etc/fstab >/dev/null; } || fail "Unable to create /etc/fstab entry for Nix"

[[ -d /was-nix ]] && {
	echo "Copying nix to new volume.." >&2
	{ sudo rsync -aH /was-nix/ /nix/ && sudo rm -rf /was-nix; } || echo "WARNING: nonzero exit status from rsync moving content from /was-nix to /nix" >&2
}

(( initially_multiuser )) && sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist

(( have_nix )) && {
	echo 'Waiting for nix-daemon..' >&2
	while ! nix ping-store >/dev/null 2>&1; do
	    echo -n '.' >&2
	    sleep 1
	done
	echo >&2
}

echo "Done!" >&2
