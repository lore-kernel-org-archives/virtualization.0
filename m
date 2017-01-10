From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_mmio: Set DMA masks appropriately
Date: Tue, 10 Jan 2017 18:07:50 +0200
Message-ID: <20170110180656-mutt-send-email-mst@kernel.org>
References: <50defbbe87d75db85a9d22f914258975d661208a.1484051089.git.robin.murphy@arm.com>
	<20170110165221-mutt-send-email-mst@kernel.org>
	<b60d0de1-a79b-50c0-f773-5a509b0e94d5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b60d0de1-a79b-50c0-f773-5a509b0e94d5@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, luto@kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 10, 2017 at 03:55:31PM +0000, Robin Murphy wrote:
> On 10/01/17 14:54, Michael S. Tsirkin wrote:
> > On Tue, Jan 10, 2017 at 12:26:01PM +0000, Robin Murphy wrote:
> >> Once DMA API usage is enabled, it becomes apparent that virtio-mmio is
> >> inadvertently relying on the default 32-bit DMA mask, which leads to
> >> problems like rapidly exhausting SWIOTLB bounce buffers.
> >>
> >> Ensure that we set the appropriate 64-bit DMA mask whenever possible,
> >> with the coherent mask suitably limited for the legacy vring as per
> >> a0be1db4304f ("virtio_pci: Limit DMA mask to 44 bits for legacy virtio
> >> devices").
> >>
> >> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> >> Fixes: b42111382f0e ("virtio_mmio: Use the DMA API if enabled")
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>  drivers/virtio/virtio_mmio.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> >> index 48bfea91dbca..b5c5d49ca598 100644
> >> --- a/drivers/virtio/virtio_mmio.c
> >> +++ b/drivers/virtio/virtio_mmio.c
> >> @@ -59,6 +59,7 @@
> >>  #define pr_fmt(fmt) "virtio-mmio: " fmt
> >>  
> >>  #include <linux/acpi.h>
> >> +#include <linux/dma-mapping.h>
> >>  #include <linux/highmem.h>
> >>  #include <linux/interrupt.h>
> >>  #include <linux/io.h>
> >> @@ -497,6 +498,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
> >>  	struct virtio_mmio_device *vm_dev;
> >>  	struct resource *mem;
> >>  	unsigned long magic;
> >> +	int rc;
> >>  
> >>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>  	if (!mem)
> >> @@ -548,6 +550,14 @@ static int virtio_mmio_probe(struct platform_device *pdev)
> >>  	if (vm_dev->version == 1)
> >>  		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> >>  
> >> +	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >> +	if (rc)
> >> +		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> >> +	else if (vm_dev->version == 1)
> >> +		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32 + PAGE_SHIFT));
> > 
> > That's a very convoluted way to do this, for version 1 you
> > set coherent mask to 64 then override it.
> > why not
> > 
> > if (vm_dev->version == 1) {
> > 	dma_set_mask
> > 	dma_set_coherent_mask
> > } else {
> > 	dma_set_mask_and_coherent
> > }
> > 
> > if (rc)
> > 	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> 
> Purely because it's fewer lines of code - if you'd prefer separate
> legacy vs. modern flows for clarity that's fine by me.

Yes please. It's less legacy vs modern and more that I don't like
line 2 undoig what line 1 did.

> >> +	if (rc)
> >> +		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> >> +
> > 
> > is there a chance it actually still might work?
> 
> If we're not actually using the DMA API, we may still get away with it,
> otherwise it's a fairly sure bet that the subsequent dma_map/dma_alloc
> calls will fail and we'll get nowhere. If I change this to be a probe
> failure condition (and correspondingly in the PCI drivers too), would
> you rather that be predicated on vring_use_dma_api(), or always (given
> the TODO in virtio_ring.c)?
> 
> Robin.

Oh I see you are just mirroring what pci does. I think it's fine.

> >>  	platform_set_drvdata(pdev, vm_dev);
> >>  
> >>  	return register_virtio_device(&vm_dev->vdev);
> >> -- 
> >> 2.10.2.dirty
