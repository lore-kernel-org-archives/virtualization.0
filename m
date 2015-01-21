From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH post-squash 8/9] virtio_pci: add module param to force legacy
	mode
Date: Wed, 21 Jan 2015 17:05:32 +0200
Message-ID: <1421852670-23742-9-git-send-email-mst__29470.9883085035$1421852802$gmane$org@redhat.com>
References: <1421852670-23742-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421852670-23742-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If set, try legacy interface first, modern one if that fails.  Useful to
work around device/driver bugs, and for compatibility testing.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 8ae34a3..e894eb2 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -19,6 +19,14 @@
 
 #include "virtio_pci_common.h"
 
+static bool force_legacy = false;
+
+#if IS_ENABLED(CONFIG_VIRTIO_PCI_LEGACY)
+module_param(force_legacy, bool, 0444);
+MODULE_PARM_DESC(force_legacy,
+		 "Force legacy mode for transitional virtio 1 devices");
+#endif
+
 /* wait for pending irq handlers */
 void vp_synchronize_vectors(struct virtio_device *vdev)
 {
@@ -505,11 +513,20 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto err_request_regions;
 
-	rc = virtio_pci_modern_probe(vp_dev);
-	if (rc == -ENODEV)
+	if (force_legacy) {
 		rc = virtio_pci_legacy_probe(vp_dev);
-	if (rc)
-		goto err_probe;
+		/* Also try modern mode if we can't map BAR0 (no IO space). */
+		if (rc == -ENODEV || rc == -ENOMEM)
+			rc = virtio_pci_modern_probe(vp_dev);
+		if (rc)
+			goto err_probe;
+	} else {
+		rc = virtio_pci_modern_probe(vp_dev);
+		if (rc == -ENODEV)
+			rc = virtio_pci_legacy_probe(vp_dev);
+		if (rc)
+			goto err_probe;
+	}
 
 	pci_set_master(pci_dev);
 
-- 
MST
