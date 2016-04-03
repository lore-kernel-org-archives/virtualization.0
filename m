From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: virtio 1.0 cs04 spec compliance for reset
Date: Sun, 3 Apr 2016 15:26:22 +0300
Message-ID: <1459686336-29527-1-git-send-email-mst__1816.04405302114$1459686405$gmane$org@redhat.com>
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
Cc: Bandan Das <bsd@redhat.com>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The spec says: after writing 0 to device_status, the driver MUST wait
for a read of device_status to return 0 before reinitializing the
device.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f6f28cc..e76bd91 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -17,6 +17,7 @@
  *
  */
 
+#include <linux/delay.h>
 #define VIRTIO_PCI_NO_LEGACY
 #include "virtio_pci_common.h"
 
@@ -271,9 +272,13 @@ static void vp_reset(struct virtio_device *vdev)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	/* 0 status means a reset. */
 	vp_iowrite8(0, &vp_dev->common->device_status);
-	/* Flush out the status write, and flush in device writes,
-	 * including MSI-X interrupts, if any. */
-	vp_ioread8(&vp_dev->common->device_status);
+	/* After writing 0 to device_status, the driver MUST wait for a read of
+	 * device_status to return 0 before reinitializing the device.
+	 * This will flush out the status write, and flush in device writes,
+	 * including MSI-X interrupts, if any.
+	 */
+	while (vp_ioread8(&vp_dev->common->device_status))
+		msleep(1);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
-- 
MST
