#
# Example shell file for starting PhoenixMiner.exe to mine ETH
#

# IMPORTANT: Replace the ETH address with your own ETH wallet address in the -wal option (Rig001 is the name of the rig)
./PhoenixMiner -pool ssl://eu1.ethermine.org:5555 -pool2 ssl://us1.ethermine.org:5555 -wal 0x31454f004F00Ebabc17A91312BCF2D4DdA63d56e.0x31454f004F00Ebabc17A91312BCF2D4DdA63d56e -cdm 1 -cdmport 0.0.0.0:3335 -rmode 2
