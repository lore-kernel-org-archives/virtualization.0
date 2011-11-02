From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH (repost) RFC 2/2] virtio-pci: recall and return msix
	notifications on ISR read
Date: Wed, 2 Nov 2011 22:11:28 +0200
Message-ID: <6dc9aa9764b1cfddf557a98f269e0f7d31ce03ac.1320259840.git.mst@redhat.com>
References: <cover.1320259840.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1320259840.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Stefan Weil <weil@mail.berlios.de>, Avi Kivity <avi@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

MSIX spec requires that device can be operated with
all vectors masked, by polling pending bits.
Add APIs to recall an msix notification, and make polling
mode possible in virtio-pci by clearing the
pending bits and setting ISR appropriately on ISR read.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/msix.c       |   26 ++++++++++++++++++++++++++
 hw/msix.h       |    3 +++
 hw/virtio-pci.c |   11 ++++++++++-
 3 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/hw/msix.c b/hw/msix.c
index 63b41b9..fe967c9 100644
--- a/hw/msix.c
+++ b/hw/msix.c
@@ -349,6 +349,32 @@ void msix_notify(PCIDevice *dev, unsigned vector)
     stl_le_phys(address, data);
 }
 
+/* Recall outstanding MSI-X notifications for a vector, if possible.
+ * Return true if any were outstanding. */
+bool msix_recall(PCIDevice *dev, unsigned vector)
+{
+    bool ret;
+    if (vector >= dev->msix_entries_nr)
+        return false;
+    ret = msix_is_pending(dev, vector);
+    msix_clr_pending(dev, vector);
+    return ret;
+}
+
+/* Recall outstanding MSI-X notifications for all vectors, if possible.
+ * Return true if any were outstanding. */
+bool msix_recall_all(PCIDevice *dev)
+{
+    uint8_t ret = 0;
+    uint8_t *b;
+    for (b = dev->msix_table_page + MSIX_PAGE_PENDING;
+	 b <= msix_pending_byte(dev, dev->msix_entries_nr - 1); ++b) {
+        ret |= *b;
+        *b = 0;
+    }
+    return ret;
+}
+
 void msix_reset(PCIDevice *dev)
 {
     if (!(dev->cap_present & QEMU_PCI_CAP_MSIX))
diff --git a/hw/msix.h b/hw/msix.h
index 7e04336..86a92b1 100644
--- a/hw/msix.h
+++ b/hw/msix.h
@@ -27,6 +27,9 @@ void msix_unuse_all_vectors(PCIDevice *dev);
 
 void msix_notify(PCIDevice *dev, unsigned vector);
 
+bool msix_recall(PCIDevice *dev, unsigned vector);
+bool msix_recall_all(PCIDevice *dev);
+
 void msix_reset(PCIDevice *dev);
 
 extern int msix_supported;
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index df27c19..cab7dde 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -393,7 +393,16 @@ static uint32_t virtio_ioport_read(VirtIOPCIProxy *proxy, uint32_t addr)
         /* reading from the ISR also clears it. */
         ret = vdev->isr;
         vdev->isr = 0;
-        qemu_set_irq(proxy->pci_dev.irq[0], 0);
+        if (msix_enabled(&proxy->pci_dev)) {
+            if (msix_recall(&proxy->pci_dev, vdev->config_vector)) {
+                ret |= VIRTIO_ISR_CONFIG;
+            }
+            if (msix_recall_all(&proxy->pci_dev)) {
+                ret |= VIRTIO_ISR_VQ;
+            }
+        } else {
+		qemu_set_irq(proxy->pci_dev.irq[0], 0);
+        }
         break;
     case VIRTIO_MSI_CONFIG_VECTOR:
         ret = vdev->config_vector;
-- 
1.7.5.53.gc233e
