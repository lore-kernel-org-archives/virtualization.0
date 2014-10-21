From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] virtio 1.0 vring endian-ness
Date: Wed, 22 Oct 2014 01:09:40 +0300
Message-ID: <20141021220940.GA17704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This adds wrappers to switch between native endian-ness
(virtio 0.9) and virtio endian-ness (virtio 1.0).
Add new typedefs as well, so that we can check
statically that we didn't miss any accesses.
All callers simply pass in false (0.9) so no
functional change for now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Sending this early so I can get feedback on this style.
Rusty, what's your opinion? Reasonable?

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 67e06fe..32211aa 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -62,6 +62,26 @@ static inline void virtio_wmb(bool weak_barriers)
 }
 #endif
 
+#define DEFINE_VIRTIO_XX_TO_CPU(bits) \
+static inline u##bits virtio##bits##_to_cpu(bool little_endian, __virtio##bits val) \
+{ \
+	if (little_endian) \
+		return le##bits##_to_cpu((__force __le##bits)val); \
+	else \
+		return (__force u##bits)val; \
+} \
+static inline __virtio##bits cpu_to_virtio##bits(bool little_endian, u##bits val) \
+{ \
+	if (little_endian) \
+		return (__force __virtio##bits)cpu_to_le##bits(val); \
+	else \
+		return val; \
+}
+
+DEFINE_VIRTIO_XX_TO_CPU(16)
+DEFINE_VIRTIO_XX_TO_CPU(32)
+DEFINE_VIRTIO_XX_TO_CPU(64)
+
 struct virtio_device;
 struct virtqueue;
 
diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index a99f9b7..744cee1 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -33,6 +33,10 @@
  * Copyright Rusty Russell IBM Corporation 2007. */
 #include <linux/types.h>
 
+typedef __u16 __bitwise __virtio16;
+typedef __u32 __bitwise __virtio32;
+typedef __u64 __bitwise __virtio64;
+
 /* This marks a buffer as continuing via the next field. */
 #define VRING_DESC_F_NEXT	1
 /* This marks a buffer as write-only (otherwise read-only). */
@@ -61,32 +65,32 @@
 /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
 struct vring_desc {
 	/* Address (guest-physical). */
-	__u64 addr;
+	__virtio64 addr;
 	/* Length. */
-	__u32 len;
+	__virtio32 len;
 	/* The flags as indicated above. */
-	__u16 flags;
+	__virtio16 flags;
 	/* We chain unused descriptors via this, too */
-	__u16 next;
+	__virtio16 next;
 };
 
 struct vring_avail {
-	__u16 flags;
-	__u16 idx;
-	__u16 ring[];
+	__virtio16 flags;
+	__virtio16 idx;
+	__virtio16 ring[];
 };
 
 /* u32 is used here for ids for padding reasons. */
 struct vring_used_elem {
 	/* Index of start of used descriptor chain. */
-	__u32 id;
+	__virtio32 id;
 	/* Total length of the descriptor chain which was used (written to) */
-	__u32 len;
+	__virtio32 len;
 };
 
 struct vring_used {
-	__u16 flags;
-	__u16 idx;
+	__virtio16 flags;
+	__virtio16 idx;
 	struct vring_used_elem ring[];
 };
 
@@ -109,25 +113,25 @@ struct vring {
  *	struct vring_desc desc[num];
  *
  *	// A ring of available descriptor heads with free-running index.
- *	__u16 avail_flags;
- *	__u16 avail_idx;
- *	__u16 available[num];
- *	__u16 used_event_idx;
+ *	__virtio16 avail_flags;
+ *	__virtio16 avail_idx;
+ *	__virtio16 available[num];
+ *	__virtio16 used_event_idx;
  *
  *	// Padding to the next align boundary.
  *	char pad[];
  *
  *	// A ring of used descriptor heads with free-running index.
- *	__u16 used_flags;
- *	__u16 used_idx;
+ *	__virtio16 used_flags;
+ *	__virtio16 used_idx;
  *	struct vring_used_elem used[num];
- *	__u16 avail_event_idx;
+ *	__virtio16 avail_event_idx;
  * };
  */
 /* We publish the used event index at the end of the available ring, and vice
  * versa. They are at the end for backwards compatibility. */
 #define vring_used_event(vr) ((vr)->avail->ring[(vr)->num])
-#define vring_avail_event(vr) (*(__u16 *)&(vr)->used->ring[(vr)->num])
+#define vring_avail_event(vr) (*(__virtio16 *)&(vr)->used->ring[(vr)->num])
 
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			      unsigned long align)
@@ -135,29 +139,29 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 	vr->num = num;
 	vr->desc = p;
 	vr->avail = p + num*sizeof(struct vring_desc);
-	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__u16)
+	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
 		+ align-1) & ~(align - 1));
 }
 
 static inline unsigned vring_size(unsigned int num, unsigned long align)
 {
-	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (3 + num)
+	return ((sizeof(struct vring_desc) * num + sizeof(__virtio16) * (3 + num)
 		 + align - 1) & ~(align - 1))
-		+ sizeof(__u16) * 3 + sizeof(struct vring_used_elem) * num;
+		+ sizeof(__virtio16) * 3 + sizeof(struct vring_used_elem) * num;
 }
 
 /* The following is used with USED_EVENT_IDX and AVAIL_EVENT_IDX */
 /* Assuming a given event_idx value from the other size, if
  * we have just incremented index from old to new_idx,
  * should we trigger an event? */
