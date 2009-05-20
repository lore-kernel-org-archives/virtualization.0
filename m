From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2-RFC 1/2] qemu-kvm: add MSI-X support
Date: Wed, 20 May 2009 15:49:49 +0300
Message-ID: <20090520124949.GB12583__30896.8576523059$1242823989$gmane$org@redhat.com>
References: <cover.1242823256.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1242823256.git.mst@redhat.com>
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

This adds MSI-X support infrastructure and uses that to enable MSI-X
support in virtio net device. Also add a global option to disable MSI-X.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile.target        |    2 +-
 hw/device-assignment.c |    2 +
 hw/msix.c              |  447 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/msix.h              |   38 ++++
 hw/pci.c               |  135 +++++++++++----
 hw/pci.h               |   68 +++++++-
 hw/virtio-balloon.c    |    2 +-
 hw/virtio-blk.c        |    3 +-
 hw/virtio-console.c    |    3 +-
 hw/virtio-net.c        |    3 +-
 hw/virtio.c            |  206 ++++++++++++++++++----
 hw/virtio.h            |    6 +-
 qemu-options.hx        |    2 +
 vl.c                   |    3 +
 14 files changed, 838 insertions(+), 82 deletions(-)
 create mode 100644 hw/msix.c
 create mode 100644 hw/msix.h

diff --git a/Makefile.target b/Makefile.target
index 979c07f..e049550 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -542,7 +542,7 @@ endif #CONFIG_BSD_USER
 ifndef CONFIG_USER_ONLY
 
 OBJS=vl.o osdep.o monitor.o pci.o loader.o isa_mmio.o machine.o dma-helpers.o \
-     gdbstub.o gdbstub-xml.o
+     gdbstub.o gdbstub-xml.o msix.o
 # virtio has to be here due to weird dependency between PCI and virtio-net.
 # need to fix this properly
 OBJS+=virtio.o virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o
diff --git a/hw/device-assignment.c b/hw/device-assignment.c
index 624d15a..4806112 100644
--- a/hw/device-assignment.c
+++ b/hw/device-assignment.c
@@ -1151,6 +1151,8 @@ struct PCIDevice *init_assigned_device(AssignedDevInfo *adev, PCIBus *bus)
                     assigned_device_pci_cap_init) < 0)
         goto assigned_out;
 
