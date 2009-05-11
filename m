From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] qemu-kvm: use common code for assigned msix
Date: Tue, 12 May 2009 01:14:09 +0300
Message-ID: <20090511221409.GA22863__20676.613765727$1242080207$gmane$org@redhat.com>
References: <cover.1242079177.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1242079177.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemon>
List-Id: virtualization@lists.linuxfoundation.org


For assigned devices, use common code to enable msi-x.
Add "hack" option as assigned devices lack a standard way to get vector usage.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/device-assignment.c |  336 ++++++++++++------------------------------------
 hw/device-assignment.h |    8 +-
 hw/msix.c              |   11 ++-
 hw/pci.h               |    4 +
 4 files changed, 100 insertions(+), 259 deletions(-)

diff --git a/hw/device-assignment.c b/hw/device-assignment.c
index 0a5f850..aabed69 100644
--- a/hw/device-assignment.c
+++ b/hw/device-assignment.c
@@ -33,6 +33,7 @@
 #include <sys/stat.h>
 #include "qemu-kvm.h"
 #include "hw.h"
+#include "msix.h"
 #include "pc.h"
 #include "sysemu.h"
 #include "console.h"
@@ -150,11 +151,10 @@ static void assigned_dev_iomem_map(PCIDevice *pci_dev, int region_num,
 {
     AssignedDevice *r_dev = container_of(pci_dev, AssignedDevice, dev);
     AssignedDevRegion *region = &r_dev->v_addrs[region_num];
-    PCIRegion *real_region = &r_dev->real_device.regions[region_num];
     uint32_t old_ephys = region->e_physbase;
     uint32_t old_esize = region->e_size;
     int first_map = (region->e_size == 0);
-    int ret = 0;
+    int ret;
 
     DEBUG("e_phys=%08x r_virt=%p type=%d len=%08x region_num=%d \n",
           e_phys, region->u.r_virtbase, type, e_size, region_num);
@@ -166,27 +166,17 @@ static void assigned_dev_iomem_map(PCIDevice *pci_dev, int region_num,
 	kvm_destroy_phys_mem(kvm_context, old_ephys,
                              TARGET_PAGE_ALIGN(old_esize));
 
-    if (e_size > 0) {
-        /* deal with MSI-X MMIO page */
-        if (real_region->base_addr <= r_dev->msix_table_addr &&
-                real_region->base_addr + real_region->size >=
-                r_dev->msix_table_addr) {
-            int offset = r_dev->msix_table_addr - real_region->base_addr;
-            ret = munmap(region->u.r_virtbase + offset, TARGET_PAGE_SIZE);
-            if (ret == 0)
-                DEBUG("munmap done, virt_base 0x%p\n",
-                        region->u.r_virtbase + offset);
-            else {
-                fprintf(stderr, "%s: fail munmap msix table!\n", __func__);
-                exit(1);
-            }
-            cpu_register_physical_memory(e_phys + offset,
-                    TARGET_PAGE_SIZE, r_dev->mmio_index);
-        }
-	ret = kvm_register_phys_mem(kvm_context, e_phys,
-                                    region->u.r_virtbase,
-                                    TARGET_PAGE_ALIGN(e_size), 0);
-    }
+    if (e_size <= 0)
+        return;
+
+    /* deal with MSI-X MMIO page */
+    msix_mmio_map(pci_dev, region_num, e_phys, e_size, type);
+    /* Only register as much memory as required to cover the
+     * actual device region. */
+    e_size = r_dev->real_device.regions[region_num].size;
+    ret = kvm_register_phys_mem(kvm_context, e_phys,
+                                region->u.r_virtbase,
+                                TARGET_PAGE_ALIGN(e_size), 0);
 
     if (ret != 0) {
 	fprintf(stderr, "%s: Error: create new mapping failed\n", __func__);
@@ -378,11 +368,16 @@ static int assigned_dev_register_regions(PCIRegion *io_regions,
 
         /* handle memory io regions */
         if (cur_region->type & IORESOURCE_MEM) {
+            uint32_t size = i == msix_bar_nr(&pci_dev->dev)
+                ? pci_dev->msix_bar_size : cur_region->size;
+
             int t = cur_region->type & IORESOURCE_PREFETCH
                 ? PCI_ADDRESS_SPACE_MEM_PREFETCH
                 : PCI_ADDRESS_SPACE_MEM;
 
             /* map physical memory */
+            /* MSI-X table is located outside cur_region->size
+             * and so won't be mapped */
             pci_dev->v_addrs[i].e_physbase = cur_region->base_addr;
             pci_dev->v_addrs[i].u.r_virtbase =
                 mmap(NULL,
@@ -397,7 +392,7 @@ static int assigned_dev_register_regions(PCIRegion *io_regions,
                         (uint32_t) (cur_region->base_addr));
                 return -1;
             }
-            pci_dev->v_addrs[i].r_size = cur_region->size;
+            pci_dev->v_addrs[i].r_size = size;
             pci_dev->v_addrs[i].e_size = 0;
 
             /* add offset */
@@ -405,8 +400,7 @@ static int assigned_dev_register_regions(PCIRegion *io_regions,
                 (cur_region->base_addr & 0xFFF);
 
             pci_register_io_region((PCIDevice *) pci_dev, i,
-                                   cur_region->size, t,
-                                   assigned_dev_iomem_map);
+                                   size, t, assigned_dev_iomem_map);
             continue;
         }
         /* handle port io regions */
@@ -542,11 +536,11 @@ static void free_dev_irq_entries(AssignedDevice *dev)
 {
     int i;
 
-    for (i = 0; i < dev->irq_entries_nr; i++)
-        kvm_del_routing_entry(kvm_context, &dev->entry[i]);
-    free(dev->entry);
-    dev->entry = NULL;
-    dev->irq_entries_nr = 0;
+    for (i = 0; i < dev->msi_irq_entries_nr; i++)
+        kvm_del_routing_entry(kvm_context, &dev->msi_entry[i]);
+    free(dev->msi_entry);
+    dev->msi_entry = NULL;
+    dev->msi_irq_entries_nr = 0;
 }
 #endif
 
@@ -764,33 +758,33 @@ static void assigned_dev_update_msi(PCIDevice *pci_dev, unsigned int ctrl_pos)
     }
 
     if (ctrl_byte & PCI_MSI_FLAGS_ENABLE) {
-        assigned_dev->entry = calloc(1, sizeof(struct kvm_irq_routing_entry));
-        if (!assigned_dev->entry) {
+        assigned_dev->msi_entry = calloc(1, sizeof(struct kvm_irq_routing_entry));
+        if (!assigned_dev->msi_entry) {
             perror("assigned_dev_update_msi: ");
             return;
         }
-        assigned_dev->entry->u.msi.address_lo =
+        assigned_dev->msi_entry->u.msi.address_lo =
                 *(uint32_t *)(pci_dev->config + pci_dev->cap.start +
                               PCI_MSI_ADDRESS_LO);
-        assigned_dev->entry->u.msi.address_hi = 0;
-        assigned_dev->entry->u.msi.data = *(uint16_t *)(pci_dev->config +
+        assigned_dev->msi_entry->u.msi.address_hi = 0;
+        assigned_dev->msi_entry->u.msi.data = *(uint16_t *)(pci_dev->config +
                 pci_dev->cap.start + PCI_MSI_DATA_32);
-        assigned_dev->entry->type = KVM_IRQ_ROUTING_MSI;
-        assigned_dev->entry->gsi = kvm_get_irq_route_gsi(kvm_context);
-        if (assigned_dev->entry->gsi < 0) {
+        assigned_dev->msi_entry->type = KVM_IRQ_ROUTING_MSI;
+        assigned_dev->msi_entry->gsi = kvm_get_irq_route_gsi(kvm_context);
+        if (assigned_dev->msi_entry->gsi < 0) {
             perror("assigned_dev_update_msi: kvm_get_irq_route_gsi");
             return;
         }
 
-        kvm_add_routing_entry(kvm_context, assigned_dev->entry);
+        kvm_add_routing_entry(kvm_context, assigned_dev->msi_entry);
         if (kvm_commit_irq_routes(kvm_context) < 0) {
             perror("assigned_dev_update_msi: kvm_commit_irq_routes");
             assigned_dev->cap.state &= ~ASSIGNED_DEVICE_MSI_ENABLED;
             return;
         }
-	assigned_dev->irq_entries_nr = 1;
+	assigned_dev->msi_irq_entries_nr = 1;
 
-        assigned_irq_data.guest_irq = assigned_dev->entry->gsi;
+        assigned_irq_data.guest_irq = assigned_dev->msi_entry->gsi;
 	assigned_irq_data.flags = KVM_DEV_IRQ_HOST_MSI | KVM_DEV_IRQ_GUEST_MSI;
         if (kvm_assign_irq(kvm_context, &assigned_irq_data) < 0)
             perror("assigned_dev_enable_msi: assign irq");
@@ -804,39 +798,17 @@ static void assigned_dev_update_msi(PCIDevice *pci_dev, unsigned int ctrl_pos)
 static int assigned_dev_update_msix_mmio(PCIDevice *pci_dev)
 {
     AssignedDevice *adev = container_of(pci_dev, AssignedDevice, dev);
-    u16 entries_nr = 0, entries_max_nr;
-    int pos = 0, i, r = 0;
-    u32 msg_addr, msg_upper_addr, msg_data, msg_ctrl;
+    int i, r = 0, n = 0;
     struct kvm_assigned_msix_nr msix_nr;
     struct kvm_assigned_msix_entry msix_entry;
-    void *va = adev->msix_table_page;
-
-    if (adev->cap.available & ASSIGNED_DEVICE_CAP_MSI)
-        pos = pci_dev->cap.start + PCI_CAPABILITY_CONFIG_MSI_LENGTH;
-    else
-        pos = pci_dev->cap.start;
-
-    entries_max_nr = pci_dev->config[pos + 2];
-    entries_max_nr &= PCI_MSIX_TABSIZE;
-    entries_max_nr += 1;
-
-    /* Get the usable entry number for allocating */
-    for (i = 0; i < entries_max_nr; i++) {
-        memcpy(&msg_ctrl, va + i * 16 + 12, 4);
-        memcpy(&msg_data, va + i * 16 + 8, 4);
-        /* Ignore unused entry even it's unmasked */
-        if (msg_data == 0)
-            continue;
-        entries_nr ++;
-    }
 
-    if (entries_nr == 0) {
-        fprintf(stderr, "MSI-X entry number is zero!\n");
-        return -EINVAL;
-    }
     msix_nr.assigned_dev_id = calc_assigned_dev_id(adev->h_busnr,
                                           (uint8_t)adev->h_devfn);
-    msix_nr.entry_nr = entries_nr;
+    msix_nr.entry_nr = 0;
+    for (i = 0; i < pci_dev->msix_irq_entries_nr; ++i)
+        if (msix_vector_is_used(pci_dev, i))
+            ++msix_nr.entry_nr;
+
     r = kvm_assign_set_msix_nr(kvm_context, &msix_nr);
     if (r != 0) {
         fprintf(stderr, "fail to set MSI-X entry number for MSIX! %s\n",
@@ -844,67 +816,29 @@ static int assigned_dev_update_msix_mmio(PCIDevice *pci_dev)
         return r;
     }
 
-    free_dev_irq_entries(adev);
-    adev->irq_entries_nr = entries_nr;
-    adev->entry = calloc(entries_nr, sizeof(struct kvm_irq_routing_entry));
-    if (!adev->entry) {
-        perror("assigned_dev_update_msix_mmio: ");
-        return -errno;
-    }
-
     msix_entry.assigned_dev_id = msix_nr.assigned_dev_id;
-    entries_nr = 0;
-    for (i = 0; i < entries_max_nr; i++) {
-        if (entries_nr >= msix_nr.entry_nr)
-            break;
-        memcpy(&msg_ctrl, va + i * 16 + 12, 4);
-        if (msg_ctrl & 0x1)
+    for (i = 0; i < pci_dev->msix_irq_entries_nr; ++i) {
+        if (!msix_vector_is_used(pci_dev, i))
             continue;
-        memcpy(&msg_data, va + i * 16 + 8, 4);
-        if (msg_data == 0)
-            continue;
-
-        memcpy(&msg_addr, va + i * 16, 4);
-        memcpy(&msg_upper_addr, va + i * 16 + 4, 4);
-
-        r = kvm_get_irq_route_gsi(kvm_context);
-        if (r < 0)
-            return r;
-
-        adev->entry[entries_nr].gsi = r;
-        adev->entry[entries_nr].type = KVM_IRQ_ROUTING_MSI;
-        adev->entry[entries_nr].flags = 0;
-        adev->entry[entries_nr].u.msi.address_lo = msg_addr;
-        adev->entry[entries_nr].u.msi.address_hi = msg_upper_addr;
-        adev->entry[entries_nr].u.msi.data = msg_data;
-        DEBUG("MSI-X data 0x%x, MSI-X addr_lo 0x%x\n!", msg_data, msg_addr);
-	kvm_add_routing_entry(kvm_context, &adev->entry[entries_nr]);
-
-        msix_entry.gsi = adev->entry[entries_nr].gsi;
-        msix_entry.entry = i;
+        msix_entry.gsi = pci_dev->msix_irq_entries[i].gsi;
+        msix_entry.entry = n++;
         r = kvm_assign_set_msix_entry(kvm_context, &msix_entry);
         if (r) {
-            fprintf(stderr, "fail to set MSI-X entry! %s\n", strerror(-r));
+            fprintf(stderr, "failed to set MSI-X entry! %s\n", strerror(-r));
             break;
         }
         DEBUG("MSI-X entry gsi 0x%x, entry %d\n!",
                 msix_entry.gsi, msix_entry.entry);
-        entries_nr ++;
-    }
-
-    if (r == 0 && kvm_commit_irq_routes(kvm_context) < 0) {
-	    perror("assigned_dev_update_msix_mmio: kvm_commit_irq_routes");
-	    return -EINVAL;
     }
 
     return r;
 }
 
-static void assigned_dev_update_msix(PCIDevice *pci_dev, unsigned int ctrl_pos)
+static void assigned_dev_update_msix(PCIDevice *pci_dev,
+                                     uint32_t address, uint32_t val, int len)
 {
     struct kvm_assigned_irq assigned_irq_data;
     AssignedDevice *assigned_dev = container_of(pci_dev, AssignedDevice, dev);
-    uint16_t *ctrl_word = (uint16_t *)(pci_dev->config + ctrl_pos);
     int r;
 
     memset(&assigned_irq_data, 0, sizeof assigned_irq_data);
@@ -914,15 +848,17 @@ static void assigned_dev_update_msix(PCIDevice *pci_dev, unsigned int ctrl_pos)
 
     if (assigned_dev->irq_requested_type) {
         assigned_irq_data.flags = assigned_dev->irq_requested_type;
-        free_dev_irq_entries(assigned_dev);
         r = kvm_deassign_irq(kvm_context, &assigned_irq_data);
         /* -ENXIO means no assigned irq */
         if (r && r != -ENXIO)
             perror("assigned_dev_update_msix: deassign irq");
     }
+
+    msix_write_config(pci_dev, address, val, len);
+
     assigned_irq_data.flags = KVM_DEV_IRQ_HOST_MSIX | KVM_DEV_IRQ_GUEST_MSIX;
 
-    if (*ctrl_word & PCI_MSIX_ENABLE) {
+    if (msix_enabled(pci_dev)) {
         if (assigned_dev_update_msix_mmio(pci_dev) < 0) {
             perror("assigned_dev_update_msix_mmio");
             return;
@@ -955,12 +891,11 @@ static void assigned_device_pci_cap_write_config(PCIDevice *pci_dev, uint32_t ad
 #endif
 #ifdef KVM_CAP_DEVICE_MSIX
     if (assigned_dev->cap.available & ASSIGNED_DEVICE_CAP_MSIX) {
-        ctrl_pos = pos + 3;
+        ctrl_pos = pci_dev->cap.msix + PCI_CAP_FLAGS + 1;
         if (address <= ctrl_pos && address + len > ctrl_pos) {
             ctrl_pos--; /* control is word long */
-            assigned_dev_update_msix(pci_dev, ctrl_pos);
+            assigned_dev_update_msix(pci_dev, address, val, len);
 	}
-        pos += PCI_CAPABILITY_CONFIG_MSIX_LENGTH;
     }
 #endif
 #endif
@@ -971,130 +906,29 @@ static int assigned_device_pci_cap_init(PCIDevice *pci_dev)
 {
     AssignedDevice *dev = container_of(pci_dev, AssignedDevice, dev);
     PCIRegion *pci_region = dev->real_device.regions;
-    int next_cap_pt = 0;
-
-    pci_dev->cap.length = 0;
-#ifdef KVM_CAP_IRQ_ROUTING
-#ifdef KVM_CAP_DEVICE_MSI
-    /* Expose MSI capability
-     * MSI capability is the 1st capability in capability config */
-    if (pci_find_cap_offset(dev->pdev, PCI_CAP_ID_MSI)) {
-        dev->cap.available |= ASSIGNED_DEVICE_CAP_MSI;
-        memset(&pci_dev->config[pci_dev->cap.start + pci_dev->cap.length],
-               0, PCI_CAPABILITY_CONFIG_MSI_LENGTH);
-        pci_dev->config[pci_dev->cap.start + pci_dev->cap.length] =
-                        PCI_CAP_ID_MSI;
-        pci_dev->cap.length += PCI_CAPABILITY_CONFIG_MSI_LENGTH;
-        next_cap_pt = 1;
-    }
-#endif
-#ifdef KVM_CAP_DEVICE_MSIX
-    /* Expose MSI-X capability */
-    if (pci_find_cap_offset(dev->pdev, PCI_CAP_ID_MSIX)) {
-        int pos, entry_nr, bar_nr;
-        u32 msix_table_entry;
-        dev->cap.available |= ASSIGNED_DEVICE_CAP_MSIX;
-        memset(&pci_dev->config[pci_dev->cap.start + pci_dev->cap.length],
-               0, PCI_CAPABILITY_CONFIG_MSIX_LENGTH);
-        pos = pci_find_cap_offset(dev->pdev, PCI_CAP_ID_MSIX);
-        entry_nr = pci_read_word(dev->pdev, pos + 2) & PCI_MSIX_TABSIZE;
-        pci_dev->config[pci_dev->cap.start + pci_dev->cap.length] = 0x11;
-        pci_dev->config[pci_dev->cap.start +
-                        pci_dev->cap.length + 2] = entry_nr;
-        msix_table_entry = pci_read_long(dev->pdev, pos + PCI_MSIX_TABLE);
-        *(uint32_t *)(pci_dev->config + pci_dev->cap.start +
-                      pci_dev->cap.length + PCI_MSIX_TABLE) = msix_table_entry;
-        *(uint32_t *)(pci_dev->config + pci_dev->cap.start +
-                      pci_dev->cap.length + PCI_MSIX_PBA) =
-                    pci_read_long(dev->pdev, pos + PCI_MSIX_PBA);
-        bar_nr = msix_table_entry & PCI_MSIX_BIR;
-        msix_table_entry &= ~PCI_MSIX_BIR;
-        dev->msix_table_addr = pci_region[bar_nr].base_addr + msix_table_entry;
-        if (next_cap_pt != 0) {
-            pci_dev->config[pci_dev->cap.start + next_cap_pt] =
-                pci_dev->cap.start + pci_dev->cap.length;
-            next_cap_pt += PCI_CAPABILITY_CONFIG_MSI_LENGTH;
-        } else
-            next_cap_pt = 1;
-        pci_dev->cap.length += PCI_CAPABILITY_CONFIG_MSIX_LENGTH;
-    }
-#endif
-#endif
-
-    return 0;
-}
+    int pos;
 
-static uint32_t msix_mmio_readl(void *opaque, target_phys_addr_t addr)
-{
-    AssignedDevice *adev = opaque;
-    unsigned int offset = addr & 0xfff;
-    void *page = adev->msix_table_page;
-    uint32_t val = 0;
+    if (pci_find_cap_offset(dev->pdev, PCI_CAP_ID_MSI))
+        pci_add_capability(pci_dev, PCI_CAP_ID_MSI,
+                           PCI_CAPABILITY_CONFIG_MSI_LENGTH);
 
-    memcpy(&val, (void *)((char *)page + offset), 4);
+    if ((pos = pci_find_cap_offset(dev->pdev, PCI_CAP_ID_MSIX))) {
+        int entry_nr = pci_read_word(dev->pdev, pos + PCI_CAP_FLAGS) &
+                       PCI_MSIX_TABSIZE;
+        u32 msix_table = pci_read_long(dev->pdev, pos + PCI_MSIX_TABLE);
+        int r, bar_nr = msix_table & PCI_MSIX_BIR;
 
-    return val;
-}
-
-static uint32_t msix_mmio_readb(void *opaque, target_phys_addr_t addr)
-{
-    return ((msix_mmio_readl(opaque, addr & ~3)) >>
-            (8 * (addr & 3))) & 0xff;
-}
-
-static uint32_t msix_mmio_readw(void *opaque, target_phys_addr_t addr)
-{
-    return ((msix_mmio_readl(opaque, addr & ~3)) >>
-            (8 * (addr & 3))) & 0xffff;
-}
-
-static void msix_mmio_writel(void *opaque,
-                             target_phys_addr_t addr, uint32_t val)
-{
-    AssignedDevice *adev = opaque;
-    unsigned int offset = addr & 0xfff;
-    void *page = adev->msix_table_page;
-
-    DEBUG("write to MSI-X entry table mmio offset 0x%lx, val 0x%lx\n",
-		    addr, val);
-    memcpy((void *)((char *)page + offset), &val, 4);
-}
-
-static void msix_mmio_writew(void *opaque,
-                             target_phys_addr_t addr, uint32_t val)
-{
-    msix_mmio_writel(opaque, addr & ~3,
-                     (val & 0xffff) << (8*(addr & 3)));
-}
-
-static void msix_mmio_writeb(void *opaque,
-                             target_phys_addr_t addr, uint32_t val)
-{
-    msix_mmio_writel(opaque, addr & ~3,
-                     (val & 0xff) << (8*(addr & 3)));
-}
-
-static CPUWriteMemoryFunc *msix_mmio_write[] = {
-    msix_mmio_writeb,	msix_mmio_writew,	msix_mmio_writel
-};
-
-static CPUReadMemoryFunc *msix_mmio_read[] = {
-    msix_mmio_readb,	msix_mmio_readw,	msix_mmio_readl
-};
-
-static int assigned_dev_register_msix_mmio(AssignedDevice *dev)
-{
-    dev->msix_table_page = mmap(NULL, 0x1000,
-                                PROT_READ|PROT_WRITE,
-                                MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
-    if (dev->msix_table_page == MAP_FAILED) {
-        fprintf(stderr, "fail allocate msix_table_page! %s\n",
-                strerror(errno));
-        return -EFAULT;
+        r = msix_init(pci_dev, entry_nr + 1, bar_nr,
+                      pci_region[bar_nr].size, &dev->msix_bar_size);
+        /* On error, recover by not enabling MSI-X */
+        if (r < 0)
+            fprintf(stderr, "Can't enable MSI-X: %d\n", r);
+        else {
+            pci_dev->msix_hack = 1;
+            dev->cap.available |= ASSIGNED_DEVICE_CAP_MSIX;
+        }
     }
-    memset(dev->msix_table_page, 0, 0x1000);
-    dev->mmio_index = cpu_register_io_memory(0,
-                        msix_mmio_read, msix_mmio_write, dev);
+
     return 0;
 }
 
@@ -1128,12 +962,6 @@ struct PCIDevice *init_assigned_device(AssignedDevInfo *adev, PCIBus *bus)
         goto out;
     }
 
-    /* handle real device's MMIO/PIO BARs */
-    if (assigned_dev_register_regions(dev->real_device.regions,
-                                      dev->real_device.region_number,
-                                      dev))
-        goto out;
-
     /* handle interrupt routing */
     e_device = (dev->dev.devfn >> 3) & 0x1f;
     e_intx = dev->dev.config[0x3d] - 1;
@@ -1147,10 +975,17 @@ struct PCIDevice *init_assigned_device(AssignedDevInfo *adev, PCIBus *bus)
     pci_init(pacc);
     dev->pdev = pci_get_dev(pacc, 0, adev->bus, adev->dev, adev->func);
 
-    if (pci_enable_capability_support(pci_dev, 0, NULL,
+    if (pci_enable_capability_support(pci_dev, NULL,
                     assigned_device_pci_cap_write_config,
                     assigned_device_pci_cap_init) < 0)
-        goto assigned_out;
+        goto out;
+
+
+    /* handle real device's MMIO/PIO BARs */
+    if (assigned_dev_register_regions(dev->real_device.regions,
+                                      dev->real_device.region_number,
+                                      dev))
+        goto out;
 
     /* assign device to guest */
     r = assign_device(adev);
@@ -1162,11 +997,6 @@ struct PCIDevice *init_assigned_device(AssignedDevInfo *adev, PCIBus *bus)
     if (r < 0)
         goto assigned_out;
 
-    /* intercept MSI-X entry page in the MMIO */
-    if (dev->cap.available & ASSIGNED_DEVICE_CAP_MSIX)
-        if (assigned_dev_register_msix_mmio(dev))
-            return NULL;
-
     return &dev->dev;
 
 assigned_out:
diff --git a/hw/device-assignment.h b/hw/device-assignment.h
index c691e11..7eb6238 100644
--- a/hw/device-assignment.h
+++ b/hw/device-assignment.h
@@ -91,12 +91,10 @@ typedef struct {
 #define ASSIGNED_DEVICE_MSIX_MASKED (1 << 2)
         uint32_t state;
     } cap;
-    int irq_entries_nr;
-    struct kvm_irq_routing_entry *entry;
-    void *msix_table_page;
-    target_phys_addr_t msix_table_addr;
-    int mmio_index;
+    int msi_irq_entries_nr;
+    struct kvm_irq_routing_entry *msi_entry;
     int need_emulate_cmd;
+    uint32_t msix_bar_size;
 } AssignedDevice;
 
 typedef struct AssignedDevInfo AssignedDevInfo;
diff --git a/hw/msix.c b/hw/msix.c
index dcb7dbd..4f833c5 100644
--- a/hw/msix.c
+++ b/hw/msix.c
@@ -127,7 +127,7 @@ void msix_write_config(PCIDevice *dev, uint32_t addr,
     /* MSI enable bit is in byte 1 in FLAGS register */
     unsigned flags_pos = dev->cap.msix + PCI_CAP_FLAGS + 1;
     uint8_t orig, mask = PCI_MSIX_FLAGS_ENABLE >> 8;
-    int i, enabled;
+    int i, changed = 0, enabled;
 
     /* Slow but simple */
     for (i = addr; i < addr + len; val >>= 8, ++i) {
@@ -136,8 +136,17 @@ void msix_write_config(PCIDevice *dev, uint32_t addr,
         orig = dev->config[i];
         enabled = val & mask;
         dev->config[i] = (orig & ~mask) | enabled;
+        changed = orig ^ dev->config[i];
         break;
     }
+
+    if (changed && dev->msix_hack) {
+        if (enabled)
+            msix_enable(dev);
+        else
+            msix_free_irq_entries(dev);
+        kvm_commit_irq_routes(kvm_context);
+    }
 }
 
 static uint32_t msix_mmio_readl(void *opaque, target_phys_addr_t addr)
diff --git a/hw/pci.h b/hw/pci.h
index cd88564..935d194 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -201,6 +201,10 @@ struct PCIDevice {
     int msix_mmio_index;
     /* Reference-count for entries actually in use by driver. */
     unsigned *msix_entry_used;
+    /* For some devices, there's no easy way to get MSI-X usage data from the
+     * guest. As a hack, we can look at vector control and message data fields,
+     * and assume that all unmasked vectors with data != 0 are used. */
+    int msix_hack;
 };
 
 PCIDevice *pci_register_device(PCIBus *bus, const char *name,
-- 
1.6.3.rc3.1.g830204
