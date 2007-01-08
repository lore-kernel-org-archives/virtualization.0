From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lhype booting debootstrapped debian image over nfsroot,
	partial success
Date: Mon, 08 Jan 2007 22:56:44 +1100
Message-ID: <1168257404.19646.30.camel@localhost.localdomain>
References: <20070107224644.GA1521@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070107224644.GA1521@outpost.ds9a.nl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2007-01-07 at 23:46 +0100, bert hubert wrote:
> Hi!

Hi Bert!

> Bored by previous lhype success, I tried to boot a debootstrapped debian
> over nfsroot, and lo, this almost works!

8)

> Commandline:
> # drivers/lhype/lhype_add 256m 0 ./vmlinux --tunnet=3D192.168.1.20
>  root=3D/dev/root nfsroot=3D/home/ahu/lhype-root
> ip=3D192.168.1.21:192.168.1.20:192.168.1.20
> =

> This with lhype.patch current as of this message and 2.9.20-rc4.
> =

> The boot process stops after:
> Starting periodic command scheduler: crond.
> =

> Trying to use the console yields:
> lhype_add: Failed to get DMA buffer from (nil): No such file or directory
> lhype_add: console: no dma buffer!: No such file or directory

That's strange!  I can't reproduce that here 8(.  Even if noone listens
on the console it's still registered...  Hmm, but I did fix a
theoretical bug in the console with my latest patch.  I doubt that's
happening to you though 8(

I've also changed the console to be raw: press ^C three times in a row
within 1 second to exit.  I still got "-bash: no job control in this
shell" until I attached the console to /dev/hvc0
not /dev/console...(thanks sfr!)

> /dev/tty does exist on the root: crw-rw-rw- 1 root tty 5, 0 Jan  7  2007 =
/dev/tty
> =

> However, TCP/IP was working, so I installed an ssh server so I could log =
in
> over the network, but no dice:
> Starting OpenBSD Secure Shell server: sshdPRNG is not seeded

Hmm, good catch!  Nothing in the guest contributes entropy
to /dev/random; something needs to or this kind of thing will happen.
I'll need to think harder about what the right answer is, but it almost
certainly involves me fixing up time in the guest (a good thing in
itself!).

> Installing telnet, and removing /etc/securetty allowed me to login as roo=
t,
> but this doesn't always work. When I try to, lhype prints out the followi=
ng,
> if it works or not:
> =

> lhype_add: Failed to get DMA buffer from 0xb7fff008: No such file or dire=
ctory
> lhype_add: network: no dma buffer!: No such file or directory

OK, these just mean the guest wasn't receiving networking.  On my
system, IPv6 sends probes from the guest as soon as the device comes up,
so this happens.  I've silenced the warnings, at least until we've seen
some output from the guest device...

> lhype_add: Pending dma 0x7906c0, addr 0xb7fff000

This is unusual, but harmless by itself.  We exhausted the guest's (8!)
network buffers, and when it refilled it sent a useful ping to tell us.
This will be greatly alleviated (and network speed greatly improved!) in
the coming I/O rewrite, where guests will be able to have arbitrary
numbers of registered buffers.

> When it does work, things sort of work, but it looks like timing is
> seriously off:
> =

> intel:~# uptime
>  01:52:22 up -24855 days, -3:-14,  1 user,  load average: nan, nan, 0.03
> =

> The clock appears to run around 5 times too slow.

Wow, I haven't seen that before!  But the clock *is* really slow.  It's
time for the guests to have a real clock.  =


> But things are looking pretty nice! Booting from nfsroot beats a fixed im=
age
> any day for me.
> =

> Keep up the good work!

Thanks for the report!  I'll install sshd tomorrow and fix that issue
too.  And I'll study up on struct clocksource and time...

Thanks!
Rusty.
