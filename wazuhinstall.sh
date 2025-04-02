#!/bin/bash

# Wazuh Installation Script für Ubuntu 24.04
# Quelle: Wazuh Dokumentation & Community-Beiträge [1][2][7]

# Systemaktualisierung
sudo apt update && sudo apt upgrade -y

# Abhängigkeiten installieren
sudo apt install -y curl gnupg apt-transport-https openssh-server

# Wazuh Repository hinzufügen
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo gpg --dearmor -o /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list

# Paketlisten aktualisieren
sudo apt update

# Wazuh All-in-One Installation
curl -sO https://packages.wazuh.com/4.11/wazuh-install.sh
sudo bash ./wazuh-install.sh -a

# Installation abschließen
echo "Wazuh Installation abgeschlossen!"
echo -e "\nZugangsdaten:"
sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt

# Repository deaktivieren (empfohlen)
sudo sed -i "s/^deb /#deb /" /etc/apt/sources.list.d/wazuh.list
sudo apt update

echo -e "\nWeb Interface: https://$(hostname -I | awk '{print $1}'):443"
echo "Benutzername: admin"
echo "Passwort: Siehe oben ausgegebene Zugangsdaten"
