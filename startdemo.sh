#!/usr/bin/env bash

set -e

demo=${1%/}

echo $demo

cp $demo/infrastructure_config.py .

if [ -f $demo/sf-config.sh ]; then
    cp $demo/sf-config.sh .
fi
if [ -f $demo/sff-config.sh ]; then
    cp $demo/sff-config.sh .
fi
if [ -f $demo/pxy-config.sh ]; then
    cp $demo/pxy-config.sh .
fi
if [ -f $demo/sw-config.sh ]; then
    cp $demo/sw-config.sh .
fi

echo "Starting demo from $demo with vars:"
echo "Number of nodes: " $NUM_NODES
echo "Opendaylight Controller: " $ODL
echo "Base subnet: " $SUBNET

for i in `seq 1 $NUM_NODES`; do
  hostname="sfcpxy"$i
  echo $hostname
  vagrant ssh $hostname -c "sudo -E /vagrant/infrastructure_launch.py"
done

#echo "Configuring controller..."
#./$demo/rest.py

