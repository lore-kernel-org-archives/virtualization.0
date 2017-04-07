From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 09/15] virtio: access vring and buffers through
	IOMMU mappings
Date: Fri,  7 Apr 2017 20:24:49 +0100
Message-ID: <20170407192455.26814-10-jean-philippe.brucker__7327.54513524032$1491593214$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

Teach the virtio core how to access scattered vring structures. When
presenting a virtual IOMMU to the guest in front of virtio devices, the
virtio ring and buffers will be scattered across discontiguous guest-
physical pages. The device has to translate all IOVAs to host-virtual
addresses and gather the pages before accessing any structure.

Buffers described by vring.desc are already returned to the device via an
iovec. We simply have to fill them at a finer granularity and hope that:

1. The driver doesn't provide too many descriptors at a time, since the
   iovec is only as big as the number of descriptor and an overflow is now
   possible.

2. The device doesn't make assumption on message framing from vectors (ie.
   a message can now be contained in more vectors than before). This is
   forbidden by virtio 1.0 (and legacy with ANY_LAYOUT) but our
   virtio-net, for instance, assumes that the first vector always contains
   a full vnet header. In practice it's fine, but still extremely fragile.

For accessing vring and indirect descriptor tables, we now allocate an
iovec describing the IOMMU mappings of the structure, and make all
accesses via this iovec.

                                  ***

A more elegant way to do it would be to create a subprocess per
address-space, and remap fragments of guest memory in a contiguous manner:

                                .---- virtio-blk process
                               /
           viommu process ----+------ virtio-net process
                               \
                                '---- some other device

(0) Initially, parent forks for each emulated device. Each child reserves
    a large chunk of virtual memory with mmap (base), representing the
    IOVA space, but doesn't populate it.
(1) virtio-dev wants to access guest memory, for instance read the vring.
    It sends a TLB miss for an IOVA to the parent via pipe or socket.
(2) Parent viommu checks its translation table, and returns an offset in
    guest memory.
(3) Child does a mmap in its IOVA space, using the fd that backs guest
    memory: mmap(base + iova, pgsize, SHARED|FIXED, fd, offset)

This would be really cool, but I suspect it adds a lot of complexity,
since it's not clear which devices are entirely self-contained and which
need to access parent memory. So stay with scatter-gather accesses for
now.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/kvm/virtio.h | 108 +++++++++++++++++++++++++++++--
 virtio/core.c        | 179 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 252 insertions(+), 35 deletions(-)

