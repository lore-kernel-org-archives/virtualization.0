From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH net-next v2 5/5] virtio_ring: enable packed ring
Date: Wed, 11 Jul 2018 10:27:11 +0800
Message-ID: <20180711022711.7090-6-tiwei.bie__18774.1943788298$1531276289$gmane$org@intel.com>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180711022711.7090-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/s390/virtio/virtio_ccw.c | 14 ++++++++++++++
 drivers/virtio/virtio_ring.c     |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 8f5c1d7f751a..8654f3a94635 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -765,6 +765,17 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	return rc;
 }
 
+static void ccw_transport_features(struct virtio_device *vdev)
+{
+	/*
+	 * Packed ring isn't enabled on virtio_ccw for now,
+	 * because virtio_ccw uses some legacy accessors,
+	 * e.g. virtqueue_get_avail() and virtqueue_get_used()
+	 * which aren't available in packed ring currently.
+	 */
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -791,6 +802,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_ccw a chance to accept features. */
+	ccw_transport_features(vdev);
+
 	features->index = 0;
 	features->features = cpu_to_le32((u32)vdev->features);
 	/* Write the first half of the feature bits to the host. */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f79a1e17f7d1..807ed4b362c5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1968,6 +1968,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_RING_PACKED:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.18.0
