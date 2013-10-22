From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH RFC 1/7] virtio_ring: add new functions
	virtqueue{_set_broken()/_is_broken()}
Date: Tue, 22 Oct 2013 14:45:05 +0200
Message-ID: <1382445911-55657-2-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
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

This patch adds 2 new functions:

virtqueue_set_broken(): to be called when a virtqueue kick operation fails.

virtqueue_is_broken(): can be called to query the virtqueue state after a host
was kicked.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/virtio/virtio_ring.c | 16 ++++++++++++++++
 include/linux/virtio.h       |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5217baf..930ee39 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -836,4 +836,20 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
 
+void virtqueue_set_broken(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	vq->broken = true;
+}
+EXPORT_SYMBOL_GPL(virtqueue_set_broken);
+
+bool virtqueue_is_broken(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return vq->broken;
+}
+EXPORT_SYMBOL_GPL(virtqueue_is_broken);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 9ff8645..c09ae2b 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -76,6 +76,10 @@ void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 
 unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
 
+void virtqueue_set_broken(struct virtqueue *vq);
+
+bool virtqueue_is_broken(struct virtqueue *vq);
+
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
-- 
1.8.3.1
