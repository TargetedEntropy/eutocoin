Sample init scripts and service configuration for eutocoind
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/eutocoind.service:    systemd service unit configuration
    contrib/init/eutocoind.openrc:     OpenRC compatible SysV style init script
    contrib/init/eutocoind.openrcconf: OpenRC conf.d file
    contrib/init/eutocoind.conf:       Upstart service configuration file
    contrib/init/eutocoind.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "eutocoin" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes eutocoind will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, eutocoind requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, eutocoind will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that eutocoind and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If eutocoind is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running eutocoind without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/eutocoin.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/eutocoind`  
Configuration file:  `/etc/eutocoin/eutocoin.conf`  
Data directory:      `/var/lib/eutocoind`  
PID file:            `/var/run/eutocoind/eutocoind.pid` (OpenRC and Upstart) or `/var/lib/eutocoind/eutocoind.pid` (systemd)  
Lock file:           `/var/lock/subsys/eutocoind` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the eutocoin user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
eutocoin user and group.  Access to eutocoin-cli and other eutocoind rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/eutocoind`  
Configuration file:  `~/Library/Application Support/EutoCoin/eutocoin.conf`  
Data directory:      `~/Library/Application Support/EutoCoin`  
Lock file:           `~/Library/Application Support/EutoCoin/.lock`  

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start eutocoind` and to enable for system startup run
`systemctl enable eutocoind`

### OpenRC

Rename eutocoind.openrc to eutocoind and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/eutocoind start` and configure it to run on startup with
`rc-update add eutocoind`

### Upstart (for Debian/Ubuntu based distributions)

Drop eutocoind.conf in /etc/init.  Test by running `service eutocoind start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy eutocoind.init to /etc/init.d/eutocoind. Test by running `service eutocoind start`.

Using this script, you can adjust the path and flags to the eutocoind program by
setting the EUTOCOIND and FLAGS environment variables in the file
/etc/sysconfig/eutocoind. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.eutocoin.eutocoind.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.eutocoin.eutocoind.plist`.

This Launch Agent will cause eutocoind to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run eutocoind as the current user.
You will need to modify org.eutocoin.eutocoind.plist if you intend to use it as a
Launch Daemon with a dedicated eutocoin user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