+    pci_dev->config[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
+
     /* assign device to guest */
     r = assign_device(adev);
     if (r < 0)
diff --git a/hw/msix.c b/hw/msix.c
new file mode 100644
index 0000000..323eabc
--- /dev/null
+++ b/hw/msix.c
@@ -0,0 +1,447 @@
+/*
+ * MSI-X device support
+ *
+ * This module includes support for MSI-X in pci devices.
+ *
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ *
+ *  Copyright (c) 2009, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "hw.h"
+#include "msix.h"
+#include "pci.h"
+#include <qemu-kvm.h>
+
+/* Declaration from linux/pci_regs.h */
+#define  PCI_CAP_ID_MSIX 0x11 /* MSI-X */
+#define  PCI_MSIX_FLAGS 2     /* Table at lower 11 bits */
+#define  PCI_MSIX_FLAGS_QSIZE	0x7FF
+#define  PCI_MSIX_FLAGS_ENABLE	(1 << 15)
+#define  PCI_MSIX_FLAGS_BIRMASK	(7 << 0)
+
+/* MSI-X capability structure */
+#define MSIX_TABLE_OFFSET 4
+#define MSIX_PBA_OFFSET 8
+
+/* MSI-X table format */
+#define MSIX_MSG_ADDR 0
+#define MSIX_MSG_UPPER_ADDR 4
+#define MSIX_MSG_DATA 8
+#define MSIX_VECTOR_CTRL 12
+#define MSIX_ENTRY_SIZE 16
+#define MSIX_VECTOR_MASK 0x1
+
+/* How much space does an MSIX table need. */
+/* The spec requires giving the table structure
+ * a 4K aligned region all by itself. Align it to
+ * target pages so that drivers can do passthrough
+ * on the rest of the region. */
+#define MSIX_PAGE_SIZE TARGET_PAGE_ALIGN(0x1000)
+
+#ifdef MSIX_DEBUG
+#define DEBUG(fmt, ...)                                       \
+    do {                                                      \
+      fprintf(stderr, "%s: " fmt, __func__ , __VA_ARGS__);    \
+    } while (0)
+#else
+#define DEBUG(fmt, ...) do { } while(0)
+#endif
+
+/* Flag to globally disable MSI-X support */
+int msix_disable;
+
+/* Add MSI-X capability to the config space for the device. */
+/* Given a bar and its size, add MSI-X table on top of it
+ * and fill MSI-X capability in the config space.
+ * Original bar size must be a power of 2 or 0.
+ * New bar size is returned. */
+static int msix_add_config(struct PCIDevice *pdev, unsigned short nentries,
+                           unsigned bar_nr, unsigned bar_size)
+{
+    unsigned config_offset = pdev->cap.start + pdev->cap.length;
+    uint8_t *config = pdev->config + config_offset;
+    uint32_t new_size;
+
+    if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1)
+        return -EINVAL;
+    if (bar_size > 0x80000000)
+        return -ENOSPC;
+
+    /* Add space for MSI-X structures */
+    if (!bar_size)
+        new_size = MSIX_PAGE_SIZE;
+    else if (bar_size < MSIX_PAGE_SIZE) {
+        bar_size = MSIX_PAGE_SIZE;
+        new_size = MSIX_PAGE_SIZE * 2;
+    } else
+        new_size = bar_size * 2;
+
+    pdev->msix_bar_size = new_size;
+
+    pci_set_word(config + PCI_MSIX_FLAGS, nentries - 1);
+    /* Table on top of BAR */
+    pci_set_long(config + MSIX_TABLE_OFFSET, bar_size | bar_nr);
+    /* Pending bits on top of that */
+    pci_set_long(config + MSIX_PBA_OFFSET, (bar_size + MSIX_PAGE_SIZE / 2) |
+                 bar_nr);
+    pdev->cap.msix = config_offset;
+    return 0;
+}
+
+static void msix_free_irq_entries(PCIDevice *dev)
+{
+    int vector, changed = 0;
+
+    /* TODO: handle errors */
+    for (vector = 0; vector < dev->msix_irq_entries_nr; ++vector)
+        if (dev->msix_entry_used[vector]) {
+            kvm_del_routing_entry(kvm_context, &dev->msix_irq_entries[vector]);
+            dev->msix_entry_used[vector] = 0;
+            changed = 1;
+        }
+    if (changed)
+        kvm_commit_irq_routes(kvm_context);
+}
+
+static void msix_enable(PCIDevice *dev)
+{
+    uint32_t ctrl, data;
+    int i;
+
+    if (!dev->msix_irq_entries_nr) {
+        fprintf(stderr, "MSI-X entry number is zero!\n");
+        return;
+    }
+
+    for (i = 0; i < dev->msix_irq_entries_nr; ++i) {
+        uint8_t *table_entry = dev->msix_table_page + i * MSIX_ENTRY_SIZE;
+
+        data = pci_get_long(table_entry + MSIX_MSG_DATA);
+        if (!data)
+            msix_vector_unuse(dev, i);
+        else
+            msix_vector_use(dev, i);
+    }
+}
+
+/* Handle MSI-X capability config write. */
+void msix_write_config(PCIDevice *dev, uint32_t addr,
+                       uint32_t val, int len)
+{
+    /* MSI enable bit is in byte 1 in FLAGS register */
+    unsigned flags_pos = dev->cap.msix + PCI_CAP_FLAGS + 1;
+    uint8_t orig, mask = PCI_MSIX_FLAGS_ENABLE >> 8;
+    int i, changed = 0, enabled;
+
+    /* Slow but simple */
+    for (i = addr; i < addr + len; val >>= 8, ++i) {
+        if (i != flags_pos)
+            continue;
+        orig = dev->config[i];
+        enabled = val & mask;
+        dev->config[i] = (orig & ~mask) | enabled;
+        changed = orig ^ dev->config[i];
+        break;
+    }
+    if (changed && !enabled)
+        qemu_set_irq(dev->irq[0], 0);
+}
+
+static uint32_t msix_mmio_readl(void *opaque, target_phys_addr_t addr)
+{
+    PCIDevice *dev = opaque;
+    unsigned int offset = addr & (MSIX_PAGE_SIZE - 1);
+    void *page = dev->msix_table_page;
+    uint32_t val = 0;
+
+    memcpy(&val, (void *)((char *)page + offset), 4);
+
+    return val;
+}
+
+static uint32_t msix_mmio_read_unallowed(void *opaque, target_phys_addr_t addr)
+{
+    fprintf(stderr, "MSI-X: only dword read is allowed!\n");
+    return 0;
+}
+
+static void msix_mmio_writel(void *opaque, target_phys_addr_t addr,
+                             uint32_t val)
+{
+    PCIDevice *dev = opaque;
+    unsigned int offset = addr & (MSIX_PAGE_SIZE - 1);
+    void *page = dev->msix_table_page;
+    /* TODO: handle vector masking / pending bits here. */
+
+    memcpy((void *)((char *)page + offset), &val, 4);
+}
+
+static void msix_mmio_write_unallowed(void *opaque, target_phys_addr_t addr,
+                                      uint32_t val)
+{
+    fprintf(stderr, "MSI-X: only dword write is allowed!\n");
+}
+
+static CPUWriteMemoryFunc *msix_mmio_write[] = {
+    msix_mmio_write_unallowed, msix_mmio_write_unallowed, msix_mmio_writel
+};
+
+static CPUReadMemoryFunc *msix_mmio_read[] = {
+    msix_mmio_read_unallowed, msix_mmio_read_unallowed, msix_mmio_readl
+};
+
+/* Should be called from device's map method. */
+void msix_mmio_map(PCIDevice *d, int region_num,
+                   uint32_t addr, uint32_t size, int type)
+{
+    uint8_t *config = d->config + d->cap.msix;
+    uint32_t table = pci_get_long(config + MSIX_TABLE_OFFSET);
+    uint32_t offset = table & ~(MSIX_PAGE_SIZE - 1);
+    /* TODO: map pending bits separately in case they are in a separate bar */
+    int table_bir = table & PCI_MSIX_FLAGS_BIRMASK;
+
+    if (table_bir != region_num)
+        return;
+    if (size <= offset)
+        return;
+    cpu_register_physical_memory(addr + offset, size - offset,
+                                 d->msix_mmio_index);
+}
+
+/* Initialize the MSI-X structures. Note: if MSI-X is supported, BAR size is
+ * modified, it should be retrieved with msix_bar_size. */
+int msix_init(struct PCIDevice *dev, unsigned short nentries,
+              unsigned bar_nr, unsigned bar_size)
+{
+    int ret = msix_add_config(dev, nentries, bar_nr, bar_size);
+    if (ret)
+        return ret;
+
+    dev->msix_irq_entries = qemu_malloc(nentries *
+                                        sizeof *dev->msix_irq_entries);
+    if (!dev->msix_irq_entries)
+        goto err_entries;
+
+    dev->msix_entry_used = qemu_mallocz(nentries *
+                                        sizeof *dev->msix_entry_used);
+    if (!dev->msix_entry_used)
+        goto err_used;
+
+    dev->msix_table_page = qemu_mallocz(MSIX_PAGE_SIZE);
+    if (!dev->msix_table_page)
+        goto err_page;
+
+    dev->msix_mmio_index = cpu_register_io_memory(0, msix_mmio_read,
+                                                  msix_mmio_write, dev);
+    if (dev->msix_mmio_index == -1) {
+        ret = -EBUSY;
+        goto err_index;
+    }
+
+    dev->msix_irq_entries_nr = nentries;
+    dev->cap_supported |= QEMU_PCI_CAP_MSIX;
+    if (msix_disable)
+        return 0;
+    pci_add_capability(dev, PCI_CAP_ID_MSIX,
+                       PCI_CAPABILITY_CONFIG_MSIX_LENGTH);
+    dev->cap_present |= QEMU_PCI_CAP_MSIX;
+    return 0;
+
+err_index:
+    qemu_free(dev->msix_table_page);
+    dev->msix_table_page = NULL;
+err_page:
+    qemu_free(dev->msix_entry_used);
+    dev->msix_entry_used = NULL;
+err_used:
+    qemu_free(dev->msix_irq_entries);
+    dev->msix_irq_entries = NULL;
+err_entries:
+    pci_del_capability(dev, PCI_CAP_ID_MSIX, PCI_CAPABILITY_CONFIG_MSIX_LENGTH);
+    dev->cap.msix = 0;
+    return ret;
+}
+
+/* Clean up resources for the device. */
+void msix_uninit(PCIDevice *dev)
+{
+    if (!(dev->cap_supported & QEMU_PCI_CAP_MSIX))
+        return;
+    msix_free_irq_entries(dev);
+    dev->msix_irq_entries_nr = 0;
+    cpu_unregister_io_memory(dev->msix_mmio_index);
+    qemu_free(dev->msix_table_page);
+    dev->msix_table_page = NULL;
+    qemu_free(dev->msix_entry_used);
+    dev->msix_entry_used = NULL;
+    qemu_free(dev->msix_irq_entries);
+    dev->msix_irq_entries = NULL;
+    pci_del_capability(dev, PCI_CAP_ID_MSIX, PCI_CAPABILITY_CONFIG_MSIX_LENGTH);
+    dev->cap.msix = 0;
+    dev->cap_present &= ~QEMU_PCI_CAP_MSIX;
+    dev->cap_supported &= ~QEMU_PCI_CAP_MSIX;
+    return;
+}
+
+void msix_save(PCIDevice *dev, QEMUFile *f)
+{
+    unsigned nentries = (pci_get_word(dev->config + PCI_MSIX_FLAGS) &
+                         PCI_MSIX_FLAGS_QSIZE) + 1;
+    qemu_put_buffer(f, dev->msix_table_page, nentries * MSIX_ENTRY_SIZE);
+    qemu_put_buffer(f, dev->msix_table_page + MSIX_PAGE_SIZE / 2,
+                    (nentries + 63) / 64);
+}
+
+/* Should be called after restoring the config space. */
+int msix_load(PCIDevice *dev, QEMUFile *f)
+{
+    uint8_t offset = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+    unsigned nentries;
+
+    if (!!(dev->cap_present & QEMU_PCI_CAP_MSIX) == !!offset) {
+        fprintf(stderr, "MSI-X bit set but no capability is present\n");
+        return -EINVAL;
+    }
+
+    if (!dev->cap_present & QEMU_PCI_CAP_MSIX)
+        return 0;
+
+    /* Some sanity checks: we probably could add more of these. */
+    if (dev->cap.msix != offset) {
+        fprintf(stderr, "MSI-X capability moved from offset 0x%x to 0x%x\n",
+                dev->cap.msix, offset);
+        return -EINVAL;
+    }
+
+    nentries = (pci_get_word(dev->config + PCI_MSIX_FLAGS) &
+                PCI_MSIX_FLAGS_QSIZE) + 1;
+    if (nentries > dev->msix_irq_entries_nr) {
+        fprintf(stderr, "msix_load: nentries mismatch: %d > %d\n",
+                nentries, dev->msix_irq_entries_nr);
+        return -EINVAL;
+    }
+
+    msix_free_irq_entries(dev);
+
+    qemu_get_buffer(f, dev->msix_table_page, nentries * MSIX_ENTRY_SIZE);
+    qemu_get_buffer(f, dev->msix_table_page + MSIX_PAGE_SIZE / 2,
+                   (nentries + 63) / 64);
+
+    return 0;
+}
+
+/* Does device support MSI-X? */
+int msix_present(PCIDevice *dev)
+{
+    return dev->cap_present & QEMU_PCI_CAP_MSIX;
+}
+
+/* Is MSI-X enabled? */
+int msix_enabled(PCIDevice *dev)
+{
+    return (dev->cap_present & QEMU_PCI_CAP_MSIX) &&
+        (dev->config[dev->cap.msix + PCI_CAP_FLAGS + 1] &
+         (PCI_MSIX_FLAGS_ENABLE >> 8));
+}
+
+/* Bar where MSI-X table resides. Returns -1 if no MSI-X capability */
+int msix_bar_nr(PCIDevice *dev)
+{
+    uint8_t *config = dev->config + dev->cap.msix;
+    if (!(dev->cap_present & QEMU_PCI_CAP_MSIX))
+        return -1;
+    return pci_get_word(config + MSIX_TABLE_OFFSET) & PCI_MSIX_FLAGS_BIRMASK;
+}
+
+/* Size of bar where MSI-X table resides, or 0 if MSI-X not supported. */
+uint32_t msix_bar_size(PCIDevice *dev)
+{
+    return (dev->cap_present & QEMU_PCI_CAP_MSIX) ?
+        dev->msix_bar_size : 0;
+}
+
+/* Offset of MSI-X table within the bar */
+uint32_t msix_offset(PCIDevice *dev)
+{
+    uint8_t *config = dev->config + dev->cap.msix;
+    return pci_get_word(config + MSIX_TABLE_OFFSET) & ~PCI_MSIX_FLAGS_BIRMASK;
+}
+
+/* Size of space reserved for */
+uint32_t msix_size(PCIDevice *dev)
+{
+    return MSIX_PAGE_SIZE;
+}
+
+/* TODO: convert to qemu_set_irq and friends, to make this work without kvm */
+/* Send an MSI-X message */
+void msix_notify(PCIDevice *dev, unsigned vector)
+{
+    if (vector < dev->msix_irq_entries_nr && dev->msix_entry_used[vector])
+        kvm_set_irq(dev->msix_irq_entries[vector].gsi, 1, NULL);
+}
+
+/* Mark vector as used. */
+int msix_vector_use(PCIDevice *dev, unsigned vector)
+{
+    uint8_t *table_entry = dev->msix_table_page + vector * MSIX_ENTRY_SIZE;
+    struct kvm_irq_routing_entry *entry = dev->msix_irq_entries + vector;
+    int r;
+
+    if (vector >= dev->msix_irq_entries_nr || dev->msix_entry_used[vector]++)
+        return 0;
+
+    r = kvm_get_irq_route_gsi(kvm_context);
+    if (r < 0)
+        return r;
+
+    entry->gsi = r;
+    entry->type = KVM_IRQ_ROUTING_MSI;
+    entry->flags = 0;
+    entry->u.msi.address_lo = pci_get_long(table_entry + MSIX_MSG_ADDR);
+    entry->u.msi.address_hi = pci_get_long(table_entry + MSIX_MSG_UPPER_ADDR);
+    entry->u.msi.data = pci_get_long(table_entry + MSIX_MSG_DATA);
+    r = kvm_add_routing_entry(kvm_context, entry);
+    if (r < 0) {
+        perror("msix_vector_use: kvm_add_routing_entry failed: ");
+        return r;
+    }
+
+    r = kvm_commit_irq_routes(kvm_context);
+    if (r < 0) {
+        perror("msix_vector_use: kvm_add_routing_entry failed: ");
+        return r;
+    }
+    return 0;
+}
+
+/* Mark vector as unused. */
+void msix_vector_unuse(PCIDevice *dev, unsigned vector)
+{
+    if (vector < dev->msix_irq_entries_nr && dev->msix_entry_used[vector]
+        && !--dev->msix_entry_used[vector]) {
+        kvm_del_routing_entry(kvm_context, &dev->msix_irq_entries[vector]);
+        kvm_commit_irq_routes(kvm_context);
+    }
+}
+
+int msix_vector_is_used(PCIDevice *dev, unsigned vector)
+{
+    return vector < dev->msix_irq_entries_nr && dev->msix_entry_used[vector];
+}
+
+void msix_reset(PCIDevice *dev)
+{
+    if (!(dev->cap_present & QEMU_PCI_CAP_MSIX))
+        return;
+    msix_free_irq_entries(dev);
+    dev->config[dev->cap.msix + PCI_CAP_FLAGS + 1] &=
+        ~(PCI_MSIX_FLAGS_ENABLE >> 8);
+    memset(dev->msix_table_page, 0, MSIX_PAGE_SIZE);
+}
+
+
diff --git a/hw/msix.h b/hw/msix.h
new file mode 100644
index 0000000..23fe7aa
--- /dev/null
+++ b/hw/msix.h
@@ -0,0 +1,38 @@
+#ifndef QEMU_MSIX_H
+#define QEMU_MSIX_H
+
+#include "qemu-common.h"
+
+int msix_init(PCIDevice *pdev, unsigned short nentries,
+              unsigned bar_nr, unsigned bar_size);
+
+void msix_write_config(PCIDevice *pci_dev, uint32_t address,
+                       uint32_t val, int len);
+
+void msix_mmio_map(PCIDevice *pci_dev, int region_num,
+                   uint32_t addr, uint32_t size, int type);
+
+void msix_uninit(PCIDevice *d);
+
+void msix_save(PCIDevice *dev, QEMUFile *f);
+int msix_load(PCIDevice *dev, QEMUFile *f);
+
+int msix_enabled(PCIDevice *dev);
+int msix_present(PCIDevice *dev);
+
+int msix_bar_nr(PCIDevice *dev);
+uint32_t msix_bar_size(PCIDevice *dev);
+uint32_t msix_offset(PCIDevice *dev);
+uint32_t msix_size(PCIDevice *dev);
+
+int msix_vector_use(PCIDevice *dev, unsigned vector);
+void msix_vector_unuse(PCIDevice *dev, unsigned vector);
+int msix_vector_is_used(PCIDevice *dev, unsigned vector);
+
+void msix_notify(PCIDevice *dev, unsigned vector);
+
+void msix_reset(PCIDevice *dev);
+
+extern int msix_disable;
+
+#endif
diff --git a/hw/pci.c b/hw/pci.c
index 35c08e6..a35aad7 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -127,12 +127,15 @@ int pci_bus_num(PCIBus *s)
 
 void pci_device_save(PCIDevice *s, QEMUFile *f)
 {
+    int version = s->cap_present ? 3 : 2;
     int i;
 
-    qemu_put_be32(f, 2); /* PCI device version */
+    qemu_put_be32(f, version); /* PCI device version */
     qemu_put_buffer(f, s->config, 256);
     for (i = 0; i < 4; i++)
         qemu_put_be32(f, s->irq_state[i]);
+    if (version >= 3)
+        qemu_put_be32(f, s->cap_present);
 }
 
 int pci_device_load(PCIDevice *s, QEMUFile *f)
