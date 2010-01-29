From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/2] virtio: Add ability to detach unused buffers from vrings
Date: Fri, 29 Jan 2010 23:49:05 +1030
Message-ID: <201001292349.05360.rusty__9967.04517533562$1264771256$gmane$org@rustcorp.com.au>
References: <201001292346.43675.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001292346.43675.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: Shirley Ma <mashirle@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Shirley Ma <mashirle@us.ibm.com>

There's currently no way for a virtio driver to ask for unused
buffers, so it has to keep a list itself to reclaim them at shutdown.
This is redundant, since virtio_ring stores that information.  So
add a new hook to do this.

Signed-off-by: Shirley Ma <xma@us.ibm.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |   25 +++++++++++++++++++++++++
 include/linux/virtio.h       |    4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbd2ecd..71929ee 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -334,6 +334,30 @@ static bool vring_enable_cb(struct virtqueue *_vq)
 	return true;
 }
 
+static void *vring_detach_unused_buf(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	unsigned int i;
+	void *buf;
+
+	START_USE(vq);
+
+	for (i = 0; i < vq->vring.num; i++) {
+		if (!vq->data[i])
+			continue;
+		/* detach_buf clears data, so grab it now. */
+		buf = vq->data[i];
+		detach_buf(vq, i);
+		END_USE(vq);
+		return buf;
+	}
+	/* That should have freed everything. */
+	BUG_ON(vq->num_free != vq->vring.num);
+
+	END_USE(vq);
+	return NULL;
+}
+
 irqreturn_t vring_interrupt(int irq, void *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -360,6 +384,7 @@ static struct virtqueue_ops vring_vq_ops = {
 	.kick = vring_kick,
 	.disable_cb = vring_disable_cb,
 	.enable_cb = vring_enable_cb,
+	.detach_unused_buf = vring_detach_unused_buf,
 };
 
 struct virtqueue *vring_new_virtqueue(unsigned int num,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 057a2e0..f508c65 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -51,6 +51,9 @@ struct virtqueue {
  *	This re-enables callbacks; it returns "false" if there are pending
  *	buffers in the queue, to detect a possible race between the driver
  *	checking for more work, and enabling callbacks.
+ * @detach_unused_buf: detach first unused buffer
+ * 	vq: the struct virtqueue we're talking about.
+ * 	Returns NULL or the "data" token handed to add_buf
  *
  * Locking rules are straightforward: the driver is responsible for
  * locking.  No two operations may be invoked simultaneously, with the exception
@@ -71,6 +74,7 @@ struct virtqueue_ops {
 
 	void (*disable_cb)(struct virtqueue *vq);
 	bool (*enable_cb)(struct virtqueue *vq);
+	void *(*detach_unused_buf)(struct virtqueue *vq);
 };
 
 /**
