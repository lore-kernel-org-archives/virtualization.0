From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A set of "standard" virtual devices?
Date: Wed, 4 Apr 2007 00:49:11 +0200
Message-ID: <200704040049.13118.arnd@arndb.de>
References: <4611652F.700@zytor.com> <200704032351.17823.arnd@arndb.de> <4612D0CA.3070209@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992466AbXDCWu0@vger.kernel.org>
In-Reply-To: <4612D0CA.3070209@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Andi Kleen <ak@suse.de>, Christian Borntraeger <borntrae@de.ibm.com>, virtualization@lists.linux-foundation.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 04 April 2007, H. Peter Anvin wrote:
> Note that at least for PIO-based devices, there is nothing that says =
you=20
> can't implement PCI over another transport, if you wish. =A0It's real=
ly=20
> just a very simple RPC protocol.

The PIO aspect of PCI is simple, yes, except on architectures that don'=
t
have the concept of PIO or even uncached memory, but even that can
be done by defining readl/writel/inl/outl/... as hcalls.

The tricky part about PCI is the device probing, everything about confi=
g
space accesses, interrupt swizzling, bus/device/function numbers and
base address registers becomes a pointless excercise when the other sid=
e
is just faking it.

> DMA is trickier, as it makes the data appear into the address space o=
f=20
> the guest in a way that is both device- and host-dependent (in the=20
> presence of PCI domains, IOMMU etc.) =A0There may be reason to avoid =
DMA=20
> for that reason.

Right, PCI DMA and virtualization don't mix. DMA in general is fine tho=
ugh,
as long as your devices (real or virtual) see the guest physical addres=
ses
as a contiguous 64 bit range and have well-defined semantics about what
addresses are accessed in what way.
When you think of file read/write syscalls as DMA into user space, it's
a very clean concept. Async I/O somewhat less so, but still pretty good=
=2E

	Arnd <><
