From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Date: Wed, 24 Jun 2020 16:47:20 -0400
Message-ID: <20200624163940-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Stefano Stabellini <sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: jgross-IBi9RG/b67k@public.gmane.org, Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > Export xen_swiotlb for all platforms using xen swiotlb
> > > 
> > > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > > disabled, it is not required.
> > > 
> > > Signed-off-by: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
> > 
> > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > Xen was there first, but everyone else is using that now.
> 
> Unfortunately it is complicated and it is not related to
> VIRTIO_F_IOMMU_PLATFORM :-(
> 
> 
> The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
> foreign mappings (memory coming from other VMs) to physical addresses.
> On x86, it also uses dma_ops to translate Linux's idea of a physical
> address into a real physical address (this is unneeded on ARM.)
> 
> 
> So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
> always and on Xen/ARM if Linux is Dom0 (because it has foreign
> mappings.) That is why we have the if (xen_domain) return true; in
> vring_use_dma_api.

VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.

Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also*
forces DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.

Unfortunately as a result Xen never got around to
properly setting VIRTIO_F_IOMMU_PLATFORM.

I would like to make Xen do what everyone else is doing
which is just set VIRTIO_F_IOMMU_PLATFORM and then put
platform specific hacks inside DMA API.
Then we can think about deprecating the Xen hack in a
distance future, or hiding it behind a static branch, or something
like this.


> You might have noticed that I missed one possible case above: Xen/ARM
> DomU :-)
> 
> Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
> (xen_domain) return true; would give the wrong answer in that case.
> Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
> the "normal" dma_ops fail.
> 
> 
> The solution I suggested was to make the check in vring_use_dma_api more
> flexible by returning true if the swiotlb_xen is supposed to be used,
> not in general for all Xen domains, because that is what the check was
> really meant to do.

Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is wrong with that?


> 
> In this regards I have two more comments:
> 
> - the comment on top of the check in vring_use_dma_api is still valid
> - the patch looks broken on x86: it should always return true, but it
>   returns false instead
> 
>  
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index a2de775801af..768afd79f67a 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> > >  	 * the DMA API if we're a Xen guest, which at least allows
> > >  	 * all of the sensible Xen configurations to work correctly.
> > >  	 */
> > > -	if (xen_domain())
> > > +	if (xen_vring_use_dma())
> > >  		return true;
> > >  
> > >  	return false;
> > 
> > 
> > The comment above this should probably be fixed.
> 
> > 
