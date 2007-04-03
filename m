From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 19:50:59 +0200
Message-ID: <200704031951.00544.arnd@arndb.de>
References: <4611652F.700@zytor.com> <200704031030.36473.ak@suse.de>
	<20070403111731.52f2102a@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070403111731.52f2102a@gondolin.boeblingen.de.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 April 2007, Cornelia Huck wrote:
> On s390, it would be more than strangeness. There's no implementation
> of PCI at all, someone would have to cook it up - and it wouldn't have
> any use beyond those special devices. Since there isn't any bus type
> that is available on *all* architectures, a generic "virtual" bus with
> very simple probing seems much saner...

I think we need to separate two problems here:

1. Probing:
That's really what triggered the discussion, PCI probing is well-understood
and implemented on _most_ platforms, so there is some value in reusing it.
When you talk about 'very simple probing', I'm not sure what the most simple
approach could be. Ideas that have been implemented before include:
a) have a limited set of device IDs (e.g. 65535 devices, or a hierarchic tr=
ee),
   and try to access each one of them in order to find out if it's there. We
   do that for PCI or CCW, for instance.
b) Have an iterator in the hypervisor (or firmware), to return a handle to
   the first, next or child of a device. We do that for open firmware.
c) ask the hypervisor for an unused device of a given class, which needs to
   be returned to the hypervisor when no longer used. This is how the PS3
   hypervisor works, but it does not play well with the Linux driver model.

2. Device access:
When talking to a virtual device, you want to have at least a way to give
commands to it and a way to get interrupts back. Again, multiple ideas
have been used in the past, and we should choose a subset:
a) PCI-like: mmio using memory and/or I/O space BAR setup, interrupt
   numbers and DMA to guest physical addresses.
b) Channel-like: use an hcall to give commands to the hypervisor, passing
   down a device handle command code and data areas in guest physical space.
   Interrupts return the device handle or a OS-defined per-device value.
c) Minimalistic: Every device is mapped into the guest address space and
   can potentially be remapped into user space. The device memory can be
   shared between guests and/or with the host if that uses the same driver.
   The guest is able to signal the receiving end using an hcall and gets
   interrupts like in b)
d) UNIX-like: devices appear like file descriptors, the guest can do
   operations like read/write/sync/mmap, potentially ioctl on them to talk
   to the host.

	Arnd <><
