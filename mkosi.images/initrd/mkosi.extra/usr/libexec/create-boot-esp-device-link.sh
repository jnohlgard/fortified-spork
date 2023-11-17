#!/usr/bin/sh
set -eu

efi_var='LoaderDevicePartUUID-4a67b082-0a4c-41cf-b6c7-440b29bb8c4f'
partuuid="$(cat "/sys/firmware/efi/efivars/${efi_var}" | tail -c +5 | iconv -f utf16le -t utf8 | tr -cd "[:graph:]" | tr "[:upper:]" "[:lower:]")"

if [ -z "${partuuid}" ]; then
  >&2 printf 'Missing %s EFI variable\n' "${efi_var}"
  exit 1
fi

if [ -L "/dev/disk/by-partuuid/${partuuid}" ]; then
  cp -dv "/dev/disk/by-partuuid/${partuuid}" "/dev/disk/by-id/boot-esp"
else
  ln -sv "../by-partuuid/${partuuid}" "/dev/disk/by-id/boot-esp"
fi
