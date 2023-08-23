systemctl try-reload-or-restart bind.service 2>/dev/null || :
systemctl try-restart sshd.service 2>/dev/null || :
systemctl try-restart ipsec.service 2>/dev/null || :
