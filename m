From: bert hubert <bert.hubert@netherlabs.nl>
Subject: lhype booting debootstrapped debian image over nfsroot,
	partial success
Date: Sun, 7 Jan 2007 23:46:45 +0100
Message-ID: <20070107224644.GA1521@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hi!

Bored by previous lhype success, I tried to boot a debootstrapped debian
over nfsroot, and lo, this almost works!

Commandline:
# drivers/lhype/lhype_add 256m 0 ./vmlinux --tunnet=3D192.168.1.20
 root=3D/dev/root nfsroot=3D/home/ahu/lhype-root
ip=3D192.168.1.21:192.168.1.20:192.168.1.20

This with lhype.patch current as of this message and 2.9.20-rc4.

The boot process stops after:
Starting periodic command scheduler: crond.

Trying to use the console yields:
lhype_add: Failed to get DMA buffer from (nil): No such file or directory
lhype_add: console: no dma buffer!: No such file or directory

/dev/tty does exist on the root: crw-rw-rw- 1 root tty 5, 0 Jan  7  2007 /d=
ev/tty

However, TCP/IP was working, so I installed an ssh server so I could log in
over the network, but no dice:
Starting OpenBSD Secure Shell server: sshdPRNG is not seeded
 =

Installing telnet, and removing /etc/securetty allowed me to login as root,
but this doesn't always work. When I try to, lhype prints out the following,
if it works or not:

lhype_add: Failed to get DMA buffer from 0xb7fff008: No such file or direct=
ory
lhype_add: network: no dma buffer!: No such file or directory
lhype_add: Failed to get DMA buffer from 0xb7fff008: No such file or direct=
ory
lhype_add: network: no dma buffer!: No such file or directory
(8 more of these 2)
lhype_add: Pending dma 0x7906c0, addr 0xb7fff000

When it does work, things sort of work, but it looks like timing is
seriously off:

intel:~# uptime
 01:52:22 up -24855 days, -3:-14,  1 user,  load average: nan, nan, 0.03

The clock appears to run around 5 times too slow.

But things are looking pretty nice! Booting from nfsroot beats a fixed image
any day for me.

Keep up the good work!

-- =

http://www.PowerDNS.com      Open source, database driven DNS Software =

http://netherlabs.nl              Open and Closed source services
