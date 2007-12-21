From: Dor Laor <dor.laor@gmail.com>
Subject: [Virtio-for-kvm] [PATCH 6/7] userspace virtio
Date: Fri, 21 Dec 2007 16:44:35 +0200
Message-ID: <476BD153.6080609__33611.19651604$1198248375$gmane$org@qumranet.com>
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

 From 1b493ba192cd677d9feb886eb494cb266a8604e2 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Thu, 20 Dec 2007 10:48:32 +0200
Subject: [PATCH] [VIRTIO] Add virtio_reset callback

Call it when the driver sets the pfn to zero and
also on qemu_reset notifier list.
This fixes crashes when virtio driver unloads or when
rebooting the guest.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 qemu/hw/virtio.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/qemu/hw/virtio.c b/qemu/hw/virtio.c
index 6a1d380..e7fcfa3 100644
--- a/qemu/hw/virtio.c
+++ b/qemu/hw/virtio.c
@@ -158,6 +158,25 @@ static void virtio_update_irq(VirtIODevice *vdev)
     qemu_set_irq(vdev->pci_dev.irq[0], vdev->isr & 1);
 }
 
+void virtio_reset(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+    int i;
+
+    vdev->features = 0;
+    vdev->queue_sel = 0;
+    vdev->status = 0;
+    vdev->isr = 0;
+
+    for(i = 0; i < VIRTIO_PCI_QUEUE_MAX; i++) {
+        vdev->vq[i].vring.desc = NULL;
+        vdev->vq[i].vring.avail = NULL;
+        vdev->vq[i].vring.used = NULL;
+        vdev->vq[i].last_avail_idx = 0;
+        vdev->vq[i].pfn = 0;
+    }
+}
+
 static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
 {
     VirtIODevice *vdev = to_virtio_device(opaque);
@@ -175,9 +194,7 @@ static void virtio_ioport_write(void *opaque, 
uint32_t addr, uint32_t val)
     pa = (ram_addr_t)val << TARGET_PAGE_BITS;
     vdev->vq[vdev->queue_sel].pfn = val;
     if (pa == 0) {
-        vdev->vq[vdev->queue_sel].vring.desc = NULL;
-        vdev->vq[vdev->queue_sel].vring.avail = NULL;
-        vdev->vq[vdev->queue_sel].vring.used = NULL;
+            virtio_reset(vdev);
     } else if (pa < (ram_size - TARGET_PAGE_SIZE)) {
         virtqueue_init(&vdev->vq[vdev->queue_sel], phys_ram_base + pa);
         /* FIXME if pa == 0, deal with device tear down */
@@ -417,6 +434,7 @@ VirtIODevice *virtio_init_pci(PCIBus *bus, const 
char *name,
 
     pci_register_io_region(pci_dev, 0, 20 + config_size, 
PCI_ADDRESS_SPACE_IO,
                virtio_map);
+    qemu_register_reset(virtio_reset, vdev);
 
     return vdev;
 }
-- 
1.5.3.3
