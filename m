From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] virtio_mmio: Set DMA masks appropriately
Date: Tue, 10 Jan 2017 13:25:43 +0000
Message-ID: <20170110132543.GI14217@n2100.armlinux.org.uk>
References: <50defbbe87d75db85a9d22f914258975d661208a.1484051089.git.robin.murphy@arm.com>
	<2220292.9CN9cxzsPe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <2220292.9CN9cxzsPe@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: mst@redhat.com, will.deacon@arm.com, virtualization@lists.linux-foundation.org, luto@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 10, 2017 at 02:15:57PM +0100, Arnd Bergmann wrote:
> On Tuesday, January 10, 2017 12:26:01 PM CET Robin Murphy wrote:
> > @@ -548,6 +550,14 @@ static int virtio_mmio_probe(struct platform_device *pdev)
> >         if (vm_dev->version == 1)
> >                 writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> >  
> > +       rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > +       if (rc)
> > +               rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> 
> You don't seem to do anything different when 64-bit DMA is unsupported.
> How do you prevent the use of kernel buffers that are above the first 4G
> here?
> 
> > +       else if (vm_dev->version == 1)
> > +               dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32 + PAGE_SHIFT));
> 
> Why is this limitation only for the coherent mask?

It looks wrong for two reasons:

1. It is calling dma_set_coherent_mask(), so only the coherent mask
   is being updated.  What about streaming DMA?

   Maybe include the comment from the commit you refer to (a0be1db4304f)
   which explains this, which would help reviewers understand why you're
   only changing the coherent mask.

2. It fails to check whether the coherent mask was accepted... which
   I guess is okay, as the coherent allocation mask won't be updated
   so you should get coherent memory below 4GB.  Nevertheless, drivers
   are expected to try setting a 32-bit coherent mask if setting a
   larger mask fails.  See examples in Documentation/DMA-API-HOWTO.txt.

Of course, if setting a 32-bit coherent mask fails, then the driver
should probably fail to initialise.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
