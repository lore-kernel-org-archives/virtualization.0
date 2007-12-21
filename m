From: Dor Laor <dor.laor@gmail.com>
Subject: [Virtio-for-kvm] [PATCH 1/7] userspace virtio
Date: Fri, 21 Dec 2007 16:43:11 +0200
Message-ID: <476BD0FF.3070202__784.073354634707$1198248312$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rus>
List-Id: virtualization@lists.linuxfoundation.org

 From 80b234220ea85d6fb291b0509ce2b3322e5ecc1f Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Wed, 19 Dec 2007 23:07:16 +0200
Subject: [PATCH] [PATCH 1/3] virtio infrastructure

This patch implements the basic infrastructure for virtio devices.  These
devices are exposed to the guest as real PCI devices.  The PCI vendor/device
IDs have been donated by Qumranet and the subsystem IDs are used to 
distinguish
the virtio device itself.

Virtio provides an abstraction for performing guest=>host and host=>guest
communications.  It also provides a standard ring queue interface and 
discovery
mechanism.  Finally, virtio provides a simple mechanism for passing
configuration between host and guest.

In this virtio implementation, we provide these things via normal PCI
operations.  The Linux kernel support for this virtio device is pending in
Rusty's virtio patch queue[1].  They should be submitted once the merge 
window
opens again.

Some future TODOs are to use endian/alignment safe routines when 
accessing the
virtqueue so that mixed mode host/guests are supported.

[1] http://ozlabs.org/~rusty/kernel/hg

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Avi Kivity <avi@qumranet.com>
Cc: Dor Laor <dor.laor@qumranet.com>
---
 qemu/Makefile.target |    3 +
 qemu/hw/virtio.c     |  422 
++++++++++++++++++++++++++++++++++++++++++++++++++
 qemu/hw/virtio.h     |  143 +++++++++++++++++
 3 files changed, 568 insertions(+), 0 deletions(-)
 create mode 100644 qemu/hw/virtio.c
 create mode 100644 qemu/hw/virtio.h

diff --git a/qemu/Makefile.target b/qemu/Makefile.target
index 12fb043..8b5853b 100644
--- a/qemu/Makefile.target
+++ b/qemu/Makefile.target
@@ -463,6 +463,9 @@ VL_OBJS += rtl8139.o
 # PCI Hypercall
 VL_OBJS+= hypercall.o
 
+# virtio devices
+VL_OBJS += virtio.o
+
 ifeq ($(TARGET_BASE_ARCH), i386)
 # Hardware support
 VL_OBJS+= ide.o pckbd.o ps2.o vga.o $(SOUND_HW) dma.o
