From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH v6 01/11] virtio: pci: switch to new PM API
Date: Thu, 22 Dec 2011 16:58:25 +0530
Message-ID: <20a25a186555104a4f3a7870f05de1b4d9fa3a90.1324553223.git.amit.shah@redhat.com>
References: <cover.1324553223.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1324553223.git.amit.shah@redhat.com>
In-Reply-To: <cover.1324553223.git.amit.shah@redhat.com>
References: <cover.1324553223.git.amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The older PM API doesn't have a way to get notifications on hibernate
events.  Switch to the newer one that gives us those notifications.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_pci.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 03d1984..23e1532 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -708,19 +708,28 @@ static void __devexit virtio_pci_remove(struct pci_dev *pci_dev)
 }
 
 #ifdef CONFIG_PM
-static int virtio_pci_suspend(struct pci_dev *pci_dev, pm_message_t state)
+static int virtio_pci_suspend(struct device *dev)
 {
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
 	pci_save_state(pci_dev);
 	pci_set_power_state(pci_dev, PCI_D3hot);
 	return 0;
 }
 
-static int virtio_pci_resume(struct pci_dev *pci_dev)
+static int virtio_pci_resume(struct device *dev)
 {
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+
 	pci_restore_state(pci_dev);
 	pci_set_power_state(pci_dev, PCI_D0);
 	return 0;
 }
+
+static const struct dev_pm_ops virtio_pci_pm_ops = {
+	.suspend = virtio_pci_suspend,
+	.resume  = virtio_pci_resume,
+};
 #endif
 
 static struct pci_driver virtio_pci_driver = {
@@ -729,8 +738,7 @@ static struct pci_driver virtio_pci_driver = {
 	.probe		= virtio_pci_probe,
 	.remove		= __devexit_p(virtio_pci_remove),
 #ifdef CONFIG_PM
-	.suspend	= virtio_pci_suspend,
-	.resume		= virtio_pci_resume,
+	.driver.pm	= &virtio_pci_pm_ops,
 #endif
 };
 
-- 
1.7.7.4
