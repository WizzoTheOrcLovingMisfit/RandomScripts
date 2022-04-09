REQUIRED_PKG="torsocks"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi
torsocks wget -P /tmp/malzip/ -i $1 --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0" 
zip  -m -j -P infected ~/Desktop/$(date +%s)mal.zip  $(find /tmp/malzip/ -type f -cmin -1 ! -name "mal.zip" ! -name "malzip.sh" ! -name $1 )
rm -rf /tmp/malzip/
echo "Finished downloading files in "$1
