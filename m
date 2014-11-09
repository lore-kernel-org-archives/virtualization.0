From: Fam Zheng <famz@redhat.com>
Subject: [PATCH] virtio-pci: Reset device on shutdown
Date: Sun,  9 Nov 2014 17:39:05 +0800
Message-ID: <1415525945-7324-1-git-send-email-famz@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ulrich Obergfell <uobergfe@redhat.com>, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This fixes a hanging issue during guest shutdown.

The device is left enabled even though we removed it and disabled msix
during shutdown. If the virtio device happens to get a new event right
at this point, seeing msix is disabled, it may try to notify us with an
IRQ, which is totally unexpected thus will not be handled. In this
case the guest hangs.

Let's reset the device so that it will not generate any interrupts.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1128424
Cc: Ulrich Obergfell <uobergfe@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/virtio/virtio_pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index d34ebfa..cd7be6f 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -743,6 +743,14 @@ out:
 	return err;
 }
 
+static void virtio_pci_shutdown(struct pci_dev *pci_dev)
+{
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+
+	vp_reset(&vp_dev->vdev);
+}
+
+
 static void virtio_pci_remove(struct pci_dev *pci_dev)
 {
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
@@ -794,6 +802,7 @@ static struct pci_driver virtio_pci_driver = {
 	.id_table	= virtio_pci_id_table,
 	.probe		= virtio_pci_probe,
 	.remove		= virtio_pci_remove,
+	.shutdown	= virtio_pci_shutdown,
 #ifdef CONFIG_PM_SLEEP
 	.driver.pm	= &virtio_pci_pm_ops,
 #endif
-- 
1.9.3
