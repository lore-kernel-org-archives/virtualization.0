From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] qemu-kvm: add MSI-X support
Date: Tue, 12 May 2009 01:13:59 +0300
Message-ID: <20090511221359.GA22860__841.416119556193$1242080200$gmane$org@redhat.com>
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

This adds (incomplete) MSI-X support to virtio net device.
Missing is save/load support, and command-line flag to
control the feature.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile.target     |    2 +-
 hw/msix.c           |  362 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/msix.h           |   33 +++++
 hw/pci.c            |   35 ++++--
 hw/pci.h            |   53 +++++++-
 hw/virtio-balloon.c |    2 +-
 hw/virtio-blk.c     |    3 +-
 hw/virtio-console.c |    3 +-
 hw/virtio-net.c     |    3 +-
 hw/virtio.c         |  167 +++++++++++++++++++-----
 hw/virtio.h         |    4 +-
 11 files changed, 610 insertions(+), 57 deletions(-)
 create mode 100644 hw/msix.c
 create mode 100644 hw/msix.h

diff --git a/Makefile.target b/Makefile.target
index 5cb4c64..6a59a30 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -550,7 +550,7 @@ endif #CONFIG_BSD_USER
 # System emulator target
 ifndef CONFIG_USER_ONLY
 
-OBJS=vl.o osdep.o monitor.o pci.o loader.o isa_mmio.o machine.o dma-helpers.o
+OBJS=vl.o osdep.o monitor.o pci.o msix.o loader.o isa_mmio.o machine.o dma-helpers.o
 # virtio has to be here due to weird dependency between PCI and virtio-net.
 # need to fix this properly
 OBJS+=virtio.o virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o
