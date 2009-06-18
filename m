From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv5 08/13] qemu: add support for resizing regions
Date: Thu, 18 Jun 2009 16:14:38 +0300
Message-ID: <20090618131438.GI19092__12259.8079070032$1245332495$gmane$org@redhat.com>
References: <cover.1245330293.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1245330293.git.mst@redhat.com>
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

Make it possible to resize PCI regions.  This will be used by virtio
with MSI-X, where the region size depends on whether MSI-X is enabled,
and can change across load/save.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci.c |   53 +++++++++++++++++++++++++++++++++++------------------
 hw/pci.h |    2 ++
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/hw/pci.c b/hw/pci.c
index e3f80d0..aa88a0b 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -386,6 +386,40 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     *(uint32_t *)(pci_dev->wmask + addr) = cpu_to_le32(wmask);
 }
 
+static void pci_unmap_region(PCIDevice *d, PCIIORegion *r)
+{
+    if (r->addr == -1)
+        return;
+    if (r->type & PCI_ADDRESS_SPACE_IO) {
+        int class;
+        /* NOTE: specific hack for IDE in PC case:
+           only one byte must be mapped. */
+        class = pci_get_word(d->config + PCI_CLASS_DEVICE);
+        if (class == 0x0101 && r->size == 4) {
+            isa_unassign_ioport(r->addr + 2, 1);
+        } else {
+            isa_unassign_ioport(r->addr, r->size);
+        }
+    } else {
+        cpu_register_physical_memory(pci_to_cpu_addr(r->addr),
+                                     r->size,
+                                     IO_MEM_UNASSIGNED);
+        qemu_unregister_coalesced_mmio(r->addr, r->size);
+    }
+}
+
+void pci_resize_bar(PCIDevice *pci_dev, int region_num, uint32_t size)
+{
+
+    PCIIORegion *r = &pci_dev->io_regions[region_num];
+    if (r->size == size)
+        return;
+    r->size = size;
+    pci_unmap_region(pci_dev, r);
+    r->addr = -1;
+    pci_update_mappings(pci_dev);
+}
+
 static void pci_update_mappings(PCIDevice *d)
 {
     PCIIORegion *r;
@@ -439,24 +473,7 @@ static void pci_update_mappings(PCIDevice *d)
             }
             /* now do the real mapping */
             if (new_addr != r->addr) {
-                if (r->addr != -1) {
-                    if (r->type & PCI_ADDRESS_SPACE_IO) {
-                        int class;
-                        /* NOTE: specific hack for IDE in PC case:
-                           only one byte must be mapped. */
-                        class = d->config[0x0a] | (d->config[0x0b] << 8);
-                        if (class == 0x0101 && r->size == 4) {
-                            isa_unassign_ioport(r->addr + 2, 1);
-                        } else {
-                            isa_unassign_ioport(r->addr, r->size);
-                        }
-                    } else {
-                        cpu_register_physical_memory(pci_to_cpu_addr(r->addr),
-                                                     r->size,
-                                                     IO_MEM_UNASSIGNED);
-                        qemu_unregister_coalesced_mmio(r->addr, r->size);
-                    }
-                }
+                pci_unmap_region(d, r);
                 r->addr = new_addr;
                 if (r->addr != -1) {
                     r->map_func(d, i, r->addr, r->size, r->type);
diff --git a/hw/pci.h b/hw/pci.h
index 25865d7..67e4b4d 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -217,6 +217,8 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                             uint32_t size, int type,
                             PCIMapIORegionFunc *map_func);
 
+void pci_resize_bar(PCIDevice *pci_dev, int region_num, uint32_t size);
+
 int pci_add_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
 
 void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
-- 
1.6.2.2
