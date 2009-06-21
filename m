From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv6 03/12] qemu/pci: add routines to manage PCI capabilities
Date: Sun, 21 Jun 2009 19:45:40 +0300
Message-ID: <20090621164540.GD10164__22432.0176909261$1245603444$gmane$org@redhat.com>
References: <cover.1245594586.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1245594586.git.mst@redhat.com>
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

Add routines to manage PCI capability list. First user will be MSI-X.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/pci.h |   18 ++++++++++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/hw/pci.c b/hw/pci.c
index 359959e..72ca27b 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -148,7 +148,6 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
     if (version_id >= 2)
         for (i = 0; i < 4; i ++)
             s->irq_state[i] = qemu_get_be32(f);
-
     return 0;
 }
 
@@ -856,3 +855,76 @@ PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
 
     return (PCIDevice *)dev;
 }
+
+static int pci_find_space(PCIDevice *pdev, uint8_t size)
+{
+    int offset = PCI_CONFIG_HEADER_SIZE;
+    int i;
+    for (i = PCI_CONFIG_HEADER_SIZE; i < PCI_CONFIG_SPACE_SIZE; ++i)
+        if (pdev->used[i])
+            offset = i + 1;
+        else if (i - offset + 1 == size)
+            return offset;
+    return 0;
+}
+
+static uint8_t pci_find_capability_list(PCIDevice *pdev, uint8_t cap_id,
+                                        uint8_t *prev_p)
+{
+    uint8_t next, prev;
+
+    if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST))
+        return 0;
+
+    for (prev = PCI_CAPABILITY_LIST; (next = pdev->config[prev]);
+         prev = next + PCI_CAP_LIST_NEXT)
+        if (pdev->config[next + PCI_CAP_LIST_ID] == cap_id)
+            break;
+
+    if (prev_p)
+        *prev_p = prev;
+    return next;
+}
+
+/* Reserve space and add capability to the linked list in pci config space */
+int pci_add_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
+{
+    uint8_t offset = pci_find_space(pdev, size);
+    uint8_t *config = pdev->config + offset;
+    if (!offset)
+        return -ENOSPC;
+    config[PCI_CAP_LIST_ID] = cap_id;
+    config[PCI_CAP_LIST_NEXT] = pdev->config[PCI_CAPABILITY_LIST];
+    pdev->config[PCI_CAPABILITY_LIST] = offset;
+    pdev->config[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
+    memset(pdev->used + offset, 0xFF, size);
+    /* Make capability read-only by default */
+    memset(pdev->wmask + offset, 0, size);
+    return offset;
+}
+
+/* Unlink capability from the pci config space. */
+void pci_del_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
+{
+    uint8_t prev, offset = pci_find_capability_list(pdev, cap_id, &prev);
+    if (!offset)
+        return;
+    pdev->config[prev] = pdev->config[offset + PCI_CAP_LIST_NEXT];
+    /* Make capability writeable again */
+    memset(pdev->wmask + offset, 0xff, size);
+    memset(pdev->used + offset, 0, size);
+
+    if (!pdev->config[PCI_CAPABILITY_LIST])
+        pdev->config[PCI_STATUS] &= ~PCI_STATUS_CAP_LIST;
+}
+
+/* Reserve space for capability at a known offset (to call after load). */
+void pci_reserve_capability(PCIDevice *pdev, uint8_t offset, uint8_t size)
+{
+    memset(pdev->used + offset, 0xff, size);
+}
+
+uint8_t pci_find_capability(PCIDevice *pdev, uint8_t cap_id)
+{
+    return pci_find_capability_list(pdev, cap_id, NULL);
+}
diff --git a/hw/pci.h b/hw/pci.h
index 2ba582e..7172d81 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -121,6 +121,10 @@ typedef struct PCIIORegion {
 #define PCI_MIN_GNT		0x3e	/* 8 bits */
 #define PCI_MAX_LAT		0x3f	/* 8 bits */
 
+/* Capability lists */
+#define PCI_CAP_LIST_ID		0	/* Capability ID */
+#define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
+
 #define PCI_REVISION            0x08    /* obsolete, use PCI_REVISION_ID */
 #define PCI_SUBVENDOR_ID        0x2c    /* obsolete, use PCI_SUBSYSTEM_VENDOR_ID */
 #define PCI_SUBDEVICE_ID        0x2e    /* obsolete, use PCI_SUBSYSTEM_ID */
@@ -128,7 +132,7 @@ typedef struct PCIIORegion {
 /* Bits in the PCI Status Register (PCI 2.3 spec) */
 #define PCI_STATUS_RESERVED1	0x007
 #define PCI_STATUS_INT_STATUS	0x008
-#define PCI_STATUS_CAPABILITIES	0x010
+#define PCI_STATUS_CAP_LIST	0x010
 #define PCI_STATUS_66MHZ	0x020
 #define PCI_STATUS_RESERVED2	0x040
 #define PCI_STATUS_FAST_BACK	0x080
@@ -158,6 +162,9 @@ struct PCIDevice {
     /* Used to implement R/W bytes */
     uint8_t wmask[PCI_CONFIG_SPACE_SIZE];
 
+    /* Used to allocate config space for capabilities. */
+    uint8_t used[PCI_CONFIG_SPACE_SIZE];
+
     /* the following fields are read only */
     PCIBus *bus;
     int devfn;
@@ -186,6 +193,15 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                             uint32_t size, int type,
                             PCIMapIORegionFunc *map_func);
 
+int pci_add_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
+
+void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
+
+void pci_reserve_capability(PCIDevice *pci_dev, uint8_t offset, uint8_t size);
+
+uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
+
+
 uint32_t pci_default_read_config(PCIDevice *d,
                                  uint32_t address, int len);
 void pci_default_write_config(PCIDevice *d,
-- 
1.6.2.2
