DEFAULT astra
LABEL astra
kernel linux
append initrd=initrd.gz vga=788 auto=true priority=critical astra-license/license=true url=http://{{ dhcp_global_next_server }}/preseed.cfg interface=auto netcfg/dhcp_timeout=60
TIMEOUT 5