@@ -141,7 +144,7 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
     int i;
 
     version_id = qemu_get_be32(f);
-    if (version_id > 2)
+    if (version_id > 3)
         return -EINVAL;
     qemu_get_buffer(f, s->config, 256);
     pci_update_mappings(s);
@@ -149,6 +152,13 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
     if (version_id >= 2)
         for (i = 0; i < 4; i ++)
             s->irq_state[i] = qemu_get_be32(f);
+    if (version_id >= 3)
+        s->cap_present = qemu_get_be32(f);
+    else
+        s->cap_present = 0;
+
+    if (s->cap_present & ~s->cap_supported)
+        return -EINVAL;
 
     return 0;
 }
@@ -324,6 +334,7 @@ PCIDevice *pci_register_device(PCIBus *bus, const char *name,
     pci_dev->irq_index = pci_irq_index++;
     bus->devices[devfn] = pci_dev;
     pci_dev->irq = qemu_allocate_irqs(pci_set_irq, pci_dev, 4);
+    pci_dev->cap.start = PCI_CAPABILITY_CONFIG_START_ADDR;
     return pci_dev;
 }
 
@@ -397,6 +408,27 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
     }
     *(uint32_t *)(pci_dev->config + addr) = cpu_to_le32(type);
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
 
 static void pci_update_mappings(PCIDevice *d)
 {
@@ -451,24 +483,7 @@ static void pci_update_mappings(PCIDevice *d)
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
@@ -1006,8 +1021,61 @@ PCIBus *pci_bridge_init(PCIBus *bus, int devfn, uint16_t vid, uint16_t did,
     return s->bus;
 }
 
+void pci_add_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
+{
+    uint8_t offset = pdev->cap.start + pdev->cap.length;
+    uint8_t *config = pdev->config + offset;
+    config[PCI_CAP_LIST_ID] = cap_id;
+    config[PCI_CAP_LIST_NEXT] = pdev->config[PCI_CAPABILITY_LIST];
+    pdev->config[PCI_CAPABILITY_LIST] = offset;
+    pdev->cap.length += size;
+    pdev->config[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
+}
+
+void pci_del_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
+{
+    uint8_t offset = pci_find_capability(pdev, cap_id);
+    uint8_t *config = pdev->config + offset;
+    if (!offset)
+        return;
+    /* We assume capabilities are removed in reverse order of their being
+     * added. Verify this assumption here. */
+    if (offset != pdev->config[PCI_CAPABILITY_LIST]) {
+        fprintf(stderr, "pci_remove_capability: 0x%x at 0x%x "
+                "is not the first capability in list.\n",
+                cap_id, offset);
+        return;
+    }
+    pdev->config[PCI_CAPABILITY_LIST] = config[PCI_CAP_LIST_NEXT];
+    pdev->cap.length -= size;
+
+    if (!pdev->config[PCI_CAPABILITY_LIST])
+        pdev->config[PCI_STATUS] &= ~PCI_STATUS_CAP_LIST;
+
+    if (offset + size != pdev->cap.start + pdev->cap.length) {
+        fprintf(stderr, "pci_remove_capability: 0x%x at 0x%x "
+                "is not the last added capability.\n",
+                cap_id, offset);
+        return;
+    }
+}
+
+uint8_t pci_find_capability(PCIDevice *pdev, uint8_t cap_id)
+{
+    uint8_t offset;
+
+    if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST))
+        return 0;
+
+    for (offset = pdev->config[PCI_CAPABILITY_LIST]; offset;
+         offset = pdev->config[offset + PCI_CAP_LIST_NEXT])
+        if (pdev->config[offset + PCI_CAP_LIST_ID] == cap_id)
+            break;
+
+    return offset;
+}
+
 int pci_enable_capability_support(PCIDevice *pci_dev,
-                                  uint32_t config_start,
                                   PCICapConfigReadFunc *config_read,
                                   PCICapConfigWriteFunc *config_write,
                                   PCICapConfigInitFunc *config_init)
