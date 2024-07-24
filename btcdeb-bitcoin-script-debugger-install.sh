### BOZZA ###
Bitcoin Script Debugger (`btcdeb`) di @kallewoof
sudo apt-get install git
git clone https://github.com/bitcoin-core/btcdeb.git
# dovresti avere bitcoin-0.20.0-x86_64-linux-gnu.tar.gz  btcdeb  laanwj-releases.asc  SHA256SUMS.asc

sudo apt-get install autoconf libtool g++ pkg-config make

sudo apt-get install libreadline-dev

#You're now ready to compile and install `btcdeb`:
# cd btcdeb
# ./autogen.sh
# ./configure
# make
# sudo make install
After all of that, you should have a copy of `btcdeb`:
#
# which btcdeb
# /usr/local/bin/btcdeb
