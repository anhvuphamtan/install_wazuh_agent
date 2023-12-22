MANAGER="wazuh-agent.styl.solutions"
echo "Enter Wazuh Agent name"
read AGENT_NAME

echo "Enter Wazuh Agent group"
read AGENT_GROUP

curl -O https://packages.wazuh.com/4.x/macos/wazuh-agent-4.7.0-1.arm64.pkg

echo "WAZUH_MANAGER='$MANAGER' && WAZUH_REGISTRATION_SERVER='$MANAGER' && WAZUH_AGENT_NAME='$AGENT_NAME' && \
WAZUH_AGENT_GROUP='$AGENT_GROUP'" > /tmp/wazuh_envs && installer -pkg ./wazuh-agent-4.5.4-1.arm64.pkg -target /

sleep 2

/Library/Ossec/bin/wazuh-control start
