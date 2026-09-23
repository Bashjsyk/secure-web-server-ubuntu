# Secure Web Server Deployment and Monitoring Using Ubuntu Linux

## Project Overview

This project demonstrates the deployment, configuration, security, and basic monitoring of a web server using Ubuntu Linux.

The project was created to gain practical experience with Linux server administration, web server deployment, network security, access control, firewall configuration, intrusion prevention, and system monitoring.

## Project Objectives

The main objectives of this project are to:

- Deploy an Ubuntu Linux server environment.
- Install and configure Nginx as a web server.
- Configure HTTP and HTTPS access.
- Configure SSH for secure administration.
- Configure the UFW firewall.
- Install and configure Fail2Ban.
- Monitor system and security logs.
- Create a basic server monitoring script.
- Document the deployment process.
- Upload and manage the project using GitHub.

## Technologies and Tools

- Ubuntu Linux
- Nginx
- OpenSSH
- UFW (Uncomplicated Firewall)
- Fail2Ban
- Bash Scripting
- Git
- GitHub
- VirtualBox

## Security Features

### UFW Firewall

UFW was configured to control network traffic and allow only the required services.

### SSH

SSH was configured to provide secure remote administration of the Ubuntu server.

### Fail2Ban

Fail2Ban was installed and configured to help protect SSH against repeated failed authentication attempts.

### HTTPS

HTTPS was configured to provide encrypted communication between clients and the web server.

### Log Monitoring

SSH and Nginx logs were monitored to help identify authentication attempts, web requests, and security events.

## Web Server

Nginx was installed and configured as the web server.

The server was tested to confirm that Nginx was active and accepting web connections.

### Network Ports

- HTTP: Port 80
- HTTPS: Port 443
- SSH: Port 22

## Monitoring

A server monitoring script was created to provide information about the system and server status.

The monitoring script checks important information such as:

- System uptime
- Disk usage
- Memory usage
- Network information
- Running services
- Server status

The monitoring script was tested successfully on the Ubuntu server.

##  Testing and Verification

The following components were successfully tested:

- Ubuntu server
- Nginx website
- HTTP (Port 80)
- HTTPS (Port 443)
- UFW firewall
- SSH
- Fail2Ban
- Monitoring script
- SSH and Nginx logs

## Project Files

```text
project 1/
├── secure-server.sh
└── README.md
```

## How to Run

1. Start the Ubuntu Virtual Machine in VirtualBox.
2. Open the terminal.
3. Navigate to the project directory.
4. Make the script executable:

```bash
chmod +x secure-server.sh
```

5. Run the script with administrator privileges:

```bash
sudo ./secure-server.sh
```

6. Check the Nginx service:

```bash
sudo systemctl status nginx
```

7. Check the firewall:

```bash
sudo ufw status
```

8. Check Fail2Ban:

```bash
sudo fail2ban-client status
```

## Learning Outcomes

This project provided practical experience with:

* Linux server administration
* Nginx web server configuration
* SSH
* Firewall configuration
* Fail2Ban
* Bash scripting
* Log monitoring
* Server security
* Git and GitHub

