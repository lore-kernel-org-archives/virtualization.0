From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 4/5] virtio-pci: S3 support
Date: Thu, 29 Mar 2012 13:58:10 +0530
Message-ID: <08e96b3cfe2f96e34e8a97ecde470d87f58bd29d.1333008576.git.amit.shah@redhat.com>
References: <cover.1333008576.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1333008576.git.amit.shah@redhat.com>
In-Reply-To: <cover.1333008576.git.amit.shah@redhat.com>
References: <cover.1333008576.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

There's no difference in supporting S3 and S4 for virtio devices: the
vqs have to be re-created as the device has to be assumed to be reset at
restore-time.  Since S4 already handles this situation, we can directly
use the same code and callbacks for S3 support.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_pci.c |   24 +++---------------------
 1 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 982d6c9..0fa4f85 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -720,24 +720,6 @@ static void __devexit virtio_pci_remove(struct pci_dev *pci_dev)
 }
 
 #ifdef CONFIG_PM
-static int virtio_pci_suspend(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-
-	pci_save_state(pci_dev);
-	pci_set_power_state(pci_dev, PCI_D3hot);
-	return 0;
-}
-
-static int virtio_pci_resume(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-
-	pci_restore_state(pci_dev);
-	pci_set_power_state(pci_dev, PCI_D0);
-	return 0;
-}
-
 static int virtio_pci_freeze(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -786,12 +768,12 @@ static int virtio_pci_restore(struct device *dev)
 }
 
 static const struct dev_pm_ops virtio_pci_pm_ops = {
-	.suspend	= virtio_pci_suspend,
-	.resume		= virtio_pci_resume,
+	.suspend	= virtio_pci_freeze,
+	.resume		= virtio_pci_restore,
 	.freeze		= virtio_pci_freeze,
 	.thaw		= virtio_pci_restore,
 	.restore	= virtio_pci_restore,
-	.poweroff	= virtio_pci_suspend,
+	.poweroff	= virtio_pci_freeze,
 };
 #endif
 
-- 
1.7.7.6
