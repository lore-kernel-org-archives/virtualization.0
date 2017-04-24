From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC 3/3] virtio-iommu: future work
Date: Mon, 24 Apr 2017 16:05:55 +0100
Message-ID: <48f4cfa5-6240-e3ae-e437-5617b6c61bc1__44891.6570087478$1493046232$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407191747.26618-4-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190CB249E@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190CB249E@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 21/04/17 09:31, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Saturday, April 8, 2017 3:18 AM
>>
>> Here I propose a few ideas for extensions and optimizations. This is all
>> very exploratory, feel free to correct mistakes and suggest more things.
> 
> [...]
>>
>>   II. Page table sharing
>>   ======================
>>
>>   1. Sharing IOMMU page tables
>>   ----------------------------
>>
>> VIRTIO_IOMMU_F_PT_SHARING
>>
>> This is independent of the nested mode described in I.2, but relies on a
>> similar feature in the physical IOMMU: having two stages of page tables,
>> one for the host and one for the guest.
>>
>> When this is supported, the guest can manage its own s1 page directory, to
>> avoid sending MAP/UNMAP requests. Feature
>> VIRTIO_IOMMU_F_PT_SHARING allows
>> a driver to give a page directory pointer (pgd) to the host and send
>> invalidations when removing or changing a mapping. In this mode, three
>> requests are used: probe, attach and invalidate. An address space cannot
>> be using the MAP/UNMAP interface and PT_SHARING at the same time.
>>
>> Device and driver first need to negotiate which page table format they
>> will be using. This depends on the physical IOMMU, so the request contains
>> a negotiation part to probe the device capabilities.
>>
>> (1) Driver attaches devices to address spaces as usual, but a flag
>>     VIRTIO_IOMMU_ATTACH_F_PRIVATE (working title) tells the device not to
>>     create page tables for use with the MAP/UNMAP API. The driver intends
>>     to manage the address space itself.
>>
>> (2) Driver sends a PROBE_TABLE request. It sets len > 0 with the size of
>>     pg_format array.
>>
>> 	VIRTIO_IOMMU_T_PROBE_TABLE
>>
>> 	struct virtio_iommu_req_probe_table {
>> 		le32	address_space;
>> 		le32	flags;
>> 		le32	len;
>>
>> 		le32	nr_contexts;
>> 		struct {
>> 			le32	model;
>> 			u8	format[64];
>> 		} pg_format[len];
>> 	};
>>
>> Introducing a probe request is more flexible than advertising those
>> features in virtio config, because capabilities are dynamic, and depend on
>> which devices are attached to an address space. Within a single address
>> space, devices may support different numbers of contexts (PASIDs), and
>> some may not support recoverable faults.
>>
>> (3) Device responds success with all page table formats implemented by the
>>     physical IOMMU in pg_format. 'model' 0 is invalid, so driver can
>>     initialize the array to 0 and deduce from there which entries have
>>     been filled by the device.
>>
>> Using a probe method seems preferable over trying to attach every possible
>> format until one sticks. For instance, with an ARM guest running on an x86
>> host, PROBE_TABLE would return the Intel IOMMU page table format, and
>> the
>> guest could use that page table code to handle its mappings, hidden behind
>> the IOMMU API. This requires that the page-table code is reasonably
>> abstracted from the architecture, as is done with drivers/iommu/io-pgtable
>> (an x86 guest could use any format implement by io-pgtable for example.)
> 
> So essentially you need modify all existing IOMMU drivers to support page 
> table sharing in pvIOMMU. After abstraction is done the core pvIOMMU files 
> can be kept vendor agnostic. But if we talk about the whole pvIOMMU 
> module, it actually includes vendor specific logic thus unlike typical 
> para-virtualized virtio drivers being completely vendor agnostic. Is this 
> understanding accurate?

Yes, although kernel modules would be separate. For Linux on ARM we
already have the page-table logic abstracted in iommu/io-pgtable module,
because multiple IOMMUs share the same PT formats (SMMUv2, SMMUv3, Renesas
IPMMU, Qcom MSM, Mediatek). It offers a simple interface:

* When attaching devices to an IOMMU domain, the IOMMU driver registers
its page table format and provides invalidation callbacks.