@@ -1015,15 +1083,6 @@ int pci_enable_capability_support(PCIDevice *pci_dev,
     if (!pci_dev)
         return -ENODEV;
 
-    pci_dev->config[0x06] |= 0x10; // status = capabilities
-
-    if (config_start == 0)
-	pci_dev->cap.start = PCI_CAPABILITY_CONFIG_DEFAULT_START_ADDR;
-    else if (config_start >= 0x40 && config_start < 0xff)
-        pci_dev->cap.start = config_start;
-    else
-        return -EINVAL;
-
     if (config_read)
         pci_dev->cap.config_read = config_read;
     else
@@ -1033,6 +1092,18 @@ int pci_enable_capability_support(PCIDevice *pci_dev,
     else
         pci_dev->cap.config_write = pci_default_cap_write_config;
     pci_dev->cap.supported = 1;
-    pci_dev->config[PCI_CAPABILITY_LIST] = pci_dev->cap.start;
-    return config_init(pci_dev);
+    return config_init ? config_init(pci_dev) : 0;
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
 }
diff --git a/hw/pci.h b/hw/pci.h
index 8c8d808..339a700 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -108,6 +108,7 @@ typedef struct PCIIORegion {
 #define  PCI_COMMAND_IO		0x1	/* Enable response in I/O space */
 #define  PCI_COMMAND_MEMORY	0x2	/* Enable response in Memory space */
 #define PCI_STATUS              0x06    /* 16 bits */
+#define  PCI_STATUS_CAP_LIST	0x10	/* Support Capability List */
 #define PCI_REVISION_ID         0x08    /* 8 bits  */
 #define PCI_CLASS_DEVICE        0x0a    /* Device class */
 #define PCI_HEADER_TYPE         0x0e    /* 8 bits */
@@ -123,6 +124,10 @@ typedef struct PCIIORegion {
 #define PCI_MIN_GNT		0x3e	/* 8 bits */
 #define PCI_MAX_LAT		0x3f	/* 8 bits */
 
+#define PCI_CAP_LIST_ID		0	/* Capability ID */
+#define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
+#define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
+
 #define PCI_REVISION            0x08    /* obsolete, use PCI_REVISION_ID */
 #define PCI_SUBVENDOR_ID        0x2c    /* obsolete, use PCI_SUBSYSTEM_VENDOR_ID */
 #define PCI_SUBDEVICE_ID        0x2e    /* obsolete, use PCI_SUBSYSTEM_ID */
@@ -156,10 +161,13 @@ typedef struct PCIIORegion {
 #define PCI_COMMAND_RESERVED_MASK_HI (PCI_COMMAND_RESERVED >> 8)
 
 #define PCI_CAPABILITY_CONFIG_MAX_LENGTH 0x60
-#define PCI_CAPABILITY_CONFIG_DEFAULT_START_ADDR 0x40
+#define PCI_CAPABILITY_CONFIG_START_ADDR 0x40
 #define PCI_CAPABILITY_CONFIG_MSI_LENGTH 0x10
 #define PCI_CAPABILITY_CONFIG_MSIX_LENGTH 0x10
 
+/* Bits in cap_supported/cap_present fields. */
+#define QEMU_PCI_CAP_MSIX 0x1
+
 struct PCIDevice {
     /* PCI config space */
     uint8_t config[256];
@@ -189,7 +197,24 @@ struct PCIDevice {
         unsigned int start, length;
         PCICapConfigReadFunc *config_read;
         PCICapConfigWriteFunc *config_write;
+        /* Offsets to specific capabilities */
+        uint8_t msix;
     } cap;
+
+    /* Capability bits for save/load */
+    uint32_t cap_supported;
+    uint32_t cap_present;
+
+    int msix_irq_entries_nr;
+    struct kvm_irq_routing_entry *msix_irq_entries;
+    /* Space to store MSIX table */
+    uint8_t *msix_table_page;
+    /* MMIO index used to map MSIX table and pending bit entries. */
+    int msix_mmio_index;
+    /* Reference-count for entries actually in use by driver. */
+    unsigned *msix_entry_used;
+    /* Region including the MSI-X table */
+    uint32_t msix_bar_size;
 };
 
 PCIDevice *pci_register_device(PCIBus *bus, const char *name,
@@ -202,12 +227,21 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
                             uint32_t size, int type,
                             PCIMapIORegionFunc *map_func);
 
+void pci_resize_io_region(PCIDevice *pci_dev, int region_num,
+                          uint32_t size);
+
+/* Reserve space and add capability to the linked list in pci config space */
+void pci_add_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
+
 int pci_enable_capability_support(PCIDevice *pci_dev,
-                                  uint32_t config_start,
                                   PCICapConfigReadFunc *config_read,
                                   PCICapConfigWriteFunc *config_write,
                                   PCICapConfigInitFunc *config_init);
 
+void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
+
+uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
+
 int pci_map_irq(PCIDevice *pci_dev, int pin);
 uint32_t pci_default_read_config(PCIDevice *d,
                                  uint32_t address, int len);
@@ -246,21 +280,45 @@ PCIBus *pci_bridge_init(PCIBus *bus, int devfn, uint16_t vid, uint16_t did,
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
+pci_set_long(uint8_t *config, uint16_t val)
+{
+    cpu_to_le32wu((uint32_t *)config, val);
+}
+
+static inline uint16_t
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
 
 /* lsi53c895a.c */
diff --git a/hw/virtio-balloon.c b/hw/virtio-balloon.c
index 7f41a2a..c1a5c3f 100644
--- a/hw/virtio-balloon.c
+++ b/hw/virtio-balloon.c
@@ -180,7 +180,7 @@ void *virtio_balloon_init(PCIBus *bus)
                                          PCI_VENDOR_ID_REDHAT_QUMRANET,
                                          VIRTIO_ID_BALLOON,
                                          PCI_CLASS_MEMORY_RAM, 0x00,
-                                         8, sizeof(VirtIOBalloon));
+                                         8, sizeof(VirtIOBalloon), 0);
     if (s == NULL)
         return NULL;
 
diff --git a/hw/virtio-blk.c b/hw/virtio-blk.c
index dad4ef0..4e48be4 100644
--- a/hw/virtio-blk.c
+++ b/hw/virtio-blk.c
@@ -360,7 +360,8 @@ void *virtio_blk_init(PCIBus *bus, BlockDriverState *bs)
                                        PCI_VENDOR_ID_REDHAT_QUMRANET,
                                        VIRTIO_ID_BLOCK,
                                        PCI_CLASS_STORAGE_OTHER, 0x00,
-                                       sizeof(struct virtio_blk_config), sizeof(VirtIOBlock));
+                                       sizeof(struct virtio_blk_config), sizeof(VirtIOBlock),
+                                       0);
     if (!s)
         return NULL;
 
diff --git a/hw/virtio-console.c b/hw/virtio-console.c
index 89e8be0..759f249 100644
--- a/hw/virtio-console.c
+++ b/hw/virtio-console.c
@@ -133,7 +133,8 @@ void *virtio_console_init(PCIBus *bus, CharDriverState *chr)
                                          PCI_VENDOR_ID_REDHAT_QUMRANET,
                                          VIRTIO_ID_CONSOLE,
                                          PCI_CLASS_OTHERS, 0x00,
-                                         0, sizeof(VirtIOConsole));
+                                         0, sizeof(VirtIOConsole),
+                                         0);
     if (s == NULL)
         return NULL;
 
diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index 4beb16d..dfcff38 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -708,7 +708,8 @@ PCIDevice *virtio_net_init(PCIBus *bus, NICInfo *nd, int devfn)
                                      VIRTIO_ID_NET,
                                      PCI_CLASS_NETWORK_ETHERNET, 0x00,
                                      sizeof(struct virtio_net_config),
-                                     sizeof(VirtIONet));
+                                     sizeof(VirtIONet),
+                                     3);
     if (!n)
         return NULL;
 
diff --git a/hw/virtio.c b/hw/virtio.c
index 78c7637..5b13bd1 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -15,6 +15,7 @@
 
 #include "virtio.h"
 #include "sysemu.h"
+#include "msix.h"
 
 /* from Linux's linux/virtio_pci.h */
 
@@ -44,7 +45,25 @@
  * a read-and-acknowledge. */
 #define VIRTIO_PCI_ISR                  19
 
-#define VIRTIO_PCI_CONFIG               20
+/* MSI-X registers: only enabled if MSI-X is enabled. */
+/* A 16-bit vector for configuration changes. */
+#define VIRTIO_MSI_CONFIG_VECTOR        20
+/* A 16-bit vector for selected queue notifications. */
+#define VIRTIO_MSI_QUEUE_VECTOR         22
+
+/* Vector value used to disable MSI for queue */
+#define VIRTIO_MSI_NO_VECTOR            0xffff
+
+/* Config space size */
+#define VIRTIO_PCI_CONFIG_NOMSI         20
+#define VIRTIO_PCI_CONFIG_MSI           24
+#define VIRTIO_PCI_CONFIG_MAX           24
+
+/* The remaining space is defined by each driver as the per-driver
+ * configuration space */
+#define VIRTIO_PCI_CONFIG(dev)          (msix_enabled(dev) ? \
+                                         VIRTIO_PCI_CONFIG_MSI : \
+                                         VIRTIO_PCI_CONFIG_NOMSI)
 
 /* Virtio ABI version, if we increment this, we break the guest driver. */
 #define VIRTIO_PCI_ABI_VERSION          0
