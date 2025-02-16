#!/bin/sh

set -e

TOPDIR=$(realpath $(dirname $0))

BUILDDIR="$TOPDIR/build"

OPENWRTREPO="https://github.com/coolsnowwolf/lede.git"

time_start=$(date +"%s")

set -x

if [ ! -d "$BUILDDIR" ];then
    git clone $OPENWRTREPO $BUILDDIR
fi

### generate feeds.conf
if [ ! -e "$BUILDDIR/feeds.conf" ];then
    cp -f "$BUILDDIR/feeds.conf.default" "$BUILDDIR/feeds.conf"

    cat >> "$BUILDDIR/feeds.conf" <<EOF
src-git helloworld https://github.com/fw876/helloworld.git

src-git openclash https://github.com/vernesong/OpenClash.git
src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git
src-git openappfilter https://github.com/destan19/OpenAppFilter.git
EOF
fi

if [ ! -e "$BUILDDIR/.config" ];then
    echo "copy x86_64 config seed"
    cp -f configs/x86_64.config $BUILDDIR/.config
else
    make defconfig
fi

cd $BUILDDIR

./scripts/feeds update -a
./scripts/feeds install -a

make defconfig

make -j8 download || make download V=s

make -j$(nproc) || make -j1 V=s

set +x

echo "============= Space usage =============="
echo "======================="
df -h
echo "======================="
du -h --max-depth=1 ./ --exclude=build_dir --exclude=bin
du -h --max-depth=1 ./build_dir
du -h --max-depth=1 ./bin

time_end=$(date +"%s")

echo "============= Build Version =============="

LEDE_REV=`git rev-list --max-count=1 HEAD`
REPO_URL=`git remote get-url origin`

echo "OpenWRT:"
echo "$REPO_URL^$LEDE_REV"
echo ""
echo "feeds:"
./scripts/feeds list -sf


echo "============= Build Time =============="

duration=$(date -u -d "@$(($time_end - $time_start))" +"%H hours, %M min, %S seconds")

echo "time: $duration"

cd -