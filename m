From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_balloon: disable VIOMMU support
Date: Tue, 13 Jun 2017 21:00:40 +0300
Message-ID: <1497376825-15502-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio balloon bypasses the DMA API entirely so does not support the
VIOMMU right now.  It's not clear we need that support, for now let's
just make sure we don't pretend to support it.

Cc: stable@vger.kernel.org
Cc: Wei Wang <wei.w.wang@intel.com>
Fixes: 1a937693993f ("virtio: new feature to detect IOMMU device quirk")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 408c174..22caf80 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -663,6 +663,12 @@ static int virtballoon_restore(struct virtio_device *vdev)
 }
 #endif
 
+static int virtballoon_validate(struct virtio_device *vdev)
+{
+	__virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
+	return 0;
+}
+
 static unsigned int features[] = {
 	VIRTIO_BALLOON_F_MUST_TELL_HOST,
 	VIRTIO_BALLOON_F_STATS_VQ,
@@ -675,6 +681,7 @@ static struct virtio_driver virtio_balloon_driver = {
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
+	.validate =	virtballoon_validate,
 	.probe =	virtballoon_probe,
 	.remove =	virtballoon_remove,
 	.config_changed = virtballoon_changed,
-- 
MST
