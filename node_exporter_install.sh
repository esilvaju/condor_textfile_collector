#!bin/sh
echo "Installing node exporter"
REPO_URL="https://raw.githubusercontent.com/ejr004/"
NODE_EXPORTER_VERSION="0.18.1"

# Installing node exporter
wget -qO- https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz | tar xvz -C /tmp/

mv /tmp/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64/node_exporter /usr/local/bin/

useradd -M -r -s /bin/false node_exporter

touch /var/lib/node_exporter/textfile_collector/condor.status
touch /var/lib/node_exporter/textfile_collector/condor.queue
chown -R node_exporter:node_exporter /usr/local/bin/node_exporter

wget -O - $REPO_URL/node_exporter.service > /etc/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl start node_exporter.service
systemctl enable node_exporter.service

# wget -O - https://github.com/ejr004/raw/condor_textfile_collector/node_exporter_install.sh | bash