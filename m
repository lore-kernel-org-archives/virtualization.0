From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] iommu/virtio: Reject IOMMU page granule larger than
 PAGE_SIZE
Date: Wed, 18 Mar 2020 18:47:39 +0100
Message-ID: <20200318174739.GC1501414@myrica>
References: <20200318114047.1518048-1-jean-philippe@linaro.org>
 <f1f3d844-8080-d26d-200e-a38480895480@arm.com>
 <09a32736-ea01-21f9-6bd5-9344b368f90a@redhat.com>
 <5b637bf5-dc49-b6eb-852a-a4317602d43e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5b637bf5-dc49-b6eb-852a-a4317602d43e@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Auger Eric <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, Bharat Bhushan <bbhushan2@marvell.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 18, 2020 at 05:13:59PM +0000, Robin Murphy wrote:
> On 2020-03-18 4:14 pm, Auger Eric wrote:
> > Hi,
> > 
> > On 3/18/20 1:00 PM, Robin Murphy wrote:
> > > On 2020-03-18 11:40 am, Jean-Philippe Brucker wrote:
> > > > We don't currently support IOMMUs with a page granule larger than the
> > > > system page size. The IOVA allocator has a BUG_ON() in this case, and
> > > > VFIO has a WARN_ON().
> > 
> > Adding Alex in CC in case he has time to jump in. At the moment I don't
> > get why this WARN_ON() is here.
> > 
> > This was introduced in
> > c8dbca165bb090f926996a572ea2b5b577b34b70 vfio/iommu_type1: Avoid overflow
> > 
> > > > 
> > > > It might be possible to remove these obstacles if necessary. If the host
> > > > uses 64kB pages and the guest uses 4kB, then a device driver calling
> > > > alloc_page() followed by dma_map_page() will create a 64kB mapping for a
> > > > 4kB physical page, allowing the endpoint to access the neighbouring 60kB
> > > > of memory. This problem could be worked around with bounce buffers.
> > > 
> > > FWIW the fundamental issue is that callers of iommu_map() may expect to
> > > be able to map two or more page-aligned regions directly adjacent to
> > > each other for scatter-gather purposes (or ring buffer tricks), and
> > > that's just not possible if the IOMMU granule is too big. Bounce
> > > buffering would be a viable workaround for the streaming DMA API and
> > > certain similar use-cases, but not in general (e.g. coherent DMA, VFIO,
> > > GPUs, etc.)
> > > 
> > > Robin.
> > > 
> > > > For the moment, rather than triggering the IOVA BUG_ON() on mismatched
> > > > page sizes, abort the virtio-iommu probe with an error message.
> > 
> > I understand this is a introduced as a temporary solution but this
> > sounds as an important limitation to me. For instance this will prevent
> > from running a fedora guest exposed with a virtio-iommu with a RHEL host.
> 
> As above, even if you bypassed all the warnings it wouldn't really work
> properly anyway. In all cases that wouldn't be considered broken, the
> underlying hardware IOMMUs should support the same set of granules as the
> CPUs (or at least the smallest one), so is it actually appropriate for RHEL
> to (presumably) expose a 64K granule in the first place, rather than "works
> with anything" 4K? And/or more generally is there perhaps a hole in the
> virtio-iommu spec WRT being able to negotiate page_size_mask for a
> particular granule if multiple options are available?

That could be added (by allowing config write). The larger problems are:
1) Supporting granularity smaller than the host's PAGE_SIZE in host VFIO.
   At the moment it restricts the exposed page mask and rejects DMA_MAP
   requests not aligned on that granularity.
2) Propagating this negotiation all the way to io-pgtable and the SMMU
   driver in the host.

Thanks,
Jean