@@ -57,6 +76,7 @@
  * x86 pagesize again. */
 #define VIRTIO_PCI_VRING_ALIGN         4096
 
+
 /* QEMU doesn't strictly need write barriers since everything runs in
  * lock-step.  We'll leave the calls to wmb() in though to make it obvious for
  * KVM or if kqemu gets SMP support.
@@ -105,6 +125,7 @@ struct VirtQueue
     uint32_t pfn;
     uint16_t last_avail_idx;
     int inuse;
+    uint16_t vector;
     void (*handle_output)(VirtIODevice *vdev, VirtQueue *vq);
 };
 
@@ -431,6 +452,7 @@ static void virtio_reset(void *opaque)
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->isr = 0;
+    vdev->config_vector = VIRTIO_MSI_NO_VECTOR;
     virtio_update_irq(vdev);
 
     for(i = 0; i < VIRTIO_PCI_QUEUE_MAX; i++) {
@@ -439,7 +461,10 @@ static void virtio_reset(void *opaque)
         vdev->vq[i].vring.used = 0;
         vdev->vq[i].last_avail_idx = 0;
         vdev->vq[i].pfn = 0;
+        vdev->vq[i].vector = VIRTIO_MSI_NO_VECTOR;
     }
+
+    msix_reset(&vdev->pci_dev);
 }
 
 static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
@@ -447,8 +472,6 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     VirtIODevice *vdev = to_virtio_device(opaque);
     ram_addr_t pa;
 
-    addr -= vdev->addr;
-
     switch (addr) {
     case VIRTIO_PCI_GUEST_FEATURES:
 	/* Guest does not negotiate properly?  We have to assume nothing. */
@@ -484,6 +507,24 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         if (vdev->status == 0)
             virtio_reset(vdev);
         break;
+    case VIRTIO_MSI_CONFIG_VECTOR:
+        msix_vector_unuse(&vdev->pci_dev, vdev->config_vector);
+        /* Make it possible for guest to discover an error took place. */
+        if (msix_vector_use(&vdev->pci_dev, val) < 0)
+            val = VIRTIO_MSI_NO_VECTOR;
+        vdev->config_vector = val;
+        break;
+    case VIRTIO_MSI_QUEUE_VECTOR:
+        msix_vector_unuse(&vdev->pci_dev, vdev->vq[vdev->queue_sel].vector);
+        /* Make it possible for guest to discover an error took place. */
+        if (msix_vector_use(&vdev->pci_dev, val) < 0)
+            val = VIRTIO_MSI_NO_VECTOR;
+        vdev->vq[vdev->queue_sel].vector = val;
+        break;
+    default:
+        fprintf(stderr, "%s: unexpected address 0x%x value 0x%x\n",
+                __func__, addr, val);
+        break;
     }
 }
 
@@ -492,8 +533,6 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
     VirtIODevice *vdev = to_virtio_device(opaque);
     uint32_t ret = 0xFFFFFFFF;
 
-    addr -= vdev->addr;
-
     switch (addr) {
     case VIRTIO_PCI_HOST_FEATURES:
         ret = vdev->get_features(vdev);
@@ -518,9 +557,17 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
         /* reading from the ISR also clears it. */
         ret = vdev->isr;
         vdev->isr = 0;
-        virtio_update_irq(vdev);
+        if (!msix_enabled(&vdev->pci_dev))
+            virtio_update_irq(vdev);
+        break;
+    case VIRTIO_MSI_CONFIG_VECTOR:
+        ret = vdev->config_vector;
+        break;
+    case VIRTIO_MSI_QUEUE_VECTOR:
+        ret = vdev->vq[vdev->queue_sel].vector;
         break;
     default:
+        fprintf(stderr, "%s: unexpected address 0x%x\n", __func__, addr);
         break;
     }
 
