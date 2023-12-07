echo "Enter your wazuh agent name"
read agent_name
echo "Enter wazuh agent group"
read agent_group

curl -so wazuh-agent.deb https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.5.4-1_amd64.deb && sudo WAZUH_MANAGER='wazuh-uat-agent.styl.solutions' WAZUH_AGENT_GROUP=$agent_group WAZUH_AGENT_NAME=$agent_name dpkg -i ./wazuh-agent.deb


echo "Install Wazuh agent successfully"
sleep 5

systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent

echo "Reload Wazuh agent successfully"

sed -i "s/^deb/#deb/" /etc/apt/sources.list.d/wazuh.list
apt-get update
echo "wazuh-agent hold" | dpkg --set-selections

echo "Disable auto update on Wazuh agent successfully"

rm -rf wazuh-agent.deb
