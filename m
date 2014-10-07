From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 04/11] virtio_ring: implement endian reversal based on
	VERSION_1 feature.
Date: Tue,  7 Oct 2014 16:39:45 +0200
Message-ID: <1412692792-12325-5-git-send-email-cornelia.huck__6322.09388209066$1412704504$gmane$org@de.ibm.com>
References: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>

[Cornelia Huck: we don't need the vq->vring.num -> vq->ring_mask change]
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/virtio/virtio_ring.c |  195 ++++++++++++++++++++++++++++++------------
 1 file changed, 138 insertions(+), 57 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1cfb5ba..350c39b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -145,42 +145,54 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 	i = 0;
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
-			desc[i].flags = VRING_DESC_F_NEXT;
-			desc[i].addr = sg_phys(sg);
-			desc[i].len = sg->length;
-			desc[i].next = i+1;
+			desc[i].flags = cpu_to_virtio_u16(vq->vq.vdev,
+							  VRING_DESC_F_NEXT);
+			desc[i].addr = cpu_to_virtio_u64(vq->vq.vdev,
+							 sg_phys(sg));
+			desc[i].len = cpu_to_virtio_u32(vq->vq.vdev,
+							sg->length);
+			desc[i].next = cpu_to_virtio_u16(vq->vq.vdev,
+							 i+1);
 			i++;
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
-			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-			desc[i].addr = sg_phys(sg);
-			desc[i].len = sg->length;
-			desc[i].next = i+1;
+			desc[i].flags =	cpu_to_virtio_u16(vq->vq.vdev,
+							  VRING_DESC_F_NEXT|
+							  VRING_DESC_F_WRITE);
+			desc[i].addr = cpu_to_virtio_u64(vq->vq.vdev,
+							 sg_phys(sg));
+			desc[i].len = cpu_to_virtio_u32(vq->vq.vdev,
+							sg->length);
+			desc[i].next = cpu_to_virtio_u16(vq->vq.vdev, i+1);
 			i++;
 		}
 	}
-	BUG_ON(i != total_sg);
 
 	/* Last one doesn't continue. */
-	desc[i-1].flags &= ~VRING_DESC_F_NEXT;
+	desc[i-1].flags &= ~cpu_to_virtio_u16(vq->vq.vdev, VRING_DESC_F_NEXT);
 	desc[i-1].next = 0;
 
-	/* We're about to use a buffer */
-	vq->vq.num_free--;
-
 	/* Use a single buffer which doesn't continue */
 	head = vq->free_head;
-	vq->vring.desc[head].flags = VRING_DESC_F_INDIRECT;
-	vq->vring.desc[head].addr = virt_to_phys(desc);
+	vq->vring.desc[head].flags =
+		cpu_to_virtio_u16(vq->vq.vdev, VRING_DESC_F_INDIRECT);
+	vq->vring.desc[head].addr =
+		cpu_to_virtio_u64(vq->vq.vdev, virt_to_phys(desc));
 	/* kmemleak gives a false positive, as it's hidden by virt_to_phys */
 	kmemleak_ignore(desc);
-	vq->vring.desc[head].len = i * sizeof(struct vring_desc);
+	vq->vring.desc[head].len =
+		cpu_to_virtio_u32(vq->vq.vdev, i * sizeof(struct vring_desc));
 
-	/* Update free pointer */
+	BUG_ON(i != total_sg);
+
+	/* Update free pointer (we store this in native endian) */
 	vq->free_head = vq->vring.desc[head].next;
 
+	/* We've just used a buffer */
+	vq->vq.num_free--;
+
 	return head;
 }
 
@@ -199,6 +211,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct scatterlist *sg;
 	unsigned int i, n, avail, uninitialized_var(prev), total_sg;
 	int head;
+	u16 nexti;
 
 	START_USE(vq);
 
@@ -253,26 +266,46 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	vq->vq.num_free -= total_sg;
 
 	head = i = vq->free_head;
+
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
-			vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
-			vq->vring.desc[i].addr = sg_phys(sg);
-			vq->vring.desc[i].len = sg->length;
+			vq->vring.desc[i].flags =
+				cpu_to_virtio_u16(vq->vq.vdev,
+						  VRING_DESC_F_NEXT);
+			vq->vring.desc[i].addr =
+				cpu_to_virtio_u64(vq->vq.vdev, sg_phys(sg));
+			vq->vring.desc[i].len =
+				cpu_to_virtio_u32(vq->vq.vdev, sg->length);
+
+			/* We chained .next in native: fix endian. */
+			nexti = vq->vring.desc[i].next;
+			vq->vring.desc[i].next
+				= virtio_to_cpu_u16(vq->vq.vdev, nexti);
 			prev = i;