diff --git a/include/kvm/virtio.h b/include/kvm/virtio.h
index 9f2ff237..cdc960cd 100644
--- a/include/kvm/virtio.h
+++ b/include/kvm/virtio.h
@@ -29,12 +29,16 @@
 
 struct virt_queue {
 	struct vring	vring;
+	struct iovec	*vring_sg;
+	size_t		vring_nr_sg;
 	u32		pfn;
 	/* The last_avail_idx field is an index to ->ring of struct vring_avail.
 	   It's where we assume the next request index is at.  */
 	u16		last_avail_idx;
 	u16		last_used_signalled;
 	u16		endian;
+
+	struct virtio_device *vdev;
 };
 
 /*
@@ -96,26 +100,91 @@ static inline __u64 __virtio_h2g_u64(u16 endian, __u64 val)
 
 #endif
 
+void *virtio_guest_access(struct kvm *kvm, struct virtio_device *vdev,
+			  u64 addr, size_t size, size_t *out_size, int prot);
+int virtio_populate_sg(struct kvm *kvm, struct virtio_device *vdev, u64 addr,
+		       size_t size, int prot, u16 cur_sg, u16 max_sg,
+		       struct iovec iov[]);
+
+/*
+ * Access element in a virtio structure. If @iov is NULL, access is linear and
+ * @ptr represents a Host-Virtual Address (HVA).
+ *
+ * Otherwise, the structure is scattered in the guest-physical space, and is
+ * made virtually-contiguous by the virtual IOMMU. @iov describes the
+ * structure's IOVA->HVA fragments, @base is the IOVA of the structure, and @ptr
+ * an IOVA inside the structure. @max is the number of elements in @iov.
+ *
+ *                                        HVA
+ *                      IOVA      .----> +---+ iov[0].base
+ *              @base-> +---+ ----'      |   |
+ *                      |   |            +---+
+ *                      +---+ ----.      :   :
+ *                      |   |     '----> +---+ iov[1].base
+ *               @ptr-> |   |            |   |
+ *                      +---+            |   |--> out
+ *                                       +---+
+ */
+static void *virtio_access_sg(struct iovec *iov, int max, void *base, void *ptr)
+{
+	int i;
+	size_t off = ptr - base;
+
+	if (!iov)
+		return ptr;
+
+	for (i = 0; i < max; i++) {
+		size_t sz = iov[i].iov_len;
+		if (off < sz)
+			return iov[i].iov_base + off;
+		off -= sz;
+	}
+
+	pr_err("virtio_access_sg overflow");
+	return NULL;
+}
+
+/*
+ * We only implement legacy vhost, so vring is a single virtually-contiguous
+ * structure starting at the descriptor table. Differentiation of accesses
+ * allows to ease a future move to virtio 1.0.
+ */
+#define vring_access_avail(vq, ptr)	\
+	virtio_access_sg(vq->vring_sg, vq->vring_nr_sg, vq->vring.desc, ptr)
+#define vring_access_desc(vq, ptr)	\
+	virtio_access_sg(vq->vring_sg, vq->vring_nr_sg, vq->vring.desc, ptr)
+#define vring_access_used(vq, ptr)	\
+	virtio_access_sg(vq->vring_sg, vq->vring_nr_sg, vq->vring.desc, ptr)
+
 static inline u16 virt_queue__pop(struct virt_queue *queue)
 {
+	void *ptr;
 	__u16 guest_idx;
 
-	guest_idx = queue->vring.avail->ring[queue->last_avail_idx++ % queue->vring.num];
+	ptr = &queue->vring.avail->ring[queue->last_avail_idx++ % queue->vring.num];
+	guest_idx = *(u16 *)vring_access_avail(queue, ptr);
+
 	return virtio_guest_to_host_u16(queue, guest_idx);
 }
 
 static inline struct vring_desc *virt_queue__get_desc(struct virt_queue *queue, u16 desc_ndx)
 {
-	return &queue->vring.desc[desc_ndx];
+	return vring_access_desc(queue, &queue->vring.desc[desc_ndx]);
 }
 
 static inline bool virt_queue__available(struct virt_queue *vq)
 {
+	u16 *evt, *idx;
+
 	if (!vq->vring.avail)
 		return 0;
 
-	vring_avail_event(&vq->vring) = virtio_host_to_guest_u16(vq, vq->last_avail_idx);
-	return virtio_guest_to_host_u16(vq, vq->vring.avail->idx) != vq->last_avail_idx;
+	/* Disgusting casts under the hood: &(*&used[size]) */
+	evt = vring_access_used(vq, &vring_avail_event(&vq->vring));
+	idx = vring_access_avail(vq, &vq->vring.avail->idx);
+
+	*evt = virtio_host_to_guest_u16(vq, vq->last_avail_idx);
+	return virtio_guest_to_host_u16(vq, *idx) != vq->last_avail_idx;
 }
 
 void virt_queue__used_idx_advance(struct virt_queue *queue, u16 jump);
@@ -177,10 +246,39 @@ static inline void virtio_init_device_vq(struct kvm *kvm,
 					 struct virt_queue *vq, size_t nr_descs,
 					 u32 page_size, u32 align, u32 pfn)
 {
-	void *p		= guest_flat_to_host(kvm, (u64)pfn * page_size);
+	void *p;
 
 	vq->endian	= vdev->endian;
 	vq->pfn		= pfn;
+	vq->vdev	= vdev;
+	vq->vring_sg	= NULL;
+
+	if (vdev->iotlb) {
+		u64 addr = (u64)pfn * page_size;
+		size_t size = vring_size(nr_descs, align);
+		/* Our IOMMU maps at PAGE_SIZE granularity */
+		size_t nr_sg = size / PAGE_SIZE;
+		int flags = IOMMU_PROT_READ | IOMMU_PROT_WRITE;
+
+		vq->vring_sg = calloc(nr_sg, sizeof(struct iovec));
+		if (!vq->vring_sg) {
+			pr_err("could not allocate vring_sg");
+			return; /* Explode later. */
+		}
+
+		vq->vring_nr_sg = virtio_populate_sg(kvm, vdev, addr, size,
+						     flags, 0, nr_sg,
+						     vq->vring_sg);
+		if (!vq->vring_nr_sg) {
+			pr_err("could not map vring");
+			free(vq->vring_sg);
+		}
+
+		/* vring is described with its IOVA */
+		p = (void *)addr;
+	} else {
+		p = guest_flat_to_host(kvm, (u64)pfn * page_size);
+	}
 
 	vring_init(&vq->vring, nr_descs, p, align);
 }
