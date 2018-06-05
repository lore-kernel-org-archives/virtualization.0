From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC v6 5/5] virtio_ring: enable packed ring
Date: Tue,  5 Jun 2018 15:40:46 +0800
Message-ID: <20180605074046.20709-6-tiwei.bie__34482.4603795589$1528184685$gmane$org@intel.com>
References: <20180605074046.20709-1-tiwei.bie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180605074046.20709-1-tiwei.bie@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 drivers/s390/virtio/virtio_ccw.c | 8 ++++++++
 drivers/virtio/virtio_ring.c     | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 8f5c1d7f751a..ff5b85736d8d 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -765,6 +765,11 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	return rc;
 }
 
+static void ccw_transport_features(struct virtio_device *vdev)
+{
+	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
+}
+
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -791,6 +796,9 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
+	/* Give virtio_ccw a chance to accept features. */
+	ccw_transport_features(vdev);
+
 	features->index = 0;
 	features->features = cpu_to_le32((u32)vdev->features);
 	/* Write the first half of the feature bits to the host. */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index aefd7ac40928..fe849fd8733b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1965,6 +1965,8 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		case VIRTIO_F_IOMMU_PLATFORM:
 			break;
+		case VIRTIO_F_RING_PACKED:
+			break;
 		default:
 			/* We don't understand this bit. */
 			__virtio_clear_bit(vdev, i);
-- 
2.17.0
