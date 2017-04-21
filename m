From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [RFC 3/3] virtio-iommu: future work
Date: Fri, 21 Apr 2017 08:31:15 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190CB249E__1243.02943372658$1492763491$gmane$org@SHSMSX101.ccr.corp.intel.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407191747.26618-4-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407191747.26618-4-jean-philippe.brucker@arm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Jean-Philippe Brucker
> Sent: Saturday, April 8, 2017 3:18 AM
> 
> Here I propose a few ideas for extensions and optimizations. This is all
> very exploratory, feel free to correct mistakes and suggest more things.

[...]
> 
>   II. Page table sharing
>   ======================
> 
>   1. Sharing IOMMU page tables
>   ----------------------------
> 
> VIRTIO_IOMMU_F_PT_SHARING
> 
> This is independent of the nested mode described in I.2, but relies on a
> similar feature in the physical IOMMU: having two stages of page tables,
> one for the host and one for the guest.
> 
> When this is supported, the guest can manage its own s1 page directory, to
> avoid sending MAP/UNMAP requests. Feature
> VIRTIO_IOMMU_F_PT_SHARING allows
> a driver to give a page directory pointer (pgd) to the host and send
> invalidations when removing or changing a mapping. In this mode, three
> requests are used: probe, attach and invalidate. An address space cannot
> be using the MAP/UNMAP interface and PT_SHARING at the same time.
> 
> Device and driver first need to negotiate which page table format they
> will be using. This depends on the physical IOMMU, so the request contains
> a negotiation part to probe the device capabilities.
> 
> (1) Driver attaches devices to address spaces as usual, but a flag
>     VIRTIO_IOMMU_ATTACH_F_PRIVATE (working title) tells the device not to
>     create page tables for use with the MAP/UNMAP API. The driver intends
>     to manage the address space itself.
> 
> (2) Driver sends a PROBE_TABLE request. It sets len > 0 with the size of
>     pg_format array.
> 
> 	VIRTIO_IOMMU_T_PROBE_TABLE
> 
> 	struct virtio_iommu_req_probe_table {
> 		le32	address_space;
> 		le32	flags;
> 		le32	len;
> 
> 		le32	nr_contexts;
> 		struct {
> 			le32	model;
> 			u8	format[64];
> 		} pg_format[len];
> 	};
> 
> Introducing a probe request is more flexible than advertising those
> features in virtio config, because capabilities are dynamic, and depend on
> which devices are attached to an address space. Within a single address
> space, devices may support different numbers of contexts (PASIDs), and
> some may not support recoverable faults.
> 
> (3) Device responds success with all page table formats implemented by the
>     physical IOMMU in pg_format. 'model' 0 is invalid, so driver can
>     initialize the array to 0 and deduce from there which entries have
>     been filled by the device.
> 
> Using a probe method seems preferable over trying to attach every possible
> format until one sticks. For instance, with an ARM guest running on an x86
> host, PROBE_TABLE would return the Intel IOMMU page table format, and
> the
> guest could use that page table code to handle its mappings, hidden behind
> the IOMMU API. This requires that the page-table code is reasonably
> abstracted from the architecture, as is done with drivers/iommu/io-pgtable
> (an x86 guest could use any format implement by io-pgtable for example.)

So essentially you need modify all existing IOMMU drivers to support page 
table sharing in pvIOMMU. After abstraction is done the core pvIOMMU files 
can be kept vendor agnostic. But if we talk about the whole pvIOMMU 
module, it actually includes vendor specific logic thus unlike typical 
para-virtualized virtio drivers being completely vendor agnostic. Is this 
understanding accurate?

It also means in the host-side pIOMMU driver needs to propagate all
supported formats through VFIO to Qemu vIOMMU, meaning
such format definitions need be consistently agreed across all those 
components.

[...]

> 
>   2. Sharing MMU page tables
>   --------------------------
> 
> The guest can share process page-tables with the physical IOMMU. To do
> that, it sends PROBE_TABLE with (F_INDIRECT | F_NATIVE | F_FAULT). The
> page table format is implicit, so the pg_format array can be empty (unless
> the guest wants to query some specific property, e.g. number of levels
> supported by the pIOMMU?). If the host answers with success, guest can
> send its MMU page table details with ATTACH_TABLE and (F_NATIVE |
> F_INDIRECT | F_FAULT) flags.
> 
> F_FAULT means that the host communicates page requests from device to
> the
> guest, and the guest can handle them by mapping virtual address in the
> fault to pages. It is only available with VIRTIO_IOMMU_F_FAULT_QUEUE (see
> below.)
> 
> F_NATIVE means that the pIOMMU pgtable format is the same as guest
> MMU
> pgtable format.
> 
> F_INDIRECT means that 'table' pointer is a context table, instead of a
> page directory. Each slot in the context table points to a page directory:
> 
>                        64              2 1 0
>           table ----> +---------------------+
>                       |       pgd       |0|1|<--- context 0
>                       |       ---       |0|0|<--- context 1
>                       |       pgd       |0|1|
>                       |       ---       |0|0|
>                       |       ---       |0|0|
>                       +---------------------+
>                                          | \___Entry is valid
>                                          |______reserved
> 
> Question: do we want per-context page table format, or can it stay global
> for the whole indirect table?

