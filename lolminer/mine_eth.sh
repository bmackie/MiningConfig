#!/bin/bash

#################################
## Begin of user-editable part ##
#################################

POOL=us1.ethermine.org:4444
WALLET=0x31454f004F00Ebabc17A91312BCF2D4DdA63d56e.0x31454f004F00Ebabc17A91312BCF2D4DdA63d56e

#################################
##  End of user-editable part  ##
#################################

cd "$(dirname "$0")"

./lolMiner --algo ETHASH --pool $POOL --user $WALLET $@
