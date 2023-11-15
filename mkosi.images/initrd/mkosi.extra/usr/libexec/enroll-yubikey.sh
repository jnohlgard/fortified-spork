#!/usr/bin/sh
set -eu

systemd-cryptenroll --wipe-slot=empty --fido2-device=auto --tpm2-public-key=/run/systemd/tpm2-pcr-public-key.pem --tpm2-signature=/run/systemd/tpm2-pcr-signature.json --tpm2-public-key-pcrs=11
