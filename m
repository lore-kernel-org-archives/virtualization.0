From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv6 07/12] qemu/virtio: virtio support for many interrupt vectors
Date: Sun, 21 Jun 2009 19:50:13 +0300
Message-ID: <20090621165013.GH10164__9902.166928123$1245603779$gmane$org@redhat.com>
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

Extend virtio to support many interrupt vectors, and rearrange code in
preparation for multi-vector support (mostly move reset out to bindings,
because we will have to reset the vectors in transport-specific code).
Actual bindings in pci, and use in net, to follow.
Load and save are not connected to bindings yet, so they are left
stubbed out for now.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/syborg_virtio.c |   13 ++++++++--
 hw/virtio-pci.c    |   24 ++++++++++++++++----
 hw/virtio.c        |   59 ++++++++++++++++++++++++++++++++++++++-------------
 hw/virtio.h        |   10 +++++++-
 4 files changed, 81 insertions(+), 25 deletions(-)

diff --git a/hw/syborg_virtio.c b/hw/syborg_virtio.c
index 8e665c6..108af06 100644
--- a/hw/syborg_virtio.c
+++ b/hw/syborg_virtio.c
@@ -134,7 +134,10 @@ static void syborg_virtio_writel(void *opaque, target_phys_addr_t offset,
         vdev->features = value;
         break;
     case SYBORG_VIRTIO_QUEUE_BASE:
-        virtio_queue_set_addr(vdev, vdev->queue_sel, value);
+        if (value == 0)
+            virtio_reset(vdev);
+        else
+            virtio_queue_set_addr(vdev, vdev->queue_sel, value);
         break;
     case SYBORG_VIRTIO_QUEUE_SEL:
         if (value < VIRTIO_PCI_QUEUE_MAX)
@@ -228,7 +231,7 @@ static CPUWriteMemoryFunc *syborg_virtio_writefn[] = {
      syborg_virtio_writel
 };
 
-static void syborg_virtio_update_irq(void *opaque)
+static void syborg_virtio_update_irq(void *opaque, uint16_t vector)
 {
     SyborgVirtIOProxy *proxy = opaque;
     int level;
@@ -239,7 +242,7 @@ static void syborg_virtio_update_irq(void *opaque)
 }
 
 static VirtIOBindings syborg_virtio_bindings = {
-    .update_irq = syborg_virtio_update_irq
+    .notify = syborg_virtio_update_irq
 };
 
 static void syborg_virtio_init(SyborgVirtIOProxy *proxy, VirtIODevice *vdev)
@@ -248,6 +251,8 @@ static void syborg_virtio_init(SyborgVirtIOProxy *proxy, VirtIODevice *vdev)
 
     proxy->vdev = vdev;
 
+    /* Don't support multiple vectors */
+    proxy->vdev->nvectors = 0;
     sysbus_init_irq(&proxy->busdev, &proxy->irq);
     iomemtype = cpu_register_io_memory(syborg_virtio_readfn,
                                        syborg_virtio_writefn, proxy);
@@ -255,6 +260,8 @@ static void syborg_virtio_init(SyborgVirtIOProxy *proxy, VirtIODevice *vdev)
 
     proxy->id = ((uint32_t)0x1af4 << 16) | vdev->device_id;
 
+    qemu_register_reset(virtio_reset, 0, vdev);
+
     virtio_bind_device(vdev, &syborg_virtio_bindings, proxy);
 }
 
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 24fe837..d4a134d 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -78,13 +78,19 @@ typedef struct {
 
 /* virtio device */
 
-static void virtio_pci_update_irq(void *opaque)
+static void virtio_pci_notify(void *opaque, uint16_t vector)
 {
     VirtIOPCIProxy *proxy = opaque;
 
     qemu_set_irq(proxy->pci_dev.irq[0], proxy->vdev->isr & 1);
 }
 
+static void virtio_pci_reset(void *opaque)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    virtio_reset(proxy->vdev);
+}
+
 static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIOPCIProxy *proxy = opaque;
@@ -108,7 +114,10 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
         break;
     case VIRTIO_PCI_QUEUE_PFN:
         pa = (target_phys_addr_t)val << VIRTIO_PCI_QUEUE_ADDR_SHIFT;
-        virtio_queue_set_addr(vdev, vdev->queue_sel, pa);
+        if (pa == 0)
+            virtio_pci_reset(proxy);
+        else
+            virtio_queue_set_addr(vdev, vdev->queue_sel, pa);
         break;
     case VIRTIO_PCI_QUEUE_SEL:
         if (val < VIRTIO_PCI_QUEUE_MAX)
@@ -120,7 +129,7 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
     case VIRTIO_PCI_STATUS:
         vdev->status = val & 0xFF;
         if (vdev->status == 0)
-            virtio_reset(vdev);
+            virtio_pci_reset(proxy);
         break;
     }
 }