Are you defining this context table format in software, or following
hardware definition? At least for VT-d there is a strict hardware-defined
structure (PASID table) which must be used here.

[...]
> 
>   4. Host implementation with VFIO
>   --------------------------------
> 
> The VFIO interface for sharing page tables is being worked on at the
> moment by Intel. Other virtual IOMMU implementation will most likely let
> guest manage full context tables (PASID tables) themselves, giving the
> context table pointer to the pIOMMU via a VFIO ioctl.
> 
> For the architecture-agnostic virtio-iommu however, we shouldn't have to
> implement all possible formats of context table (they are at least
> different between ARM SMMU and Intel IOMMU, and will certainly be
> extended

Since anyway you'll finally require vendor specific page table logic,
why not also abstracting this context table too which then doesn't
require below host-side changes?

> in future physical IOMMU architectures.) In addition, most users might
> only care about having one page directory per device, as SVM is a luxury
> at the moment and few devices support it. For these reasons, we should
> allow to pass single page directories via VFIO, using very similar
> structures as described above, whilst reusing the VFIO channel developed
> for Intel vIOMMU.
> 
> 	* VFIO_SVM_INFO: probe page table formats
> 	* VFIO_SVM_BIND: set pgd and arch-specific configuration
> 
> There is an inconvenient with letting the pIOMMU driver manage the guest's
> context table. During a page table walk, the pIOMMU translates the context
> table pointer using the stage-2 page tables. The context table must
> therefore be mapped in guest-physical space by the pIOMMU driver. One
> solution is to let the pIOMMU driver reserve some GPA space upfront using
> the iommu and sysfs resv API [1]. The host would then carve that region
> out of the guest-physical space using a firmware mechanism (for example DT
> reserved-memory node).

Can you elaborate this flow? pIOMMU driver doesn't directly manage GPA
address space thus it's not reasonable for it to randomly specify a reserved
range. It might make more sense for GPA owner (e.g. Qemu) to decide and
then pass information to pIOMMU driver.

> 
> 
>   III. Relaxed operations
>   =======================
> 
> VIRTIO_IOMMU_F_RELAXED
> 
> Adding an IOMMU dramatically reduces performance of a device, because
> map/unmap operations are costly and produce a lot of TLB traffic. For
> significant performance improvements, device might allow the driver to
> sacrifice safety for speed. In this mode, the driver does not need to send
> UNMAP requests. The semantics of MAP change and are more complex to
> implement. Given a MAP([start:end] -> phys, flags) request:
> 
> (1) If [start:end] isn't mapped, request succeeds as usual.
> (2) If [start:end] overlaps an existing mapping [old_start:old_end], we
>     unmap [max(start, old_start):min(end, old_end)] and replace it with
>     [start:end].
> (3) If [start:end] overlaps an existing mapping that matches the new map
>     request exactly (same flags, same phys address), the old mapping is
>     kept.
> 
> This squashing could be performed by the guest. The driver can catch unmap
> requests from the DMA layer, and only relay map requests for (1) and (2).
> A MAP request is therefore able to split and partially override an
> existing mapping, which isn't allowed in non-relaxed mode. UNMAP requests
> are unnecessary, but are now allowed to split or carve holes in mappings.
> 
> In this model, a MAP request may take longer, but we may have a net gain
> by removing a lot of redundant requests. Squashing series of map/unmap
> performed by the guest for the same mapping improves temporal reuse of
> IOVA mappings, which I can observe by simply dumping IOMMU activity of a
> virtio device. It reduce the number of TLB invalidations to the strict
> minimum while keeping correctness of DMA operations (provided the device
> obeys its driver). There is a good read on the subject of optimistic
> teardown in paper [2].
> 
> This model is completely unsafe. A stale DMA transaction might access a
> page long after the device driver in the guest unmapped it and
> decommissioned the page. The DMA transaction might hit into a completely
> different part of the system that is now reusing the page. Existing
> relaxed implementations attempt to mitigate the risk by setting a timeout
> on the teardown. Unmap requests from device drivers are not discarded
> entirely, but buffered and sent at a later time. Paper [2] reports good
> results with a 10ms delay.
> 
> We could add a way for device and driver to negotiate a vulnerability
> window to mitigate the risk of DMA attacks. Driver might not accept a
> window at all, since it requires more infrastructure to keep delayed
> mappings. In my opinion, it should be made clear that regardless of the
> duration of this window, any driver accepting F_RELAXED feature makes the
> guest completely vulnerable, and the choice boils down to either isolation
> or speed, not a bit of both.

Even with above optimization I'd image the performance drop is still
significant for kernel map/unmap usages, not to say when such 
optimization is not possible if safety is required (actually I don't
know why IOMMU is still required if safety can be compromised. Aren't
we using IOMMU for security purpose?). I think we'd better focus on
higher-value usages, e.g. user space DMA protection (DPDK) and 
SVM, while leaving kernel protection with a lower priority (most for 
functionality verification). Is this strategy aligned with your thought?

btw what about interrupt remapping/posting? Are they also in your
plan for pvIOMMU?

Last, thanks for very informative write-! Looks a long enabling path is 
required get pvIOMMU feature on-par with a real IOMMU. Starting 
with a minimal set is relatively easier. :-)

Thanks
Kevin
