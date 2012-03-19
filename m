From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2] virtio-pci: add MMIO property
Date: Mon, 19 Mar 2012 22:37:22 +0200
Message-ID: <20120319203721.GA9399@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexey Kardashevskiy <aik@ozlabs.ru>, rusty@rustcorp.com.au, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, avi@redhat.com
Cc: Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Currently virtio-pci is specified so that configuration of the device is
done through a PCI IO space (via BAR 0 of the virtual PCI device).
However, Linux guests happen to use ioread/iowrite/iomap primitives
for access, and these work uniformly across memory/io BARs.

While PCI IO accesses are faster than MMIO on x86 kvm,
MMIO might be helpful on other systems:
for example IBM pSeries machines not all firmware/hypervisor
versions necessarily support PCI PIO access on all domains.

Add a property to make it possible to tweak the BAR type.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

OK I added old_mmio (BTW: would be nice if ops were checked when
region is inited) and now things work in userspace.
However, when I add ioeventfd=on I get an assert:

qemu/kvm-all.c:747: kvm_mem_ioeventfd_add: Assertion `match_data &&
section->size == 4' failed.

How to reproduce:
1. apply patch
2. create virtio device with flags mmio=on,ioeventfd=on


 hw/virtio-pci.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/virtio-pci.h |    5 ++++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 28498ec..b061000 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -510,8 +510,58 @@ const MemoryRegionPortio virtio_portio[] = {
     PORTIO_END_OF_LIST()
 };
 
+static void virtio_pci_config_mmio_writeb(void *opaque, target_phys_addr_t addr, uint32_t val)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    virtio_pci_config_writeb(opaque, addr & proxy->bar0_mask, val);
+}
+
+static void virtio_pci_config_mmio_writew(void *opaque, target_phys_addr_t addr, uint32_t val)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    virtio_pci_config_writew(opaque, addr & proxy->bar0_mask, val);
+}
+
+static void virtio_pci_config_mmio_writel(void *opaque, target_phys_addr_t addr, uint32_t val)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    virtio_pci_config_writel(opaque, addr & proxy->bar0_mask, val);
+}
+
+static uint32_t virtio_pci_config_mmio_readb(void *opaque, target_phys_addr_t addr)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    return virtio_pci_config_readb(opaque, addr & proxy->bar0_mask);
+}
+
+static uint32_t virtio_pci_config_mmio_readw(void *opaque, target_phys_addr_t addr)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    uint32_t val = virtio_pci_config_readw(opaque, addr & proxy->bar0_mask);
+    return val;
+}
+
+static uint32_t virtio_pci_config_mmio_readl(void *opaque, target_phys_addr_t addr)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    uint32_t val = virtio_pci_config_readl(opaque, addr & proxy->bar0_mask);
+    return val;
+}
+
 static const MemoryRegionOps virtio_pci_config_ops = {
     .old_portio = virtio_portio,
+    .old_mmio = {
+        .read = {
+            virtio_pci_config_mmio_readb,
+            virtio_pci_config_mmio_readw,
+            virtio_pci_config_mmio_readl,
+        },
+        .write = {
+            virtio_pci_config_mmio_writeb,
+            virtio_pci_config_mmio_writew,
+            virtio_pci_config_mmio_writel,
+        },
+    },
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
@@ -655,6 +705,7 @@ void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev)
 {
     uint8_t *config;
     uint32_t size;
+    uint8_t bar0_type;
 
     proxy->vdev = vdev;
 
@@ -682,10 +733,18 @@ void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev)
     if (size & (size-1))
         size = 1 << qemu_fls(size);
 
+    proxy->bar0_mask = size - 1;
+
     memory_region_init_io(&proxy->bar, &virtio_pci_config_ops, proxy,
                           "virtio-pci", size);
-    pci_register_bar(&proxy->pci_dev, 0, PCI_BASE_ADDRESS_SPACE_IO,
-                     &proxy->bar);
+
+    if (proxy->flags & VIRTIO_PCI_FLAG_USE_MMIO) {
+        bar0_type = PCI_BASE_ADDRESS_SPACE_MEMORY;
+    } else {
+        bar0_type = PCI_BASE_ADDRESS_SPACE_IO;
+    }
+
+    pci_register_bar(&proxy->pci_dev, 0, bar0_type, &proxy->bar);
 
     if (!kvm_has_many_ioeventfds()) {
         proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
@@ -823,6 +882,7 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
     DEFINE_VIRTIO_BLK_FEATURES(VirtIOPCIProxy, host_features),
+    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -856,6 +916,7 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_UINT32("x-txtimer", VirtIOPCIProxy, net.txtimer, TX_TIMER_INTERVAL),
     DEFINE_PROP_INT32("x-txburst", VirtIOPCIProxy, net.txburst, TX_BURST),
     DEFINE_PROP_STRING("tx", VirtIOPCIProxy, net.tx),
+    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -888,6 +949,7 @@ static Property virtio_serial_properties[] = {
     DEFINE_PROP_HEX32("class", VirtIOPCIProxy, class_code, 0),
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIOPCIProxy, host_features),
     DEFINE_PROP_UINT32("max_ports", VirtIOPCIProxy, serial.max_virtserial_ports, 31),
+    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -915,6 +977,7 @@ static TypeInfo virtio_serial_info = {
 
 static Property virtio_balloon_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIOPCIProxy, host_features),
+    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -969,6 +1032,7 @@ static int virtio_scsi_exit_pci(PCIDevice *pci_dev)
 static Property virtio_scsi_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
     DEFINE_VIRTIO_SCSI_PROPERTIES(VirtIOPCIProxy, host_features, scsi),
+    DEFINE_PROP_BIT("mmio", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_MMIO_BIT, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio-pci.h b/hw/virtio-pci.h
index e560428..71ae5c9 100644
--- a/hw/virtio-pci.h
+++ b/hw/virtio-pci.h
@@ -24,6 +24,10 @@
 #define VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT 1
 #define VIRTIO_PCI_FLAG_USE_IOEVENTFD   (1 << VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT)
 
+/* Some guests don't support port IO. Use MMIO instead. */
+#define VIRTIO_PCI_FLAG_USE_MMIO_BIT 2
+#define VIRTIO_PCI_FLAG_USE_MMIO   (1 << VIRTIO_PCI_FLAG_USE_MMIO_BIT)
+
 typedef struct {
     PCIDevice pci_dev;
     VirtIODevice *vdev;
@@ -44,6 +48,7 @@ typedef struct {
     VirtIOSCSIConf scsi;
     bool ioeventfd_disabled;
     bool ioeventfd_started;
+    unsigned bar0_mask;
 } VirtIOPCIProxy;
 
 void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev);
-- 
1.7.9.111.gf3fb0
