---
# group vars

ip_address:
%{ for jump-server in jump-servers ~}
  ${ jump-server["name"] }: ${ jump-server.network_interface[0].ip_address }
%{ endfor ~}
%{ for db-server in db-servers ~}
  ${ db-server["name"] }: ${ db-server.network_interface[0].ip_address }
%{ endfor ~}
%{ for iscsi-server in iscsi-servers ~}
  ${ iscsi-server["name"] }: ${ iscsi-server.network_interface[0].ip_address }
%{ endfor ~}
%{ for backend-server in backend-servers ~}
  ${ backend-server["name"] }: ${ backend-server.network_interface[0].ip_address }
%{ endfor ~}
%{ for nginx-server in nginx-servers ~}
  ${ nginx-server["name"] }: ${ nginx-server.network_interface[0].ip_address }
%{ endfor ~}


domain: "mydomain.test"
ntp_timezone: "UTC"
pcs_password: "strong_pass" # cluster user: hacluster
cluster_name: "hacluster"
subnet_cidrs: "{ %{ for subnet_cidr in subnet_cidrs ~} ${ subnet_cidr }, %{ endfor ~} }"
