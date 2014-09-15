From: Anthony Liguori <anthony@codemonkey.ws>
Subject: [PATCH] virtio_pci: properly clean up MSI-X state when initialization
	fails
Date: Sun, 14 Sep 2014 20:23:26 -0700
Message-ID: <1410751406-10039-1-git-send-email-anthony@codemonkey.ws>
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
To: virtualization@lists.linux-foundation.org
Cc: kernel@vger.kernel.org, Matt Wilson <msw@amazon.com>, Anthony Liguori <aliguori@amazon.com>, Michael Tsirkin <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Anthony Liguori <aliguori@amazon.com>

If MSI-X initialization fails after setting msix_enabled = 1, then
the device is left in an inconsistent state.  This would normally
only happen if there was a bug in the device emulation but it still
should be handled correctly.

Cc: Matt Wilson <msw@amazon.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Michael Tsirkin <mst@redhat.com>
Signed-off-by: Anthony Liguori <aliguori@amazon.com>
---
 drivers/virtio/virtio_pci.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 9cbac33..3d2c2a5 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -357,7 +357,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
 	if (v == VIRTIO_MSI_NO_VECTOR) {
 		err = -EBUSY;
-		goto error;
+		goto error_msix_used;
 	}
 
 	if (!per_vq_vectors) {
@@ -369,11 +369,15 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
 				  vp_dev);
 		if (err)
-			goto error;
+			goto error_msix_used;
 		++vp_dev->msix_used_vectors;
 	}
 	return 0;
+error_msix_used:
+	v = --vp_dev->msix_used_vectors;
+	free_irq(vp_dev->msix_entries[v].vector, vp_dev);
 error:
+	vp_dev->msix_enabled = 0;
 	vp_free_vectors(vdev);
 	return err;
 }
-- 
1.7.9.5
