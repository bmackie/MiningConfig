#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

export GPU_FORCE_64BIT_PTR=1
export GPU_MAX_HEAP_SIZE=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100

POOL=us1-etc.ethermine.org:4444
WALLET=0x9c3FE09a2607bb9ca27BCD7D453c46E1D25d8b59

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner --algo ETCHASH --pool $POOL --user $WALLET $@ --apiport 9999