diff --git a/hw/msix.c b/hw/msix.c
new file mode 100644
index 0000000..dcb7dbd
--- /dev/null
+++ b/hw/msix.c
@@ -0,0 +1,362 @@
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
+/* Add MSI-X capability to the config space for the device. */
+/* Given a bar and its size, add MSI-X table on top of it
+ * and fill MSI-X capability in the config space.
+ * Original bar size must be a power of 2 or 0.
+ * New bar size is returned. */
+static int msix_add_config(struct PCIDevice *pdev, unsigned short nentries,
+                           unsigned bar_nr, unsigned bar_size,
+                           unsigned *new_size)
+{
+    unsigned config_offset = pdev->cap.start + pdev->cap.length;
+    uint8_t *config = pdev->config + config_offset;
+
+    if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1)
+        return -EINVAL;
+    if (bar_size > 0x80000000)
+        return -ENOSPC;
+
+    /* Add space for MSI-X structures */
+    if (!bar_size)
+        *new_size = MSIX_PAGE_SIZE;
+    else if (bar_size < MSIX_PAGE_SIZE) {
+        bar_size = MSIX_PAGE_SIZE;
+        *new_size = MSIX_PAGE_SIZE * 2;
+    } else
+        *new_size = bar_size * 2;
+
+    pci_set_word(config + PCI_MSIX_FLAGS, nentries - 1);
+    /* Table on top of BAR */
+    pci_set_long(config + MSIX_TABLE_OFFSET, bar_size | bar_nr);
+    /* Pending bits on top of that */
+    pci_set_long(config + MSIX_PBA_OFFSET, (bar_size + MSIX_PAGE_SIZE / 2) |
+                 bar_nr);
+    pci_add_capability(pdev, PCI_CAP_ID_MSIX, PCI_CAPABILITY_CONFIG_MSIX_LENGTH);
+    pdev->cap.msix = config_offset;
+    return 0;
+}
+
+static void msix_free_irq_entries(PCIDevice *dev)
+{
+    int i;
+
+    /* TODO: handle errors */
+    for (i = 0; i < dev->msix_irq_entries_nr; i++)
+        msix_vector_unuse(dev, i);
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
+	/* FIXME: move this to pio handling code */
+        ctrl = pci_get_long(table_entry + MSIX_VECTOR_CTRL);
+        data = pci_get_long(table_entry + MSIX_MSG_DATA);
+        if ((ctrl & MSIX_VECTOR_MASK) || !data)
+            msix_vector_unuse(dev, i);
+        else
+            msix_vector_use(dev, i);
+    }
+}
+
+/* Handle MSI-X capability config write */
+void msix_write_config(PCIDevice *dev, uint32_t addr,
+                       uint32_t val, int len)
+{
+    /* MSI enable bit is in byte 1 in FLAGS register */
+    unsigned flags_pos = dev->cap.msix + PCI_CAP_FLAGS + 1;
+    uint8_t orig, mask = PCI_MSIX_FLAGS_ENABLE >> 8;
+    int i, enabled;
+
+    /* Slow but simple */
+    for (i = addr; i < addr + len; val >>= 8, ++i) {
+        if (i != flags_pos)
+            continue;
+        orig = dev->config[i];
+        enabled = val & mask;
+        dev->config[i] = (orig & ~mask) | enabled;
+        break;
+    }
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
+    cpu_register_physical_memory(addr + offset, size - offset,
+                                 d->msix_mmio_index);
+}
+
+/* Initialize the MSI-X structures. */
+int msix_init(struct PCIDevice *dev, unsigned short nentries,
+              unsigned bar_nr, unsigned bar_size,
+              unsigned *new_size)
+{
+    int ret = msix_add_config(dev, nentries, bar_nr, bar_size, new_size);
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
+    return ret;
+}
+
+/* Clean up resources for the device. */
+void msix_uninit(PCIDevice *dev)
+{
+    if (!dev->cap.msix)
+        return;
+    msix_free_irq_entries(dev);
+    dev->msix_irq_entries_nr = 0;
+    kvm_commit_irq_routes(kvm_context);
+    cpu_unregister_io_memory(dev->msix_mmio_index);
+    qemu_free(dev->msix_table_page);
+    dev->msix_table_page = NULL;
+    qemu_free(dev->msix_entry_used);
+    dev->msix_entry_used = NULL;
+    qemu_free(dev->msix_irq_entries);
+    dev->msix_irq_entries = NULL;
+    pci_del_capability(dev, PCI_CAP_ID_MSIX, PCI_CAPABILITY_CONFIG_MSIX_LENGTH);
+    return;
+}
+
+void msix_save(PCIDevice *vdev, QEMUFile *f)
+{
+    /* TODO */
+}
+void msix_load(PCIDevice *vdev, QEMUFile *f)
+{
+    /* TODO */
+}
+
+/* Is MSI-X enabled? */
+int msix_enabled(PCIDevice *dev)
+{
+    return dev->cap.msix &&
+        (dev->config[dev->cap.msix + PCI_CAP_FLAGS + 1] &
+         (PCI_MSIX_FLAGS_ENABLE >> 8));
+}
+
+/* Bar where MSI-X table resides. Returns -1 if no MSI-X capability */
+int msix_bar_nr(PCIDevice *dev)
+{
+    uint8_t *config = dev->config + dev->cap.msix;
+    if (!dev->cap.msix)
+        return -1;
+    return pci_get_word(config + MSIX_TABLE_OFFSET) & PCI_MSIX_FLAGS_BIRMASK;
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
diff --git a/hw/msix.h b/hw/msix.h
new file mode 100644
index 0000000..282a1c6
--- /dev/null
+++ b/hw/msix.h
@@ -0,0 +1,33 @@
+#ifndef QEMU_MSIX_H
+#define QEMU_MSIX_H
+
+#include "qemu-common.h"
+
+int msix_init(PCIDevice *pdev, unsigned short nentries,
+              unsigned bar_nr, unsigned bar_size,
+              unsigned *new_size);
+
+void msix_write_config(PCIDevice *pci_dev, uint32_t address,
+                       uint32_t val, int len);
+
+void msix_mmio_map(PCIDevice *pci_dev, int region_num,
+                   uint32_t addr, uint32_t size, int type);
+
+void msix_uninit(PCIDevice *d);
+
+void msix_save(PCIDevice *vdev, QEMUFile *f);
+void msix_load(PCIDevice *vdev, QEMUFile *f);
+
+int msix_enabled(PCIDevice *dev);
+
+int msix_bar_nr(PCIDevice *dev);
+uint32_t msix_offset(PCIDevice *dev);
+uint32_t msix_size(PCIDevice *dev);
+
+int msix_vector_use(PCIDevice *dev, unsigned vector);
+void msix_vector_unuse(PCIDevice *dev, unsigned vector);
+int msix_vector_is_used(PCIDevice *dev, unsigned vector);
+
+void msix_notify(PCIDevice *dev, unsigned vector);
+
+#endif
diff --git a/hw/pci.c b/hw/pci.c
index 64fb82e..fc1ca46 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -323,6 +323,7 @@ PCIDevice *pci_register_device(PCIBus *bus, const char *name,
     pci_dev->irq_index = pci_irq_index++;
     bus->devices[devfn] = pci_dev;
     pci_dev->irq = qemu_allocate_irqs(pci_set_irq, pci_dev, 4);
+    pci_dev->cap.start = PCI_CAPABILITY_CONFIG_START_ADDR;
     return pci_dev;
 }
 
@@ -1004,8 +1005,30 @@ PCIBus *pci_bridge_init(PCIBus *bus, int devfn, uint16_t vid, uint16_t did,
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
+}
+
+void pci_del_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
+{
+    uint8_t offset = pdev->config[PCI_CAPABILITY_LIST];
+    uint8_t *config = pdev->config + offset;
+    if (config[PCI_CAP_LIST_ID] != cap_id) {
+        fprintf(stderr, "pci_remove_capability: expected 0x%x found 0x%x\n",
+                cap_id, config[PCI_CAP_LIST_ID]);
+        return;
+    }
+    pdev->config[PCI_CAPABILITY_LIST] = config[PCI_CAP_LIST_NEXT];
+    pdev->cap.length -= size;
+}
+
 int pci_enable_capability_support(PCIDevice *pci_dev,
-                                  uint32_t config_start,
                                   PCICapConfigReadFunc *config_read,
                                   PCICapConfigWriteFunc *config_write,
                                   PCICapConfigInitFunc *config_init)
@@ -1015,13 +1038,6 @@ int pci_enable_capability_support(PCIDevice *pci_dev,
 
     pci_dev->config[0x06] |= 0x10; // status = capabilities
 
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
@@ -1031,6 +1047,5 @@ int pci_enable_capability_support(PCIDevice *pci_dev,
     else
         pci_dev->cap.config_write = pci_default_cap_write_config;
     pci_dev->cap.supported = 1;
-    pci_dev->config[PCI_CAPABILITY_LIST] = pci_dev->cap.start;
-    return config_init(pci_dev);
+    return config_init ? config_init(pci_dev) : 0;
 }
diff --git a/hw/pci.h b/hw/pci.h
index 21e2cbf..cd88564 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -119,6 +119,10 @@ typedef struct PCIIORegion {
 #define PCI_MIN_GNT		0x3e	/* 8 bits */
 #define PCI_MAX_LAT		0x3f	/* 8 bits */
 
+#define PCI_CAP_LIST_ID		0	/* Capability ID */
+#define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
+#define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
+
 #define PCI_REVISION            0x08    /* obsolete, use PCI_REVISION_ID */
 #define PCI_SUBVENDOR_ID        0x2c    /* obsolete, use PCI_SUBSYSTEM_VENDOR_ID */
 #define PCI_SUBDEVICE_ID        0x2e    /* obsolete, use PCI_SUBSYSTEM_ID */
@@ -152,7 +156,7 @@ typedef struct PCIIORegion {
 #define PCI_COMMAND_RESERVED_MASK_HI (PCI_COMMAND_RESERVED >> 8)
 
 #define PCI_CAPABILITY_CONFIG_MAX_LENGTH 0x60
-#define PCI_CAPABILITY_CONFIG_DEFAULT_START_ADDR 0x40
+#define PCI_CAPABILITY_CONFIG_START_ADDR 0x40
 #define PCI_CAPABILITY_CONFIG_MSI_LENGTH 0x10
 #define PCI_CAPABILITY_CONFIG_MSIX_LENGTH 0x10
 
@@ -185,7 +189,18 @@ struct PCIDevice {
         unsigned int start, length;
         PCICapConfigReadFunc *config_read;
         PCICapConfigWriteFunc *config_write;
+        /* Offsets to specific capabilities */
+        uint8_t msix;
     } cap;
+
+    int msix_irq_entries_nr;
+    struct kvm_irq_routing_entry *msix_irq_entries;
+    /* Space to store MSIX table */
+    uint8_t *msix_table_page;
+    /* MMIO index used to map MSIX table and pending bit entries. */
+    int msix_mmio_index;
+    /* Reference-count for entries actually in use by driver. */
+    unsigned *msix_entry_used;
 };
 
 PCIDevice *pci_register_device(PCIBus *bus, const char *name,
@@ -198,12 +213,16 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
                             uint32_t size, int type,
                             PCIMapIORegionFunc *map_func);
 
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
 int pci_map_irq(PCIDevice *pci_dev, int pin);
 uint32_t pci_default_read_config(PCIDevice *d,
                                  uint32_t address, int len);
@@ -242,21 +261,45 @@ PCIBus *pci_bridge_init(PCIBus *bus, int devfn, uint16_t vid, uint16_t did,
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
index 51a8e22..7858a77 100644
--- a/hw/virtio-blk.c
+++ b/hw/virtio-blk.c
@@ -251,7 +251,8 @@ void *virtio_blk_init(PCIBus *bus, BlockDriverState *bs)
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
index 5f5f2f3..cc1c739 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -691,7 +691,8 @@ PCIDevice *virtio_net_init(PCIBus *bus, NICInfo *nd, int devfn)
                                      VIRTIO_ID_NET,
                                      PCI_CLASS_NETWORK_ETHERNET, 0x00,
                                      sizeof(struct virtio_net_config),
-                                     sizeof(VirtIONet));
+                                     sizeof(VirtIONet),
+                                     3);
     if (!n)
         return NULL;
 
diff --git a/hw/virtio.c b/hw/virtio.c
index 4aa5f20..86d0b53 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -15,6 +15,7 @@
 
 #include "virtio.h"
 #include "sysemu.h"
+#include "msix.h"
 
 /* from Linux's linux/virtio_pci.h */
 
@@ -44,7 +45,21 @@
  * a read-and-acknowledge. */
 #define VIRTIO_PCI_ISR                  19
 
-#define VIRTIO_PCI_CONFIG               20
+/* MSI-X registers: only enabled if MSI-X is enabled. */
+/* A 16-bit vector for configuration changes. */
+#define VIRTIO_MSI_CONFIG_VECTOR        20
+/* A 16-bit vector for selected queue notifications. */
+#define VIRTIO_MSI_QUEUE_VECTOR         22
+
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
@@ -57,6 +72,7 @@
  * x86 pagesize again. */
 #define VIRTIO_PCI_VRING_ALIGN         4096
 
+
 /* QEMU doesn't strictly need write barriers since everything runs in
  * lock-step.  We'll leave the calls to wmb() in though to make it obvious for
  * KVM or if kqemu gets SMP support.
@@ -105,6 +121,7 @@ struct VirtQueue
     uint32_t pfn;
     uint16_t last_avail_idx;
     int inuse;
+    uint16_t vector;
     void (*handle_output)(VirtIODevice *vdev, VirtQueue *vq);
 };
 
@@ -431,7 +448,8 @@ static void virtio_reset(void *opaque)
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->isr = 0;
-    virtio_update_irq(vdev);
+    if (!msix_enabled(&vdev->pci_dev))
+        virtio_update_irq(vdev);
 
     for(i = 0; i < VIRTIO_PCI_QUEUE_MAX; i++) {
         vdev->vq[i].vring.desc = 0;
@@ -447,8 +465,6 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     VirtIODevice *vdev = to_virtio_device(opaque);
     ram_addr_t pa;
 
-    addr -= vdev->addr;
-
     switch (addr) {
     case VIRTIO_PCI_GUEST_FEATURES:
 	/* Guest does not negotiate properly?  We have to assume nothing. */
@@ -484,6 +500,24 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         if (vdev->status == 0)
             virtio_reset(vdev);
         break;
+    case VIRTIO_MSI_CONFIG_VECTOR:
+        msix_vector_unuse(&vdev->pci_dev, vdev->config_vector);
+        /* Make it possible for guest to discover an error took place. */
+        if (msix_vector_use(&vdev->pci_dev, val) < 0)
+            val = -1;
+        vdev->config_vector = val;
+        break;
+    case VIRTIO_MSI_QUEUE_VECTOR:
+        msix_vector_unuse(&vdev->pci_dev, vdev->vq[vdev->queue_sel].vector);
+        /* Make it possible for guest to discover an error took place. */
+        if (msix_vector_use(&vdev->pci_dev, val) < 0)
+            val = -1;
+        vdev->vq[vdev->queue_sel].vector = val;
+        break;
+    default:
+        fprintf(stderr, "%s: unexpected address 0x%x value 0x%x\n",
+                __func__, addr, val);
+        break;
     }
 }
 
