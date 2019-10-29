From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH 1/2] virtio: accept parent as a parameter when allocating
	virtqueue
Date: Tue, 29 Oct 2019 18:58:42 +0800
Message-ID: <20191029105843.12061-2-jasowang__27611.601205875$1572346782$gmane$org@redhat.com>
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
 drivers/virtio/virtio_ring.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index bdc08244a648..51d83f4d7c32 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -269,12 +269,12 @@ size_t virtio_max_dma_size(struct virtio_device *vdev)
 }
 EXPORT_SYMBOL_GPL(virtio_max_dma_size);
 
-static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
-			      dma_addr_t *dma_handle, gfp_t flag)
+static void *vring_alloc_queue(struct virtio_device *vdev,
+			       struct device *parent, size_t size,
+			       dma_addr_t *dma_handle, gfp_t flag)
 {
 	if (vring_use_dma_api(vdev)) {
-		return dma_alloc_coherent(vdev->dev.parent, size,
-					  dma_handle, flag);
+		return dma_alloc_coherent(parent, size, dma_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
 
@@ -859,6 +859,7 @@ static struct virtqueue *vring_create_virtqueue_split(
 	dma_addr_t dma_addr;
 	size_t queue_size_in_bytes;
 	struct vring vring;
+	struct device *parent = vdev->dev.parent;
 
 	/* We assume num is a power of 2. */
 	if (num & (num - 1)) {
@@ -868,7 +869,8 @@ static struct virtqueue *vring_create_virtqueue_split(
 
 	/* TODO: allocate each queue chunk individually */
 	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+		queue = vring_alloc_queue(vdev, parent,
+					  vring_size(num, vring_align),
 					  &dma_addr,
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
@@ -882,7 +884,8 @@ static struct virtqueue *vring_create_virtqueue_split(
 
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
-		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+		queue = vring_alloc_queue(vdev, parent,
+					  vring_size(num, vring_align),
 					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
@@ -1569,10 +1572,11 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 	size_t ring_size_in_bytes, event_size_in_bytes;
 	unsigned int i;
+	struct device *parent = vdev->dev.parent;
 
 	ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
 
-	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
+	ring = vring_alloc_queue(vdev, parent, ring_size_in_bytes,
 				 &ring_dma_addr,
 				 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!ring)
@@ -1580,13 +1584,13 @@ static struct virtqueue *vring_create_virtqueue_packed(
 
 	event_size_in_bytes = sizeof(struct vring_packed_desc_event);
 
-	driver = vring_alloc_queue(vdev, event_size_in_bytes,
+	driver = vring_alloc_queue(vdev, parent, event_size_in_bytes,
 				   &driver_event_dma_addr,
 				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!driver)
 		goto err_driver;
 
-	device = vring_alloc_queue(vdev, event_size_in_bytes,
+	device = vring_alloc_queue(vdev, parent, event_size_in_bytes,
 				   &device_event_dma_addr,
 				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!device)
-- 
2.19.1
