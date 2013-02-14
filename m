From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/9] virtio: new API for addition of buffers,
	scatterlist changes
Date: Thu, 14 Feb 2013 16:30:32 +1030
Message-ID: <87r4kjjuyn.fsf@rustcorp.com.au>
References: <1360671815-2135-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1360671815-2135-1-git-send-email-pbonzini@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> This series adds a different set of APIs for adding a buffer to a
> virtqueue.  The new API lets you pass the buffers piecewise, wrapping
> multiple calls to virtqueue_add_sg between virtqueue_start_buf and
> virtqueue_end_buf.  Letting drivers call virtqueue_add_sg multiple times
> if they already have a scatterlist provided by someone else simplifies the
> code and, for virtio-scsi, it saves the copying and related locking.

They are ugly though.  It's convoluted because we do actually know all
the buffers at once, we don't need a piecemeal API.

As a result, you now have arbitrary changes to the indirect heuristic,
because the API is now piecemeal.

How about this as a first step?

virtio_ring: virtqueue_add_sgs, to add multiple sgs.

virtio_scsi and virtio_blk can really use these, to avoid their current
hack of copying the whole sg array.

Signed-off-by: Ruty Russell <rusty@rustcorp.com.au> 

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ffd7e7d..c5afc5d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -121,14 +121,16 @@ struct vring_virtqueue
 
 /* Set up an indirect table of descriptors and add it to the queue. */
 static int vring_add_indirect(struct vring_virtqueue *vq,
-			      struct scatterlist sg[],
-			      unsigned int out,
-			      unsigned int in,
+			      struct scatterlist *sgs[],
+			      unsigned int total_sg,
+			      unsigned int out_sgs,
+			      unsigned int in_sgs,
 			      gfp_t gfp)
 {
 	struct vring_desc *desc;
 	unsigned head;
-	int i;
+	struct scatterlist *sg;
+	int i, n;
 
 	/*
 	 * We require lowmem mappings for the descriptors because
@@ -137,26 +139,31 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	 */
 	gfp &= ~(__GFP_HIGHMEM | __GFP_HIGH);
 
-	desc = kmalloc((out + in) * sizeof(struct vring_desc), gfp);
+	desc = kmalloc(total_sg * sizeof(struct vring_desc), gfp);
 	if (!desc)
 		return -ENOMEM;
 
-	/* Transfer entries from the sg list into the indirect page */
-	for (i = 0; i < out; i++) {
-		desc[i].flags = VRING_DESC_F_NEXT;
-		desc[i].addr = sg_phys(sg);
-		desc[i].len = sg->length;
-		desc[i].next = i+1;
-		sg++;
+	/* Transfer entries from the sg lists into the indirect page */
+	i = 0;
+	for (n = 0; n < out_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			desc[i].flags = VRING_DESC_F_NEXT;
+			desc[i].addr = sg_phys(sg);
+			desc[i].len = sg->length;
+			desc[i].next = i+1;
+		}
 	}
-	for (; i < (out + in); i++) {
-		desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-		desc[i].addr = sg_phys(sg);
-		desc[i].len = sg->length;
-		desc[i].next = i+1;
-		sg++;
+	for (; n < (out_sgs + in_sgs); n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
+			desc[i].addr = sg_phys(sg);
+			desc[i].len = sg->length;
+			desc[i].next = i+1;
+		}
 	}
 
+	BUG_ON(i != total_sg);
+
 	/* Last one doesn't continue. */
 	desc[i-1].flags &= ~VRING_DESC_F_NEXT;
 	desc[i-1].next = 0;
@@ -176,6 +183,15 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	return head;
 }
 
