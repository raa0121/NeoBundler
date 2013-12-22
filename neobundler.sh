#!/usr/bin/sh

cat > .neobundlerc <<EOF
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath+=./.neobundle
  call neobundle#rc(expand('./lib'))
endif
source ./NeoBundlefile
filetype plugin indent on
EOF

cat > .neobundlerc <<EOF
.neobundle/
.neobundlerc
EOF

if [ -s .neobundle ] ; then
  cd .neobundle && git pull --rebase && cd ..
else
  git clone git://github.com/Shougo/neobundle.vim.git ./.neobundle
fi

mkdir -p lib
if [ $1 = "install" ] ; then
  vim -u NONE --cmd "so .neobundlerc | NeoBundleInstall | q!"
elif [ $1 = "update" ] ; then
  vim -u NONE --cmd "so .neobundlerc | NeoBundleUpdate| q!"
fi
