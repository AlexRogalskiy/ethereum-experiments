#!/bin/bash

networkid=77778
datadir=.ethereum_private-$networkid
port=30304

echo $datadir
rm -rf $datadir
mkdir $datadir

  # --ipcpath ~/Library/Ethereum/geth.ipc \
geth --fast --cache 512 \
  --nodiscover \
  --networkid $port \
  --port $port \
  --datadir $datadir \
  2>>$datadir/geth.log init genesis-$networkid.json
  
  # --ipcpath ~/Library/Ethereum/geth.ipc \
nohup geth --fast --cache 512 \
  --nodiscover \
  --networkid $port \
  --port $port \
  --datadir $datadir \
  2>>$datadir/geth.log &

pid=$(echo $!)

function finish {
  kill -9 $pid
  echo Killed geth of pid $pid
}
trap finish EXIT
echo Started geth with pid $pid

tail -f $datadir/geth.log | ctail