* On iommu_map/unmap, the IOMMU driver calls into io_pgtable_ops, which
provide map, unmap and iova_to_phys functions.

* Page table operations call back into the driver via iommu_gather_ops
when they need to invalidate TLB entries.

Currently only the few flavors of ARM PT formats are implemented, but
other page table formats could be added if they fit this model.

> It also means in the host-side pIOMMU driver needs to propagate all
> supported formats through VFIO to Qemu vIOMMU, meaning
> such format definitions need be consistently agreed across all those 
> components.

Yes, that's the icky part. We need to define a format that every OS and
hypervisor implementing virtio-iommu can understand (similarly to the
PASID table sharing interface that Yi L is working on for VFIO, although
that one is contained in Linux UAPI and doesn't require other OSes to know
about it).

>>   2. Sharing MMU page tables
>>   --------------------------
>>
>> The guest can share process page-tables with the physical IOMMU. To do
>> that, it sends PROBE_TABLE with (F_INDIRECT | F_NATIVE | F_FAULT). The
>> page table format is implicit, so the pg_format array can be empty (unless
>> the guest wants to query some specific property, e.g. number of levels
>> supported by the pIOMMU?). If the host answers with success, guest can
>> send its MMU page table details with ATTACH_TABLE and (F_NATIVE |
>> F_INDIRECT | F_FAULT) flags.
>>
>> F_FAULT means that the host communicates page requests from device to
>> the
>> guest, and the guest can handle them by mapping virtual address in the
>> fault to pages. It is only available with VIRTIO_IOMMU_F_FAULT_QUEUE (see
>> below.)
>>
>> F_NATIVE means that the pIOMMU pgtable format is the same as guest
>> MMU
>> pgtable format.
>>
>> F_INDIRECT means that 'table' pointer is a context table, instead of a
>> page directory. Each slot in the context table points to a page directory:
>>
>>                        64              2 1 0
>>           table ----> +---------------------+
>>                       |       pgd       |0|1|<--- context 0
>>                       |       ---       |0|0|<--- context 1
>>                       |       pgd       |0|1|
>>                       |       ---       |0|0|
>>                       |       ---       |0|0|
>>                       +---------------------+
>>                                          | \___Entry is valid
>>                                          |______reserved
>>
>> Question: do we want per-context page table format, or can it stay global
>> for the whole indirect table?
> 
> Are you defining this context table format in software, or following
> hardware definition? At least for VT-d there is a strict hardware-defined
> structure (PASID table) which must be used here.

This definition is only for virtio-iommu, I didn't follow any hardware
definitions. For SMMUv3 the context tables are completely different. There
may be two levels of tables, and each context gets a 512-bits descriptor
(it has per-context page table format and other info).

To be honest I'm not sure where I was going with this indirect table. I
can't see any advantage in using an indirect table over sending a bunch of
individual ATTACH_TABLE requests, each with a pgd and a pasid. However the
indirect flag could be needed for sharing physical context tables (below).

>>   4. Host implementation with VFIO
>>   --------------------------------
>>
>> The VFIO interface for sharing page tables is being worked on at the
>> moment by Intel. Other virtual IOMMU implementation will most likely let
>> guest manage full context tables (PASID tables) themselves, giving the
>> context table pointer to the pIOMMU via a VFIO ioctl.
>>
>> For the architecture-agnostic virtio-iommu however, we shouldn't have to
>> implement all possible formats of context table (they are at least
>> different between ARM SMMU and Intel IOMMU, and will certainly be
>> extended
> 
> Since anyway you'll finally require vendor specific page table logic,
> why not also abstracting this context table too which then doesn't
> require below host-side changes?

I keep going back and forth on that question :) Some pIOMMUs won't have
context tables, so we need a ATTACH_TABLE interface for sharing single pgd
anyway. Now for SVM, we could either create an additional interface for
vendor-specific context tables, or send individual ATTACH_TABLE request.

The disadvantage of sharing context tables is that it requires more
specification work to enumerate all existing context table formats,
similarly to the work needed for defining all page table formats. As I
said earlier this work needs to be done anyway for VFIO, but this time it
would be an interface that needs to suit all OSes and hypervisor, not only
Linux. I think it's a lot more complicated to agree on that since it's not
a matter of sending Linux patches to extend the interface anymore, it is a
wider scope.

