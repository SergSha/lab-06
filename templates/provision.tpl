---
- hosts: all
  #remote_user: cloud-user
  become: true
  serial: 5
  tasks:
    - name: Set hostname
      ansible.builtin.hostname:
        name: "{{ ansible_hostname }}.{{ domain }}"

    - name: Add my own IP address to /etc/hosts instead localhost
      ansible.builtin.replace:
        path: "/etc/hosts"
        regexp: '^127\.0\.0\.1(\s+){{ ansible_hostname }}(\s+){{ ansible_hostname }}.*'
        replace: "{{ ansible_host }} {{ ansible_hostname }}.{{ domain }} {{ ansible_hostname }}"

    - name: Add nodes to /etc/hosts
      ansible.builtin.lineinfile:
        path: "/etc/hosts"
        state: present
        line: "{{ item }}"
      loop:
%{ for nginx-server in nginx-servers ~}
        - "${ nginx-server.network_interface[0].ip_address } ${ nginx-server["name"] }.{{ domain }} ${ nginx-server["name"] }"
%{ endfor ~}
%{ for backend-server in backend-servers ~}
        - "${ backend-server.network_interface[0].ip_address } ${ backend-server["name"] }.{{ domain }} ${ backend-server["name"] }"
%{ endfor ~}
%{ for iscsi-server in iscsi-servers ~}
        - "${ iscsi-server.network_interface[0].ip_address } ${ iscsi-server["name"] }.{{ domain }} ${ iscsi-server["name"] }"
%{ endfor ~}
%{ for db-server in db-servers ~}
        - "${ db-server.network_interface[0].ip_address } ${ db-server["name"] }.{{ domain }} ${ db-server["name"] }"
%{ endfor ~}
%{ for jump-server in jump-servers ~}
        - "${ jump-server.network_interface[0].ip_address } ${ jump-server["name"] }.{{ domain }} ${ jump-server["name"] }"
%{ endfor ~}

- hosts: all
  #remote_user: cloud-user
  become: true
  serial: 5
  roles:
    - { role: chrony, tags: chrony_tag }
    #- { role: haproxy-servers, when: "'haproxy_servers' in group_names" }
    - { role: jump-servers, when: "'jump_servers' in group_names", tags: jump-servers_tag }
    - { role: nginx-servers, when: "'nginx_servers' in group_names", tags: nginx-servers_tag }
    - { role: iscsi-servers, when: "'iscsi_servers' in group_names", tags: iscsi-servers_tag }
    - { role: backend-servers, when: "'backend_servers' in group_names", tags: backend-servers_tag }
    - { role: db-servers, when: "'db_servers' in group_names", tags: db-servers_tag }
