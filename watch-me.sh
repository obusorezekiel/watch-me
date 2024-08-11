#!/bin/bash
set -e

RED='\033[0;31m'
BLUE='\033[40;38;5;82m'
PURPLE='\033[0;35m'

echo "
+-+-+-+-+-+-+-+-+
|W|a|t|c|h||-|i|t|
+-+-+-+-+-+-+-+-+
"

apt-get update
apt-get install -y wget curl tar adduser libfontconfig1

sudo adduser --system --group --no-create-home prometheus
sudo adduser --system --group --no-create-home node_exporter
sudo adduser --system --group --home /var/lib/grafana grafana

# Install Prometheus
PROMETHEUS_VERSION="2.49.0"
tar xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
cd prometheus-${PROMETHEUS_VERSION}.linux-amd64/
sudo mv prometheus promtool /usr/local/bin/
sudo mkdir -p /etc/prometheus /var/lib/prometheus
sudo mv consoles/ console_libraries/ prometheus.yml /etc/prometheus/
cd ..
rm -rf prometheus-${PROMETHEUS_VERSION}.linux-amd64*

# Set Prometheus ownership
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus

#Install Node Exporter
NODE_EXPORTER_VERSION="1.7.0"
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar xvf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
sudo mv node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64/node_exporter /usr/local/bin/
rm -rf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64*

#Install cAdvisor (latest version as of the last update)
CADVISOR_VERSION="0.50.0"
sudo apt-get install -y libseccomp2
wget https://github.com/google/cadvisor/releases/download/${CADVISOR_VERSION}/cadvisor-${CADVISOR_VERSION}-linux-amd64
sudo mv cadvisor-${CADVISOR_VERSION}-linux-amd64 /usr/local/bin/cadvisor
sudo chmod +x /usr/local/bin/cadvisor

# Create systemd service files
# Prometheus
cat << EOF | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF

# Node Exporter
cat << EOF | sudo tee /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF


# cAdvisor
cat << EOF | sudo tee /etc/systemd/system/cadvisor.service
[Unit]
Description=cAdvisor
Wants=network-online.target
After=network-online.target

[Service]
User=root
Group=root
Type=simple
ExecStart=/usr/local/bin/cadvisor

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start services
sudo systemctl daemon-reload
sudo systemctl enable prometheus node_exporter cadvisor grafana-server
sudo systemctl start prometheus node_exporter cadvisor grafana-server

echo "${BLUE} Installation complete. Please check the status of the services to ensure they are running correctly."
