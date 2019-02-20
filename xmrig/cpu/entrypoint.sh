#!/bin/bash
#
# Run xmrig on Container.
#

set -eu

${BIN_NAME} --donate-level=${DONATE_LEVEL} \
     -o ${POOL} -u ${WALLET} -p x -k \
     -o ${POOL_FAIL} -u ${WALLET} -p x -k
