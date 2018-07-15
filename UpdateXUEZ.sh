                                          #/bin/bash
cd ~
echo "****************************************************************************"
echo "*                        XUEZ WALLET UPDATE SCRIPT                         *"
echo "****************************************************************************"
./xuez-cli stop
pkill -9 xuezd
rm ~/.xuez/peers.dat
rm ~/.xuez/mnpayments.dat
rm ~/.xuez/mncache.dat
rm ~/.xuez/fee_estimates.dat
rm ~/.xuez/debug.log
rm ~/.xuez/db.log
rm ~/.xuez/budget.dat
rm ~/.xuez/.lock
rm -r ~/.xuez/zerocoin
rm -r ~/.xuez/chainstate
rm -r ~/.xuez/blocks
rm -r ~/.xuez/sporks
rm ~/xuez-cli
rm ~/xuezd
rm ~/xuez-linux-cli.tgz
rm ~/xuez-tx
echo ""
wget https://github.com/XUEZ/xuez/releases/download/1.0.1.10/xuez-linux-cli-10110.tgz 
echo ""
echo ""
tar -xvzf xuez-linux-cli-10110.tgz
./xuezd -daemon
echo "****************************************************************************"
echo "*                        UPDATE COMPLETE                                   *"
echo "****************************************************************************"
