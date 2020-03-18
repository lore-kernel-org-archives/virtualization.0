From: Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/virtio: Reject IOMMU page granule larger than
 PAGE_SIZE
Date: Wed, 18 Mar 2020 18:06:41 +0100
Message-ID: <20200318170641.GB1501414@myrica>
References: <20200318114047.1518048-1-jean-philippe@linaro.org>
 <f1f3d844-8080-d26d-200e-a38480895480@arm.com>
 <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <09a32736-ea01-21f9-6bd5-9344b368f90a-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bharat Bhushan <bbhushan2-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 18, 2020 at 05:14:05PM +0100, Auger Eric wrote:
> Hi,
> 
> On 3/18/20 1:00 PM, Robin Murphy wrote:
> > On 2020-03-18 11:40 am, Jean-Philippe Brucker wrote:
> >> We don't currently support IOMMUs with a page granule larger than the
> >> system page size. The IOVA allocator has a BUG_ON() in this case, and
> >> VFIO has a WARN_ON().
> 
> Adding Alex in CC in case he has time to jump in. At the moment I don't
> get why this WARN_ON() is here.
> 
> This was introduced in
> c8dbca165bb090f926996a572ea2b5b577b34b70 vfio/iommu_type1: Avoid overflow
> 
> >>
> >> It might be possible to remove these obstacles if necessary. If the host
> >> uses 64kB pages and the guest uses 4kB, then a device driver calling
> >> alloc_page() followed by dma_map_page() will create a 64kB mapping for a
> >> 4kB physical page, allowing the endpoint to access the neighbouring 60kB
> >> of memory. This problem could be worked around with bounce buffers.
> > 
> > FWIW the fundamental issue is that callers of iommu_map() may expect to
> > be able to map two or more page-aligned regions directly adjacent to
> > each other for scatter-gather purposes (or ring buffer tricks), and
> > that's just not possible if the IOMMU granule is too big. Bounce
> > buffering would be a viable workaround for the streaming DMA API and
> > certain similar use-cases, but not in general (e.g. coherent DMA, VFIO,
> > GPUs, etc.)
> > 
> > Robin.
> > 
> >> For the moment, rather than triggering the IOVA BUG_ON() on mismatched
> >> page sizes, abort the virtio-iommu probe with an error message.
> 
> I understand this is a introduced as a temporary solution but this
> sounds as an important limitation to me. For instance this will prevent
> from running a fedora guest exposed with a virtio-iommu with a RHEL host.

Looks like you have another argument for nested translation :) We could
probably enable 64k-4k for VFIO, but I don't think we can check and fix
all uses of iommu_map() across the kernel, even if we disallow
IOMMU_DOMAIN_DMA for this case.

Thanks,
Jean
