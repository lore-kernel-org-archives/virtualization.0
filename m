From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6/6] virtio_ring: remove a level of indirection
Date: Mon, 12 Apr 2010 16:19:07 +0300
Message-ID: <fc8f4156b84fbfba6130121d0472f58aa6a04cab.1271078235.git.mst@redhat.com>
References: <cover.1271078235.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1271078235.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We have a single virtqueue_ops implementation,
and it seems unlikely we'll get another one
at this point. So let's remove an unnecessary
level of indirection: it would be very easy to
re-add it if another implementation surfaces.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c |   36 +++++++++------------
 include/linux/virtio.h       |   71 ++++++++++-------------------------------
 2 files changed, 34 insertions(+), 73 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0f90634..0717b5b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -155,11 +155,11 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	return head;
 }
 
-static int vring_add_buf(struct virtqueue *_vq,
-			 struct scatterlist sg[],
-			 unsigned int out,
-			 unsigned int in,
-			 void *data)
+int virtqueue_add_buf(struct virtqueue *_vq,
+		  struct scatterlist sg[],
+		  unsigned int out,
+		  unsigned int in,
+		  void *data)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i, avail, head, uninitialized_var(prev);
@@ -232,8 +232,9 @@ add_head:
 		return vq->num_free ? vq->vring.num : 0;
 	return vq->num_free;
 }
+EXPORT_SYMBOL_GPL(virtqueue_add_buf);
 
-static void vring_kick(struct virtqueue *_vq)
+void virtqueue_kick(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	START_USE(vq);
@@ -253,6 +254,7 @@ static void vring_kick(struct virtqueue *_vq)
 
 	END_USE(vq);
 }
+EXPORT_SYMBOL_GPL(virtqueue_kick);
 
 static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 {
@@ -284,7 +286,7 @@ static inline bool more_used(const struct vring_virtqueue *vq)
 	return vq->last_used_idx != vq->vring.used->idx;
 }
 
-static void *vring_get_buf(struct virtqueue *_vq, unsigned int *len)
+void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	void *ret;
@@ -325,15 +327,17 @@ static void *vring_get_buf(struct virtqueue *_vq, unsigned int *len)
 	END_USE(vq);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(virtqueue_get_buf);
 
-static void vring_disable_cb(struct virtqueue *_vq)
+void virtqueue_disable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
 }
+EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
-static bool vring_enable_cb(struct virtqueue *_vq)
+bool virtqueue_enable_cb(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
@@ -351,8 +355,9 @@ static bool vring_enable_cb(struct virtqueue *_vq)
 	END_USE(vq);
 	return true;
 }
+EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
 
