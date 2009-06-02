From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 08/13] qemu: add support for resizing regions
Date: Tue, 2 Jun 2009 18:02:49 +0300
Message-ID: <20090602150249.GI6554__142.146732150827$1243955650$gmane$org@redhat.com>
References: <cover.1243954694.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1243954694.git.mst@redhat.com>
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
 hw/pci.c |   54 ++++++++++++++++++++++++++++++++++++------------------
 hw/pci.h |    3 +++
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/hw/pci.c b/hw/pci.c
index 31ba2ed..a63d988 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -392,6 +392,41 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
     *(uint32_t *)(pci_dev->mask + addr) = cpu_to_le32(mask);
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
+void pci_resize_io_region(PCIDevice *pci_dev, int region_num,
+                          uint32_t size)
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
@@ -445,24 +480,7 @@ static void pci_update_mappings(PCIDevice *d)
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
index 6da626b..4072f16 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -221,6 +221,9 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
                             uint32_t size, int type,
                             PCIMapIORegionFunc *map_func);
 
+void pci_resize_io_region(PCIDevice *pci_dev, int region_num,
+                          uint32_t size);
+
 int pci_add_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
 
 void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
-- 
1.6.3.1.56.g79e1.dirty