So we need to carefully consider whether this additional specification
effort is really needed. We certainly want to share page tables with the
guest to improves performance over the map/unmap interface, but I don't
see a similar performance concern on context tables. Supposedly binding a
device context to a task is a relatively rare event, much less frequent
than updating PT mappings.

In addition page table formats might be more common than context table
formats and therefore easier to abstract. With context tables you will
need one format per IOMMU variant, whereas (on ARM) multiple IOMMUs could
share the same page table format. I'm not sure whether the same argument
applies to x86 (similarity of page tables between Intel and AMD IOMMU
versus differences in PASID/GCR3 table formats)

On the other hand, the clear advantage of sharing context tables with the
guest is that we don't have to do the complicated memory reserve dance
described below.

>> in future physical IOMMU architectures.) In addition, most users might
>> only care about having one page directory per device, as SVM is a luxury
>> at the moment and few devices support it. For these reasons, we should
>> allow to pass single page directories via VFIO, using very similar
>> structures as described above, whilst reusing the VFIO channel developed
>> for Intel vIOMMU.
>>
>> 	* VFIO_SVM_INFO: probe page table formats
>> 	* VFIO_SVM_ATTACH_TABLE: set pgd and arch-specific configuration
>>
>> There is an inconvenient with letting the pIOMMU driver manage the guest's
>> context table. During a page table walk, the pIOMMU translates the context
>> table pointer using the stage-2 page tables. The context table must
>> therefore be mapped in guest-physical space by the pIOMMU driver. One
>> solution is to let the pIOMMU driver reserve some GPA space upfront using
>> the iommu and sysfs resv API [1]. The host would then carve that region
>> out of the guest-physical space using a firmware mechanism (for example DT
>> reserved-memory node).
> 
> Can you elaborate this flow? pIOMMU driver doesn't directly manage GPA
> address space thus it's not reasonable for it to randomly specify a reserved
> range. It might make more sense for GPA owner (e.g. Qemu) to decide and
> then pass information to pIOMMU driver.

I realized that it's actually more complicated than this, because I didn't
consider hotplugging devices into VM. If you insert new devices at
runtime, you might need more GPA space for storing their context tables,
but only if they don't attach to an existing address space (otherwise on
ARM we could reuse the existing context table)

So GPA space cannot be reserved statically, but must be reclaimed at
runtime. In addition, context tables can become quite big, and with static
reserve we'd have to reserve tonnes of GPA space upfront even if the guest
isn't planning on using context tables at all. And even without
considering SVM, some IOMMUs (namely SMMUv3) would still need a
single-entry table in GPA space for nested translation.

I don't have any pleasant solution so far. One way of doing it is to carry
memory reclaim in ATTACH_TABLE requests:

(1) Driver sends ATTACH_TABLE(pasid, pgd)
(2) Device relays BIND(pasid, pgd) to pIOMMU via VFIO
(3) pIOMMU needs, say, 512KiB of contiguous GPA for mapping a context
table. Returns this info via VFIO.
(4) Device replies to ATTACH_TABLE with "try again" and, somewhere in the
request buffer, stores the amount of contiguous GPA that the operation
will cost.
(5) Driver re-sends the ATTACH_TABLE request, but this time with a GPA
address that the host can use.

Note that each reclaim for a table should be accompanied by an identifier
for that table. So that if a second ATTACH_TABLE requests reaches the
device between (4) and (5) and require GPA space for the same table, the
device returns the same GPA reclaim with the same identifier and the
driver won't have to allocate GPA twice.

If the pIOMMU needs N > 1 contiguous GPA chunks (for instance, two levels
of context tables) we could do N reclaim (requiring N + 1 ATTACH_TABLE
requests) or put an array in the ATTACH_TABLE request. I prefer the
former, there is little advantage to the latter.

Alternatively, this could be a job for something similar to
virtio-balloon, with contiguous chunks instead of pages. The ATTACH_TABLE
would block the primary request queue while the GPA reclaim is serviced by
the guest on an auxiliary queue (which may not be acceptable if the driver
expects MAP/UNMAP/INVALIDATE requests on the same queue to be fast).

In any case, I would greatly appreciate any proposal for a nicer
mechanism, because this feels very fragile.