@@ -530,11 +577,15 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
 static uint32_t virtio_config_readb(void *opaque, uint32_t addr)
 {
     VirtIODevice *vdev = opaque;
+    uint32_t config = VIRTIO_PCI_CONFIG(&vdev->pci_dev);
     uint8_t val;
 
     vdev->get_config(vdev, vdev->config);
 
-    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    addr -= vdev->addr;
+    if (addr < config)
+        return virtio_ioport_read(opaque, addr);
+    addr -= config;
     if (addr > (vdev->config_len - sizeof(val)))
         return (uint32_t)-1;
 
@@ -545,11 +596,15 @@ static uint32_t virtio_config_readb(void *opaque, uint32_t addr)
 static uint32_t virtio_config_readw(void *opaque, uint32_t addr)
 {
     VirtIODevice *vdev = opaque;
+    uint32_t config = VIRTIO_PCI_CONFIG(&vdev->pci_dev);
     uint16_t val;
 
     vdev->get_config(vdev, vdev->config);
 
-    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    addr -= vdev->addr;
+    if (addr < config)
+        return virtio_ioport_read(opaque, addr);
+    addr -= config;
     if (addr > (vdev->config_len - sizeof(val)))
         return (uint32_t)-1;
 
@@ -560,11 +615,15 @@ static uint32_t virtio_config_readw(void *opaque, uint32_t addr)
 static uint32_t virtio_config_readl(void *opaque, uint32_t addr)
 {
     VirtIODevice *vdev = opaque;
+    uint32_t config = VIRTIO_PCI_CONFIG(&vdev->pci_dev);
     uint32_t val;
 
     vdev->get_config(vdev, vdev->config);
 
-    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    addr -= vdev->addr;
+    if (addr < config)
+        return virtio_ioport_read(opaque, addr);
+    addr -= config;
     if (addr > (vdev->config_len - sizeof(val)))
         return (uint32_t)-1;
 
@@ -575,9 +634,15 @@ static uint32_t virtio_config_readl(void *opaque, uint32_t addr)
 static void virtio_config_writeb(void *opaque, uint32_t addr, uint32_t data)
 {
     VirtIODevice *vdev = opaque;
+    uint32_t config = VIRTIO_PCI_CONFIG(&vdev->pci_dev);
     uint8_t val = data;
 
-    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    addr -= vdev->addr;
+    if (addr < config) {
+        virtio_ioport_write(opaque, addr, val);
+        return;
+    }
+    addr -= config;
     if (addr > (vdev->config_len - sizeof(val)))
         return;
 
@@ -590,9 +655,15 @@ static void virtio_config_writeb(void *opaque, uint32_t addr, uint32_t data)
 static void virtio_config_writew(void *opaque, uint32_t addr, uint32_t data)
 {
     VirtIODevice *vdev = opaque;
+    uint32_t config = VIRTIO_PCI_CONFIG(&vdev->pci_dev);
     uint16_t val = data;
 
-    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    addr -= vdev->addr;
+    if (addr < config) {
+        virtio_ioport_write(opaque, addr, val);
+        return;
+    }
+    addr -= config;
     if (addr > (vdev->config_len - sizeof(val)))
         return;
 
@@ -605,9 +676,15 @@ static void virtio_config_writew(void *opaque, uint32_t addr, uint32_t data)
 static void virtio_config_writel(void *opaque, uint32_t addr, uint32_t data)
 {
     VirtIODevice *vdev = opaque;
+    uint32_t config = VIRTIO_PCI_CONFIG(&vdev->pci_dev);
     uint32_t val = data;
 
-    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    addr -= vdev->addr;
+    if (addr < config) {
+        virtio_ioport_write(opaque, addr, val);
+        return;
+    }
+    addr -= config;
     if (addr > (vdev->config_len - sizeof(val)))
         return;
 
@@ -621,30 +698,30 @@ static void virtio_map(PCIDevice *pci_dev, int region_num,
                        uint32_t addr, uint32_t size, int type)
 {
     VirtIODevice *vdev = to_virtio_device(pci_dev);
-    int i;
 
     vdev->addr = addr;
-    for (i = 0; i < 3; i++) {
-        register_ioport_write(addr, 20, 1 << i, virtio_ioport_write, vdev);
-        register_ioport_read(addr, 20, 1 << i, virtio_ioport_read, vdev);
-    }
 
-    if (vdev->config_len) {
-        register_ioport_write(addr + 20, vdev->config_len, 1,
-                              virtio_config_writeb, vdev);
-        register_ioport_write(addr + 20, vdev->config_len, 2,
-                              virtio_config_writew, vdev);
-        register_ioport_write(addr + 20, vdev->config_len, 4,
-                              virtio_config_writel, vdev);
-        register_ioport_read(addr + 20, vdev->config_len, 1,
-                             virtio_config_readb, vdev);
-        register_ioport_read(addr + 20, vdev->config_len, 2,
-                             virtio_config_readw, vdev);
-        register_ioport_read(addr + 20, vdev->config_len, 4,
-                             virtio_config_readl, vdev);
+    register_ioport_write(addr, VIRTIO_PCI_CONFIG_MAX + vdev->config_len, 1,
+                          virtio_config_writeb, vdev);
+    register_ioport_write(addr, VIRTIO_PCI_CONFIG_MAX + vdev->config_len, 2,
+                          virtio_config_writew, vdev);
+    register_ioport_write(addr, VIRTIO_PCI_CONFIG_MAX + vdev->config_len, 4,
+                          virtio_config_writel, vdev);
+    register_ioport_read(addr, VIRTIO_PCI_CONFIG_MAX + vdev->config_len, 1,
+                         virtio_config_readb, vdev);
+    register_ioport_read(addr, VIRTIO_PCI_CONFIG_MAX + vdev->config_len, 2,
+                         virtio_config_readw, vdev);
+    register_ioport_read(addr, VIRTIO_PCI_CONFIG_MAX + vdev->config_len, 4,
+                         virtio_config_readl, vdev);
 
+    if (vdev->config_len)
         vdev->get_config(vdev, vdev->config);
-    }
+}
+
+static void virtio_mmio_map(PCIDevice *pci_dev, int region_num,
+                            uint32_t addr, uint32_t size, int type)
+{
+    msix_mmio_map(pci_dev, region_num, addr, size, type);
 }
 
 VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
@@ -662,6 +739,7 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
 
     vdev->vq[i].vring.num = queue_size;
     vdev->vq[i].handle_output = handle_output;
+    vdev->vq[i].vector = VIRTIO_MSI_NO_VECTOR;
 
     return &vdev->vq[i];
 }
@@ -675,7 +753,10 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
         return;
 
     vdev->isr |= 0x01;
-    virtio_update_irq(vdev);
+    if (msix_enabled(&vdev->pci_dev))
+        msix_notify(&vdev->pci_dev, vq->vector);
+    else
+        virtio_update_irq(vdev);
 }
 
 void virtio_notify_config(VirtIODevice *vdev)
@@ -684,7 +765,10 @@ void virtio_notify_config(VirtIODevice *vdev)
         return;
 
     vdev->isr |= 0x03;
-    virtio_update_irq(vdev);
+    if (msix_enabled(&vdev->pci_dev))
+        msix_notify(&vdev->pci_dev, vdev->config_vector);
+    else
+        virtio_update_irq(vdev);
 }
 
 void virtio_save(VirtIODevice *vdev, QEMUFile *f)
@@ -692,6 +776,7 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     int i;
 
     pci_device_save(&vdev->pci_dev, f);
+    msix_save(&vdev->pci_dev, f);
 
     qemu_put_be32s(f, &vdev->addr);
     qemu_put_8s(f, &vdev->status);
@@ -701,6 +786,9 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     qemu_put_be32(f, vdev->config_len);
     qemu_put_buffer(f, vdev->config, vdev->config_len);
 
+    if (msix_present(&vdev->pci_dev))
+        qemu_put_be16s(f, &vdev->config_vector);
+
     for (i = 0; i < VIRTIO_PCI_QUEUE_MAX; i++) {
         if (vdev->vq[i].vring.num == 0)
             break;
@@ -715,14 +803,21 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
         qemu_put_be32(f, vdev->vq[i].vring.num);
         qemu_put_be32s(f, &vdev->vq[i].pfn);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
+        if (msix_present(&vdev->pci_dev))
+            qemu_put_be16s(f, &vdev->vq[i].vector);
     }
 }
 
-void virtio_load(VirtIODevice *vdev, QEMUFile *f)
+int virtio_load(VirtIODevice *vdev, QEMUFile *f)
 {
-    int num, i;
+    int num, i, r;
 
     pci_device_load(&vdev->pci_dev, f);
+    r = msix_load(&vdev->pci_dev, f);
+    if (r)
+        return r;
+
+    pci_resize_io_region(&vdev->pci_dev, 1, msix_bar_size(&vdev->pci_dev));
 
     qemu_get_be32s(f, &vdev->addr);
     qemu_get_8s(f, &vdev->status);
@@ -732,12 +827,25 @@ void virtio_load(VirtIODevice *vdev, QEMUFile *f)
     vdev->config_len = qemu_get_be32(f);
     qemu_get_buffer(f, vdev->config, vdev->config_len);
 
+    if (msix_present(&vdev->pci_dev)) {
+        qemu_get_be16s(f, &vdev->config_vector);
+        r = msix_vector_use(&vdev->pci_dev, vdev->config_vector);
+        if (r)
+            return r;
+    }
+
     num = qemu_get_be32(f);
 
     for (i = 0; i < num; i++) {
         vdev->vq[i].vring.num = qemu_get_be32(f);
         qemu_get_be32s(f, &vdev->vq[i].pfn);
         qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
+        if (msix_present(&vdev->pci_dev)) {
+            qemu_get_be16s(f, &vdev->vq[i].vector);
+            r = msix_vector_use(&vdev->pci_dev, vdev->vq[i].vector);
+            if (r)
+                return r;
+        }
 
         if (vdev->vq[i].pfn) {
             target_phys_addr_t pa;
@@ -747,11 +855,16 @@ void virtio_load(VirtIODevice *vdev, QEMUFile *f)
         }
     }
 
-    virtio_update_irq(vdev);
+    if (msix_enabled(&vdev->pci_dev))
+        qemu_set_irq(vdev->pci_dev.irq[0], 0);
+    else
+        virtio_update_irq(vdev);
+    return 0;
 }
 
 void virtio_cleanup(VirtIODevice *vdev)
 {
+    msix_uninit(&vdev->pci_dev);
     if (vdev->config)
         qemu_free(vdev->config);
     qemu_free(vdev->vq);
@@ -761,7 +874,8 @@ VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
                               uint16_t vendor, uint16_t device,
                               uint16_t subvendor, uint16_t subdevice,
                               uint16_t class_code, uint8_t pif,
-                              size_t config_size, size_t struct_size)
+                              size_t config_size, size_t struct_size,
+                              int nvectors)
 {
     VirtIODevice *vdev;
     PCIDevice *pci_dev;
@@ -775,6 +889,7 @@ VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
 
     vdev = to_virtio_device(pci_dev);
 
+    vdev->config_vector = VIRTIO_MSI_NO_VECTOR;
     vdev->status = 0;
     vdev->isr = 0;
     vdev->queue_sel = 0;
@@ -804,13 +919,28 @@ VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
     else
         vdev->config = NULL;
 
-    size = 20 + config_size;
+    size = VIRTIO_PCI_CONFIG_MAX + config_size;
     if (size & (size-1))
         size = 1 << qemu_fls(size);
 
     pci_register_io_region(pci_dev, 0, size, PCI_ADDRESS_SPACE_IO,
                            virtio_map);
+
     qemu_register_reset(virtio_reset, vdev);
+    if (!nvectors)
+        return vdev;
+
+    if (msix_init(pci_dev, nvectors, 1, 0))
+        return vdev;
+
+    if (pci_enable_capability_support(pci_dev, NULL,
+                    msix_write_config,
+                    NULL) < 0) {
+        msix_uninit(pci_dev);
+        return vdev;
+    }
 
+    pci_register_io_region(pci_dev, 1, msix_bar_size(pci_dev),
+                           PCI_ADDRESS_SPACE_MEM, virtio_mmio_map);
     return vdev;
 }
diff --git a/hw/virtio.h b/hw/virtio.h
index 935b118..6999186 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -83,6 +83,7 @@ struct VirtIODevice
     uint32_t features;
     size_t config_len;
     void *config;
+    uint16_t config_vector;
     uint32_t (*get_features)(VirtIODevice *vdev);
     uint32_t (*bad_features)(VirtIODevice *vdev);
     void (*set_features)(VirtIODevice *vdev, uint32_t val);
@@ -96,7 +97,8 @@ VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
                               uint16_t vendor, uint16_t device,
                               uint16_t subvendor, uint16_t subdevice,
                               uint16_t class_code, uint8_t pif,
-                              size_t config_size, size_t struct_size);
+                              size_t config_size, size_t struct_size,
+                              int nvectors);
 
 VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
                             void (*handle_output)(VirtIODevice *,
@@ -115,7 +117,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
 void virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
-void virtio_load(VirtIODevice *vdev, QEMUFile *f);
+int virtio_load(VirtIODevice *vdev, QEMUFile *f);
 
 void virtio_cleanup(VirtIODevice *vdev);
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 173f458..9503743 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1607,3 +1607,5 @@ DEF("mempath", HAS_ARG, QEMU_OPTION_mempath,
 DEF("mem-prealloc", 0, QEMU_OPTION_mem_prealloc,
     "-mem-prealloc        preallocate guest memory (use with -mempath)\n")
 #endif
+DEF("disable-msix", 0, QEMU_OPTION_disable_msix,
+    "-disable-msix disable msix support for PCI devices (enabled by default)\n")
diff --git a/vl.c b/vl.c
index d9f0607..77d9e57 100644
--- a/vl.c
+++ b/vl.c
@@ -135,6 +135,7 @@ int main(int argc, char **argv)
 #include "hw/usb.h"
 #include "hw/pcmcia.h"
 #include "hw/pc.h"
+#include "hw/msix.h"
 #include "hw/audiodev.h"
 #include "hw/isa.h"
 #include "hw/baum.h"
@@ -5760,6 +5761,8 @@ int main(int argc, char **argv, char **envp)
                 xen_mode = XEN_ATTACH;
                 break;
 #endif
+            case QEMU_OPTION_disable_msix:
+                msix_disable = 1;
             }
         }
     }
-- 
1.6.3.1.56.g79e1.dirty
