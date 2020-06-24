From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Date: Wed, 24 Jun 2020 18:16:26 -0400
Message-ID: <20200624181026-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
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

On Wed, Jun 24, 2020 at 02:53:54PM -0700, Stefano Stabellini wrote:
> On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 10:59:47AM -0700, Stefano Stabellini wrote:
> > > On Wed, 24 Jun 2020, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> > > > > Export xen_swiotlb for all platforms using xen swiotlb
> > > > > 
> > > > > Use xen_swiotlb to determine when vring should use dma APIs to map the
> > > > > ring: when xen_swiotlb is enabled the dma API is required. When it is
> > > > > disabled, it is not required.
> > > > > 
> > > > > Signed-off-by: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
> > > > 
> > > > Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
> > > > Xen was there first, but everyone else is using that now.
> > > 
> > > Unfortunately it is complicated and it is not related to
> > > VIRTIO_F_IOMMU_PLATFORM :-(
> > > 
> > > 
> > > The Xen subsystem in Linux uses dma_ops via swiotlb_xen to translate
> > > foreign mappings (memory coming from other VMs) to physical addresses.
> > > On x86, it also uses dma_ops to translate Linux's idea of a physical
> > > address into a real physical address (this is unneeded on ARM.)
> > > 
> > > 
> > > So regardless of VIRTIO_F_IOMMU_PLATFORM, dma_ops should be used on Xen/x86
> > > always and on Xen/ARM if Linux is Dom0 (because it has foreign
> > > mappings.) That is why we have the if (xen_domain) return true; in
> > > vring_use_dma_api.
> > 
> > VIRTIO_F_IOMMU_PLATFORM makes guest always use DMA ops.
> > 
> > Xen hack predates VIRTIO_F_IOMMU_PLATFORM so it *also*
> > forces DMA ops even if VIRTIO_F_IOMMU_PLATFORM is clear.
> >
> > Unfortunately as a result Xen never got around to
> > properly setting VIRTIO_F_IOMMU_PLATFORM.
> 
> I don't think VIRTIO_F_IOMMU_PLATFORM would be correct for this because
> the usage of swiotlb_xen is not a property of virtio,


Basically any device without VIRTIO_F_ACCESS_PLATFORM
(that is it's name in latest virtio spec, VIRTIO_F_IOMMU_PLATFORM is
what linux calls it) is declared as "special, don't follow normal rules
for access".

So yes swiotlb_xen is not a property of virtio, but what *is* a property
of virtio is that it's not special, just a regular device from DMA POV.


> it is a detail of
> the way Linux does Xen address translations. swiotlb-xen is used to do
> these translations and it is hooked into the dma_ops framework.
> 
> It would be possible to have a device in hardware that is
> virtio-compatible and doesn't set VIRTIO_F_IOMMU_PLATFORM.

That device would be basically broken, since hardware
can't know whether it can access all memory or not.

> The device
> could be directly assigned (passthrough) to a DomU. We would still
> have to use swiotlb_xen if Xen is running.
> 
> You should think of swiotlb-xen as only internal to Linux and not
> related to whether the (virtual or non-virtual) hardware comes with an
> IOMMU or not.

IOMMU is a misnomer here.  Virtio spec now calls this bit
VIRTIO_F_ACCESS_PLATFORM. We should have done the same a while ago -
I'll send a patch.

> 
> > > You might have noticed that I missed one possible case above: Xen/ARM
> > > DomU :-)
> > > 
> > > Xen/ARM domUs don't need swiotlb_xen, it is not even initialized. So if
> > > (xen_domain) return true; would give the wrong answer in that case.
> > > Linux would end up calling the "normal" dma_ops, not swiotlb-xen, and
> > > the "normal" dma_ops fail.
> > > 
> > > 
> > > The solution I suggested was to make the check in vring_use_dma_api more
> > > flexible by returning true if the swiotlb_xen is supposed to be used,
> > > not in general for all Xen domains, because that is what the check was
> > > really meant to do.
> > 
> > Why not fix DMA ops so they DTRT (nop) on Xen/ARM DomU? What is wrong with that?
> 
> swiotlb-xen is not used on Xen/ARM DomU, the default dma_ops are the
> ones that are used. So you are saying, why don't we fix the default
> dma_ops to work with virtio?
> 
> It is bad that the default dma_ops crash with virtio, so yes I think it
> would be good to fix that. However, even if we fixed that, the if
> (xen_domain()) check in vring_use_dma_api is still a problem.

Why is it a problem? It just makes virtio use DMA API.
If that in turn works, problem solved.



> 
> Alternatively we could try to work-around it from swiotlb-xen. We could
> enable swiotlb-xen for Xen/ARM DomUs with a different implementation so
> that we could leave the vring_use_dma_api check unmodified.
> 
> It would be ugly because we would have to figure out from the new
> swiotlb-xen functions if the device is a normal device, so we have to
> call the regular dma_ops functions, or if the device is a virtio device,
> in which case there is nothing to do. I think it is undesirable but
> could probably be made to work.