diff --git a/virtio/core.c b/virtio/core.c
index 32bd4ebc..ba35e5f1 100644
--- a/virtio/core.c
+++ b/virtio/core.c
@@ -28,7 +28,8 @@ const char* virtio_trans_name(enum virtio_trans trans)
 
 void virt_queue__used_idx_advance(struct virt_queue *queue, u16 jump)
 {
-	u16 idx = virtio_guest_to_host_u16(queue, queue->vring.used->idx);
+	u16 *ptr = vring_access_used(queue, &queue->vring.used->idx);
+	u16 idx = virtio_guest_to_host_u16(queue, *ptr);
 
 	/*
 	 * Use wmb to assure that used elem was updated with head and len.
@@ -37,7 +38,7 @@ void virt_queue__used_idx_advance(struct virt_queue *queue, u16 jump)
 	 */
 	wmb();
 	idx += jump;
-	queue->vring.used->idx = virtio_host_to_guest_u16(queue, idx);
+	*ptr = virtio_host_to_guest_u16(queue, idx);
 
 	/*
 	 * Use wmb to assure used idx has been increased before we signal the guest.
@@ -52,10 +53,12 @@ virt_queue__set_used_elem_no_update(struct virt_queue *queue, u32 head,
 				    u32 len, u16 offset)
 {
 	struct vring_used_elem *used_elem;
-	u16 idx = virtio_guest_to_host_u16(queue, queue->vring.used->idx);
+	u16 *ptr = vring_access_used(queue, &queue->vring.used->idx);
+	u16 idx = virtio_guest_to_host_u16(queue, *ptr);
 
-	idx += offset;
-	used_elem	= &queue->vring.used->ring[idx % queue->vring.num];
+	idx = (idx + offset) % queue->vring.num;
+
+	used_elem	= vring_access_used(queue, &queue->vring.used->ring[idx]);
 	used_elem->id	= virtio_host_to_guest_u32(queue, head);
 	used_elem->len	= virtio_host_to_guest_u32(queue, len);
 
@@ -84,16 +87,17 @@ static inline bool virt_desc__test_flag(struct virt_queue *vq,
  * at the end.
  */
 static unsigned next_desc(struct virt_queue *vq, struct vring_desc *desc,
-			  unsigned int i, unsigned int max)
+			  unsigned int max)
 {
 	unsigned int next;
 
 	/* If this descriptor says it doesn't chain, we're done. */
-	if (!virt_desc__test_flag(vq, &desc[i], VRING_DESC_F_NEXT))
+	if (!virt_desc__test_flag(vq, desc, VRING_DESC_F_NEXT))
 		return max;
 
+	next = virtio_guest_to_host_u16(vq, desc->next);
 	/* Check they're not leading us off end of descriptors. */
-	next = virtio_guest_to_host_u16(vq, desc[i].next);
+	next = min(next, max);
 	/* Make sure compiler knows to grab that: we don't want it changing! */
 	wmb();
 
@@ -102,32 +106,76 @@ static unsigned next_desc(struct virt_queue *vq, struct vring_desc *desc,
 
 u16 virt_queue__get_head_iov(struct virt_queue *vq, struct iovec iov[], u16 *out, u16 *in, u16 head, struct kvm *kvm)
 {
-	struct vring_desc *desc;
+	struct vring_desc *desc_base, *desc;
+	bool indirect, is_write;
+	struct iovec *desc_sg;
+	size_t len, nr_sg;
+	u64 addr;
 	u16 idx;
 	u16 max;
 
 	idx = head;
 	*out = *in = 0;
 	max = vq->vring.num;
-	desc = vq->vring.desc;
+	desc_base = vq->vring.desc;
+	desc_sg = vq->vring_sg;
+	nr_sg = vq->vring_nr_sg;
+
+	desc = vring_access_desc(vq, &desc_base[idx]);
+	indirect = virt_desc__test_flag(vq, desc, VRING_DESC_F_INDIRECT);
+	if (indirect) {
+		len = virtio_guest_to_host_u32(vq, desc->len);
+		max = len / sizeof(struct vring_desc);
+		addr = virtio_guest_to_host_u64(vq, desc->addr);
+		if (desc_sg) {
+			desc_sg = calloc(len / PAGE_SIZE + 1, sizeof(struct iovec));
+			if (!desc_sg)
+				return 0;
+
+			nr_sg = virtio_populate_sg(kvm, vq->vdev, addr, len,
+						   IOMMU_PROT_READ, 0, max,
+						   desc_sg);
+			if (!nr_sg) {
+				pr_err("failed to populate indirect table");
+				free(desc_sg);
+				return 0;
+			}
+
+			desc_base = (void *)addr;
+		} else {
+			desc_base = guest_flat_to_host(kvm, addr);
+		}
 
-	if (virt_desc__test_flag(vq, &desc[idx], VRING_DESC_F_INDIRECT)) {
-		max = virtio_guest_to_host_u32(vq, desc[idx].len) / sizeof(struct vring_desc);
-		desc = guest_flat_to_host(kvm, virtio_guest_to_host_u64(vq, desc[idx].addr));
 		idx = 0;
 	}
 
 	do {
+		u16 nr_io;
+
+		desc = virtio_access_sg(desc_sg, nr_sg, desc_base, &desc_base[idx]);
+		is_write = virt_desc__test_flag(vq, desc, VRING_DESC_F_WRITE);
+
 		/* Grab the first descriptor, and check it's OK. */
-		iov[*out + *in].iov_len = virtio_guest_to_host_u32(vq, desc[idx].len);
-		iov[*out + *in].iov_base = guest_flat_to_host(kvm,
-							      virtio_guest_to_host_u64(vq, desc[idx].addr));
+		len = virtio_guest_to_host_u32(vq, desc->len);
+		addr = virtio_guest_to_host_u64(vq, desc->addr);
+
+		/*
+		 * dodgy assumption alert: device uses vring.desc.num iovecs.
+		 * True in practice, but they are not obligated to do so.
+		 */
+		nr_io = virtio_populate_sg(kvm, vq->vdev, addr, len, is_write ?
+					   IOMMU_PROT_WRITE : IOMMU_PROT_READ,
+					   *out + *in, vq->vring.num, iov);
+
 		/* If this is an input descriptor, increment that count. */
-		if (virt_desc__test_flag(vq, &desc[idx], VRING_DESC_F_WRITE))
-			(*in)++;
+		if (is_write)
+			(*in) += nr_io;
 		else
-			(*out)++;
-	} while ((idx = next_desc(vq, desc, idx, max)) != max);
+			(*out) += nr_io;
+	} while ((idx = next_desc(vq, desc, max)) != max);
+
+	if (indirect && desc_sg)
+		free(desc_sg);
 
 	return head;
 }
@@ -147,23 +195,35 @@ u16 virt_queue__get_inout_iov(struct kvm *kvm, struct virt_queue *queue,
 			      u16 *in, u16 *out)
 {
 	struct vring_desc *desc;
+	struct iovec *iov;
 	u16 head, idx;
+	bool is_write;
+	size_t len;
+	u64 addr;
+	int prot;
+	u16 *cur;
 
 	idx = head = virt_queue__pop(queue);
 	*out = *in = 0;
 	do {
-		u64 addr;
 		desc = virt_queue__get_desc(queue, idx);
+		is_write = virt_desc__test_flag(queue, desc, VRING_DESC_F_WRITE);
+		len = virtio_guest_to_host_u32(queue, desc->len);
 		addr = virtio_guest_to_host_u64(queue, desc->addr);
-		if (virt_desc__test_flag(queue, desc, VRING_DESC_F_WRITE)) {
-			in_iov[*in].iov_base = guest_flat_to_host(kvm, addr);
-			in_iov[*in].iov_len = virtio_guest_to_host_u32(queue, desc->len);
-			(*in)++;
+		if (is_write) {
+			prot = IOMMU_PROT_WRITE;
+			iov = in_iov;
+			cur = in;
 		} else {
-			out_iov[*out].iov_base = guest_flat_to_host(kvm, addr);
-			out_iov[*out].iov_len = virtio_guest_to_host_u32(queue, desc->len);
-			(*out)++;
+			prot = IOMMU_PROT_READ;
+			iov = out_iov;
+			cur = out;
 		}
+
+		/* dodgy assumption alert: device uses vring.desc.num iovecs */
+		*cur += virtio_populate_sg(kvm, queue->vdev, addr, len, prot,
+					   *cur, queue->vring.num, iov);
+
 		if (virt_desc__test_flag(queue, desc, VRING_DESC_F_NEXT))
 			idx = virtio_guest_to_host_u16(queue, desc->next);
 		else
@@ -191,9 +251,12 @@ bool virtio_queue__should_signal(struct virt_queue *vq)
 {
 	u16 old_idx, new_idx, event_idx;
 
+	u16 *new_ptr	= vring_access_used(vq, &vq->vring.used->idx);
+	u16 *event_ptr	= vring_access_avail(vq, &vring_used_event(&vq->vring));
+
 	old_idx		= vq->last_used_signalled;
-	new_idx		= virtio_guest_to_host_u16(vq, vq->vring.used->idx);
-	event_idx	= virtio_guest_to_host_u16(vq, vring_used_event(&vq->vring));
+	new_idx		= virtio_guest_to_host_u16(vq, *new_ptr);
+	event_idx	= virtio_guest_to_host_u16(vq, *event_ptr);
 
 	if (vring_need_event(event_idx, new_idx, old_idx)) {
 		vq->last_used_signalled = new_idx;
@@ -238,6 +301,62 @@ int virtio__iommu_detach(void *priv, struct virtio_device *vdev)
 	return 0;
 }
 
+void *virtio_guest_access(struct kvm *kvm, struct virtio_device *vdev,
+			  u64 addr, size_t size, size_t *out_size, int prot)
+{
+	u64 paddr;
+
+	if (!vdev->iotlb) {
+		*out_size = size;
+		paddr = addr;
+	} else {
+		paddr = iommu_access(vdev->iotlb, addr, size, out_size, prot);
+	}
+
+	return guest_flat_to_host(kvm, paddr);
+}
+
+/*
+ * Fill @iov starting at index @cur_vec with translations of the (@addr, @size)
+ * range. If @vdev doesn't have a tlb, fill a single vector with the
+ * corresponding HVA. Otherwise, fill vectors with GVA->GPA->HVA translations.
+ * Since the IOVA range may span over multiple IOMMU mappings, there may need to
+ * be multiple vectors. @nr_vec is the size of the @iov array.
+ */
+int virtio_populate_sg(struct kvm *kvm, struct virtio_device *vdev, u64 addr,
+		       size_t size, int prot, u16 cur_vec, u16 nr_vec,
+		       struct iovec iov[])
+{
+	void *ptr;
+	int vec = cur_vec;
+	size_t consumed = 0;
+
+	while (size > 0 && vec < nr_vec) {
+		ptr = virtio_guest_access(kvm, vdev, addr, size, &consumed,
+					  prot);
+		if (!ptr)
+			break;
+
+		iov[vec].iov_len = consumed;
+		iov[vec].iov_base = ptr;
+
+		size -= consumed;
+		addr += consumed;
+		vec++;
+	}
+
+	if (cur_vec == nr_vec && size)
+		/*
+		 * This is bad. Devices used to offer as many iovecs as vring
+		 * descriptors, so there was no chance of filling up the array.
+		 * But with the IOMMU, buffers may be fragmented and use
+		 * multiple iovecs per descriptor.
+		 */
+		pr_err("reached end of iovec, incomplete buffer");
+
+	return vec - cur_vec;
+}
+
 int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 		struct virtio_ops *ops, enum virtio_trans trans,
 		int device_id, int subsys_id, int class)
-- 
2.12.1