@@ -158,7 +167,7 @@ static uint32_t virtio_ioport_read(void *opaque, uint32_t addr)
         /* reading from the ISR also clears it. */
         ret = vdev->isr;
         vdev->isr = 0;
-        virtio_update_irq(vdev);
+        qemu_set_irq(proxy->pci_dev.irq[0], 0);
         break;
     default:
         break;
@@ -243,7 +252,7 @@ static void virtio_map(PCIDevice *pci_dev, int region_num,
 }
 
 static const VirtIOBindings virtio_pci_bindings = {
-    .update_irq = virtio_pci_update_irq
+    .notify = virtio_pci_notify
 };
 
 static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
@@ -255,6 +264,9 @@ static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
 
     proxy->vdev = vdev;
 
+    /* No support for multiple vectors yet. */
+    proxy->vdev->nvectors = 0;
+
     config = proxy->pci_dev.config;
     pci_config_set_vendor_id(config, vendor);
     pci_config_set_device_id(config, device);
@@ -279,6 +291,8 @@ static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
     pci_register_bar(&proxy->pci_dev, 0, size, PCI_ADDRESS_SPACE_IO,
                            virtio_map);
 
+    qemu_register_reset(virtio_pci_reset, 0, proxy);
+
     virtio_bind_device(vdev, &virtio_pci_bindings, proxy);
 }
 
diff --git a/hw/virtio.c b/hw/virtio.c
index 45a49fa..fe9f793 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -68,6 +68,7 @@ struct VirtQueue
     target_phys_addr_t pa;
     uint16_t last_avail_idx;
     int inuse;
+    uint16_t vector;
     void (*handle_output)(VirtIODevice *vdev, VirtQueue *vq);
 };
 
@@ -373,12 +374,16 @@ int virtqueue_pop(VirtQueue *vq, VirtQueueElement *elem)
 }
 
 /* virtio device */
+static void virtio_notify_vector(VirtIODevice *vdev, uint16_t vector)
+{
+    if (vdev->binding->notify) {
+        vdev->binding->notify(vdev->binding_opaque, vector);
+    }
+}
 
 void virtio_update_irq(VirtIODevice *vdev)
 {
-    if (vdev->binding->update_irq) {
-        vdev->binding->update_irq(vdev->binding_opaque);
-    }
+    virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
 }
 
 void virtio_reset(void *opaque)
@@ -393,7 +398,8 @@ void virtio_reset(void *opaque)
     vdev->queue_sel = 0;
     vdev->status = 0;
     vdev->isr = 0;
-    virtio_update_irq(vdev);
+    vdev->config_vector = VIRTIO_NO_VECTOR;
+    virtio_notify_vector(vdev, vdev->config_vector);
 
     for(i = 0; i < VIRTIO_PCI_QUEUE_MAX; i++) {
         vdev->vq[i].vring.desc = 0;
@@ -401,6 +407,7 @@ void virtio_reset(void *opaque)
         vdev->vq[i].vring.used = 0;
         vdev->vq[i].last_avail_idx = 0;
         vdev->vq[i].pa = 0;
+        vdev->vq[i].vector = VIRTIO_NO_VECTOR;
     }
 }
 
@@ -484,12 +491,8 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data)
 
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, target_phys_addr_t addr)
 {
-    if (addr == 0) {
-        virtio_reset(vdev);
-    } else {
-        vdev->vq[n].pa = addr;
-        virtqueue_init(&vdev->vq[n]);
-    }
+    vdev->vq[n].pa = addr;
+    virtqueue_init(&vdev->vq[n]);
 }
 
 target_phys_addr_t virtio_queue_get_addr(VirtIODevice *vdev, int n)
@@ -509,6 +512,18 @@ void virtio_queue_notify(VirtIODevice *vdev, int n)
     }
 }
 
+uint16_t virtio_queue_vector(VirtIODevice *vdev, int n)
+{
+    return n < VIRTIO_PCI_QUEUE_MAX ? vdev->vq[n].vector :
+        VIRTIO_NO_VECTOR;
+}
+
+void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector)
+{
+    if (n < VIRTIO_PCI_QUEUE_MAX)
+        vdev->vq[n].vector = vector;
+}
+
 VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
                             void (*handle_output)(VirtIODevice *, VirtQueue *))
 {
@@ -537,7 +552,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
         return;
 
     vdev->isr |= 0x01;
-    virtio_update_irq(vdev);
+    virtio_notify_vector(vdev, vq->vector);
 }
 
 void virtio_notify_config(VirtIODevice *vdev)
@@ -546,7 +561,7 @@ void virtio_notify_config(VirtIODevice *vdev)
         return;
 
     vdev->isr |= 0x03;
-    virtio_update_irq(vdev);
+    virtio_notify_vector(vdev, vdev->config_vector);
 }
 
 void virtio_save(VirtIODevice *vdev, QEMUFile *f)
@@ -555,6 +570,7 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
 
     /* FIXME: load/save binding.  */
     //pci_device_save(&vdev->pci_dev, f);
