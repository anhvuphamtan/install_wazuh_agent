/Library/Ossec/bin/wazuh-control stop

/bin/rm -r /Library/Ossec

/bin/launchctl unload /Library/LaunchDaemons/com.wazuh.agent.plist

/bin/rm -f /Library/LaunchDaemons/com.wazuh.agent.plist
/bin/rm -rf /Library/StartupItems/WAZUH

/usr/bin/dscl . -delete "/Users/wazuh"
/usr/bin/dscl . -delete "/Groups/wazuh"

/usr/sbin/pkgutil --forget com.wazuh.pkg.wazuh-agent
