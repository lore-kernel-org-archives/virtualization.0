From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 3/3] virtio-iommu: future work
Date: Wed, 26 Apr 2017 19:24:24 +0300
Message-ID: <20170426192340-mutt-send-email-mst__4826.53783769837$1493223888$gmane$org@kernel.org>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407191747.26618-4-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170407191747.26618-4-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: virtio-dev@lists.oasis-open.org, lorenzo.pieralisi@arm.com, kvm@vger.kernel.org, cdall@linaro.org, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 07, 2017 at 08:17:47PM +0100, Jean-Philippe Brucker wrote:
> Here I propose a few ideas for extensions and optimizations. This is all
> very exploratory, feel free to correct mistakes and suggest more things.
> 
> 	I.   Linux host
> 	     1. vhost-iommu

A qemu based implementation would be a first step.
Would allow validating the claim that it's much
simpler to support than e.g. VTD.

> 	     2. VFIO nested translation
> 	II.  Page table sharing
> 	     1. Sharing IOMMU page tables
> 	     2. Sharing MMU page tables (SVM)
> 	     3. Fault reporting
> 	     4. Host implementation with VFIO
> 	III. Relaxed operations
> 	IV.  Misc
> 
> 
>   I. Linux host
>   =============
> 
>   1. vhost-iommu
>   --------------
> 
> An advantage of virtualizing an IOMMU using virtio is that it allows to
> hoist a lot of the emulation code into the kernel using vhost, and avoid
> returning to userspace for each request. The mainline kernel already
> implements vhost-net, vhost-scsi and vhost-vsock, and a lot of core code
> could be reused.
> 
> Introducing vhost in a simplified scenario 1 (removed guest userspace
> pass-through, irrelevant to this example) gives us the following:
> 
>   MEM____pIOMMU________PCI device____________                    HARDWARE
>             |                                \
>   ----------|-------------+-------------+-----\--------------------------
>             |             :     KVM     :      \
>        pIOMMU drv         :             :       \                  KERNEL
>             |             :             :     net drv
>           VFIO            :             :       /
>             |             :             :      /
>        vhost-iommu_________________________virtio-iommu-drv
>                           :             :
>   --------------------------------------+-------------------------------
>                  HOST                   :             GUEST
> 
> 
> Introducing vhost in scenario 2, userspace now only handles the device
> initialisation part, and most runtime communication is handled in kernel:
> 
>   MEM__pIOMMU___PCI device                                     HARDWARE
>          |         |
>   -------|---------|------+-------------+-------------------------------
>          |         |      :     KVM     :
>     pIOMMU drv     |      :             :                         KERNEL
>              \__net drv   :             :
>                    |      :             :
>                   tap     :             :
>                    |      :             :
>               _vhost-net________________________virtio-net drv
>          (2) /            :             :           / (1a)
>             /             :             :          /
>    vhost-iommu________________________________virtio-iommu drv
>                           :             : (1b)
>   ------------------------+-------------+-------------------------------
>                  HOST                   :             GUEST
> 
> (1) a. Guest virtio driver maps ring and buffers
>     b. Map requests are relayed to the host the same way.
> (2) To access any guest memory, vhost-net must query the IOMMU. We can
>     reuse the existing TLB protocol for this. TLB commands are written to
>     and read from the vhost-net fd.
> 
> As defined in Linux/include/uapi/linux/vhost.h, the vhost msg structure
> has everything needed for map/unmap operations:
> 
> 	struct vhost_iotlb_msg {
> 		__u64	iova;
> 		__u64	size;
> 		__u64	uaddr;
> 		__u8	perm; /* R/W */
> 		__u8	type;
> 	#define VHOST_IOTLB_MISS
> 	#define VHOST_IOTLB_UPDATE	/* MAP */
> 	#define VHOST_IOTLB_INVALIDATE	/* UNMAP */
> 	#define VHOST_IOTLB_ACCESS_FAIL
> 	};
> 
> 	struct vhost_msg {
> 		int type;
> 		union {
> 			struct vhost_iotlb_msg iotlb;
> 			__u8 padding[64];
> 		};
> 	};
> 
> The vhost-iommu device associates a virtual device ID to a TLB fd. We
> should be able to use the same commands for [vhost-net <-> virtio-iommu]
> and [virtio-net <-> vhost-iommu] communication. A virtio-net device
> would open a socketpair and hand one side to vhost-iommu.
> 
> If vhost_msg is ever used for another purpose than TLB, we'll have some
> trouble, as there will be multiple clients that want to read/write the
> vhost fd. A multicast transport method will be needed. Until then, this
> can work.
> 
> Details of operations would be:
> 
> (1) Userspace sets up vhost-iommu as with other vhost devices, by using
> standard vhost ioctls. Userspace starts by describing the system topology
> via ioctl:
> 
> 	ioctl(iommu_fd, VHOST_IOMMU_ADD_DEVICE, struct
> 	      vhost_iommu_add_device)
> 
> 	#define VHOST_IOMMU_DEVICE_TYPE_VFIO
> 	#define VHOST_IOMMU_DEVICE_TYPE_TLB
> 
> 	struct vhost_iommu_add_device {
> 		__u8 type;
> 		__u32 devid;
> 		union {
> 			struct vhost_iommu_device_vfio {
> 				int vfio_group_fd;
> 			};
> 			struct vhost_iommu_device_tlb {
> 				int fd;
> 			};
> 		};
> 	};
> 
> (2) VIRTIO_IOMMU_T_ATTACH(address space, devid)
> 
> vhost-iommu creates an address space if necessary, finds the device along
> with the relevant operations. If type is VFIO, operations are done on a
> container, otherwise they are done on single devices.
> 
> (3) VIRTIO_IOMMU_T_MAP(address space, virt, phys, size, flags)
> 
> Turn phys into an hva using the vhost mem table.
> 
> - If type is TLB, either preload with VHOST_IOTLB_UPDATE or store the
>   mapping locally and wait for the TLB to ask for it with a
>   VHOST_IOTLB_MISS.
> - If type is VFIO, turn it into a VFIO_IOMMU_MAP_DMA (might need to
>   introduce a shortcut in the external user API of VFIO).
> 
> (4) VIRTIO_IOMMU_T_UNMAP(address space, virt, phys, size, flags)
> 
> - If type is TLB, send a VHOST_IOTLB_INVALIDATE.
> - If type is VFIO, turn it into VFIO_IOMMU_UNMAP_DMA.
> 
> (5) VIRTIO_IOMMU_T_DETACH(address space, devid)
> 
> Undo whatever was done in (2).
> 
> 
>   2. VFIO nested translation
>   --------------------------
> 
> For my current kvmtool implementation, I am putting each VFIO group in a
> different container during initialization. We cannot detach a group from a
> container at runtime without first resetting all devices in that group. So
> the best way to provide dynamic address spaces right now is one container
> per group. The drawback is that we need to maintain multiple sets of page
> tables even if the guest wants to put all devices in the same address
> space. Another disadvantage is when implementing bypass mode, we need to
> map the whole address space at the beginning, then unmap everything on
> attach. Adding nested support would be a nice way to provide dynamic
> address spaces while keeping groups tied to a container at all times.
> 
> A physical IOMMU may offer nested translation. In this case, address
> spaces are managed by two page directories instead of one. A guest-
> virtual address is translated into a guest-physical one using what we'll
> call here "stage-1" (s1) page tables, and the guest-physical address is
> translated into a host-physical one using "stage-2" (s2) page tables.
> 
>                              s1      s2
>                          GVA --> GPA --> HPA
> 
> There isn't a lot of support in Linux for nesting IOMMU page directories
> at the moment (though SVM support is coming, see II). VFIO does have a
> "nesting" IOMMU type, which doesn't mean much at the moment. The ARM SMMU
> code uses this to decide whether to manage the container with s2 page
> tables instead of s1, but even then we still only have a single stage and
> it is assumed that IOVA=GPA.
> 
> Another model that would help with dynamically changing address spaces is
> nesting VFIO containers:
> 
>                            Parent  <---------- map/unmap
>                           container
>                          /   |     \
>                         /   group   \
>                      Child         Child  <--- map/unmap
>                    container     container
>                     |   |             |
>                  group group        group
> 
> At the beginning all groups are attached to the parent container, and
> there is no child container. Doing map/unmap on the parent container maps
> stage-2 page tables (map GPA -> HVA and pin the page -> HPA). User should
> be able to choose whether they want all devices attached to this container
> to be able to access GPAs (bypass mode, as it currently is) or simply
> block all DMA (in which case there is no need to pin pages here).
> 
> At some point the guest wants to create an address space and attaches
> children to it. Using an ioctl (to be defined), we can derive a child
> container from the parent container, and move groups from parent to child.
> 
> This returns a child fd. When the guest maps something in this new address
> space, we can do a map ioctl on the child container, which maps stage-1
> page tables (map GVA -> GPA).
> 
> A page table walk may access multiple levels of tables (pgd, p4d, pud,
> pmd, pt). With nested translation, each access to a table during the
> stage-1 walk requires a stage-2 walk. This makes a full translation costly
> so it is preferable to use a single stage of translation when possible.
> Folding two stages into one is simple with a single container, as shown in
> the kvmtool example. The host keeps track of GPA->HVA mappings, so it can
> fold the full GVA->HVA mapping before sending the VFIO request. With
> nested containers however, the IOMMU driver would have to do the folding
> work itself. Keeping a copy of stage-2 mapping created on the parent
> container, it would fold them into the actual stage-2 page tables when
> receiving a map request on the child container (note that software folding
> is not possible when stage-1 pgd is managed by the guest, as described in
> next section).
> 
> I don't know if nested VFIO containers are a desirable feature at all. I
> find the concept cute on paper, and it would make it easier for userspace
> to juggle with address spaces, but it might require some invasive changes
> in VFIO, and people have been able to use the current API for IOMMU
> virtualization so far.
> 
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
> avoid sending MAP/UNMAP requests. Feature VIRTIO_IOMMU_F_PT_SHARING allows
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
> host, PROBE_TABLE would return the Intel IOMMU page table format, and the
> guest could use that page table code to handle its mappings, hidden behind
> the IOMMU API. This requires that the page-table code is reasonably
> abstracted from the architecture, as is done with drivers/iommu/io-pgtable
> (an x86 guest could use any format implement by io-pgtable for example.)
> 
> (4) If the driver is able to use this format, it sends the ATTACH_TABLE
>     request.
> 
> 	VIRTIO_IOMMU_T_ATTACH_TABLE
> 
> 	struct virtio_iommu_req_attach_table {
> 		le32	address_space;
> 		le32	flags;
> 		le64	table;
> 	
> 		le32	nr_contexts;
> 		/* Page-table format description */
> 	
> 		le32	model;
> 		u8	config[64]
> 	};
> 
> 
>     'table' is a pointer to the page directory. 'nr_contexts' isn't used
>     here.
> 
>     For both ATTACH and PROBE, 'flags' are the following (and will be
>     explained later):
> 
> 	VIRTIO_IOMMU_ATTACH_TABLE_F_INDIRECT	(1 << 0)
> 	VIRTIO_IOMMU_ATTACH_TABLE_F_NATIVE	(1 << 1)
> 	VIRTIO_IOMMU_ATTACH_TABLE_F_FAULT	(1 << 2)
> 
> Now 'model' is a bit tricky. We need to specify all possible page table
> formats and their parameters. I'm not well-versed in x86, s390 or other
> IOMMUs, so I'll just focus on the ARM world for this example. We basically
> have two page table models, with a multitude of configuration bits:
> 
> 	* ARM LPAE
> 	* ARM short descriptor
> 
> We could define a high-level identifier per page-table model, such as:
> 
> 	#define PG_TABLE_ARM	0x1
> 	#define PG_TABLE_X86	0x2
> 	...
> 
> And each model would define its own structure. On ARM 'format' could be a
> simple u32 defining a variant, LPAE 32/64 or short descriptor. It could
> also contain additional capabilities. Then depending on the variant,
> 'config' would be:
> 
> 	struct pg_config_v7s {
> 		le32	tcr;
> 		le32	prrr;
> 		le32	nmrr;
> 		le32	asid;
> 	};
> 	
> 	struct pg_config_lpae {
> 		le64	tcr;
> 		le64	mair;
> 		le32	asid;
> 	
> 		/* And maybe TTB1? */
> 	};
> 
> 	struct pg_config_arm {
> 		le32	variant;
> 		union ...;
> 	};
> 
> I am really uneasy with describing all those nasty architectural details
> in the virtio-iommu specification. We certainly won't start describing the
> content bit-by-bit of tcr or mair here, but just declaring these fields
> might be sufficient.
> 
> (5) Once the table is attached, the driver can simply write the page
>     tables and expect the physical IOMMU to observe the mappings without
>     any additional request. When changing or removing a mapping, however,
>     the driver must send an invalidate request.
> 
> 	VIRTIO_IOMMU_T_INVALIDATE
> 
> 	struct virtio_iommu_req_invalidate {
> 		le32	address_space;
> 		le32	context;
> 		le32	flags;
> 		le64	virt_addr;
> 		le64	range_size;
> 	
> 		u8	opaque[64];
> 	};
> 
>     'flags' may be:
> 
>     VIRTIO_IOMMU_INVALIDATE_T_VADDR: invalidate a single VA range
>       from 'context' (context is 0 when !F_INDIRECT).
> 
>     And with context tables only (explained below):
> 
>     VIRTIO_IOMMU_INVALIDATE_T_SINGLE: invalidate all mappings from
>       'context' (context is 0 when !F_INDIRECT). virt_addr and range_size
>       are ignored.
> 
>     VIRTIO_IOMMU_INVALIDATE_T_TABLE: with F_INDIRECT, invalidate entries
>       in the table that changed. Device reads the table again, compares it
>       to previous values, and invalidate all mappings for contexts that
>       changed. context, virt_addr and range_size are ignored.
> 
> IOMMUs may offer hints and quirks in their invalidation packets. The
> opaque structure in invalidate would allow to transport those. This
> depends on the page table format and as with architectural page-table
> definitions, I really don't want to have those details in the spec itself.
> 
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
> F_FAULT means that the host communicates page requests from device to the
> guest, and the guest can handle them by mapping virtual address in the
> fault to pages. It is only available with VIRTIO_IOMMU_F_FAULT_QUEUE (see
> below.)
> 
> F_NATIVE means that the pIOMMU pgtable format is the same as guest MMU
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
> 
> Having a context table allows to provide multiple address spaces for a
> single device. In the simplest form, without F_INDIRECT we have a single
> address space per device, but some devices may implement more, for
> instance devices with the PCI PASID extension.
> 
> A slot's position in the context table gives an ID, between 0 and
> nr_contexts. The guest can use this ID to have the device target a
> specific address space with DMA. The mechanism to do that is
> device-specific. For a PCI device, the ID is a PASID, and PCI doesn't
> define a specific way of using them for DMA, it's the device driver's
> concern.
> 
> 
>   3. Fault reporting
>   ------------------
> 
> VIRTIO_IOMMU_F_EVENT_QUEUE
> 
> With this feature, an event virtqueue (1) is available. For now it will
> only be used for fault handling, but I'm calling it eventq so that other
> asynchronous features can piggy-back on it. Device may report faults and
> page requests by sending buffers via the used ring.
> 
> 	#define VIRTIO_IOMMU_T_FAULT	0x05
> 
> 	struct virtio_iommu_evt_fault {
> 		struct virtio_iommu_evt_head {
> 			u8 type;
> 			u8 reserved[3];
> 		};
> 	
> 		u32 address_space;
> 		u32 context;
> 	
> 		u64 vaddr;
> 		u32 flags;	/* Access details: R/W/X */
> 	
> 		/* In the reply: */
> 		u32 reply;	/* Fault handled, or failure */
> 		u64 paddr;
> 	};
> 
> Driver must send the reply via the request queue, with the fault status
> in 'reply', and the mapped page in 'paddr' on success.
> 
> Existing fault handling interfaces such as PRI have a tag (PRG) allowing
> to identify a page request (or group thereof) when sending a reply. I
> wonder if this would be useful to us, but it seems like the
> (address_space, context, vaddr) tuple is sufficient to identify a page
> fault, provided the device doesn't send duplicate faults. Duplicate faults
> could be required if they have a side effect, for instance implementing a
> poor man's doorbell. If this is desirable, we could add a fault_id field.
> 
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
> different between ARM SMMU and Intel IOMMU, and will certainly be extended
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
> 
> 
>   IV. Misc
>   ========
> 
> I think we have enough to go on for a while. To improve MAP throughput, I
> considered adding a MAP_SG request depending on a feature bit, with
> variable size:
> 
> 	struct virtio_iommu_req_map_sg {
> 		struct virtio_iommu_req_head;
> 		u32	address_space;
> 		u32	nr_elems;
> 		u64	virt_addr;
> 		u64	size;
> 		u64	phys_addr[nr_elems];
> 	};
> 
> Would create the following mappings:
> 
> 	virt_addr		-> phys_addr[0]
> 	virt_addr + size	-> phys_addr[1]
> 	virt_addr + 2 * size	-> phys_addr[2]
> 	...
> 
> This would avoid the overhead of multiple map commands. We could try to
> find a more cunning format to compress virtually-contiguous mappings with
> different (phys, size) pairs as well. But Linux drivers rarely prefer
> map_sg() functions over regular map(), so I don't know if the whole map_sg
> feature is worth the effort. All we would gain is a few bytes anyway.
> 
> My current map_sg implementation in the virtio-iommu driver adds a batch
> of map requests to the queue and kick the host once. That might be enough
> of an optimization.
> 
> 
> Another invasive optimization would be adding grouped requests. By adding
> two flags in the header, L and G, we can group sequences of requests
> together, and have one status at the end, either 0 if all requests in the
> group succeeded, or the status of the first request that failed. This is
> all in-order. Requests in a group follow each others, there is no sequence
> identifier.
> 
> 	                       ___ L: request is last in the group
> 	                      /  _ G: request is part of a group
> 	                     |  /
> 	                     v v
> 	31                   9 8 7      0
> 	+--------------------------------+ <------- RO descriptor
> 	|        res0       |0|1|  type  |
> 	+--------------------------------+
> 	|            payload             |
> 	+--------------------------------+
> 	|        res0       |0|1|  type  |
> 	+--------------------------------+
> 	|            payload             |
> 	+--------------------------------+
> 	|        res0       |0|1|  type  |
> 	+--------------------------------+
> 	|            payload             |
> 	+--------------------------------+
> 	|        res0       |1|1|  type  |
> 	+--------------------------------+
> 	|            payload             |
> 	+--------------------------------+ <------- WO descriptor
> 	|        res0           | status |
> 	+--------------------------------+
> 
> This adds some complexity on the device, since it must unroll whatever was
> done by successful requests in a group as soon as one fails, and reject
> all subsequent ones. A group of requests is an atomic operation. As with
> map_sg, this change mostly allows to save space and virtio descriptors.
> 
> 
> [1] https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> [2] vIOMMU: Efficient IOMMU Emulation
>     N. Amit, M. Ben-Yehuda, D. Tsafrir, A. Schuster
