#!/usr/bin/sh
set -eu

gpg_encrypt() {
  gpg --no-keyring --encrypt --batch --recipient-file gpg.pub
}

gen_rand() {
  if [ $# -ne 1 ]; then
    exit 1
  fi
  if command -v openssl &>/dev/null; then
    openssl rand "$1"
  elif command -v gpg &>/dev/null; then
    gpg --gen-random 1 "$1"
  else
    dd if=/dev/urandom bs="$1" count=1
  fi
}

gen_rand | gpg_encrypt > keyfile.gpg
