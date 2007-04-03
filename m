From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 16:03:14 +0200
Message-ID: <200704031603.14836.arnd@arndb.de>
References: <4611652F.700@zytor.com> <200704031415.38381.arnd@arndb.de> <20070403153921.491b1e9f@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030237AbXDCOFD@vger.kernel.org>
In-Reply-To: <20070403153921.491b1e9f@gondolin.boeblingen.de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 April 2007, Cornelia Huck wrote:
> On Tue, 3 Apr 2007 14:15:37 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> That's OK for a virtualized architecture where the base architecture
> already supports PCI. But a traditional s390 OS would be as unhappy
> with a PCI device as with a device of a completely new type :)

Sure, that was my point from the start.

> There are several options for virtualized devices (and I don't know why
> they shouldn't coexist):
> 
> 1. Emulate a well-known device (like a e1000 network card on PCI or a
> model 3390 dasd on CCW). Existing operating systems can just use them,
> but it's a lot of work in the hypervisor.

Most hypervisors already do this, and it's an unrelated topic. 
What we're trying to achieve is to make sure not every hypervisor
and simulator has to introduce its own set of drivers.


> > struct virt_bus {
> > 	/* platform dependent */
> > 	long (*transfer)(struct virt_dev *dev, void *buffer,
> > 		unsigned long size, int type);
> > };
> 
> Should this embed a struct bus_type? Or reference a generic_virt_bus?

yes, that should embed the bus_type.

> > struct virt_dev {
> > 	struct device dev;
> > 	struct virt_driver *driver;
> > 	struct virt_bus *bus;
> > 	struct pci_device_id id;
> > 	int irq;
> > };
> 
> And that's where I have problems :) The notion of "irq" is far too
> platform specific. I can bend my mind round using PCI-like ids for
> non-PCI virtualized devices, but an integer is far too small and to
> specific for a way to access the device.

Sorry, I've been working too long on the lesser architectures.
IRQ number are evil indeed.
However, I'm pretty sure that we need _some_ abstraction of an
interrupt mechanism here. The easiest way is probably to have a
callback function like
	int (*irq_handler)(struct virt_dev*, unsigned long message);
in the virt_dev.

	Arnd <><
