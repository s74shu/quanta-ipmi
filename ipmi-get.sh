#tool for collecting ipmi info from Quantaplex T41S
bmc_ip=("192.168.10.1" "192.168.10.2")
uname="root"
pswd="*****"

for i in ${bmc_ip[@]}
do
  #echo $i
  # chassis SN, node SN(FRU Product Serial Number:_), node(product) model name, node(product) model pn
  mkdir $i
  ipmi-fru -e 0 -h $i -u $uname -p $pswd > $i/ipmi-fru.out
  
  sn=$(cat $i/ipmi-fru.out|grep 'FRU Product Serial Number'|cut -d ' ' -f 7)
  
  sn=T41S-$sn
  mv $i $sn
  
  # bmc version, BIOS version
  bmc-info -h $i -u $uname -p $pswd > $sn/bmc-info.out
  #sensors
  ipmi-sensors -h $i -u $uname -p $pswd > $sn/ipmi-sensors.out
  #SEL
  ipmi-sel -D LAN -h $i -u $uname -p $pswd --output-event-state > $sn/ipmi-sel.out
done


