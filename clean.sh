#!/bin/sh

rm -f /var/log/*.log /var/log/*.out /var/log/*.err
rm -f /var/log/redis/* /var/log/mysql/*
rm -f /home/git/gitlab/tmp/pids/*.pid /home/git/gitlab/log/*
apt-get clean -y --force-yes
