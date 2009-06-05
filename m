From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 10/13] qemu: MSI-X support in virtio PCI
Date: Fri, 5 Jun 2009 13:24:10 +0300
Message-ID: <20090605102410.GK26770__42160.2787952454$1244197774$gmane$org@redhat.com>
References: <cover.1244192535.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1244192535.git.mst@redhat.com>
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

This enables actual support for MSI-X in virtio PCI.
First user will be virtio-net.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio-pci.c |  152 ++++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 112 insertions(+), 40 deletions(-)

diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 7dfdd80..294f4c7 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -18,6 +18,7 @@
 #include "virtio.h"
 #include "pci.h"
 //#include "sysemu.h"
+#include "msix.h"
 
 /* from Linux's linux/virtio_pci.h */
 
@@ -47,7 +48,24 @@
  * a read-and-acknowledge. */
 #define VIRTIO_PCI_ISR                  19
 
-#define VIRTIO_PCI_CONFIG               20
+/* MSI-X registers: only enabled if MSI-X is enabled. */
+/* A 16-bit vector for configuration changes. */
+#define VIRTIO_MSI_CONFIG_VECTOR        20
+/* A 16-bit vector for selected queue notifications. */
+#define VIRTIO_MSI_QUEUE_VECTOR         22
+
+/* Config space size */
+#define VIRTIO_PCI_CONFIG_NOMSI         20
+#define VIRTIO_PCI_CONFIG_MSI           24
+#define VIRTIO_PCI_REGION_SIZE(dev)     (msix_present(dev) ? \
+                                         VIRTIO_PCI_CONFIG_MSI : \
+                                         VIRTIO_PCI_CONFIG_NOMSI)
+
+/* The remaining space is defined by each driver as the per-driver
+ * configuration space */
+#define VIRTIO_PCI_CONFIG(dev)          (msix_enabled(dev) ? \
+                                         VIRTIO_PCI_CONFIG_MSI : \
+                                         VIRTIO_PCI_CONFIG_NOMSI)
 
 /* Virtio ABI version, if we increment this, we break the guest driver. */
 #define VIRTIO_PCI_ABI_VERSION          0
@@ -81,14 +99,17 @@ typedef struct {
 static void virtio_pci_notify(void *opaque, uint16_t vector)
 {
     VirtIOPCIProxy *proxy = opaque;
-
-    qemu_set_irq(proxy->pci_dev.irq[0], proxy->vdev->isr & 1);
+    if (msix_enabled(&proxy->pci_dev))
+        msix_notify(&proxy->pci_dev, vector);
+    else
+        qemu_set_irq(proxy->pci_dev.irq[0], proxy->vdev->isr & 1);
 }
 
 static void virtio_pci_reset(void *opaque)
 {
     VirtIOPCIProxy *proxy = opaque;
     virtio_reset(proxy->vdev);
+    msix_reset(&proxy->pci_dev);
 }
 
 static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
@@ -97,8 +118,6 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     VirtIODevice *vdev = proxy->vdev;
     target_phys_addr_t pa;
 
-    addr -= proxy->addr;
-
     switch (addr) {
     case VIRTIO_PCI_GUEST_FEATURES:
 	/* Guest does not negotiate properly?  We have to assume nothing. */
@@ -131,17 +150,33 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         if (vdev->status == 0)
             virtio_pci_reset(proxy);
         break;
+    case VIRTIO_MSI_CONFIG_VECTOR:
+        msix_vector_unuse(&proxy->pci_dev, vdev->config_vector);
+        /* Make it possible for guest to discover an error took place. */
+        if (msix_vector_use(&proxy->pci_dev, val) < 0)
+            val = VIRTIO_NO_VECTOR;
+        vdev->config_vector = val;
+        break;
+    case VIRTIO_MSI_QUEUE_VECTOR:
+        msix_vector_unuse(&proxy->pci_dev,
+                          virtio_queue_vector(vdev, vdev->queue_sel));
+        /* Make it possible for guest to discover an error took place. */
+        if (msix_vector_use(&proxy->pci_dev, val) < 0)
+            val = VIRTIO_NO_VECTOR;
+        virtio_queue_set_vector(vdev, vdev->queue_sel, val);
+        break;
+    default:
+        fprintf(stderr, "%s: unexpected address 0x%x value 0x%x\n",
+                __func__, addr, val);
+        break;
     }
 }
 