-			i = vq->vring.desc[i].next;
+			i = nexti;
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
-			vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-			vq->vring.desc[i].addr = sg_phys(sg);
-			vq->vring.desc[i].len = sg->length;
+			vq->vring.desc[i].flags =
+				cpu_to_virtio_u16(vq->vq.vdev,
+						  VRING_DESC_F_NEXT|
+						  VRING_DESC_F_WRITE);
+			vq->vring.desc[i].addr =
+				cpu_to_virtio_u64(vq->vq.vdev, sg_phys(sg));
+			vq->vring.desc[i].len =
+				cpu_to_virtio_u32(vq->vq.vdev, sg->length);
+			/* We chained .next in native: fix endian. */
+			nexti = vq->vring.desc[i].next;
+			vq->vring.desc[i].next =
+				virtio_to_cpu_u16(vq->vq.vdev, nexti);
 			prev = i;
-			i = vq->vring.desc[i].next;
+			i = nexti;
 		}
 	}
 	/* Last one doesn't continue. */
-	vq->vring.desc[prev].flags &= ~VRING_DESC_F_NEXT;
+	vq->vring.desc[prev].flags &=
+		~cpu_to_virtio_u16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Update free pointer */
 	vq->free_head = i;
@@ -283,15 +316,16 @@ add_head:
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
-	avail = (vq->vring.avail->idx & (vq->vring.num-1));
-	vq->vring.avail->ring[avail] = head;
+	avail = virtio_to_cpu_u16(vq->vq.vdev, vq->vring.avail->idx);
+	vq->vring.avail->ring[avail & (vq->vring.num - 1)] =
+		cpu_to_virtio_u16(vq->vq.vdev, head);
 
-	/* Descriptors and available array need to be set before we expose the
-	 * new available array entries. */
+	/* Descriptors and available array need to be set
+	 * before we expose the new available array entries. */
 	virtio_wmb(vq->weak_barriers);
-	vq->vring.avail->idx++;
-	vq->num_added++;
+	vq->vring.avail->idx = cpu_to_virtio_u16(vq->vq.vdev, avail + 1);
 
+	vq->num_added++;
 	/* This is very unlikely, but theoretically possible.  Kick
 	 * just in case. */
 	if (unlikely(vq->num_added == (1 << 16) - 1))
@@ -408,8 +442,9 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 	 * event. */
 	virtio_mb(vq->weak_barriers);
 
-	old = vq->vring.avail->idx - vq->num_added;
-	new = vq->vring.avail->idx;
+	new = virtio_to_cpu_u16(vq->vq.vdev, vq->vring.avail->idx);
+
+	old = new - vq->num_added;
 	vq->num_added = 0;
 
 #ifdef DEBUG