+    //msix_save(&vdev->pci_dev, f);
 
     qemu_put_8s(f, &vdev->status);
     qemu_put_8s(f, &vdev->isr);
@@ -563,6 +579,9 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     qemu_put_be32(f, vdev->config_len);
     qemu_put_buffer(f, vdev->config, vdev->config_len);
 
+    if (vdev->nvectors)
+        qemu_put_be16s(f, &vdev->config_vector);
+
     for (i = 0; i < VIRTIO_PCI_QUEUE_MAX; i++) {
         if (vdev->vq[i].vring.num == 0)
             break;
@@ -577,6 +596,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
         qemu_put_be32(f, vdev->vq[i].vring.num);
         qemu_put_be64(f, vdev->vq[i].pa);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
+        if (vdev->nvectors)
+            qemu_put_be16s(f, &vdev->vq[i].vector);
     }
 }
 
@@ -586,6 +607,7 @@ void virtio_load(VirtIODevice *vdev, QEMUFile *f)
 
     /* FIXME: load/save binding.  */
     //pci_device_load(&vdev->pci_dev, f);
+    //r = msix_load(&vdev->pci_dev, f);
 
     qemu_get_8s(f, &vdev->status);
     qemu_get_8s(f, &vdev->isr);
@@ -594,6 +616,10 @@ void virtio_load(VirtIODevice *vdev, QEMUFile *f)
     vdev->config_len = qemu_get_be32(f);
     qemu_get_buffer(f, vdev->config, vdev->config_len);
 
+    if (vdev->nvectors) {
+        qemu_get_be16s(f, &vdev->config_vector);
+        //msix_vector_use(&vdev->pci_dev, vdev->config_vector);
+    }
     num = qemu_get_be32(f);
 
     for (i = 0; i < num; i++) {
@@ -604,9 +630,13 @@ void virtio_load(VirtIODevice *vdev, QEMUFile *f)
         if (vdev->vq[i].pa) {
             virtqueue_init(&vdev->vq[i]);
         }
+        if (vdev->nvectors) {
+            qemu_get_be16s(f, &vdev->vq[i].vector);
+            //msix_vector_use(&vdev->pci_dev, vdev->config_vector);
+        }
     }
 
-    virtio_update_irq(vdev);
+    virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
 }
 
 void virtio_cleanup(VirtIODevice *vdev)
@@ -627,6 +657,7 @@ VirtIODevice *virtio_common_init(const char *name, uint16_t device_id,
     vdev->status = 0;
     vdev->isr = 0;
     vdev->queue_sel = 0;
+    vdev->config_vector = VIRTIO_NO_VECTOR;
     vdev->vq = qemu_mallocz(sizeof(VirtQueue) * VIRTIO_PCI_QUEUE_MAX);
 
     vdev->name = name;
@@ -636,8 +667,6 @@ VirtIODevice *virtio_common_init(const char *name, uint16_t device_id,
     else
         vdev->config = NULL;
 
-    qemu_register_reset(virtio_reset, 0, vdev);
-
     return vdev;
 }
 
diff --git a/hw/virtio.h b/hw/virtio.h
index 425727e..04a3c3d 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -71,11 +71,13 @@ typedef struct VirtQueueElement
 } VirtQueueElement;
 
 typedef struct {
-    void (*update_irq)(void * opaque);
+    void (*notify)(void * opaque, uint16_t vector);
 } VirtIOBindings;
 
 #define VIRTIO_PCI_QUEUE_MAX 16
 
+#define VIRTIO_NO_VECTOR 0xffff
+
 struct VirtIODevice
 {
     const char *name;
@@ -85,6 +87,8 @@ struct VirtIODevice
     uint32_t features;
     size_t config_len;
     void *config;
+    uint16_t config_vector;
+    int nvectors;
     uint32_t (*get_features)(VirtIODevice *vdev);
     uint32_t (*bad_features)(VirtIODevice *vdev);
     void (*set_features)(VirtIODevice *vdev, uint32_t val);
@@ -114,7 +118,7 @@ void virtio_notify(VirtIODevice *vdev, VirtQueue *vq);
 
 void virtio_save(VirtIODevice *vdev, QEMUFile *f);
 
-void virtio_load(VirtIODevice *vdev, QEMUFile *f);
+int virtio_load(VirtIODevice *vdev, QEMUFile *f);
 
 void virtio_cleanup(VirtIODevice *vdev);
 
@@ -140,6 +144,8 @@ void virtio_queue_set_addr(VirtIODevice *vdev, int n, target_phys_addr_t addr);
 target_phys_addr_t virtio_queue_get_addr(VirtIODevice *vdev, int n);
 int virtio_queue_get_num(VirtIODevice *vdev, int n);
 void virtio_queue_notify(VirtIODevice *vdev, int n);
+uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
+void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
 void virtio_reset(void *opaque);
 void virtio_update_irq(VirtIODevice *vdev);
 
-- 
1.6.2.2
