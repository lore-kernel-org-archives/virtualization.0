From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH V2 RFC 2/9] virtio_ring: let virtqueue_{kick()/notify()}
	return a bool
Date: Thu, 24 Oct 2013 17:23:13 +0200
Message-ID: <1382628200-42956-3-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

virtqueue_{kick()/notify()} should exploit the new host notification API.
If the notify call returned with a negative value the host kick failed
(e.g. a kick triggered after a device was hot-unplugged). In this case
the virtqueue is set to 'broken' and false is returned, otherwise true.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/virtio/virtio_ring.c | 20 ++++++++++++++++----
 include/linux/virtio.h       |  4 ++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index aa40f6c..a7e0eec 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -459,13 +459,22 @@ EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
  * @vq: the struct virtqueue
  *
  * This does not need to be serialized.
+ *
+ * Returns false if host notify failed or queue is broken, otherwise true.
  */
-void virtqueue_notify(struct virtqueue *_vq)
+bool virtqueue_notify(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (unlikely(vq->broken))
+		return false;
+
 	/* Prod other side to tell it about changes. */
-	vq->notify(_vq);
+	if (vq->notify(_vq) < 0) {
+		vq->broken = true;
+		return false;
+	}
+	return true;
 }
 EXPORT_SYMBOL_GPL(virtqueue_notify);
 
@@ -478,11 +487,14 @@ EXPORT_SYMBOL_GPL(virtqueue_notify);
  *
  * Caller must ensure we don't call this with other virtqueue
  * operations at the same time (except where noted).
+ *
+ * Returns false if kick failed, otherwise true.
  */
-void virtqueue_kick(struct virtqueue *vq)
+bool virtqueue_kick(struct virtqueue *vq)
 {
 	if (virtqueue_kick_prepare(vq))
-		virtqueue_notify(vq);
+		return virtqueue_notify(vq);
+	return true;
 }
 EXPORT_SYMBOL_GPL(virtqueue_kick);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 9ff8645..4557e8a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -58,11 +58,11 @@ int virtqueue_add_sgs(struct virtqueue *vq,
 		      void *data,
 		      gfp_t gfp);
 
-void virtqueue_kick(struct virtqueue *vq);
+bool virtqueue_kick(struct virtqueue *vq);
 
 bool virtqueue_kick_prepare(struct virtqueue *vq);
 
-void virtqueue_notify(struct virtqueue *vq);
+bool virtqueue_notify(struct virtqueue *vq);
 
 void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 
-- 
1.8.3.1
