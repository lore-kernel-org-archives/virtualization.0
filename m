From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 29/32] virtio: Add ability to detach unused buffers from vrings
Date: Mon, 18 Jan 2010 19:15:23 +0530
Message-ID: <1263822326-24208-30-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-5-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-6-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-7-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-8-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-9-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-10-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-11-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-12-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-13-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-14-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-15-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-16-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-17-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-18-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-19-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-20-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-21-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-22-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-23-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-24-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-25-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-26-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-27-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-28-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-29-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-29-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, Shirley Ma <mashirle@us.ibm.com>, Shirley Ma <xma@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Shirley Ma <mashirle@us.ibm.com>

There's currently no way for a virtio driver to ask for unused
buffers, so it has to keep a list itself to reclaim them at shutdown.
This is redundant, since virtio_ring stores that information.  So
add a new hook to do this.

Signed-off-by: Shirley Ma <xma@us.ibm.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_ring.c |   25 +++++++++++++++++++++++++
 include/linux/virtio.h       |    4 ++++
 2 files changed, 29 insertions(+), 0 deletions(-)

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
-- 
1.6.2.5
