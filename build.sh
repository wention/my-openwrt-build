#!/bin/sh

set -e


time_start=$(date +"%s")

set -x


./scripts/feeds update -a
./scripts/feeds install -a

make defconfig

make -j8 download || make download V=s

make -j16 || make -j1 V=s

set +x

echo "======================="
echo "Space usage:"
echo "======================="
df -h
echo "======================="
du -h --max-depth=1 ./ --exclude=build_dir --exclude=bin
du -h --max-depth=1 ./build_dir
du -h --max-depth=1 ./bin

time_end=$(date +"%s")

duration=$(date -u -d "@$(($time_end - $time_start))" +"%H hours, %M min, %S seconds")

echo "time: $duration"