>>   III. Relaxed operations
>>   =======================
>>
>> VIRTIO_IOMMU_F_RELAXED
>>
>> Adding an IOMMU dramatically reduces performance of a device, because
>> map/unmap operations are costly and produce a lot of TLB traffic. For
>> significant performance improvements, device might allow the driver to
>> sacrifice safety for speed. In this mode, the driver does not need to send
>> UNMAP requests. The semantics of MAP change and are more complex to
>> implement. Given a MAP([start:end] -> phys, flags) request:
>>
>> (1) If [start:end] isn't mapped, request succeeds as usual.
>> (2) If [start:end] overlaps an existing mapping [old_start:old_end], we
>>     unmap [max(start, old_start):min(end, old_end)] and replace it with
>>     [start:end].
>> (3) If [start:end] overlaps an existing mapping that matches the new map
>>     request exactly (same flags, same phys address), the old mapping is
>>     kept.
>>
>> This squashing could be performed by the guest. The driver can catch unmap
>> requests from the DMA layer, and only relay map requests for (1) and (2).
>> A MAP request is therefore able to split and partially override an
>> existing mapping, which isn't allowed in non-relaxed mode. UNMAP requests
>> are unnecessary, but are now allowed to split or carve holes in mappings.
>>
>> In this model, a MAP request may take longer, but we may have a net gain
>> by removing a lot of redundant requests. Squashing series of map/unmap
>> performed by the guest for the same mapping improves temporal reuse of
>> IOVA mappings, which I can observe by simply dumping IOMMU activity of a
>> virtio device. It reduce the number of TLB invalidations to the strict
>> minimum while keeping correctness of DMA operations (provided the device
>> obeys its driver). There is a good read on the subject of optimistic
>> teardown in paper [2].
>>
>> This model is completely unsafe. A stale DMA transaction might access a
>> page long after the device driver in the guest unmapped it and
>> decommissioned the page. The DMA transaction might hit into a completely
>> different part of the system that is now reusing the page. Existing
>> relaxed implementations attempt to mitigate the risk by setting a timeout
>> on the teardown. Unmap requests from device drivers are not discarded
>> entirely, but buffered and sent at a later time. Paper [2] reports good
>> results with a 10ms delay.
>>
>> We could add a way for device and driver to negotiate a vulnerability
>> window to mitigate the risk of DMA attacks. Driver might not accept a
>> window at all, since it requires more infrastructure to keep delayed
>> mappings. In my opinion, it should be made clear that regardless of the
>> duration of this window, any driver accepting F_RELAXED feature makes the
>> guest completely vulnerable, and the choice boils down to either isolation
>> or speed, not a bit of both.
> 
> Even with above optimization I'd image the performance drop is still
> significant for kernel map/unmap usages, not to say when such 
> optimization is not possible if safety is required (actually I don't
> know why IOMMU is still required if safety can be compromised. Aren't
> we using IOMMU for security purpose?).

I guess apart from security concerns, a significant use case would be
scatter-gather, avoiding large contiguous (and pinned down) allocations in
guests. It's quite useful when you start doing DMA over MB or GB of
memory. It also allows pass-though to guest userspace, but for that there
are other ways (UIO or vfio-noiommu)

> I think we'd better focus on
> higher-value usages, e.g. user space DMA protection (DPDK) and 
> SVM, while leaving kernel protection with a lower priority (most for 
> functionality verification). Is this strategy aligned with your thought?
> 
> btw what about interrupt remapping/posting? Are they also in your
> plan for pvIOMMU?

I didn't think about this so far, because we don't have a special region
reserved for MSIs in the ARM IOMMUs; all MSI doorbells are accessed with
IOVAs and translated similarly to other regions. In addition with KVM ARM,
MSI injection bypasses the IOMMU altogether, the host doesn't actually
write the MSI. I could take a look at what other hypervisors and
architectures do.

> Last, thanks for very informative write-! Looks a long enabling path is 
> required get pvIOMMU feature on-par with a real IOMMU. Starting 
> with a minimal set is relatively easier. :-)

Yes, I described possible improvements in 3/3 in order to see how they
would fit within the baseline device of 2/3. But apart from vhost
prototype, these are a long way off, and I'd like to make sure that the
base is solid before tackling the rest.

Thanks,
Jean-Philippe
