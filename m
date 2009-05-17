From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/3] virtio: indirect ring entries
	(VIRTIO_RING_F_INDIRECT_DESC)
Date: Sun, 17 May 2009 11:34:30 +0930
Message-ID: <200905171134.31285.rusty__41225.7988391959$1242525952$gmane$org@rustcorp.com.au>
References: <1229620222-22216-1-git-send-email-markmc@redhat.com>
	<200905041149.00724.rusty@rustcorp.com.au>
	<1242061838.25337.8.camel@blaa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1242061838.25337.8.camel@blaa>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark McLoughlin <markmc@redhat.com>
Cc: netdev@vger.kernel.org, Dor Laor <dor@redhat.com>, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 May 2009 02:40:38 am Mark McLoughlin wrote:
> Still have one FIXME in the patch worth looking at - at what point
> should we use an indirect entry rather than consuming N entries?

Is this overkill?

Rusty.

virtio: use indirect buffers based on demand (heuristic)

virtio_ring uses a ring buffer of descriptors: indirect support allows
a single descriptor to refer to a table of descriptors.  This saves
space in the ring, but requires a kmalloc/kfree.

Rather than try to figure out what the right threshold at which to use
indirect buffers, we drop the threshold dynamically when the ring is
under stress.

Note: to stress this, I reduced the ring size to 32 in lguest, and a
1G send reduced the threshold to 9.

Note2: I moved the BUG_ON()s above the indirect test, where they belong
(indirect falls thru on OOM, so the constraints still apply).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -63,6 +63,8 @@ struct vring_virtqueue
 
 	/* Host supports indirect buffers */
 	bool indirect;
+	/* Threshold before we go indirect. */
+	unsigned int indirect_threshold;
 
 	/* Number of free buffers */
 	unsigned int num_free;
@@ -137,6 +141,32 @@ static int vring_add_indirect(struct vri
 	return head;
 }
 
+static void adjust_threshold(struct vring_virtqueue *vq,
+			     unsigned int out, unsigned int in)
+{
+	/* There are really two species of virtqueue, and it matters here.
+	 * If there are no output parts, it's a "normally full" receive queue,
+	 * otherwise it's a "normally empty" send queue. */
+	if (out) {
+		/* Leave threshold unless we're full. */
+		if (out + in < vq->num_free)
+			return;
+	} else {
+		/* Leave threshold unless we're empty. */
+		if (vq->num_free != vq->vring.num)
+			return;
+	}
+
+	/* Never drop threshold below 1 */
+	vq->indirect_threshold /= 2;
+	vq->indirect_threshold |= 1;
+
+	printk("%s %s: indirect threshold %u (%u+%u vs %u)\n", 
+	       dev_name(&vq->vq.vdev->dev),
+	       vq->vq.name, vq->indirect_threshold,
+	       out, in, vq->num_free);
+}
+
 static int vring_add_buf(struct virtqueue *_vq,
 			 struct scatterlist sg[],
 			 unsigned int out,
@@ -149,18 +179,31 @@ static int vring_add_buf(struct virtqueu
 	START_USE(vq);
 
 	BUG_ON(data == NULL);
-
-	/* If the host supports indirect descriptor tables, and we have multiple
-	 * buffers, then go indirect. FIXME: tune this threshold */
-	if (vq->indirect && (out + in) > 1 && vq->num_free) {
-		head = vring_add_indirect(vq, sg, out, in);
-		if (head != vq->vring.num)
-			goto add_head;
-	}
-
 	BUG_ON(out + in > vq->vring.num);
 	BUG_ON(out + in == 0);
 
+	/* If the host supports indirect descriptor tables, consider it. */
+	if (vq->indirect) {
+		bool try_indirect;
+
+		/* We tweak the threshold automatically. */
+		adjust_threshold(vq, out, in);
+
+		/* If we can't fit any at all, fall through. */
+		if (vq->num_free == 0)
+			try_indirect = false;
+		else if (out + in > vq->num_free)
+			try_indirect = true;
+		else
+			try_indirect = (out + in > vq->indirect_threshold);
+
+		if (try_indirect) {
+			head = vring_add_indirect(vq, sg, out, in);
+			if (head != vq->vring.num)
+				goto add_head;
+		}
+	}
+
 	if (vq->num_free < out + in) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
 			 out + in, vq->num_free);
@@ -391,6 +434,7 @@ struct virtqueue *vring_new_virtqueue(un
 #endif
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC);
+	vq->indirect_threshold = num;
 
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback)
