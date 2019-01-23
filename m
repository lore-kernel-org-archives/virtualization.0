From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Date: Tue, 22 Jan 2019 21:57:18 -0500
Message-ID: <20190122210710-mutt-send-email-mst__5683.48786780319$1548212460$gmane$org@kernel.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
	<alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: jgross@suse.com, Peng Fan <peng.fan@nxp.com>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "hch@infradead.org" <hch@infradead.org>, luto@kernel.org, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 22, 2019 at 11:59:31AM -0800, Stefano Stabellini wrote:
> On Mon, 21 Jan 2019, Peng Fan wrote:
> > on i.MX8QM, M4_1 is communicating with DomU using rpmsg with a fixed
> > address as the dma mem buffer which is predefined.
> > 
> > Without this patch, the flow is:
> > vring_map_one_sg -> vring_use_dma_api
> >                  -> dma_map_page
> > 		       -> __swiotlb_map_page
> > 		                ->swiotlb_map_page
> > 				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> > However we are using per device dma area for rpmsg, phys_to_virt
> > could not return a correct virtual address for virtual address in
> > vmalloc area. Then kernel panic.
> > 
> > With this patch, vring_use_dma_api will return false, and
> > vring_map_one_sg will return sg_phys(sg) which is the correct phys
> > address in the predefined memory region.
> > vring_map_one_sg -> vring_use_dma_api
> >                  -> sg_phys(sg)
> > 
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cd7e755484e3..8993d7cb3592 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -248,6 +248,8 @@ static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
> >  
> >  static bool vring_use_dma_api(struct virtio_device *vdev)
> >  {
> > +	struct device *dma_dev = vdev->dev.parent;
> > +
> >  	if (!virtio_has_iommu_quirk(vdev))
> >  		return true;
> >  
> > @@ -260,7 +262,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	 * the DMA API if we're a Xen guest, which at least allows
> >  	 * all of the sensible Xen configurations to work correctly.
> >  	 */
> > -	if (xen_domain())
> > +	if (xen_domain() && !dma_dev->dma_mem)
> >  		return true;
> >  
> >  	return false;
> 
> I can see you spotted a real issue, but this is not the right fix. We
> just need something a bit more flexible than xen_domain(): there are
> many kinds of Xen domains on different architectures, we basically want
> to enable this (return true from vring_use_dma_api) only when the xen
> swiotlb is meant to be used. Does the appended patch fix the issue you
> have?
> 
> ---
> 
> xen: introduce xen_vring_use_dma
> 
> From: Stefano Stabellini <stefanos@xilinx.com>
> 
> Export xen_swiotlb on arm and arm64.
> 
> Use xen_swiotlb to determine when vring should use dma APIs to map the
> ring: when xen_swiotlb is enabled the dma API is required. When it is
> disabled, it is not required.
> 
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Stefano Stabellini <stefanos@xilinx.com>
> 
> diff --git a/arch/arm/include/asm/xen/swiotlb-xen.h b/arch/arm/include/asm/xen/swiotlb-xen.h
> new file mode 100644
> index 0000000..455ade5
> --- /dev/null
> +++ b/arch/arm/include/asm/xen/swiotlb-xen.h
> @@ -0,0 +1 @@
> +#include <xen/arm/swiotlb-xen.h>
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index cb44aa2..8592863 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -21,6 +21,8 @@
>  #include <asm/xen/hypercall.h>
>  #include <asm/xen/interface.h>
>  
> +int xen_swiotlb __read_mostly;
> +
>  unsigned long xen_get_swiotlb_free_pages(unsigned int order)
>  {
>  	struct memblock_region *reg;
> @@ -189,6 +191,7 @@ int __init xen_mm_init(void)
>  	struct gnttab_cache_flush cflush;
>  	if (!xen_initial_domain())
>  		return 0;
> +	xen_swiotlb = 1;
>  	xen_swiotlb_init(1, false);
>  	xen_dma_ops = &xen_swiotlb_dma_ops;
>  
> diff --git a/arch/arm64/include/asm/xen/swiotlb-xen.h b/arch/arm64/include/asm/xen/swiotlb-xen.h
> new file mode 100644
> index 0000000..455ade5
> --- /dev/null
> +++ b/arch/arm64/include/asm/xen/swiotlb-xen.h
> @@ -0,0 +1 @@
> +#include <xen/arm/swiotlb-xen.h>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755..bf8badc 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -260,7 +260,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	 * the DMA API if we're a Xen guest, which at least allows
>  	 * all of the sensible Xen configurations to work correctly.
>  	 */
> -	if (xen_domain())
> +	if (xen_vring_use_dma())
>  		return true;
>  
>  	return false;
> diff --git a/include/xen/arm/swiotlb-xen.h b/include/xen/arm/swiotlb-xen.h
> new file mode 100644
> index 0000000..2aac7c4
> --- /dev/null
> +++ b/include/xen/arm/swiotlb-xen.h
> @@ -0,0 +1,10 @@
> +#ifndef _ASM_ARM_XEN_SWIOTLB_XEN_H
> +#define _ASM_ARM_XEN_SWIOTLB_XEN_H
> +
> +#ifdef CONFIG_SWIOTLB_XEN
> +extern int xen_swiotlb;
> +#else
> +#define xen_swiotlb (0)
> +#endif
> +
> +#endif
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 0e21567..74a536d 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -46,4 +46,10 @@ enum xen_domain_type {
>  bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
>  		const struct bio_vec *vec2);
>  
> +#include <asm/xen/swiotlb-xen.h>
> +static inline int xen_vring_use_dma(void)
> +{
> +	return !!xen_swiotlb;

Given xen_swiotlb is only defined on arm, how will
this build on other architectures?

> +}
> +
>  #endif	/* _XEN_XEN_H */

I'd say at this point, I'm sorry we didn't come up with PLATFORM_ACCESS
when we added the xen hack.

I'm not objecting to this patch but I would also like to bypass the xen
hack for VIRTIO 1 devices. In particular I know rpmsg is still virtio 0
so it's not an issue for it. Is Xen already using VIRTIO 1, and without
setting PLATFORM_ACCESS? If not I would like to teach
vring_use_dma_api to return false on VIRTIO_1 && !PLATFORM_ACCESS.

Would that be acceptable?

-- 
MST
