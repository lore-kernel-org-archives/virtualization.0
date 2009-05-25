From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 04/11] qemu: helper routines for pci access.
Date: Mon, 25 May 2009 15:25:33 +0300
Message-ID: <20090525122533.GE5046__10187.4723950916$1243254851$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1243253205.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>, qemu-devel@nongnu.org, Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Rusty Russell <rusty@rustcor>
List-Id: virtualization@lists.linuxfoundation.org

Add inline routines for convenient access to pci devices
with correct (little) endianness. Will be used by MSI-X support.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci.h |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/pci.h b/hw/pci.h
index 40137c6..4e112a3 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -240,21 +240,45 @@ PCIBus *pci_bridge_init(PCIBus *bus, int devfn, uint16_t vid, uint16_t did,
                         pci_map_irq_fn map_irq, const char *name);
 
 static inline void
+pci_set_word(uint8_t *config, uint16_t val)
+{
+    cpu_to_le16wu((uint16_t *)config, val);
+}
+
+static inline uint16_t
+pci_get_word(uint8_t *config)
+{
+    return le16_to_cpupu((uint16_t *)config);
+}
+
+static inline void
+pci_set_long(uint8_t *config, uint32_t val)
+{
+    cpu_to_le32wu((uint32_t *)config, val);
+}
+
+static inline uint32_t
+pci_get_long(uint8_t *config)
+{
+    return le32_to_cpupu((uint32_t *)config);
+}
+
+static inline void
 pci_config_set_vendor_id(uint8_t *pci_config, uint16_t val)
 {
-    cpu_to_le16wu((uint16_t *)&pci_config[PCI_VENDOR_ID], val);
+    pci_set_word(&pci_config[PCI_VENDOR_ID], val);
 }
 
 static inline void
 pci_config_set_device_id(uint8_t *pci_config, uint16_t val)
 {
-    cpu_to_le16wu((uint16_t *)&pci_config[PCI_DEVICE_ID], val);
+    pci_set_word(&pci_config[PCI_DEVICE_ID], val);
 }
 
 static inline void
 pci_config_set_class(uint8_t *pci_config, uint16_t val)
 {
-    cpu_to_le16wu((uint16_t *)&pci_config[PCI_CLASS_DEVICE], val);
+    pci_set_word(&pci_config[PCI_CLASS_DEVICE], val);
 }
 
 typedef void (*pci_qdev_initfn)(PCIDevice *dev);
-- 
1.6.3.1.56.g79e1.dirty
