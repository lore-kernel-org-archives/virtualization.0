From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/6] virtio_ring: inline internal vring functions more
	aggressively.
Date: Wed, 06 Mar 2013 16:22:09 +1100
Message-ID: <87a9qhayri.fsf@rustcorp.com.au>
References: <87k3plaz3d.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87k3plaz3d.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com, mst@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We use inline and get gcc to do the right thing inlining the
"indirect" traversal functions.  This also means we don't need to
clean the sgs.

for i in `seq 50`; do /usr/bin/time -f 'Wall time:%e' ./vringh_test --indirect --eventidx --parallel --fast-vringh; done 2>&1 | stats --trim-outliers:

Before:
	Using CPUS 0 and 3
	Guest: notified 0, pinged 39014-39063(39062)
	Host: notified 39014-39063(39062), pinged 0
	Wall time:1.900000-2.350000(1.921875)

After:
	Using CPUS 0 and 3
	Guest: notified 0, pinged 39062-39063(39063)
	Host: notified 39062-39063(39063), pinged 0
	Wall time:1.760000-2.220000(1.789167)

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> 

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c537385..a78ad45 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -98,13 +98,31 @@ struct vring_virtqueue
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
+static inline struct scatterlist *sg_next_chained(struct scatterlist *sg,
+						  unsigned int *count)
+{
+	return sg_next(sg);
+}
+
+static inline struct scatterlist *sg_next_arr(struct scatterlist *sg,
+					      unsigned int *count)
+{
+	if (--(*count) == 0)
+		return NULL;
+	return sg + 1;
+}
+
 /* Set up an indirect table of descriptors and add it to the queue. */
-static int vring_add_indirect(struct vring_virtqueue *vq,
-			      struct scatterlist *sgs[],
-			      unsigned int total_sg,
-			      unsigned int out_sgs,
-			      unsigned int in_sgs,
-			      gfp_t gfp)
+static inline int vring_add_indirect(struct vring_virtqueue *vq,
+				     struct scatterlist *sgs[],
+				     struct scatterlist *(*next)
+				       (struct scatterlist *, unsigned int *),
+				     unsigned int total_sg,
+				     unsigned int total_out,
+				     unsigned int total_in,
+				     unsigned int out_sgs,
+				     unsigned int in_sgs,
+				     gfp_t gfp)
 {
 	struct vring_desc *desc;
 	unsigned head;
@@ -125,7 +143,7 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	/* Transfer entries from the sg lists into the indirect page */
 	i = 0;
 	for (n = 0; n < out_sgs; n++) {
-		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
 			desc[i].flags = VRING_DESC_F_NEXT;
 			desc[i].addr = sg_phys(sg);
 			desc[i].len = sg->length;
@@ -134,7 +152,7 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
-		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
 			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
 			desc[i].addr = sg_phys(sg);
 			desc[i].len = sg->length;
@@ -163,17 +181,20 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	return head;
 }
 
-static int virtqueue_add(struct virtqueue *_vq,
-			 struct scatterlist *sgs[],
-			 unsigned int total_sg,
-			 unsigned int out_sgs,
-			 unsigned int in_sgs,
-			 void *data,
-			 gfp_t gfp)
+static inline int virtqueue_add(struct virtqueue *_vq,
+				struct scatterlist *sgs[],
+				struct scatterlist *(*next)
+				  (struct scatterlist *, unsigned int *),
+				unsigned int total_out,
+				unsigned int total_in,
+				unsigned int out_sgs,
+				unsigned int in_sgs,
+				void *data,
+				gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
-	unsigned int i, n, avail, uninitialized_var(prev);
+	unsigned int i, n, avail, uninitialized_var(prev), total_sg;
 	int head;
 
 	START_USE(vq);
@@ -193,11 +214,14 @@ static int virtqueue_add(struct virtqueue *_vq,
 	}
 #endif
 
+	total_sg = total_in + total_out;
+
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
 	if (vq->indirect && total_sg > 1 && vq->vq.num_free) {
-		head = vring_add_indirect(vq, sgs, total_sg, out_sgs, in_sgs,
-					  gfp);
+		head = vring_add_indirect(vq, sgs, next, total_sg, total_out,
+					  total_in,
+					  out_sgs, in_sgs, gfp);
 		if (likely(head >= 0))
 			goto add_head;
 	}
@@ -222,7 +246,7 @@ static int virtqueue_add(struct virtqueue *_vq,
 
 	head = i = vq->free_head;
 	for (n = 0; n < out_sgs; n++) {
-		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+		for (sg = sgs[n]; sg; sg = next(sg, &total_out)) {
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
 			vq->vring.desc[i].addr = sg_phys(sg);
 			vq->vring.desc[i].len = sg->length;
@@ -231,7 +255,7 @@ static int virtqueue_add(struct virtqueue *_vq,
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
-		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+		for (sg = sgs[n]; sg; sg = next(sg, &total_in)) {
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
 			vq->vring.desc[i].addr = sg_phys(sg);
 			vq->vring.desc[i].len = sg->length;
@@ -293,21 +317,12 @@ int virtqueue_add_buf(struct virtqueue *_vq,
 		      gfp_t gfp)
 {
 	struct scatterlist *sgs[2];
-	unsigned int i;
 
 	sgs[0] = sg;
 	sgs[1] = sg + out;
 
-	/* Workaround until callers pass well-formed sgs. */
-	for (i = 0; i < out + in; i++)
-		sg_unmark_end(sg + i);
-
-	sg_mark_end(sg + out + in - 1);
-	if (out && in)
-		sg_mark_end(sg + out - 1);
-
-	return virtqueue_add(_vq, sgs, out+in, out ? 1 : 0, in ? 1 : 0,
-			     data, gfp);
+	return virtqueue_add(_vq, sgs, sg_next_arr,
+			     out, in, out ? 1 : 0, in ? 1 : 0, data, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_buf);
 
@@ -332,15 +347,21 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 		      void *data,
 		      gfp_t gfp)
 {
-	unsigned int i, total_sg;
+	unsigned int i, total_out, total_in;
 
 	/* Count them first. */
-	for (i = total_sg = 0; i < out_sgs + in_sgs; i++) {
+	for (i = total_out = total_in = 0; i < out_sgs; i++) {
+		struct scatterlist *sg;
+		for (sg = sgs[i]; sg; sg = sg_next(sg))
+			total_out++;
+	}
+	for (; i < out_sgs + in_sgs; i++) {
 		struct scatterlist *sg;
 		for (sg = sgs[i]; sg; sg = sg_next(sg))
-			total_sg++;
+			total_in++;
 	}
-	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs, data, gfp);
+	return virtqueue_add(_vq, sgs, sg_next_chained,
+			     total_out, total_in, out_sgs, in_sgs, data, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
