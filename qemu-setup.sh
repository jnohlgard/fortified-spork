#!/usr/bin/sh
set -eu

printf 'Creating disk images for testing with qemu\n'

target_dir="$(cd "${0%/*}" && pwd)/disks"
printf 'Target directory: %s\n' "${target_dir}"
mkdir -p "${target_dir}"
cd "${target_dir}"
for d in \
  root-1 \
  var-1 \
  var-2 \
  srv-1 \
  ; do
  qemu-img create -f qcow2 \
    -o compat=v3,cluster_size=1024k,extended_l2=on,lazy_refcounts=on,preallocation=metadata,cluster_size=128k \
    "$d.qcow2" 16G
done

