#!/bin/bash
cd "$(dirname $0)/"
if [ ! -f "starnet/starnet++" ]; then
    if [ ! -f "starnet.zip" ]; then
        curl https://www.starnetastro.com/wp-content/uploads/2022/03/StarNetv2CLI_MacOS.zip -o starnet.zip
    fi
    unzip starnet.zip
    mv StarNetv2CLI_MacOS starnet
    rm starnet.zip
fi

if [ ! -x "starnet/starnet++" ]; then
    chmod +x starnet/starnet++
fi
