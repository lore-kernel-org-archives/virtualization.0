From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A set of "standard" virtual devices?
Date: Wed, 4 Apr 2007 15:11:41 +0200
Message-ID: <200704041511.42543.arnd@arndb.de>
References: <4611652F.700@zytor.com> <200704040049.13118.arnd@arndb.de> <4612F6E9.7040003@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992905AbXDDNN3@vger.kernel.org>
In-Reply-To: <4612F6E9.7040003@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 04 April 2007, H. Peter Anvin wrote:
> Configuration space access is platform-dependent. =A0It's only define=
d to=20
> work in a specific way on x86 platforms.
>=20
> "Interrupt swizzling" is really totally independent of PCI. =A0ALL PC=
I=20
> really provides is up to four interrupts per device (not counting=20
> MSI/MSI-X) and an 8-bit writable field which the platform can choose =
to=20
> use to hold interrupt information. =A0That's all. =A0The rest is all=20
> platform information.
>=20
> PCI enumeration is hardly complex. =A0Most of the stuff that doesn't =
apply=20
> to you you can generally ignore, as is done by other busses like=20
> HyperTransport when they emulate PCI.

You still don't get my point: On a platform that doesn't have interrupt
numbers, and where most of the fields in the config space don't corresp=
ond
do anything that is already there, you really don't want to invent
a set of new hcalls that implement emulation, to get something as
simple as a pipe.

wc drivers/pci/*.[ch] include/asm-i386/{pci,io}.h lib/iomap*.c \
	arch/i386/pci/*.c kernel/irq/*.c
17015  59037 463967 total

Even if you only need half of that code in reality, reimplementing
all that in both the kernel and in the hypervisor is an enourmous
effort. We've seen that before on the ps3, which initially faked
a virtual PCI bus just for the USB controller, but doing something
like that requires adding abstraction layers, to decide whether to
implement e.g. an inb as a hypercall or as a memory read.

> That being said, on platforms which are PCI-centric, such as x86, thi=
s=20
> of course makes it a lot easier to produce virtual devices which work=
=20
> across hypervisors, since the device model, of *any* operating system=
 is=20
> set up to handle them.

Yes, as I said there are two separate problems. I really think that
a standardized virtual driver interface should be modeled after
kernel <-> user interfaces, not hardware <-> kernel interfaces.

Once we know what operations we want (e.g. read, write and SIGIO,
or some other set of primitives), it will be good to provide a
virtual PCI device that can be used as one transport mechanism
below it. Using PCI device IDs to tell what functionality is
provided by the device would provide a reasonable method for
autoprobing.

	Arnd <><
