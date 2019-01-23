From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH v2] virtio: support VIRTIO_F_ORDER_PLATFORM
Date: Wed, 23 Jan 2019 17:50:26 +0800
Message-ID: <20190123095026.8387-1-tiwei.bie__46904.0994461224$1548237413$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

This patch introduces the support for VIRTIO_F_ORDER_PLATFORM.
If this feature is negotiated, the driver must use the barriers
suitable for hardware devices. Otherwise, the device and driver
are assumed to be implemented in software, that is they can be
assumed to run on identical CPUs in an SMP configuration. Thus
a weaker form of memory barriers is sufficient to yield better
performance.

It is recommended that an add-in card based PCI device offers
this feature for portability. The device will fail to operate
further or will operate in a slower emulation mode if this
feature is offered but not accepted.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
v2:
- Add more explanations in commit log (MST);

 drivers/virtio/virtio_ring.c       | 8 ++++++++
 include/uapi/linux/virtio_config.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cd7e755484e3..27d3f057493e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1609,6 +1609,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
+		vq->weak_barriers = false;
+
 	vq->packed.ring_dma_addr = ring_dma_addr;
 	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
 	vq->packed.device_event_dma_addr = device_event_dma_addr;
@@ -2079,6 +2082,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
+		vq->weak_barriers = false;
+
 	vq->split.queue_dma_addr = 0;
 	vq->split.queue_size_in_bytes = 0;
 
@@ -2213,6 +2219,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_RING_PACKED:
 			break;
+		case VIRTIO_F_ORDER_PLATFORM:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 1196e1c1d4f6..ff8e7dc9d4dd 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -78,6 +78,12 @@
 /* This feature indicates support for the packed virtqueue layout. */
 #define VIRTIO_F_RING_PACKED		34
 
+/*
+ * This feature indicates that memory accesses by the driver and the
+ * device are ordered in a way described by the platform.
+ */
+#define VIRTIO_F_ORDER_PLATFORM		36
+
 /*
  * Does the device support Single Root I/O Virtualization?
  */
-- 
2.17.1
