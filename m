From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] virtio_ring: split virtqueue_kick prepare/notify
Date: Wed,  7 Sep 2011 14:51:40 +0100
Message-ID: <1315403501-12457-2-git-send-email-stefanha@linux.vnet.ibm.com>
References: <1315403501-12457-1-git-send-email-stefanha@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1315403501-12457-1-git-send-email-stefanha@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Khoa Huynh <khoa@us.ibm.com>, Christoph Hellwig <hch@lst.de>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The virtqueue_kick() operation really has two phases and should be split
so that devices hold locks only when necessary.  This patch splits
virtqueue_kick() into two virtqueue_kick_prepare() and
virtqueue_kick_notify().

virtqueue_kick_prepare() updates the vring and checks whether the host
needs to be notified.  This function must be executed with a lock held
to protect the vring.

virtqueue_kick_notify() notifies the host that the vring has new
buffers.  This function may be executed without holding a lock
protecting the vring.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
---
 drivers/virtio/virtio_ring.c |   28 +++++++++++++++++++++-------
 include/linux/virtio.h       |   13 +++++++++++++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 68b9136..7d059f7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -237,10 +237,12 @@ add_head:
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_buf_gfp);
 
-void virtqueue_kick(struct virtqueue *_vq)
+bool virtqueue_kick_prepare(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old;
+	bool r;
+
 	START_USE(vq);
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
@@ -253,13 +255,25 @@ void virtqueue_kick(struct virtqueue *_vq)
 	/* Need to update avail index before checking if we should notify */
 	virtio_mb();
 
-	if (vq->event ?
-	    vring_need_event(vring_avail_event(&vq->vring), new, old) :
-	    !(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
-		/* Prod other side to tell it about changes. */
-		vq->notify(&vq->vq);
-
+	if (vq->event)
+		r = vring_need_event(vring_avail_event(&vq->vring), new, old);
+	else
+		r = !(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY);
 	END_USE(vq);
+	return r;
+}
+EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
+
+void virtqueue_kick_notify(struct virtqueue *_vq)
+{
+	to_vvq(_vq)->notify(_vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_kick_notify);
+
+void virtqueue_kick(struct virtqueue *_vq)
+{
+	if (virtqueue_kick_prepare(_vq))
+		virtqueue_kick_notify(_vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 7108857..65536cb 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -35,9 +35,18 @@ struct virtqueue {
  *	data: the token identifying the buffer.
  *	gfp: how to do memory allocations (if necessary).
  *      Returns remaining capacity of queue (sg segments) or a negative error.
+ * virtqueue_kick_prepare: update after add_buf and check if kick necessary
+ *	vq: the struct virtqueue
+ *	After one or more add_buf calls, invoke this to check whether kick is
+ *	necessary.
+ * virtqueue_kick_notify: kick the other side
+ *	vq: the struct virtqueue
+ *	Normally virtqueue_kick_prepare is called before this.  Can be done in
+ *	parallel with add_buf/get_buf.
  * virtqueue_kick: update after add_buf
  *	vq: the struct virtqueue
  *	After one or more add_buf calls, invoke this to kick the other side.
+ *	Uses virtqueue_kick_prepare and virtqueue_kick_notify internally.
  * virtqueue_get_buf: get the next used buffer
  *	vq: the struct virtqueue we're talking about.
  *	len: the length written into the buffer
@@ -85,6 +94,10 @@ static inline int virtqueue_add_buf(struct virtqueue *vq,
 	return virtqueue_add_buf_gfp(vq, sg, out_num, in_num, data, GFP_ATOMIC);
 }
 
+bool virtqueue_kick_prepare(struct virtqueue *vq);
+
+void virtqueue_kick_notify(struct virtqueue *vq);
+
 void virtqueue_kick(struct virtqueue *vq);
 
 void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
-- 
1.7.5.4