@@ -492,8 +526,6 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
     VirtIODevice *vdev = to_virtio_device(opaque);
     uint32_t ret = 0xFFFFFFFF;
 
-    addr -= vdev->addr;
-
     switch (addr) {
     case VIRTIO_PCI_HOST_FEATURES:
         ret = vdev->get_features(vdev);
@@ -518,9 +550,14 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
         /* reading from the ISR also clears it. */
         ret = vdev->isr;
         vdev->isr = 0;
-        virtio_update_irq(vdev);
+        if (!msix_enabled(&vdev->pci_dev))
+            virtio_update_irq(vdev);
+        break;
+    case VIRTIO_MSI_QUEUE_VECTOR:
+        ret = vdev->vq[vdev->queue_sel].vector;
         break;
     default:
+        fprintf(stderr, "%s: unexpected address 0x%x\n", __func__, addr);
         break;
     }
 
@@ -530,11 +567,15 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
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
 
@@ -545,11 +586,15 @@ static uint32_t virtio_config_readb(void *opaque, uint32_t addr)
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
 
@@ -560,11 +605,15 @@ static uint32_t virtio_config_readw(void *opaque, uint32_t addr)
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
 
@@ -575,9 +624,15 @@ static uint32_t virtio_config_readl(void *opaque, uint32_t addr)
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
 