@@ -421,10 +456,17 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
 #endif
 
 	if (vq->event) {
-		needs_kick = vring_need_event(vring_avail_event(&vq->vring),
-					      new, old);
+		u16 avail;
+
+		avail =	virtio_to_cpu_u16(vq->vq.vdev,
+					  vring_avail_event(&vq->vring));
+
+		needs_kick = vring_need_event(avail, new, old);
 	} else {
-		needs_kick = !(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
+		u16 flags;
+
+		flags = virtio_to_cpu_u16(vq->vq.vdev, vq->vring.used->flags);
+		needs_kick = !(flags & VRING_USED_F_NO_NOTIFY);
 	}
 	END_USE(vq);
 	return needs_kick;
@@ -486,11 +528,20 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 	i = head;
 
 	/* Free the indirect table */
-	if (vq->vring.desc[i].flags & VRING_DESC_F_INDIRECT)
-		kfree(phys_to_virt(vq->vring.desc[i].addr));
+	if (vq->vring.desc[i].flags &
+	    cpu_to_virtio_u16(vq->vq.vdev, VRING_DESC_F_INDIRECT)) {
+		kfree(phys_to_virt(virtio_to_cpu_u64(vq->vq.vdev,
+						     vq->vring.desc[i].addr)));
+	}
+
+	while (vq->vring.desc[i].flags &
+	       cpu_to_virtio_u16(vq->vq.vdev, VRING_DESC_F_NEXT)) {
+		u16 next;
 
-	while (vq->vring.desc[i].flags & VRING_DESC_F_NEXT) {
-		i = vq->vring.desc[i].next;
+		/* Convert endian of next back to native. */
+		next = virtio_to_cpu_u16(vq->vq.vdev, vq->vring.desc[i].next);
+		vq->vring.desc[i].next = next;
+		i = next;
 		vq->vq.num_free++;
 	}
 
@@ -502,7 +553,8 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 
 static inline bool more_used(const struct vring_virtqueue *vq)
 {
-	return vq->last_used_idx != vq->vring.used->idx;
+	return vq->last_used_idx
+		!= virtio_to_cpu_u16(vq->vq.vdev, vq->vring.used->idx);
 }
 
 /**
@@ -527,6 +579,8 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	void *ret;
 	unsigned int i;
 	u16 last_used;
+	const int no_intr =
+		cpu_to_virtio_u16(vq->vq.vdev, VRING_AVAIL_F_NO_INTERRUPT);
 
 	START_USE(vq);
 
@@ -545,8 +599,9 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	virtio_rmb(vq->weak_barriers);
 
 	last_used = (vq->last_used_idx & (vq->vring.num - 1));
-	i = vq->vring.used->ring[last_used].id;
-	*len = vq->vring.used->ring[last_used].len;
+	i = virtio_to_cpu_u32(vq->vq.vdev, vq->vring.used->ring[last_used].id);
+	*len = virtio_to_cpu_u32(vq->vq.vdev,
+				 vq->vring.used->ring[last_used].len);
 
 	if (unlikely(i >= vq->vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", i);
@@ -561,10 +616,11 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 	ret = vq->data[i];
 	detach_buf(vq, i);
 	vq->last_used_idx++;
+
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
-	if (!(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
+	if (!(vq->vring.avail->flags & no_intr)) {
 		vring_used_event(&vq->vring) = vq->last_used_idx;
 		virtio_mb(vq->weak_barriers);
 	}
@@ -591,7 +647,8 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+	vq->vring.avail->flags |=
+		cpu_to_virtio_u16(vq->vq.vdev, VRING_AVAIL_F_NO_INTERRUPT);
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
@@ -619,8 +676,12 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
 	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
 	 * entry. Always do both to keep code simple. */
-	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
-	vring_used_event(&vq->vring) = last_used_idx = vq->last_used_idx;
+	vq->vring.avail->flags &=
+		cpu_to_virtio_u16(vq->vq.vdev, ~VRING_AVAIL_F_NO_INTERRUPT);
+	last_used_idx = vq->last_used_idx;
+	vring_used_event(&vq->vring) = cpu_to_virtio_u16(vq->vq.vdev,
+							 last_used_idx);
+
 	END_USE(vq);
 	return last_used_idx;
 }
@@ -640,7 +701,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	virtio_mb(vq->weak_barriers);
-	return (u16)last_used_idx != vq->vring.used->idx;
+
+	return (u16)last_used_idx !=
+		virtio_to_cpu_u16(vq->vq.vdev, vq->vring.used->idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
@@ -678,7 +741,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
 bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	u16 bufs;
+	u16 bufs, used_idx;
 
 	START_USE(vq);
 
@@ -687,12 +750,17 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
 	 * either clear the flags bit or point the event index at the next
 	 * entry. Always do both to keep code simple. */
-	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
+	vq->vring.avail->flags &=
+		cpu_to_virtio_u16(vq->vq.vdev, ~VRING_AVAIL_F_NO_INTERRUPT);
 	/* TODO: tune this threshold */
-	bufs = (u16)(vq->vring.avail->idx - vq->last_used_idx) * 3 / 4;
-	vring_used_event(&vq->vring) = vq->last_used_idx + bufs;
+	bufs = (u16)(virtio_to_cpu_u16(vq->vq.vdev, vq->vring.avail->idx)
+		     - vq->last_used_idx) * 3 / 4;
+	vring_used_event(&vq->vring) =
+		cpu_to_virtio_u16(vq->vq.vdev, vq->last_used_idx + bufs);
 	virtio_mb(vq->weak_barriers);
-	if (unlikely((u16)(vq->vring.used->idx - vq->last_used_idx) > bufs)) {
+	used_idx = virtio_to_cpu_u16(vq->vq.vdev, vq->vring.used->idx);
+
+	if (unlikely((u16)(used_idx - vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
 	}
@@ -719,12 +787,19 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 	START_USE(vq);
 
 	for (i = 0; i < vq->vring.num; i++) {
+		u16 avail;
+
 		if (!vq->data[i])
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->data[i];
 		detach_buf(vq, i);
-		vq->vring.avail->idx--;
+
+		/* AKA "vq->vring.avail->idx++" */
+		avail = virtio_to_cpu_u16(vq->vq.vdev,  vq->vring.avail->idx);
+		vq->vring.avail->idx = cpu_to_virtio_u16(vq->vq.vdev,
+							 avail - 1);
+
 		END_USE(vq);
 		return buf;
 	}
@@ -800,12 +875,18 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
 	/* No callback?  Tell other side not to bother us. */
-	if (!callback)
-		vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
+	if (!callback) {
+		u16 flag;
+
+		flag = cpu_to_virtio_u16(vq->vq.vdev,
+					 VRING_AVAIL_F_NO_INTERRUPT);
+		vq->vring.avail->flags |= flag;
+	}
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 	for (i = 0; i < num-1; i++) {
+		/* This is for our use, so always our endian. */
 		vq->vring.desc[i].next = i+1;
 		vq->data[i] = NULL;
 	}
-- 
1.7.9.5
