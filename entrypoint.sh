#!/bin/bash
datadir=/mnt/sia

# https://github.com/NebulousLabs/Sia/issues/2215
# TODO: confirm if fixed in 1.3.1
tmpdir=$datadir/host/contractmanager
if [[ -h $tmpdir ]]; then
  tmpfs-sync recover $tmpdir
fi

tmpfs-sync init $tmpdir
while sleep 30; do
  tmpfs-sync sync $tmpdir >/dev/null
done &
./siad -M gctwhr -d $datadir &

exec /bin/bash -l