@@ -590,9 +645,15 @@ static void virtio_config_writeb(void *opaque, uint32_t addr, uint32_t data)
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
 
@@ -605,9 +666,15 @@ static void virtio_config_writew(void *opaque, uint32_t addr, uint32_t data)
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
 
@@ -621,30 +688,30 @@ static void virtio_map(PCIDevice *pci_dev, int region_num,
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
@@ -662,6 +729,7 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
 
     vdev->vq[i].vring.num = queue_size;
     vdev->vq[i].handle_output = handle_output;
+    vdev->vq[i].vector = -1;
 
     return &vdev->vq[i];
 }
@@ -675,7 +743,10 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
         return;
 
     vdev->isr |= 0x01;
-    virtio_update_irq(vdev);
+    if (msix_enabled(&vdev->pci_dev))
+        msix_notify(&vdev->pci_dev, vq->vector);
+    else
+        virtio_update_irq(vdev);
 }
 
 void virtio_notify_config(VirtIODevice *vdev)
@@ -684,7 +755,10 @@ void virtio_notify_config(VirtIODevice *vdev)
         return;
 
     vdev->isr |= 0x03;
-    virtio_update_irq(vdev);
+    if (msix_enabled(&vdev->pci_dev))
+        msix_notify(&vdev->pci_dev, vdev->config_vector);
+    else
+        virtio_update_irq(vdev);
 }
 
 void virtio_save(VirtIODevice *vdev, QEMUFile *f)