-static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
+static uint32_t virtio_ioport_read(VirtIOPCIProxy *proxy, uint32_t addr)
 {
-    VirtIOPCIProxy *proxy = opaque;
     VirtIODevice *vdev = proxy->vdev;
     uint32_t ret = 0xFFFFFFFF;
 
-    addr -= proxy->addr;
-
     switch (addr) {
     case VIRTIO_PCI_HOST_FEATURES:
         ret = vdev->get_features(vdev);
@@ -169,6 +204,12 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
         vdev->isr = 0;
         qemu_set_irq(proxy->pci_dev.irq[0], 0);
         break;
+    case VIRTIO_MSI_CONFIG_VECTOR:
+        ret = vdev->config_vector;
+        break;
+    case VIRTIO_MSI_QUEUE_VECTOR:
+        ret = virtio_queue_vector(vdev, vdev->queue_sel);
+        break;
     default:
         break;
     }
@@ -179,42 +220,72 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
 static uint32_t virtio_pci_config_readb(void *opaque, uint32_t addr)
 {
     VirtIOPCIProxy *proxy = opaque;
-    addr -= proxy->addr + VIRTIO_PCI_CONFIG;
+    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    addr -= proxy->addr;
+    if (addr < config)
+        return virtio_ioport_read(proxy, addr);
+    addr -= config;
     return virtio_config_readb(proxy->vdev, addr);
 }
 
 static uint32_t virtio_pci_config_readw(void *opaque, uint32_t addr)
 {
     VirtIOPCIProxy *proxy = opaque;
-    addr -= proxy->addr + VIRTIO_PCI_CONFIG;
+    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    addr -= proxy->addr;
+    if (addr < config)
+        return virtio_ioport_read(proxy, addr);
+    addr -= config;
     return virtio_config_readw(proxy->vdev, addr);
 }
 
 static uint32_t virtio_pci_config_readl(void *opaque, uint32_t addr)
 {
     VirtIOPCIProxy *proxy = opaque;
-    addr -= proxy->addr + VIRTIO_PCI_CONFIG;
+    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    addr -= proxy->addr;
+    if (addr < config)
+        return virtio_ioport_read(proxy, addr);
+    addr -= config;
     return virtio_config_readl(proxy->vdev, addr);
 }
 
 static void virtio_pci_config_writeb(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
-    addr -= proxy->addr + VIRTIO_PCI_CONFIG;
+    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    addr -= proxy->addr;
+    if (addr < config) {
+        virtio_ioport_write(proxy, addr, val);
+        return;
+    }
+    addr -= config;
     virtio_config_writeb(proxy->vdev, addr, val);
 }
 
 static void virtio_pci_config_writew(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
-    addr -= proxy->addr + VIRTIO_PCI_CONFIG;
+    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    addr -= proxy->addr;
+    if (addr < config) {
+        virtio_ioport_write(proxy, addr, val);
+        return;
+    }
+    addr -= config;
     virtio_config_writew(proxy->vdev, addr, val);
 }
 
 static void virtio_pci_config_writel(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
-    addr -= proxy->addr + VIRTIO_PCI_CONFIG;
+    uint32_t config = VIRTIO_PCI_CONFIG(&proxy->pci_dev);
+    addr -= proxy->addr;
+    if (addr < config) {
+        virtio_ioport_write(proxy, addr, val);
+        return;
+    }
+    addr -= config;
     virtio_config_writel(proxy->vdev, addr, val);
 }
 
@@ -223,32 +294,26 @@ static void virtio_map(PCIDevice *pci_dev, int region_num,
 {
     VirtIOPCIProxy *proxy = container_of(pci_dev, VirtIOPCIProxy, pci_dev);
     VirtIODevice *vdev = proxy->vdev;
-    int i;
+    unsigned config_len = VIRTIO_PCI_REGION_SIZE(pci_dev) + vdev->config_len;
 
     proxy->addr = addr;
-    for (i = 0; i < 3; i++) {
-        register_ioport_write(addr, VIRTIO_PCI_CONFIG, 1 << i,
-                              virtio_ioport_write, proxy);
-        register_ioport_read(addr, VIRTIO_PCI_CONFIG, 1 << i,
-                             virtio_ioport_read, proxy);
-    }
 
-    if (vdev->config_len) {
-        register_ioport_write(addr + VIRTIO_PCI_CONFIG, vdev->config_len, 1,
-                              virtio_pci_config_writeb, proxy);
-        register_ioport_write(addr + VIRTIO_PCI_CONFIG, vdev->config_len, 2,
-                              virtio_pci_config_writew, proxy);
-        register_ioport_write(addr + VIRTIO_PCI_CONFIG, vdev->config_len, 4,
-                              virtio_pci_config_writel, proxy);
-        register_ioport_read(addr + VIRTIO_PCI_CONFIG, vdev->config_len, 1,
-                             virtio_pci_config_readb, proxy);
-        register_ioport_read(addr + VIRTIO_PCI_CONFIG, vdev->config_len, 2,
-                             virtio_pci_config_readw, proxy);
-        register_ioport_read(addr + VIRTIO_PCI_CONFIG, vdev->config_len, 4,
-                             virtio_pci_config_readl, proxy);
+    register_ioport_write(addr, config_len, 1, virtio_pci_config_writeb, proxy);
+    register_ioport_write(addr, config_len, 2, virtio_pci_config_writew, proxy);
+    register_ioport_write(addr, config_len, 4, virtio_pci_config_writel, proxy);
+    register_ioport_read(addr, config_len, 1, virtio_pci_config_readb, proxy);
+    register_ioport_read(addr, config_len, 2, virtio_pci_config_readw, proxy);
+    register_ioport_read(addr, config_len, 4, virtio_pci_config_readl, proxy);
 
+    if (vdev->config_len)
         vdev->get_config(vdev, vdev->config);
-    }
+}
+
+static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
+                                uint32_t val, int len)
+{
+    pci_default_write_config(pci_dev, address, val, len);
+    msix_write_config(pci_dev, address, val, len);
 }
 
 static const VirtIOBindings virtio_pci_bindings = {
@@ -264,9 +329,6 @@ static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
 
     proxy->vdev = vdev;
 
-    /* No support for multiple vectors yet. */
-    proxy->vdev->nvectors = 0;
-
     config = proxy->pci_dev.config;
     pci_config_set_vendor_id(config, vendor);
     pci_config_set_device_id(config, device);
@@ -284,7 +346,17 @@ static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
 
     config[0x3d] = 1;
 
-    size = 20 + vdev->config_len;
+    if (vdev->nvectors && !msix_init(&proxy->pci_dev, vdev->nvectors, 1, 0)) {
+        pci_register_io_region(&proxy->pci_dev, 1,
+                               msix_bar_size(&proxy->pci_dev),
+                               PCI_ADDRESS_SPACE_MEM,
+                               msix_mmio_map);
+        proxy->pci_dev.config_write = virtio_write_config;
+        proxy->pci_dev.unregister = msix_uninit;
+    } else
+        vdev->nvectors = 0;
+
+    size = VIRTIO_PCI_REGION_SIZE(&proxy->pci_dev) + vdev->config_len;
     if (size & (size-1))
         size = 1 << qemu_fls(size);
 
-- 
1.6.3.1.56.g79e1.dirty
