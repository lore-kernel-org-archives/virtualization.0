From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Use PCI revision field to indicate virtio PCI ABI version
Date: Mon, 28 Jan 2008 09:59:59 -0600
Message-ID: <1201535999-13998-1-git-send-email-aliguori@us.ibm.com>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

As Avi pointed out, as we continue to massage the virtio PCI ABI, we can make
things a little more friendly to users by utilizing the PCI revision field to
indicate which version of the ABI we're using.  This is a hard ABI version
and incrementing it will cause the guest driver to break.

This is the necessary changes to virtio_pci to support this.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 192687e..26f787d 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -311,6 +311,12 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
 		return -ENODEV;
 
+	if (pci_dev->revision != VIRTIO_PCI_ABI_VERSION) {
+		printk(KERN_ERR "virtio_pci: expected ABI version %d, got %d\n",
+		       VIRTIO_PCI_ABI_VERSION, pci_dev->revision);
+		return -ENODEV;
+	}
+
 	/* allocate our structure and fill it out */
 	vp_dev = kzalloc(sizeof(struct virtio_pci_device), GFP_KERNEL);
 	if (vp_dev == NULL)
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
index 860eb37..b315165 100644
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -52,4 +52,6 @@
  * configuration space */
 #define VIRTIO_PCI_CONFIG		20
 
+/* Virtio ABI version, this must match exactly */
+#define VIRTIO_PCI_ABI_VERSION		0
 #endif
