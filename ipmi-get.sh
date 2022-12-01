bmc_ip=("192.168.10.1" "192.168.10.2")
uname="root"
pswd="*****"

for i in ${bmc_ip[@]}
do
  # chassis SN, node SN(FRU Product Serial Number:_), node(product) model name, node(product) model pn
  mkdir $i
  ipmi-fru -e 0 -h $i -u $uname -p $pswd # for T41S -e 00h > $i/ipmi-fru.out
  # bmc version, BIOS version
  bmc-info -h $i -u $uname -p $pswd > $i/bmc-info.out
  #sensors
  ipmi-sensors -h $i -u $uname -p $pswd $i/ipmi-sensors.out
  #SEL
  ipmi-sel -D LAN -h $i -u $uname -p $pswd --output-event-state > $i/ipmi-sel.out
done
