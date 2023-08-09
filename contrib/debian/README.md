
Debian
====================
This directory contains files used to package eutocoind/eutocoin-qt
for Debian-based Linux systems. If you compile eutocoind/eutocoin-qt yourself, there are some useful files here.

## eutocoin: URI support ##


eutocoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install eutocoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your eutocoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/eutocoin128.png` to `/usr/share/pixmaps`

eutocoin-qt.protocol (KDE)

