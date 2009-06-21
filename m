From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv6 04/12] qemu/pci: check constant registers on load
Date: Sun, 21 Jun 2009 19:49:40 +0300
Message-ID: <20090621164940.GE10164__39865.986738778$1245603571$gmane$org@redhat.com>
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

Add "cmask" table of constant register masks: if a bit is not writeable
and is set in cmask table, this bit is checked on load.  An attempt to
load an image that would change such a register causes load to fail.
Use this table to make sure that load does not modify registers that
guest can not change (directly or indirectly).

Note: we can't just assume that read-only registers never change,
because the guest could change a register indirectly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci.c |   26 +++++++++++++++++++++++++-
 hw/pci.h |    5 +++++
 2 files changed, 30 insertions(+), 1 deletions(-)

diff --git a/hw/pci.c b/hw/pci.c
index 72ca27b..d8fa439 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -136,13 +136,19 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
 
 int pci_device_load(PCIDevice *s, QEMUFile *f)
 {
+    uint8_t config[PCI_CONFIG_SPACE_SIZE];
     uint32_t version_id;
     int i;
 
     version_id = qemu_get_be32(f);
     if (version_id > 2)
         return -EINVAL;
-    qemu_get_buffer(f, s->config, 256);
+    qemu_get_buffer(f, config, sizeof config);
+    for (i = 0; i < sizeof config; ++i)
+        if ((config[i] ^ s->config[i]) & s->cmask[i] & ~s->wmask[i])
+            return -EINVAL;
+    memcpy(s->config, config, sizeof config);
+
     pci_update_mappings(s);
 
     if (version_id >= 2)
@@ -237,6 +243,18 @@ int pci_assign_devaddr(const char *addr, int *domp, int *busp, unsigned *slotp)
     return pci_parse_devaddr(devaddr, domp, busp, slotp);
 }
 
+static void pci_init_cmask(PCIDevice *dev)
+{
+    pci_set_word(dev->cmask + PCI_VENDOR_ID, 0xffff);
+    pci_set_word(dev->cmask + PCI_DEVICE_ID, 0xffff);
+    dev->cmask[PCI_STATUS] = PCI_STATUS_CAP_LIST;
+    dev->cmask[PCI_REVISION_ID] = 0xff;
+    dev->cmask[PCI_CLASS_PROG] = 0xff;
+    pci_set_word(dev->cmask + PCI_CLASS_DEVICE, 0xffff);
+    dev->cmask[PCI_HEADER_TYPE] = 0xff;
+    dev->cmask[PCI_CAPABILITY_LIST] = 0xff;
+}
+
 static void pci_init_wmask(PCIDevice *dev)
 {
     int i;
@@ -267,6 +285,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
     memset(pci_dev->irq_state, 0, sizeof(pci_dev->irq_state));
     pci_set_default_subsystem_id(pci_dev);
+    pci_init_cmask(pci_dev);
     pci_init_wmask(pci_dev);
 
     if (!config_read)
@@ -366,6 +385,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     }
     *(uint32_t *)(pci_dev->config + addr) = cpu_to_le32(type);
     *(uint32_t *)(pci_dev->wmask + addr) = cpu_to_le32(wmask);
+    *(uint32_t *)(pci_dev->cmask + addr) = 0xffffffff;
 }
 
 static void pci_update_mappings(PCIDevice *d)
@@ -900,6 +920,8 @@ int pci_add_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
     memset(pdev->used + offset, 0xFF, size);
     /* Make capability read-only by default */
     memset(pdev->wmask + offset, 0, size);
+    /* Check capability by default */
+    memset(pdev->cmask + offset, 0xFF, size);
     return offset;
 }
 
@@ -912,6 +934,8 @@ void pci_del_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
     pdev->config[prev] = pdev->config[offset + PCI_CAP_LIST_NEXT];
     /* Make capability writeable again */
     memset(pdev->wmask + offset, 0xff, size);
+    /* Clear cmask as device-specific registers can't be checked */
+    memset(pdev->cmask + offset, 0, size);
     memset(pdev->used + offset, 0, size);
 
     if (!pdev->config[PCI_CAPABILITY_LIST])
diff --git a/hw/pci.h b/hw/pci.h
index 7172d81..558e18f 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -101,6 +101,7 @@ typedef struct PCIIORegion {
 #define  PCI_COMMAND_MASTER	0x4	/* Enable bus master */
 #define PCI_STATUS              0x06    /* 16 bits */
 #define PCI_REVISION_ID         0x08    /* 8 bits  */
+#define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
 #define PCI_CLASS_DEVICE        0x0a    /* Device class */
 #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
 #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
@@ -159,6 +160,10 @@ struct PCIDevice {
     /* PCI config space */
     uint8_t config[PCI_CONFIG_SPACE_SIZE];
 
+    /* Used to enable config checks on load. Note that writeable bits are
+     * never checked even if set in cmask. */
+    uint8_t cmask[PCI_CONFIG_SPACE_SIZE];
+
     /* Used to implement R/W bytes */
     uint8_t wmask[PCI_CONFIG_SPACE_SIZE];
 
-- 
1.6.2.2
