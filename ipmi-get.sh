#tool for collecting ipmi info from Quantaplex / Hitachi DS 
bmc_ip=("192.168.10.1" "192.168.10.2")
uname="root"
pswd="*****"

for i in ${bmc_ip[@]}
do
  #echo $i
  # chassis SN, node SN(FRU Product Serial Number:_), node(product) model name, node(product) model pn
  mkdir $i
  ipmi-fru -e 0 -h $i -u $uname -p $pswd > $i/ipmi-fru.out # for bullion S  -W skipchecks
  
  sn=$(cat $i/ipmi-fru.out|grep 'FRU Product Serial Number'|cut -d ' ' -f 7)
  model=$(cat ipmi-fru.out|grep 'FRU Product Name'|cut -d ':' -f 2|rev|cut -f 1 -d ' '|rev)
  sn=$model-$sn
  
  mv $i $sn
  
  # bmc version, BIOS version
  bmc-info -h $i -u $uname -p $pswd > $sn/bmc-info.out
  #sensors
  ipmi-sensors -h $i -u $uname -p $pswd > $sn/ipmi-sensors.out
  #SEL
  ipmi-sel -D LAN -h $i -u $uname -p $pswd --output-event-state > $sn/ipmi-sel.out
done


