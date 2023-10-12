#!/bin/bash

systemctl stop --user xdg-desktop-portal-hyprland.service
systemctl stop --user xdg-desktop-portal-gtk.service
systemctl stop --user xdg-document-portal.service
sleep 1
# We are engaging the cgroup meanwhile the desktop portal is starting. This
# helps with delegation. See https://github.com/systemd/systemd/issues/18293
systemd-run --user -p AllowedCPUs=2 -- sleep 3
systemctl start --user xdg-desktop-portal-hyprland.service
sleep 1
systemctl start --user xdg-document-portal.service
sleep 1
systemctl start --user xdg-desktop-portal-gtk.service