+/* FIXME */
+static inline void sg_unmark_end(struct scatterlist *sg)
+{
+#ifdef CONFIG_DEBUG_SG
+	BUG_ON(sg->sg_magic != SG_MAGIC);
+#endif
+	sg->page_link &= ~0x02;
+}
+
 /**
  * virtqueue_add_buf - expose buffer to other end
  * @vq: the struct virtqueue we're talking about.
@@ -197,8 +213,47 @@ int virtqueue_add_buf(struct virtqueue *_vq,
 		      void *data,
 		      gfp_t gfp)
 {
+	struct scatterlist *sgs[2];
+	unsigned int i;
+
+	sgs[0] = sg;
+	sgs[1] = sg + out;
+
+	/* Workaround until callers pass well-formed sgs. */
+	for (i = 0; i < out + in; i++)
+		sg_unmark_end(sg + i);
+
+	sg_unmark_end(sg + out + in);
+	if (out && in)
+		sg_unmark_end(sg + out);
+
+	return virtqueue_add_sgs(_vq, sgs, out ? 1 : 0, in ? 1 : 0, data, gfp);
+}
+
+/**
+ * virtqueue_add_sgs - expose buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sgs: array of terminated scatterlists.
+ * @out_num: the number of scatterlists readable by other side
+ * @in_num: the number of scatterlists which are writable (after readable ones)
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM).
+ */
+int virtqueue_add_sgs(struct virtqueue *_vq,
+		      struct scatterlist *sgs[],
+		      unsigned int out_sgs,
+		      unsigned int in_sgs,
+		      void *data,
+		      gfp_t gfp)
+{
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	unsigned int i, avail, uninitialized_var(prev);
+	struct scatterlist *sg;
+	unsigned int i, n, avail, uninitialized_var(prev), total_sg;
 	int head;
 
 	START_USE(vq);
@@ -218,46 +273,59 @@ int virtqueue_add_buf(struct virtqueue *_vq,
 	}
 #endif
 
+	/* Count them first. */
+	for (i = total_sg = 0; i < out_sgs + in_sgs; i++) {
+		struct scatterlist *sg;
+		for (sg = sgs[i]; sg; sg = sg_next(sg))
+			total_sg++;
+	}
+
+
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
-	if (vq->indirect && (out + in) > 1 && vq->vq.num_free) {
-		head = vring_add_indirect(vq, sg, out, in, gfp);
+	if (vq->indirect && total_sg > 1 && vq->vq.num_free) {
+		head = vring_add_indirect(vq, sgs, total_sg, out_sgs, in_sgs,
+					  gfp);
 		if (likely(head >= 0))
 			goto add_head;
 	}
 
-	BUG_ON(out + in > vq->vring.num);
-	BUG_ON(out + in == 0);
+	BUG_ON(total_sg > vq->vring.num);
+	BUG_ON(total_sg == 0);
 
-	if (vq->vq.num_free < out + in) {
+	if (vq->vq.num_free < total_sg) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
-			 out + in, vq->vq.num_free);
+			 total_sg, vq->vq.num_free);
 		/* FIXME: for historical reasons, we force a notify here if
 		 * there are outgoing parts to the buffer.  Presumably the
 		 * host should service the ring ASAP. */
-		if (out)
+		if (out_sgs)
 			vq->notify(&vq->vq);
 		END_USE(vq);
 		return -ENOSPC;
 	}
 
 	/* We're about to use some buffers from the free list. */
-	vq->vq.num_free -= out + in;
-
-	head = vq->free_head;
-	for (i = vq->free_head; out; i = vq->vring.desc[i].next, out--) {
-		vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
-		vq->vring.desc[i].addr = sg_phys(sg);
-		vq->vring.desc[i].len = sg->length;
-		prev = i;
-		sg++;
+	vq->vq.num_free -= total_sg;
+
+	head = i = vq->free_head;
+	for (n = 0; n < out_sgs; n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
+			vq->vring.desc[i].addr = sg_phys(sg);
+			vq->vring.desc[i].len = sg->length;
+			prev = i;
+			i = vq->vring.desc[i].next;
+		}
 	}
-	for (; in; i = vq->vring.desc[i].next, in--) {
-		vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-		vq->vring.desc[i].addr = sg_phys(sg);
-		vq->vring.desc[i].len = sg->length;
-		prev = i;
-		sg++;
+	for (; n < (out_sgs + in_sgs); n++) {
+		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
+			vq->vring.desc[i].addr = sg_phys(sg);
+			vq->vring.desc[i].len = sg->length;
+			prev = i;
+			i = vq->vring.desc[i].next;
+		}
 	}
 	/* Last one doesn't continue. */
 	vq->vring.desc[prev].flags &= ~VRING_DESC_F_NEXT;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ff6714e..6eff15b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -40,6 +40,13 @@ int virtqueue_add_buf(struct virtqueue *vq,
 		      void *data,
 		      gfp_t gfp);
 
+int virtqueue_add_sgs(struct virtqueue *vq,
+		      struct scatterlist *sgs[],
+		      unsigned int out_sgs,
+		      unsigned int in_sgs,
+		      void *data,
+		      gfp_t gfp);
+
 void virtqueue_kick(struct virtqueue *vq);
 
 bool virtqueue_kick_prepare(struct virtqueue *vq);
