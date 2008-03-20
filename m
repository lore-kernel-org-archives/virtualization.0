From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] virtio_pci: unregister virtio device at device remove
Date: Wed, 19 Mar 2008 20:35:04 -0500
Message-ID: <1205976904-19592-1-git-send-email-aliguori__43834.6455026933$1205977071$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel@lists.sourceforge.net, Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Make sure to call unregister_virtio_device() when a virtio device is removed.
Otherwise, virtio_pci.ko cannot be rmmod'd.

This was spotted by Marcelo Tosatti.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 59a8f73..6c8ecde 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -388,6 +388,7 @@ static void __devexit virtio_pci_remove(struct pci_dev *pci_dev)
 {
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 
+	unregister_virtio_device(&vp_dev->vdev);
 	free_irq(pci_dev->irq, vp_dev);
 	pci_set_drvdata(pci_dev, NULL);
 	pci_iounmap(pci_dev, vp_dev->ioaddr);