-static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u16 old)
+static inline int vring_need_event(__virtio16 event_idx, __virtio16 new_idx, __virtio16 old)
 {
 	/* Note: Xen has similar logic for notification hold-off
 	 * in include/xen/interface/io/ring.h with req_event and req_prod
 	 * corresponding to event_idx + 1 and new_idx respectively.
 	 * Note also that req_event and req_prod in Xen start at 1,
 	 * event indexes in virtio start at 0. */
-	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
+	return (__virtio16)(new_idx - event_idx - 1) < (__virtio16)(new_idx - old);
 }
 
 #endif /* _UAPI_LINUX_VIRTIO_RING_H */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 61a1fe1..a2f2f22 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -98,6 +98,8 @@ struct vring_virtqueue
 };
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
+/* Will become vq->little_endian once we support virtio 1.0 */
+#define vq_le(vq) (false)
 
 static struct vring_desc *alloc_indirect(unsigned int total_sg, gfp_t gfp)
 {
@@ -116,7 +118,7 @@ static struct vring_desc *alloc_indirect(unsigned int total_sg, gfp_t gfp)
 		return NULL;
 
 	for (i = 0; i < total_sg; i++)
-		desc[i].next = i+1;
+		desc[i].next = cpu_to_virtio16(vq_le(_vq), i + 1);
 	return desc;
 }
 
@@ -171,11 +173,11 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 	if (desc) {
 		/* Use a single buffer which doesn't continue */
-		vq->vring.desc[head].flags = VRING_DESC_F_INDIRECT;
-		vq->vring.desc[head].addr = virt_to_phys(desc);
+		vq->vring.desc[head].flags = cpu_to_virtio16(vq_le(_vq), VRING_DESC_F_INDIRECT);
+		vq->vring.desc[head].addr = cpu_to_virtio64(vq_le(_vq), virt_to_phys(desc));
 		/* avoid kmemleak false positive (hidden by virt_to_phys) */
 		kmemleak_ignore(desc);
-		vq->vring.desc[head].len = total_sg * sizeof(struct vring_desc);
+		vq->vring.desc[head].len = cpu_to_virtio32(vq_le(_vq), total_sg * sizeof(struct vring_desc));
 
 		/* Set up rest to use this indirect table. */
 		i = 0;
@@ -205,28 +207,28 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			desc[i].flags = VRING_DESC_F_NEXT;
-			desc[i].addr = sg_phys(sg);
-			desc[i].len = sg->length;
+			desc[i].flags = cpu_to_virtio16(vq_le(_vq), VRING_DESC_F_NEXT);
+			desc[i].addr = cpu_to_virtio64(vq_le(_vq), sg_phys(sg));
+			desc[i].len = cpu_to_virtio32(vq_le(_vq), sg->length);
 			prev = i;
-			i = desc[i].next;
+			i = virtio16_to_cpu(vq_le(_vq), desc[i].next);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-			desc[i].addr = sg_phys(sg);
-			desc[i].len = sg->length;
+			desc[i].flags = cpu_to_virtio16(vq_le(_vq), VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
+			desc[i].addr = cpu_to_virtio64(vq_le(_vq), sg_phys(sg));
+			desc[i].len = cpu_to_virtio32(vq_le(_vq), sg->length);
 			prev = i;
-			i = desc[i].next;
+			i = virtio16_to_cpu(vq_le(_vq), desc[i].next);
 		}
 	}
 	/* Last one doesn't continue. */
