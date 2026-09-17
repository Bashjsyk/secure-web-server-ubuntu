#!/bin/bash

# =========================================================
# Secure Ubuntu Web Server Setup
# =========================================================

set -e

echo "=============================================="
echo " Secure Ubuntu Web Server Setup"
echo "=============================================="

# 1. Update the Ubuntu server
echo "[1/8] Updating Ubuntu..."
sudo apt update
# 2. Install and start Nginx
echo "[2/8] Installing Nginx..."
sudo apt install nginx -y
sudo systemctl enable --now nginx
echo "Nginx status:"
sudo systemctl status nginx --no-pager
# 3. Create the project web page
echo "[3/8] Creating project webpage..."
sudo tee /var/www/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Ubuntu Web Server</title>
</head>
<body>
    <h1>Secure Web Server Deployment and Monitoring</h1>
    <p>This website is hosted on Ubuntu Linux using Nginx.</p>
    <h2>Security Features</h2>
    <ul>
        <li>Ubuntu Linux Server</li>
        <li>Nginx Web Server</li>
        <li>UFW Firewall</li>
        <li>Fail2Ban</li>
        <li>SSH Monitoring</li>
        <li>Web Server Log Monitoring</li>
    </ul>
    <p>Server deployment completed successfully.</p>
</body>
</html>
EOF

# 4. Configure the UFW firewall
echo "[4/8] Configuring UFW firewall..."
sudo apt install ufw -y

# Allow SSH before enabling UFW to prevent accidental lockout.
sudo ufw allow OpenSSH

# Allow HTTP and HTTPS traffic.
sudo ufw allow 'Nginx Full'
sudo ufw --force enable
echo "Firewall status:"
sudo ufw status verbose
# 5. Install and start Fail2Ban
echo "[5/8] Installing Fail2Ban..."
sudo apt install fail2ban -y
sudo systemctl enable --now fail2ban
echo "Fail2Ban status:"
sudo systemctl status fail2ban --no-pager

# 6. Configure Fail2Ban for SSH
echo "[6/8] Configuring SSH protection..."
sudo tee /etc/fail2ban/jail.d/sshd.local > /dev/null <<'EOF'
[sshd]
enabled = true
port = ssh
filter = sshd
backend = systemd
maxretry = 5
findtime = 10m
bantime = 10m
EOF

sudo systemctl restart fail2ban
echo "Fail2Ban SSH jail status:"
sudo fail2ban-client status sshd

# 7. Create the monitoring script
echo "[7/8] Creating server monitoring script..."
sudo tee /usr/local/bin/server-monitor.sh > /dev/null <<'EOF'
#!/bin/bash

echo "=============================================="
echo " Ubuntu Server Security Monitoring"
echo "=============================================="

echo ""
echo "----- DATE AND TIME -----"
date

echo ""
echo "----- SERVER HOSTNAME -----"
hostname

echo ""
echo "----- SERVER IP ADDRESS -----"
hostname -I

echo ""
echo "----- SYSTEM UPTIME -----"
uptime

echo ""
echo "----- DISK USAGE -----"
df -h

echo ""
echo "----- MEMORY USAGE -----"
free -h

echo ""
echo "----- FIREWALL STATUS -----"
sudo ufw status

echo ""
echo "----- LISTENING PORTS -----"
sudo ss -tulpn

echo ""
echo "----- FAILED SYSTEM SERVICES -----"
systemctl --failed --no-pager

echo ""
echo "----- NGINX STATUS -----"
systemctl is-active nginx

echo ""
echo "----- FAIL2BAN STATUS -----"
sudo fail2ban-client status sshd

echo ""
echo "----- RECENT SSH LOGS -----"
sudo journalctl -u ssh --no-pager -n 10

echo ""
echo "----- RECENT WEB REQUESTS -----"
sudo tail -n 10 /var/log/nginx/access.log

echo ""
echo "=============================================="
echo " Monitoring Complete"
echo "=============================================="
EOF
# 8. Display final information
echo "[8/8] Setup completed."
echo ""

echo "=============================================="
echo " PROJECT COMPLETED SUCCESSFULLY"
echo "=============================================="
echo ""
echo "Server IP address:"
hostname -I
echo ""
echo "Open the following address from your browser:"
echo "http://SERVER-IP"
echo ""
echo "Run the monitoring script using:"
echo "sudo server-monitor.sh"
echo ""
echo "Check Nginx logs using:"
echo "sudo tail -f /var/log/nginx/access.log"
echo ""
echo "Check SSH logs using:"
echo "sudo journalctl -u ssh -f"
echo ""
echo "Check firewall using:"
echo "sudo ufw status verbose"
echo ""
echo "Check Fail2Ban using:"
echo "sudo fail2ban-client status sshd"
echo "=============================================="
