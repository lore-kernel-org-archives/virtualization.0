From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH net-next v3 07/13] virtio_ring: allocate desc state for split
	ring separately
Date: Wed, 21 Nov 2018 18:03:24 +0800
Message-ID: <20181121100330.24846-8-tiwei.bie__13213.6185923175$1542794642$gmane$org@intel.com>
References: <20181121100330.24846-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181121100330.24846-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Put the split ring's desc state into the .split sub-structure,
and allocate desc state for split ring separately, this makes
the code more readable and more consistent with what we will
do for packed ring.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/virtio/virtio_ring.c | 45 ++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d1076f28c7e9..acd851f3105c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -78,7 +78,7 @@
 #define LAST_ADD_TIME_INVALID(vq)
 #endif
 
-struct vring_desc_state {
+struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
 };
@@ -115,6 +115,9 @@ struct vring_virtqueue {
 
 		/* Last written value to avail->idx in guest byte order */
 		u16 avail_idx_shadow;
+
+		/* Per-descriptor state. */
+		struct vring_desc_state_split *desc_state;
 	} split;
 
 	/* How to notify other side. FIXME: commonalize hcalls! */
@@ -133,9 +136,6 @@ struct vring_virtqueue {
 	bool last_add_time_valid;
 	ktime_t last_add_time;
 #endif
-
-	/* Per-descriptor state. */
-	struct vring_desc_state desc_state[];
 };
 
 
@@ -427,11 +427,11 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		vq->free_head = i;
 
 	/* Store token and indirect buffer state. */
-	vq->desc_state[head].data = data;
+	vq->split.desc_state[head].data = data;
 	if (indirect)
-		vq->desc_state[head].indir_desc = desc;
+		vq->split.desc_state[head].indir_desc = desc;
 	else
-		vq->desc_state[head].indir_desc = ctx;
+		vq->split.desc_state[head].indir_desc = ctx;
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
@@ -512,7 +512,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Clear data ptr. */
-	vq->desc_state[head].data = NULL;
+	vq->split.desc_state[head].data = NULL;
 
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
@@ -532,7 +532,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	vq->vq.num_free++;
 
 	if (vq->indirect) {
-		struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
+		struct vring_desc *indir_desc =
+				vq->split.desc_state[head].indir_desc;
 		u32 len;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
@@ -550,9 +551,9 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 			vring_unmap_one_split(vq, &indir_desc[j]);
 
 		kfree(indir_desc);
-		vq->desc_state[head].indir_desc = NULL;
+		vq->split.desc_state[head].indir_desc = NULL;
 	} else if (ctx) {
-		*ctx = vq->desc_state[head].indir_desc;
+		*ctx = vq->split.desc_state[head].indir_desc;
 	}
 }
 
@@ -597,13 +598,13 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u out of range\n", i);
 		return NULL;
 	}
-	if (unlikely(!vq->desc_state[i].data)) {
+	if (unlikely(!vq->split.desc_state[i].data)) {
 		BAD_RING(vq, "id %u is not a head!\n", i);
 		return NULL;
 	}
 
 	/* detach_buf_split clears data, so grab it now. */
-	ret = vq->desc_state[i].data;
+	ret = vq->split.desc_state[i].data;
 	detach_buf_split(vq, i, ctx);
 	vq->last_used_idx++;
 	/* If we expect an interrupt for the next entry, tell host
@@ -711,10 +712,10 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	START_USE(vq);
 
 	for (i = 0; i < vq->split.vring.num; i++) {
-		if (!vq->desc_state[i].data)
+		if (!vq->split.desc_state[i].data)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
-		buf = vq->desc_state[i].data;
+		buf = vq->split.desc_state[i].data;
 		detach_buf_split(vq, i, NULL);
 		vq->split.avail_idx_shadow--;
 		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
@@ -1080,8 +1081,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	unsigned int i;
 	struct vring_virtqueue *vq;
 
-	vq = kmalloc(sizeof(*vq) + vring.num * sizeof(struct vring_desc_state),
-		     GFP_KERNEL);
+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
 		return NULL;
 
@@ -1120,11 +1120,19 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					vq->split.avail_flags_shadow);
 	}
 
+	vq->split.desc_state = kmalloc_array(vring.num,
+			sizeof(struct vring_desc_state_split), GFP_KERNEL);
+	if (!vq->split.desc_state) {
+		kfree(vq);
+		return NULL;
+	}
+
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 	for (i = 0; i < vring.num-1; i++)
 		vq->split.vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
-	memset(vq->desc_state, 0, vring.num * sizeof(struct vring_desc_state));
+	memset(vq->split.desc_state, 0, vring.num *
+			sizeof(struct vring_desc_state_split));
 
 	return &vq->vq;
 }
@@ -1260,6 +1268,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 	if (vq->we_own_ring) {
 		vring_free_queue(vq->vq.vdev, vq->queue_size_in_bytes,
 				 vq->split.vring.desc, vq->queue_dma_addr);
+		kfree(vq->split.desc_state);
 	}
 	list_del(&_vq->list);
 	kfree(vq);
-- 
2.14.5