-	desc[prev].flags &= ~VRING_DESC_F_NEXT;
+	desc[prev].flags &= cpu_to_virtio16(vq_le(_vq), ~VRING_DESC_F_NEXT);
 
 	/* Update free pointer */
 	if (indirect)
-		vq->free_head = vq->vring.desc[head].next;
+		vq->free_head = virtio16_to_cpu(vq_le(_vq), vq->vring.desc[head].next);
 	else
 		vq->free_head = i;
 
@@ -235,13 +237,13 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
-	avail = (vq->vring.avail->idx & (vq->vring.num-1));
-	vq->vring.avail->ring[avail] = head;
+	avail = virtio16_to_cpu(vq_le(_vq), vq->vring.avail->idx) & (vq->vring.num - 1);
+	vq->vring.avail->ring[avail] = cpu_to_virtio16(vq_le(_vq), head);
 
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
 	virtio_wmb(vq->weak_barriers);
-	vq->vring.avail->idx++;
+	vq->vring.avail->idx = cpu_to_virtio16(vq_le(_vq), virtio16_to_cpu(vq_le(_vq), vq->vring.avail->idx) + 1);
 	vq->num_added++;
 
 	/* This is very unlikely, but theoretically possible.  Kick
@@ -354,8 +356,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 	 * event. */
 	virtio_mb(vq->weak_barriers);
 
-	old = vq->vring.avail->idx - vq->num_added;
-	new = vq->vring.avail->idx;
+	old = virtio16_to_cpu(vq_le(_vq), vq->vring.avail->idx) - vq->num_added;
+	new = virtio16_to_cpu(vq_le(_vq), vq->vring.avail->idx);
 	vq->num_added = 0;
 
 #ifdef DEBUG
