From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 11/22] virtio_pci: don't use the legacy driver if we find the
	new PCI capabilities.
Date: Thu, 21 Mar 2013 18:59:32 +1030
Message-ID: <1363854584-25795-12-git-send-email-rusty@rustcorp.com.au>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
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
List-Id: virtualization@lists.linuxfoundation.org

With module option to override.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci_legacy.c |   20 +++++++++++++++++++-
 include/linux/virtio_pci.h         |   16 ++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index c75eb39..501fa79 100644
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
@@ -711,7 +715,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 			    const struct pci_device_id *id)
 {
 	struct virtio_pci_device *vp_dev;
-	int err;
+	int err, cap;
 
 	/* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
@@ -723,6 +727,20 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 		return -ENODEV;
 	}
 
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
+			return -ENODEV;
+		}
+	}
+
 	/* allocate our structure and fill it out */
 	vp_dev = kzalloc(sizeof(struct virtio_pci_device), GFP_KERNEL);
 	if (vp_dev == NULL)
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
index af5b9ab..2714160 100644
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -4,4 +4,20 @@
 #define VIRTIO_PCI_NO_LEGACY
 #include <uapi/linux/virtio_pci.h>
 
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
 #endif /* _LINUX_VIRTIO_PCI_H */
-- 
1.7.10.4
