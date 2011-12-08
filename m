From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 6/11] virtio_pci: don't use the legacy driver if we find the new
	PCI capabilities.
Date: Thu, 08 Dec 2011 21:08:30 +1030
Message-ID: <871usfgxg9.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
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
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


With module option to override.  I assume I can call
pci_find_capability() before pci_request_regions?
---
 drivers/virtio/virtio_pci_legacy.c |   20 +++++++++++++++++++-
 include/linux/virtio_pci.h         |   19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -26,6 +26,10 @@
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 
+static bool force_nonlegacy;
+module_param(force_nonlegacy, bool, 0644);
+MODULE_PARM_DESC(force_nonlegacy, "Take over non-legacy virtio devices too");
+
 MODULE_AUTHOR("Anthony Liguori <aliguori@us.ibm.com>");
 MODULE_DESCRIPTION("virtio-pci-legacy");
 MODULE_LICENSE("GPL");
@@ -622,7 +626,7 @@ static int __devinit virtio_pci_probe(st
 				      const struct pci_device_id *id)
 {
 	struct virtio_pci_device *vp_dev;
-	int err;
+	int err, cap;
 
 	/* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
@@ -654,6 +658,21 @@ static int __devinit virtio_pci_probe(st
 	if (err)
 		goto out;
 
+	/* We leave modern virtio-pci for the modern driver. */
+	cap = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG);
+	if (cap) {
+		if (force_nonlegacy)
+			dev_info(&pci_dev->dev,
+				 "virtio_pci_legacy: forcing legacy mode!\n");
+		else {
+			dev_info(&pci_dev->dev,
+				 "virtio_pci_legacy: leaving to"
+				 " non-legacy driver\n");
+			err = -ENODEV;
+			goto out_enable_device;
+		}
+	}
+
 	err = pci_request_regions(pci_dev, "virtio-pci-legacy");
 	if (err)
 		goto out_enable_device;
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -152,4 +152,23 @@ struct virtio_pci_common_cfg {
 	__le16 queue_msix_vector;/* read-write */
 	__le64 queue_address;	/* read-write: 0xFFFFFFFFFFFFFFFF == DNE. */
 };
+
+#ifdef __KERNEL__
+/* Returns offset of the capability, or 0. */
+static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type)
+{
+	int pos;
+
+	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+	     pos > 0;
+	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+		u8 type;
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+							 cfg_type), &type);
+		if (type == cfg_type)
+			return pos;
+	}
+	return 0;
+}
+#endif /* __KERNEL__ */
 #endif
