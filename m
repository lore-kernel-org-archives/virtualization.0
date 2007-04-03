From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: A set of "standard" virtual devices?
Date: Tue, 3 Apr 2007 18:07:43 +0200
Message-ID: <20070403180743.27ee64b8@gondolin.boeblingen.de.ibm.com>
References: <4611652F.700@zytor.com>
	<200704031415.38381.arnd@arndb.de>
	<20070403153921.491b1e9f@gondolin.boeblingen.de.ibm.com>
	<200704031603.14836.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753511AbXDCQFh@vger.kernel.org>
In-Reply-To: <200704031603.14836.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mathiasen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 3 Apr 2007 16:03:14 +0200,
Arnd Bergmann <arnd@arndb.de> wrote:

> > > struct virt_dev {
> > > 	struct device dev;
> > > 	struct virt_driver *driver;
> > > 	struct virt_bus *bus;
> > > 	struct pci_device_id id;
> > > 	int irq;
> > > };
> > 
> > And that's where I have problems :) The notion of "irq" is far too
> > platform specific. I can bend my mind round using PCI-like ids for
> > non-PCI virtualized devices, but an integer is far too small and to
> > specific for a way to access the device.
> 
> Sorry, I've been working too long on the lesser architectures.
> IRQ number are evil indeed.
> However, I'm pretty sure that we need _some_ abstraction of an
> interrupt mechanism here. The easiest way is probably to have a
> callback function like
> 	int (*irq_handler)(struct virt_dev*, unsigned long message);
> in the virt_dev.

Yes, something like
	int (*handler) (struct virt_dev *, struct virt_interrupt_info *);
should cover the needed cases.
