#!/bin/bash

#!/bin/bash
function git_sparse_clone() {
branch="$1" rurl="$2" localdir="$3" && shift 3
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd ..
rm -rf $localdir
}

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

# 易有云团队
git clone --depth 1 -b main https://github.com/linkease/istore && mv -n istore/luci/{luci-app-store,luci-lib-taskd,luci-lib-xterm,taskd} ./ ; rm -rf istore
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/{luci-app-ddnsto,luci-app-floatip,luci-app-istoreenhance,luci-app-istorex,luci-app-linkease,luci-app-quickstart,luci-app-unishare,luci-lib-iform,luci-nginxer} ./ ; rm -rf nas-packages-luci
git clone --depth 1 https://github.com/linkease/nas-packages && mv -n nas-packages/multimedia/ffmpeg-remux ./ ; rm -rf nas-packages
git clone --depth 1 https://github.com/linkease/nas-packages && mv -n nas-packages/network/services/{ddnsto,floatip,istoreenhance,linkease,linkmount,quickstart,unishare,webdav2} ./ ; rm -rf nas-packages
git clone --depth 1 -b main https://github.com/linkease/openwrt-app-actions && mv -n openwrt-app-actions/applications/luci-app-ap-modem ./ ; rm -rf openwrt-app-actions

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
*/Makefile

rm -rf ./*/.git ./*/.gitattributes ./*/.svn ./*/.github ./*/.gitignore
#find . -type f -name Makefile -exec sed -i 's/PKG_BUILD_FLAGS:=no-mips16/PKG_USE_MIPS16:=0/g' {} +

exit 0
