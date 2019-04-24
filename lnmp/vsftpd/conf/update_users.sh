#!/bin/bash
rm /etc/vsftpd/vsftpd_users.db
db_load -T -t hash -f /etc/vsftpd/vsftpd_users.txt /etc/vsftpd/vsftpd_users.db
chmod 600 /etc/vsftpd/vsftpd_users.db
