#!/bin/bash

cat << EOF > ~/.hab/cache/keys/skylerto-20180220124055.pub
SIG-PUB-1
skylerto-20180220124055

$HAB_PUB
EOF

cat << EOF > ~/.hab/cache/keys/skylerto-20180220124055.sig.key
SIG-SEC-1
skylerto-20180220124055

$HAB_KEY
EOF

