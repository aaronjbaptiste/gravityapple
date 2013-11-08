#!/bin/sh
IPT=/sbin/iptables

#house cleaning
$IPT -F
$IPT -Z
$IPT -X

#policies
$IPT -P OUTPUT ACCEPT
$IPT -P INPUT DROP
$IPT -P FORWARD DROP
$IPT -N SERVICES

#limit ping requests  
$IPT -A INPUT -p icmp -m icmp -m limit --limit 1/second -j ACCEPT 

#drop bogus packets  
$IPT -A INPUT   -m state --state INVALID -j DROP  
$IPT -A FORWARD -m state --state INVALID -j DROP  
$IPT -A OUTPUT  -m state --state INVALID -j DROP  
$IPT -t filter -A INPUT -p tcp --tcp-flags FIN,ACK FIN -j DROP  
$IPT -t filter -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j DROP  
$IPT -t filter -A INPUT -p tcp --tcp-flags ACK,URG URG -j DROP  
$IPT -t filter -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP  
$IPT -t filter -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP  
$IPT -t filter -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j DROP  
$IPT -t filter -A INPUT -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP 

#allow machine/applications communicate with itself/localhost
$IPT -A INPUT  -i lo -p all -j ACCEPT 

#accept any connections that are already related or established
$IPT -A INPUT -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT

#route other connections to services
$IPT -A INPUT -j SERVICES

#allowed services
#web
$IPT -A SERVICES -p tcp --dport 80 -j ACCEPT
#ssh
$IPT -A SERVICES -p tcp --dport 22 -j ACCEPT
#minecraft
$IPT -A SERVICES -p tcp --dport 25565 -j ACCEPT