From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2-RFC 1/2] virtio: support layout with avail ring before idx
Date: Wed, 26 May 2010 22:50:38 +0300
Message-ID: <8a6f96c73a72f04ed7c142e631ca59ee45b4b23b.1274903330.git.mst__26741.0010019832$1274903939$gmane$org@redhat.com>
References: <cover.1274903328.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1274903328.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

This adds an (unused) option to put available ring
before control (avail index, flags). This avoids cache line
sharing between control and ring, and also
makes it possible to extend avail control without
incurring extra cache misses.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c |    4 ++--
 include/linux/virtio_ring.h  |   30 ++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1ca8890..2241342 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -224,7 +224,7 @@ add_head:
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync).  FIXME: avoid modulus here? */
 	avail = (vq->vring.avail->idx + vq->num_added++) % vq->vring.num;
-	vq->vring.avail->ring[avail] = head;
+	vq->vring.avail_ring[avail] = head;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
@@ -425,7 +425,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
 	if (!vq)
 		return NULL;
 
-	vring_init(&vq->vring, num, pages, vring_align);
+	vring_init(&vq->vring, num, pages, vring_align, false);
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index e4d144b..c5f3ee7 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -47,6 +47,11 @@ struct vring_avail {
 	__u16 ring[];
 };
 
+struct vring_avail_ctrl {
+	__u16 flags;
+	__u16 idx;
+};
+
 /* u32 is used here for ids for padding reasons. */
 struct vring_used_elem {
 	/* Index of start of used descriptor chain. */
@@ -66,7 +71,9 @@ struct vring {
 
 	struct vring_desc *desc;
 
-	struct vring_avail *avail;
+	struct vring_avail_ctrl *avail;
+
+	__u16 *avail_ring;
 
 	struct vring_used *used;
 };
@@ -79,11 +86,18 @@ struct vring {
  *	// The actual descriptors (16 bytes each)
  *	struct vring_desc desc[num];
  *
- *	// A ring of available descriptor heads with free-running index.
+ *	// A ring of available descriptor heads with a control structure
+ *      // including a free-running index.
+ *      // The ring can come either after  (legacy) or before the control.
  *	__u16 avail_flags;
  *	__u16 avail_idx;
  *	__u16 available[num];
  *
+ * or
+ *
+ *	__u16 available[num];
+ *	__u16 avail_flags;
+ *	__u16 avail_idx;
  *	// Padding to the next align boundary.
  *	char pad[];
  *
@@ -94,13 +108,17 @@ struct vring {
  * };
  */
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
-			      unsigned long align)
+			      unsigned long align, bool avail_ring_first)
 {
+	struct vring_avail *avail = p + num * sizeof(struct vring_desc);
 	vr->num = num;
 	vr->desc = p;
-	vr->avail = p + num*sizeof(struct vring_desc);
-	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + align-1)
-			    & ~(align - 1));
+	vr->avail_ring = avail_ring_first ? (void*)avail : &avail->ring;
+	vr->avail = avail_ring_first ? (void *)&vr->avail_ring[num] : p;
+	vr->used = (void *)ALIGN((unsigned long)&avail->ring[num], align);
+	/* Verify that avail fits before used. */
+	BUG_ON((unsigned long)(vr->avail + 1) > (unsigned long)vr->used);
+	BUG_ON((unsigned long)(&vr->avail_ring[num]) > (unsigned long)vr->used);
 }
 
 static inline unsigned vring_size(unsigned int num, unsigned long align)
-- 
1.7.1.12.g42b7f
