ipmi-fru -e 03 -h 192.168.100.19 -u root -p changeme
ipmi-sensors -h 192.168.100.19 -u root -p changeme
ipmi-sel -D LAN -h 192.168.100.19 -u root -p changeme --output-event-state