diff --git a/qemu/hw/virtio.c b/qemu/hw/virtio.c
new file mode 100644
index 0000000..6a1d380
--- /dev/null
+++ b/qemu/hw/virtio.c
@@ -0,0 +1,422 @@
+/*
+ * Virtio Support
+ *
+ * Copyright IBM, Corp. 2007
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include <inttypes.h>
+#include <err.h>
+
+#include "virtio.h"
+#include "sysemu.h"
+
+/* from Linux's linux/virtio_pci.h */
+
+/* A 32-bit r/o bitmask of the features supported by the host */
+#define VIRTIO_PCI_HOST_FEATURES    0
+
+/* A 32-bit r/w bitmask of features activated by the guest */
+#define VIRTIO_PCI_GUEST_FEATURES    4
+
+/* A 32-bit r/w PFN for the currently selected queue */
+#define VIRTIO_PCI_QUEUE_PFN        8
+
+/* A 16-bit r/o queue size for the currently selected queue */
+#define VIRTIO_PCI_QUEUE_NUM        12
+
+/* A 16-bit r/w queue selector */
+#define VIRTIO_PCI_QUEUE_SEL        14
+
+/* A 16-bit r/w queue notifier */
+#define VIRTIO_PCI_QUEUE_NOTIFY        16
+
+/* An 8-bit device status register.  */
+#define VIRTIO_PCI_STATUS        18
+
+/* An 8-bit r/o interrupt status register.  Reading the value will 
return the
+ * current contents of the ISR and will also clear it.  This is effectively
+ * a read-and-acknowledge. */
+#define VIRTIO_PCI_ISR            19
+
+#define VIRTIO_PCI_CONFIG        20
+
+/* QEMU doesn't strictly need write barriers since everything runs in
+ * lock-step.  We'll leave the calls to wmb() in though to make it 
obvious for
+ * KVM or if kqemu gets SMP support.
+ */
+#define wmb() do { } while (0)
+
+/* virt queue functions */
+
+static void virtqueue_init(VirtQueue *vq, void *p)
+{
+    vq->vring.desc = p;
+    vq->vring.avail = p + vq->vring.num * sizeof(VRingDesc);
+    vq->vring.used = (void *)TARGET_PAGE_ALIGN((unsigned 
long)&vq->vring.avail->ring[vq->vring.num]);
+}
+
+static unsigned virtqueue_next_desc(VirtQueue *vq, unsigned int i)
+{
+    unsigned int next;
+
+    /* If this descriptor says it doesn't chain, we're done. */
+    if (!(vq->vring.desc[i].flags & VRING_DESC_F_NEXT))
+    return vq->vring.num;
+
+    /* Check they're not leading us off end of descriptors. */
+    next = vq->vring.desc[i].next;
+    /* Make sure compiler knows to grab that: we don't want it changing! */
+    wmb();
+
+    if (next >= vq->vring.num)
+    errx(1, "Desc next is %u", next);
+
+    return next;
+}
+
+void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
+            unsigned int len)
+{
+    VRingUsedElem *used;
+
+    /* Get a pointer to the next entry in the used ring. */
+    used = &vq->vring.used->ring[vq->vring.used->idx % vq->vring.num];
+    used->id = elem->index;
+    used->len = len;
+    /* Make sure buffer is written before we update index. */
+    wmb();
+    vq->vring.used->idx++;
+}
+
+int virtqueue_pop(VirtQueue *vq, VirtQueueElement *elem)
+{
+    unsigned int i, head;
+    unsigned int position;
+
+    /* Check it isn't doing very strange things with descriptor numbers. */
+    if ((uint16_t)(vq->vring.avail->idx - vq->last_avail_idx) > 
vq->vring.num)
+    errx(1, "Guest moved used index from %u to %u",
+         vq->last_avail_idx, vq->vring.avail->idx);
+
+    /* If there's nothing new since last we looked, return invalid. */
+    if (vq->vring.avail->idx == vq->last_avail_idx)
+    return 0;
+
+    /* Grab the next descriptor number they're advertising, and increment
+     * the index we've seen. */
+    head = vq->vring.avail->ring[vq->last_avail_idx++ % vq->vring.num];
+
+    /* If their number is silly, that's a fatal mistake. */
+    if (head >= vq->vring.num)
+    errx(1, "Guest says index %u is available", head);
+
+    /* When we start there are none of either input nor output. */
+    position = elem->out_num = elem->in_num = 0;
+
+    i = head;
+    do {
+    struct iovec *sg;
+
+    if ((vq->vring.desc[i].addr + vq->vring.desc[i].len) > ram_size)
+        errx(1, "Guest sent invalid pointer");
+
+    if (vq->vring.desc[i].flags & VRING_DESC_F_WRITE)
+        sg = &elem->in_sg[elem->in_num++];
+    else
+        sg = &elem->out_sg[elem->out_num++];
+
+    /* Grab the first descriptor, and check it's OK. */
+    sg->iov_len = vq->vring.desc[i].len;
+    sg->iov_base = phys_ram_base + vq->vring.desc[i].addr;
+
+    /* If we've got too many, that implies a descriptor loop. */
+    if ((elem->in_num + elem->out_num) > vq->vring.num)
+        errx(1, "Looped descriptor");
+    } while ((i = virtqueue_next_desc(vq, i)) != vq->vring.num);
+
+    elem->index = head;
+
+    return elem->in_num + elem->out_num;
+}
+
+/* virtio device */
+
+static VirtIODevice *to_virtio_device(PCIDevice *pci_dev)
+{
+    return (VirtIODevice *)pci_dev;
+}
+
+static void virtio_update_irq(VirtIODevice *vdev)
+{
+    qemu_set_irq(vdev->pci_dev.irq[0], vdev->isr & 1);
+}
+
+static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
+{
+    VirtIODevice *vdev = to_virtio_device(opaque);
+    ram_addr_t pa;
+
+    addr -= vdev->addr;
+
+    switch (addr) {
+    case VIRTIO_PCI_GUEST_FEATURES:
+    if (vdev->set_features)
+        vdev->set_features(vdev, val);
+    vdev->features = val;
+    break;
+    case VIRTIO_PCI_QUEUE_PFN:
+    pa = (ram_addr_t)val << TARGET_PAGE_BITS;
+    vdev->vq[vdev->queue_sel].pfn = val;
+    if (pa == 0) {
+        vdev->vq[vdev->queue_sel].vring.desc = NULL;
+        vdev->vq[vdev->queue_sel].vring.avail = NULL;
+        vdev->vq[vdev->queue_sel].vring.used = NULL;
+    } else if (pa < (ram_size - TARGET_PAGE_SIZE)) {
+        virtqueue_init(&vdev->vq[vdev->queue_sel], phys_ram_base + pa);
+        /* FIXME if pa == 0, deal with device tear down */
+    }
+    break;
+    case VIRTIO_PCI_QUEUE_SEL:
+    if (val < VIRTIO_PCI_QUEUE_MAX)
+        vdev->queue_sel = val;
+    break;
+    case VIRTIO_PCI_QUEUE_NOTIFY:
+    if (val < VIRTIO_PCI_QUEUE_MAX && vdev->vq[val].vring.desc)
+        vdev->vq[val].handle_output(vdev, &vdev->vq[val]);
+    break;
+    case VIRTIO_PCI_STATUS:
+    vdev->status = val & 0xFF;
+    break;
+    }
+}
+
+static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
+{
+    VirtIODevice *vdev = to_virtio_device(opaque);
+    uint32_t ret = 0xFFFFFFFF;
+
+    addr -= vdev->addr;
+
+    switch (addr) {
+    case VIRTIO_PCI_HOST_FEATURES:
+    ret = vdev->get_features(vdev);
+    break;
+    case VIRTIO_PCI_GUEST_FEATURES:
+    ret = vdev->features;
+    break;
+    case VIRTIO_PCI_QUEUE_PFN:
+    ret = vdev->vq[vdev->queue_sel].pfn;
+    break;
+    case VIRTIO_PCI_QUEUE_NUM:
+    ret = vdev->vq[vdev->queue_sel].vring.num;
+    break;
+    case VIRTIO_PCI_QUEUE_SEL:
+    ret = vdev->queue_sel;
+    break;
+    case VIRTIO_PCI_STATUS:
+    ret = vdev->status;
+    break;
+    case VIRTIO_PCI_ISR:
+    /* reading from the ISR also clears it. */
+    ret = vdev->isr;
+    vdev->isr = 0;
+    virtio_update_irq(vdev);
+    break;
+    default:
+    break;
+    }
+
+    return ret;
+}
+
+static uint32_t virtio_config_readb(void *opaque, uint32_t addr)
+{
+    VirtIODevice *vdev = opaque;
+    uint8_t val;
+
+    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    if (addr > (vdev->config_len - sizeof(val)))
+    return (uint32_t)-1;
+
+    memcpy(&val, vdev->config + addr, sizeof(val));
+    return val;
+}
+
+static uint32_t virtio_config_readw(void *opaque, uint32_t addr)
+{
+    VirtIODevice *vdev = opaque;
+    uint16_t val;
+
+    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    if (addr > (vdev->config_len - sizeof(val)))
+    return (uint32_t)-1;
+
+    memcpy(&val, vdev->config + addr, sizeof(val));
+    return val;
+}
+
+static uint32_t virtio_config_readl(void *opaque, uint32_t addr)
+{
+    VirtIODevice *vdev = opaque;
+    uint32_t val;
+
+    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    if (addr > (vdev->config_len - sizeof(val)))
+    return (uint32_t)-1;
+
+    memcpy(&val, vdev->config + addr, sizeof(val));
+    return val;
+}
+
+static void virtio_config_writeb(void *opaque, uint32_t addr, uint32_t 
data)
+{
+    VirtIODevice *vdev = opaque;
+    uint8_t val = data;
+
+    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    if (addr > (vdev->config_len - sizeof(val)))
+    return;
+
+    memcpy(vdev->config + addr, &val, sizeof(val));
+}
+
+static void virtio_config_writew(void *opaque, uint32_t addr, uint32_t 
data)
+{
+    VirtIODevice *vdev = opaque;
+    uint16_t val = data;
+
+    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    if (addr > (vdev->config_len - sizeof(val)))
+    return;
+
+    memcpy(vdev->config + addr, &val, sizeof(val));
+}
+
+static void virtio_config_writel(void *opaque, uint32_t addr, uint32_t 
data)
+{
+    VirtIODevice *vdev = opaque;
+    uint32_t val = data;
+
+    addr -= vdev->addr + VIRTIO_PCI_CONFIG;
+    if (addr > (vdev->config_len - sizeof(val)))
+    return;
+
+    memcpy(vdev->config + addr, &val, sizeof(val));
+}
+
+static void virtio_map(PCIDevice *pci_dev, int region_num,
+               uint32_t addr, uint32_t size, int type)
+{
+    VirtIODevice *vdev = to_virtio_device(pci_dev);
+    int i;
+
+    vdev->addr = addr;
+    for (i = 0; i < 3; i++) {
+    register_ioport_write(addr, 20, 1 << i, virtio_ioport_write, vdev);
+    register_ioport_read(addr, 20, 1 << i, virtio_ioport_read, vdev);
+    }
+
+    if (vdev->config_len) {
+    register_ioport_write(addr + 20, vdev->config_len, 1,
+                  virtio_config_writeb, vdev);
+    register_ioport_write(addr + 20, vdev->config_len, 2,
+                  virtio_config_writew, vdev);
+    register_ioport_write(addr + 20, vdev->config_len, 4,
+                  virtio_config_writel, vdev);
+    register_ioport_read(addr + 20, vdev->config_len, 1,
+                 virtio_config_readb, vdev);
+    register_ioport_read(addr + 20, vdev->config_len, 2,
+                 virtio_config_readw, vdev);
+    register_ioport_read(addr + 20, vdev->config_len, 4,
+                 virtio_config_readl, vdev);
+
+    vdev->update_config(vdev, vdev->config);
+    }
+}
+
+VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
+                void (*handle_output)(VirtIODevice *, VirtQueue *))
+{
+    int i;
+
+    for (i = 0; i < VIRTIO_PCI_QUEUE_MAX; i++) {
+    if (vdev->vq[i].vring.num == 0)
+        break;
+    }
+
+    if (i == VIRTIO_PCI_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
+    abort();
+
+    vdev->vq[i].vring.num = queue_size;
+    vdev->vq[i].handle_output = handle_output;
+    vdev->vq[i].index = i;
+
+    return &vdev->vq[i];
+}
+
+void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
+{
+    if (vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)
+    return;
+
+    vdev->isr = 1;
+    virtio_update_irq(vdev);
+}
+
+VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
+                  uint16_t vendor, uint16_t device,
+                  uint16_t subvendor, uint16_t subdevice,
+                  uint8_t class_code, uint8_t subclass_code,
+                  uint8_t pif, size_t config_size,
+                  size_t struct_size)
+{
+    VirtIODevice *vdev;
+    PCIDevice *pci_dev;
+    uint8_t *config;
+
+    pci_dev = pci_register_device(bus, name, struct_size,
+                  -1, NULL, NULL);
+    vdev = to_virtio_device(pci_dev);
+
+    vdev->status = 0;
+    vdev->isr = 0;
+    vdev->queue_sel = 0;
+    memset(vdev->vq, 0, sizeof(vdev->vq));
+
+    config = pci_dev->config;
+    config[0x00] = vendor & 0xFF;
+    config[0x01] = (vendor >> 8) & 0xFF;
+    config[0x02] = device & 0xFF;
+    config[0x03] = (device >> 8) & 0xFF;
+
+    config[0x09] = pif;
+    config[0x0a] = subclass_code;
+    config[0x0b] = class_code;
+    config[0x0e] = 0x00;
+
+    config[0x2c] = subvendor & 0xFF;
+    config[0x2d] = (subvendor >> 8) & 0xFF;
+    config[0x2e] = subdevice & 0xFF;
+    config[0x2f] = (subdevice >> 8) & 0xFF;
+
+    config[0x3d] = 1;
+
+    vdev->name = name;
+    vdev->config_len = config_size;
+    if (vdev->config_len)
+    vdev->config = qemu_mallocz(config_size);
+    else
+    vdev->config = NULL;
+
+    pci_register_io_region(pci_dev, 0, 20 + config_size, 
PCI_ADDRESS_SPACE_IO,
+               virtio_map);
+
+    return vdev;
+}
diff --git a/qemu/hw/virtio.h b/qemu/hw/virtio.h
new file mode 100644
index 0000000..dee97ba
--- /dev/null
+++ b/qemu/hw/virtio.h
@@ -0,0 +1,143 @@
+/*
+ * Virtio Support
+ *
+ * Copyright IBM, Corp. 2007
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef _QEMU_VIRTIO_H
+#define _QEMU_VIRTIO_H
+
+#include <sys/uio.h>
+#include "hw.h"
+#include "pci.h"
+
+/* from Linux's linux/virtio_config.h */
+
+/* Status byte for guest to report progress, and synchronize features. */
+/* We have seen device and processed generic fields 
(VIRTIO_CONFIG_F_VIRTIO) */
+#define VIRTIO_CONFIG_S_ACKNOWLEDGE    1
+/* We have found a driver for the device. */
+#define VIRTIO_CONFIG_S_DRIVER        2
+/* Driver has used its parts of the config, and is happy */
+#define VIRTIO_CONFIG_S_DRIVER_OK    4
+/* We've given up on this device. */
+#define VIRTIO_CONFIG_S_FAILED        0x80
+
+/* from Linux's linux/virtio_ring.h */
+
+/* This marks a buffer as continuing via the next field. */
+#define VRING_DESC_F_NEXT    1
+/* This marks a buffer as write-only (otherwise read-only). */
+#define VRING_DESC_F_WRITE    2
+
+/* This means don't notify other side when buffer added. */
+#define VRING_USED_F_NO_NOTIFY    1
+/* This means don't interrupt guest when buffer consumed. */
+#define VRING_AVAIL_F_NO_INTERRUPT    1
+
+typedef struct VirtQueue VirtQueue;
+typedef struct VirtIODevice VirtIODevice;
+
+typedef struct VRingDesc
+{
+    uint64_t addr;
+    uint32_t len;
+    uint16_t flags;
+    uint16_t next;
+} VRingDesc;
+
+typedef struct VRingAvail
+{
+    uint16_t flags;
+    uint16_t idx;
+    uint16_t ring[0];
+} VRingAvail;
+
+typedef struct VRingUsedElem
+{
+    uint32_t id;
+    uint32_t len;
+} VRingUsedElem;
+
+typedef struct VRingUsed
+{
+    uint16_t flags;
+    uint16_t idx;
+    VRingUsedElem ring[0];
+} VRingUsed;
+
+typedef struct VRing
+{
+    unsigned int num;
+    VRingDesc *desc;
+    VRingAvail *avail;
+    VRingUsed *used;
+} VRing;
+
+struct VirtQueue
+{
+    VRing vring;
+    uint32_t pfn;
+    uint16_t last_avail_idx;
+    void (*handle_output)(VirtIODevice *vdev, VirtQueue *vq);
+    int index;
+};
+
+#define VIRTQUEUE_MAX_SIZE 1024
+
+typedef struct VirtQueueElement
+{
+    unsigned int index;
+    unsigned int out_num;
+    unsigned int in_num;
+    struct iovec in_sg[VIRTQUEUE_MAX_SIZE];
+    struct iovec out_sg[VIRTQUEUE_MAX_SIZE];
+} VirtQueueElement;
+
+#define VIRTIO_PCI_QUEUE_MAX    16
+
+struct VirtIODevice
+{
+    PCIDevice pci_dev;
+    const char *name;
+    uint32_t addr;
+    uint16_t vendor;
+    uint16_t device;
+    uint8_t status;
+    uint8_t isr;
+    uint16_t queue_sel;
+    uint32_t features;
+    size_t config_len;
+    void *config;
+    uint32_t (*get_features)(VirtIODevice *vdev);
+    void (*set_features)(VirtIODevice *vdev, uint32_t val);
+    void (*update_config)(VirtIODevice *vdev, uint8_t *config);
+    VirtQueue vq[VIRTIO_PCI_QUEUE_MAX];
+};
+
+VirtIODevice *virtio_init_pci(PCIBus *bus, const char *name,
+                  uint16_t vendor, uint16_t device,
+                  uint16_t subvendor, uint16_t subdevice,
+                  uint8_t class_code, uint8_t subclass_code,
+                  uint8_t pif, size_t config_size,
+                  size_t struct_size);
+
+VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
+                void (*handle_output)(VirtIODevice *,
+                          VirtQueue *));
+
+void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
+            unsigned int len);
+
+int virtqueue_pop(VirtQueue *vq, VirtQueueElement *elem);
+
+void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
+
+#endif
-- 
1.5.3.3