@@ -716,6 +790,7 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
         qemu_put_be32s(f, &vdev->vq[i].pfn);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
     }
+    msix_save(&vdev->pci_dev, f);
 }
 
 void virtio_load(VirtIODevice *vdev, QEMUFile *f)
@@ -746,12 +821,15 @@ void virtio_load(VirtIODevice *vdev, QEMUFile *f)
             virtqueue_init(&vdev->vq[i], pa);
         }
     }
+    msix_load(&vdev->pci_dev, f);
 
-    virtio_update_irq(vdev);
+    if (!msix_enabled(&vdev->pci_dev))
+        virtio_update_irq(vdev);
 }
 
 void virtio_cleanup(VirtIODevice *vdev)
 {
+    msix_uninit(&vdev->pci_dev);
     if (vdev->config)
         qemu_free(vdev->config);
     qemu_free(vdev->vq);
@@ -761,7 +839,8 @@ VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
                               uint16_t vendor, uint16_t device,
                               uint16_t subvendor, uint16_t subdevice,
                               uint16_t class_code, uint8_t pif,
-                              size_t config_size, size_t struct_size)
+                              size_t config_size, size_t struct_size,
+                              int nvectors)
 {
     VirtIODevice *vdev;
     PCIDevice *pci_dev;
@@ -775,6 +854,7 @@ VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
 
     vdev = to_virtio_device(pci_dev);
 
+    vdev->config_vector = -1;
     vdev->status = 0;
     vdev->isr = 0;
     vdev->queue_sel = 0;
@@ -810,7 +890,22 @@ VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
 
     pci_register_io_region(pci_dev, 0, size, PCI_ADDRESS_SPACE_IO,
                            virtio_map);
+
     qemu_register_reset(virtio_reset, vdev);
+    if (!nvectors)
+        return vdev;
+
+    if (msix_init(pci_dev, nvectors, 1, 0, &size))
+        return vdev;
+
+    if (pci_enable_capability_support(pci_dev, NULL,
+                    msix_write_config,
+                    NULL) < 0) {
+        msix_uninit(pci_dev);
+        return vdev;
+    }
 
+    pci_register_io_region(pci_dev, 1, size, PCI_ADDRESS_SPACE_MEM,
+                           virtio_mmio_map);
     return vdev;
 }
diff --git a/hw/virtio.h b/hw/virtio.h
index 935b118..7df1972 100644
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
-- 
1.6.3.rc3.1.g830204
