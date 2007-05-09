From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 7/9] lguest: the net driver
Date: Thu, 10 May 2007 01:14:55 +1000
Message-ID: <1178723695.7286.164.camel@localhost.localdomain>
References: <200705090951.l499pdOr020406@shell0.pdx.osdl.net>
	 <4641BE65.3030807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757953AbXEIPP3@vger.kernel.org>
In-Reply-To: <4641BE65.3030807@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de, jmorris@namei.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Jeff,

	Thanks for your review.  Questions below.

On Wed, 2007-05-09 at 08:28 -0400, Jeff Garzik wrote:
> akpm@linux-foundation.org wrote:
> > +static void transfer_packet(struct net_device *dev,
...
> > +	hcall(LHCALL_SEND_DMA, peer_key(info,peernum), __pa(&dma), 0);
> 
> __pa() should not be used in any driver.
> 
> At the very least, lguest helper code should wrap this.

	I realize your continual battle with this, but adding a layer of
indirection doesn't seem like it will add clarity.  The issues with
__pa() are reasonably known (don't hand it a vmalloc address, for
example).  Any wrapper I create would be another hurdle to jump 8(

> > +static irqreturn_t lguestnet_rcv(int irq, void *dev_id)
...
> > +	return done ? IRQ_HANDLED : IRQ_NONE;
> 
> Using NAPI would be preferable...

I'm not so convinced: scheduling tends to give us pretty good interrupt
mitigation.  However, if you wish to send a patch, I'd be happy to
benchmark the two 8)

> > +	/* Ethernet defaults with some changes */
> > +	ether_setup(dev);
> > +	dev->set_mac_address = NULL;
> 
> why NULL?

Because it's not implemented: our MAC is advertised in the device page
and we'd have to change it there too.

Trivial to do, but is there a compelling reason to implement it?

> > +	dev->mem_start = ((unsigned long)desc->pfn << PAGE_SHIFT);
> > +	dev->mem_end = dev->mem_start + PAGE_SIZE * desc->num_pages;
> > +	dev->irq = lgdev->index+1;
> 
> don't fill in mem_start, mem_end and irq.  they are useless, and for 
> lguest, misleading.

You meant to type "useful and accurate", I think?  They show up in
ifconfig, so you can see what the underlying devices are using.  They're
as useful for virtual hardware as they are for physical hardware.

> > +	dev->features = NETIF_F_SG;
> > +	if (desc->features & LGUEST_NET_F_NOCSUM)
> > +		dev->features |= NETIF_F_NO_CSUM;
> 
> do not set SG without an accompanying csum bitflag

That seems... odd.  My driver can do SG, and may or may not need csums.
The current Linux code turns SG off if I need csums and that's fine, but
it hardly seems like my device should be making that decision.

> > +	info = dev->priv;
> 
> use netdev_priv()

OK, thanks.

> > +	info->mapsize = PAGE_SIZE * desc->num_pages;
> > +	info->peer_phys = ((unsigned long)desc->pfn << PAGE_SHIFT);
> > +	info->peer = (void *)ioremap(info->peer_phys, info->mapsize);
> 
> check for NULL

Erk, good catch!

> > +unregister:
> > +	unregister_netdev(dev);
> > +free:
> > +	free_netdev(dev);
> 
> missing iounmap() on error

What is it about me and iomap... will fix that too.

> > +static struct lguest_driver lguestnet_drv = {
> > +	.name = "lguestnet",
> > +	.owner = THIS_MODULE,
> > +	.device_type = LGUEST_DEVICE_T_NET,
> > +	.probe = lguestnet_probe,
> > +};
> 
> You are distinctly missing module remove support

Yes.  It is never built as a module currently (though it should work).

Thanks!
Rusty.
