From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH 2/2] virtio: allow query vq parent device
Date: Tue, 29 Oct 2019 18:58:43 +0800
Message-ID: <20191029105843.12061-3-jasowang__365.065403615006$1572346798$gmane$org@redhat.com>
References: <20191029105843.12061-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191029105843.12061-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: lingshan.zhu@intel.com, lulu@redhat.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c  | 16 ++++++++++++++--
 include/linux/virtio_config.h |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 51d83f4d7c32..ddeef7421d4d 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -183,6 +183,9 @@ struct vring_virtqueue {
 	/* DMA, allocation, and size information */
 	bool we_own_ring;
 
+	/* Parent device for doing DMA */
+	struct device *parent;
+
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
 	unsigned int in_use;
@@ -318,7 +321,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
  */
 static inline struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 {
-	return vq->vq.vdev->dev.parent;
+	return vq->parent;
 }
 
 /* Map one sg entry. */
@@ -1554,6 +1557,14 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 	return NULL;
 }
 
+static struct device *vring_get_parent(struct virtio_device *vdev, int index)
+{
+	if (vdev->config->get_vq_parent)
+		return vdev->config->get_vq_parent(vdev, index);
+	else
+		return vdev->dev.parent;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1572,7 +1583,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 	size_t ring_size_in_bytes, event_size_in_bytes;
 	unsigned int i;
-	struct device *parent = vdev->dev.parent;
+	struct device *parent = vring_get_parent(vdev, index);
 
 	ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
 
@@ -1613,6 +1624,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->num_added = 0;
 	vq->packed_ring = true;
 	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->parent = parent;
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 #ifdef DEBUG
 	vq->in_use = false;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bb4cc4910750..a95af83aad9f 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -65,6 +65,7 @@ struct irq_affinity;
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
+ * @get_vq_parent: get the parent device for a virtqueue (optional).
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -88,6 +89,7 @@ struct virtio_config_ops {
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
 			int index);
+	struct device *(*get_vq_parent)(struct virtio_device *vdev, int index);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.19.1
