From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Sun, 11 Aug 2019 04:12:50 -0400
Message-ID: <20190811041035-mutt-send-email-mst@kernel.org>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<20190810143038-mutt-send-email-mst@kernel.org>
	<20190810220702.GA5964@ram.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190810220702.GA5964@ram.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-devel@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 10, 2019 at 03:07:02PM -0700, Ram Pai wrote:
> On Sat, Aug 10, 2019 at 02:57:17PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jan 29, 2019 at 03:08:12PM -0200, Thiago Jung Bauermann wrote:
> > > 
> > > Hello,
> > > 
> > > With Christoph's rework of the DMA API that recently landed, the patch
> > > below is the only change needed in virtio to make it work in a POWER
> > > secure guest under the ultravisor.
> > > 
> > > The other change we need (making sure the device's dma_map_ops is NULL
> > > so that the dma-direct/swiotlb code is used) can be made in
> > > powerpc-specific code.
> > > 
> > > Of course, I also have patches (soon to be posted as RFC) which hook up
> > > <linux/mem_encrypt.h> to the powerpc secure guest support code.
> > > 
> > > What do you think?
> > > 
> > > >From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> > > From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > Date: Thu, 24 Jan 2019 22:08:02 -0200
> > > Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
> > > 
> > > The host can't access the guest memory when it's encrypted, so using
> > > regular memory pages for the ring isn't an option. Go through the DMA API.
> > > 
> > > Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index cd7e755484e3..321a27075380 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	 * not work without an even larger kludge.  Instead, enable
> > >  	 * the DMA API if we're a Xen guest, which at least allows
> > >  	 * all of the sensible Xen configurations to work correctly.
> > > +	 *
> > > +	 * Also, if guest memory is encrypted the host can't access
> > > +	 * it directly. In this case, we'll need to use the DMA API.
> > >  	 */
> > > -	if (xen_domain())
> > > +	if (xen_domain() || sev_active())
> > >  		return true;
> > > 
> > >  	return false;
> > 
> > So I gave this lots of thought, and I'm coming round to
> > basically accepting something very similar to this patch.
> > 
> > But not exactly like this :).
> > 
> > Let's see what are the requirements.
> > 
> > If
> > 
> > 1. We do not trust the device (so we want to use a bounce buffer with it)
> > 2. DMA address is also a physical address of a buffer
> > 
> > then we should use DMA API with virtio.
> > 
> > 
> > sev_active() above is one way to put (1).  I can't say I love it but
> > it's tolerable.
> > 
> > 
> > But we also want promise from DMA API about 2.
> > 
> > 
> > Without promise 2 we simply can't use DMA API with a legacy device.
> > 
> > 
> > Otherwise, on a SEV system with an IOMMU which isn't 1:1
> > and with a virtio device without ACCESS_PLATFORM, we are trying
> > to pass a virtual address, and devices without ACCESS_PLATFORM
> > can only access CPU physical addresses.
> > 
> > So something like:
> > 
> > dma_addr_is_phys_addr?
> 
> 
> On our Secure pseries platform,  dma address is physical address and this
> proposal will help us, use DMA API. 
> 
> On our normal pseries platform, dma address is physical address too.
> But we do not necessarily need to use the DMA API.  We can use the DMA
> API, but our handlers will do the same thing, the generic virtio handlers
> would do. If there is an opt-out option; even when dma addr is same as
> physical addr, than there will be less code duplication.
> 
> Would something like this be better.
> 
> (dma_addr_is_phys_addr  && arch_want_to_use_dma_api()) ?
> 
> 
> RP

I think sev_active() is an OK replacement for arch_want_to_use_dma_api.
So just the addition of dma_addr_is_phys_addr would be enough.

> 
> > -- 
> > MST
> 
> -- 
> Ram Pai