-static void *vring_detach_unused_buf(struct virtqueue *_vq)
+void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
@@ -375,6 +380,7 @@ static void *vring_detach_unused_buf(struct virtqueue *_vq)
 	END_USE(vq);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
 irqreturn_t vring_interrupt(int irq, void *_vq)
 {
@@ -396,15 +402,6 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 }
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
-static struct virtqueue_ops vring_vq_ops = {
-	.add_buf = vring_add_buf,
-	.get_buf = vring_get_buf,
-	.kick = vring_kick,
-	.disable_cb = vring_disable_cb,
-	.enable_cb = vring_enable_cb,
-	.detach_unused_buf = vring_detach_unused_buf,
-};
-
 struct virtqueue *vring_new_virtqueue(unsigned int num,
 				      unsigned int vring_align,
 				      struct virtio_device *vdev,
@@ -429,7 +426,6 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
 	vring_init(&vq->vring, num, pages, vring_align);
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
-	vq->vq.vq_ops = &vring_vq_ops;
 	vq->vq.name = name;
 	vq->notify = notify;
 	vq->broken = false;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 18ccc68..5b0fce0 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -14,7 +14,6 @@
  * @callback: the function to call when buffers are consumed (can be NULL).
  * @name: the name of this virtqueue (mainly for debugging)
  * @vdev: the virtio device this queue was created for.
- * @vq_ops: the operations for this virtqueue (see below).
  * @priv: a pointer for the virtqueue implementation to use.
  */
 struct virtqueue {
@@ -22,94 +21,60 @@ struct virtqueue {
 	void (*callback)(struct virtqueue *vq);
 	const char *name;
 	struct virtio_device *vdev;
-	struct virtqueue_ops *vq_ops;
 	void *priv;
 };
 
 /**
- * virtqueue_ops - operations for virtqueue abstraction layer
- * @add_buf: expose buffer to other end
+ * operations for virtqueue
+ * virtqueue_add_buf: expose buffer to other end
  *	vq: the struct virtqueue we're talking about.
  *	sg: the description of the buffer(s).
  *	out_num: the number of sg readable by other side
  *	in_num: the number of sg which are writable (after readable ones)
  *	data: the token identifying the buffer.
  *      Returns remaining capacity of queue (sg segments) or a negative error.
- * @kick: update after add_buf
+ * virtqueue_kick: update after add_buf
  *	vq: the struct virtqueue
  *	After one or more add_buf calls, invoke this to kick the other side.
- * @get_buf: get the next used buffer
+ * virtqueue_get_buf: get the next used buffer
  *	vq: the struct virtqueue we're talking about.
  *	len: the length written into the buffer
  *	Returns NULL or the "data" token handed to add_buf.
- * @disable_cb: disable callbacks
+ * virtqueue_disable_cb: disable callbacks
  *	vq: the struct virtqueue we're talking about.
  *	Note that this is not necessarily synchronous, hence unreliable and only
  *	useful as an optimization.
- * @enable_cb: restart callbacks after disable_cb.
+ * virtqueue_enable_cb: restart callbacks after disable_cb.
  *	vq: the struct virtqueue we're talking about.
  *	This re-enables callbacks; it returns "false" if there are pending
  *	buffers in the queue, to detect a possible race between the driver
  *	checking for more work, and enabling callbacks.
- * @detach_unused_buf: detach first unused buffer
+ * virtqueue_detach_unused_buf: detach first unused buffer
  * 	vq: the struct virtqueue we're talking about.
  * 	Returns NULL or the "data" token handed to add_buf
  *
  * Locking rules are straightforward: the driver is responsible for
  * locking.  No two operations may be invoked simultaneously, with the exception
- * of @disable_cb.
+ * of virtqueue_disable_cb.
  *
  * All operations can be called in any context.
  */
-struct virtqueue_ops {
-	int (*add_buf)(struct virtqueue *vq,
-		       struct scatterlist sg[],
-		       unsigned int out_num,
-		       unsigned int in_num,
-		       void *data);
 
-	void (*kick)(struct virtqueue *vq);
+int virtqueue_add_buf(struct virtqueue *vq,
+		      struct scatterlist sg[],
+		      unsigned int out_num,
+		      unsigned int in_num,
+		      void *data);
 
-	void *(*get_buf)(struct virtqueue *vq, unsigned int *len);
+void virtqueue_kick(struct virtqueue *vq);
 
-	void (*disable_cb)(struct virtqueue *vq);
-	bool (*enable_cb)(struct virtqueue *vq);
-	void *(*detach_unused_buf)(struct virtqueue *vq);
-};
-
-static inline int virtqueue_add_buf(struct virtqueue *vq,
-				    struct scatterlist sg[],
-				    unsigned int out_num,
-				    unsigned int in_num,
-				    void *data)
-{
-	return vq->vq_ops->add_buf(vq, sg, out_num, in_num, data);
-}
-
-static inline int void virtqueue_kick(struct virtqueue *vq)
-{
-	return vq->vq_ops->kick(vq);
-}
-
-static inline void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len)
-{
-	return vq->vq_ops->get_buf(vq, len);
-}
+void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 
-static inline void virtqueue_disable_cb(struct virtqueue *vq)
-{
-	vq->vq_ops->disable_cb(vq);
-}
+void virtqueue_disable_cb(struct virtqueue *vq);
 
-static inline bool virtqueue_enable_cb(struct virtqueue *vq)
-{
-	return vq->vq_ops->enable_cb(vq);
-}
+bool virtqueue_enable_cb(struct virtqueue *vq);
 
-static inline void *virtqueue_detach_unused_buf(struct virtqueue *vq)
-{
-	return vq->vq_ops->detach_unused_buf(vq);
-}
+void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 
 /**
  * virtio_device - representation of a device using virtio
-- 
1.7.0.2.280.gc6f05