@@ -367,10 +369,10 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 #endif
 
 	if (vq->event) {
-		needs_kick = vring_need_event(vring_avail_event(&vq->vring),
+		needs_kick = vring_need_event(virtio16_to_cpu(vq_le(_vq), vring_avail_event(&vq->vring)),
 					      new, old);
 	} else {
-		needs_kick = !(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
+		needs_kick = !(vq->vring.used->flags & cpu_to_virtio16(vq_le(_vq), VRING_USED_F_NO_NOTIFY));
 	}
 	END_USE(vq);
 	return needs_kick;
@@ -432,15 +434,15 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 	i = head;
 
 	/* Free the indirect table */
-	if (vq->vring.desc[i].flags & VRING_DESC_F_INDIRECT)
-		kfree(phys_to_virt(vq->vring.desc[i].addr));
+	if (vq->vring.desc[i].flags & cpu_to_virtio16(vq_le(_vq), VRING_DESC_F_INDIRECT))
+		kfree(phys_to_virt(virtio64_to_cpu(vq_le(_vq), vq->vring.desc[i].addr)));
 
-	while (vq->vring.desc[i].flags & VRING_DESC_F_NEXT) {
-		i = vq->vring.desc[i].next;
+	while (vq->vring.desc[i].flags & cpu_to_virtio16(vq_le(_vq), VRING_DESC_F_NEXT)) {
+		i = virtio16_to_cpu(vq_le(_vq), vq->vring.desc[i].next);
 		vq->vq.num_free++;
 	}
 
-	vq->vring.desc[i].next = vq->free_head;
+	vq->vring.desc[i].next = cpu_to_virtio16(vq_le(_vq), vq->free_head);
 	vq->free_head = head;
 	/* Plus final descriptor */
 	vq->vq.num_free++;
@@ -448,7 +450,7 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 
 static inline bool more_used(const struct vring_virtqueue *vq)
 {
-	return vq->last_used_idx != vq->vring.used->idx;
+	return vq->last_used_idx != virtio16_to_cpu(vq_le(_vq), vq->vring.used->idx);
 }
 
 /**
@@ -491,8 +493,8 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	virtio_rmb(vq->weak_barriers);
 
 	last_used = (vq->last_used_idx & (vq->vring.num - 1));
-	i = vq->vring.used->ring[last_used].id;
-	*len = vq->vring.used->ring[last_used].len;
+	i = virtio32_to_cpu(vq_le(_vq), vq->vring.used->ring[last_used].id);
+	*len = virtio32_to_cpu(vq_le(_vq), vq->vring.used->ring[last_used].len);
 
 	if (unlikely(i >= vq->vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", i);
@@ -510,8 +512,8 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
-	if (!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
-		vring_used_event(&vq->vring) = vq->last_used_idx;
+	if (!(vq->vring.avail->flags & cpu_to_virtio16(vq_le(_vq), VRING_AVAIL_F_NO_INTERRUPT))) {
+		vring_used_event(&vq->vring) = cpu_to_virtio16(vq_le(_vq), vq->last_used_idx);
 		virtio_mb(vq->weak_barriers);
 	}
 
@@ -537,7 +539,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+	vq->vring.avail->flags |= cpu_to_virtio16(vq_le(_vq), VRING_AVAIL_F_NO_INTERRUPT);
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
@@ -565,8 +567,8 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
 	 * entry. Always do both to keep code simple. */
-	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
-	vring_used_event(&vq->vring) = last_used_idx = vq->last_used_idx;
+	vq->vring.avail->flags &= cpu_to_virtio16(vq_le(_vq), ~VRING_AVAIL_F_NO_INTERRUPT);
+	vring_used_event(&vq->vring) = cpu_to_virtio16(vq_le(_vq), last_used_idx = vq->last_used_idx);
 	END_USE(vq);
 	return last_used_idx;
 }
@@ -586,7 +588,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	virtio_mb(vq->weak_barriers);
-	return (u16)last_used_idx != vq->vring.used->idx;
+	return (u16)last_used_idx != virtio16_to_cpu(vq_le(_vq), vq->vring.used->idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
@@ -633,12 +635,12 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
 	 * entry. Always do both to keep code simple. */
-	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
+	vq->vring.avail->flags &= cpu_to_virtio16(vq_le(_vq), ~VRING_AVAIL_F_NO_INTERRUPT);
 	/* TODO: tune this threshold */
-	bufs = (u16)(vq->vring.avail->idx - vq->last_used_idx) * 3 / 4;
-	vring_used_event(&vq->vring) = vq->last_used_idx + bufs;
+	bufs = (u16)(virtio16_to_cpu(vq_le(_vq), vq->vring.avail->idx) - vq->last_used_idx) * 3 / 4;
+	vring_used_event(&vq->vring) = cpu_to_virtio16(vq_le(_vq), vq->last_used_idx + bufs);
 	virtio_mb(vq->weak_barriers);
-	if (unlikely((u16)(vq->vring.used->idx - vq->last_used_idx) > bufs)) {
+	if (unlikely((u16)(virtio16_to_cpu(vq_le(_vq), vq->vring.used->idx) - vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
 	}
@@ -670,7 +672,7 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->data[i];
 		detach_buf(vq, i);
-		vq->vring.avail->idx--;
+		vq->vring.avail->idx = cpu_to_virtio16(vq_le(_vq), virtio16_to_cpu(vq_le(_vq), vq->vring.avail->idx) - 1);
 		END_USE(vq);
 		return buf;
 	}
@@ -747,12 +749,12 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback)
-		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+		vq->vring.avail->flags |= cpu_to_virtio16(vq_le(_vq), VRING_AVAIL_F_NO_INTERRUPT);
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 	for (i = 0; i < num-1; i++) {
-		vq->vring.desc[i].next = i+1;
+		vq->vring.desc[i].next = cpu_to_virtio16(vq_le(_vq), i + 1);
 		vq->data[i] = NULL;
 	}
 	vq->data[i] = NULL;
