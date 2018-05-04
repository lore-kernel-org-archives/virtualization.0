From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH v1] virtio: support VIRTIO_F_IO_BARRIER
Date: Fri,  4 May 2018 12:59:15 +0800
Message-ID: <20180504045915.17693-1-tiwei.bie__29465.0586242371$1525409815$gmane$org@intel.com>
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
To: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This patch introduces the support for VIRTIO_F_IO_BARRIER.
When this feature is negotiated, driver will use the barriers
suitable for hardware devices.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
This patch depends on below proposal for virtio-spec:
https://lists.oasis-open.org/archives/virtio-dev/201805/msg00019.html

This patch also depends on below patch:
https://lkml.org/lkml/2018/4/19/789

RFC -> v1:
- Address the changes in the proposal;

 drivers/virtio/virtio_ring.c       | 5 +++++
 include/uapi/linux/virtio_config.h | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 21d464a29cf8..edb565643bf4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -996,6 +996,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
+	if (virtio_has_feature(vdev, VIRTIO_F_IO_BARRIER))
+		vq->weak_barriers = false;
+
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
@@ -1164,6 +1167,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_IO_BARRIER:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 308e2096291f..9fb519a9df28 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -49,7 +49,7 @@
  * transport being used (eg. virtio_ring), the rest are per-device feature
  * bits. */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		34
+#define VIRTIO_TRANSPORT_F_END		37
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -71,4 +71,10 @@
  * this is for compatibility with legacy systems.
  */
 #define VIRTIO_F_IOMMU_PLATFORM		33
+
+/*
+ * If clear - driver may use barriers suitable for CPU cores.
+ * If set - driver must use barriers suitable for hardware devices.
+ */
+#define VIRTIO_F_IO_BARRIER		36
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
2.11.0
