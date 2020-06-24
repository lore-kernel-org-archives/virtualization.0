From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Date: Wed, 24 Jun 2020 10:59:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
References: <20200624091732.23944-1-peng.fan@nxp.com> <20200624050355-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200624050355-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peng Fan <peng.fan@nxp.com>, sstabellini@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, konrad.wilk@oracle.com, jasowang@redhat.com, x86@kernel.org, xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-imx@nxp.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > Export xen_swiotlb for all platforms using xen swiotlb
> > 
> > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > disabled, it is not required.
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> Xen was there first, but everyone else is using that now.

Unfortunately it is complicated and it is not related to
VIRTIO_F_IOMMU_PLATFORM :-(


The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
foreign mappings (memory coming from other VMs) to physical addresses.
On x86, it also uses dma_ops to translate Linux's idea of a physical
address into a real physical address (this is unneeded on ARM.)


So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
always and on Xen/ARM if Linux is Dom0 (because it has foreign
mappings.) That is why we have the if (xen_domain) return true; in
vring_use_dma_api.

You might have noticed that I missed one possible case above: Xen/ARM
DomU :-)

Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
(xen_domain) return true; would give the wrong answer in that case.
Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
the "normal" dma_ops fail.


The solution I suggested was to make the check in vring_use_dma_api more
flexible by returning true if the swiotlb_xen is supposed to be used,
not in general for all Xen domains, because that is what the check was
really meant to do.


In this regards I have two more comments:

- the comment on top of the check in vring_use_dma_api is still valid
- the patch looks broken on x86: it should always return true, but it
  returns false instead

 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index a2de775801af..768afd79f67a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_vring_use_dma())
> >  		return true;
> >  
> >  	return false;
> 
> 
> The comment above this should probably be fixed.

> 
