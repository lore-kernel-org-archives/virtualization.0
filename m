From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v2 1/2] virtio: Add a can_add_buf helper
Date: Wed, 19 Aug 2009 13:55:23 +0530
Message-ID: <1250670324-8426-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This helper returns 1 if a call to add_buf will not fail
with -ENOSPC.

This will help callers that do

while(1) {
	alloc()
	if (add_buf()) {
		free();
		break;
	}
}

This will result in one less alloc/free exercise.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---

v2:
  return true/false instead of 1/0

 drivers/virtio/virtio_ring.c |    8 ++++++++
 include/linux/virtio.h       |    5 +++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a882f26..ea7efe6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -137,6 +137,13 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
 	return head;
 }
 
+static bool vring_can_add_buf(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->num_free ? true : false;
+}
+
 static int vring_add_buf(struct virtqueue *_vq,
 			 struct scatterlist sg[],
 			 unsigned int out,
@@ -350,6 +357,7 @@ EXPORT_SYMBOL_GPL(vring_interrupt);
 static struct virtqueue_ops vring_vq_ops = {
 	.add_buf = vring_add_buf,
 	.get_buf = vring_get_buf,
+	.can_add_buf = vring_can_add_buf,
 	.kick = vring_kick,
 	.disable_cb = vring_disable_cb,
 	.enable_cb = vring_enable_cb,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 4fca4f5..cc0e3aa 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -35,6 +35,9 @@ struct virtqueue {
  *	in_num: the number of sg which are writable (after readable ones)
  *	data: the token identifying the buffer.
  *      Returns 0 or an error.
+ * @can_add_buf: indicates whether we have a free slot to add a buffer
+ *      vq: the struct virtqueue we're talking about.
+ *      Returns 0 or 1.
  * @kick: update after add_buf
  *	vq: the struct virtqueue
  *	After one or more add_buf calls, invoke this to kick the other side.
@@ -65,6 +68,8 @@ struct virtqueue_ops {
 		       unsigned int in_num,
 		       void *data);
 
+	bool (*can_add_buf)(struct virtqueue *vq);
+
 	void (*kick)(struct virtqueue *vq);
 
 	void *(*get_buf)(struct virtqueue *vq, unsigned int *len);
-- 
1.6.2.5
