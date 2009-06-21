From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv6 09/12] qemu/virtio: virtio save/load bindings
Date: Sun, 21 Jun 2009 19:50:40 +0300
Message-ID: <20090621165040.GJ10164__38373.0841837407$1245604114$gmane$org@redhat.com>
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

Implement bindings for virtio save/load. Use them in virtio pci.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio-pci.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 hw/virtio.c     |   33 ++++++++++++++++-----------------
 hw/virtio.h     |    4 ++++
 3 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index d3f4884..4db0b88 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -105,6 +105,46 @@ static void virtio_pci_notify(void *opaque, uint16_t vector)
         qemu_set_irq(proxy->pci_dev.irq[0], proxy->vdev->isr & 1);
 }
 
+static void virtio_pci_save_config(void * opaque, QEMUFile *f)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    pci_device_save(&proxy->pci_dev, f);
+    msix_save(&proxy->pci_dev, f);
+    if (msix_present(&proxy->pci_dev))
+        qemu_put_be16(f, proxy->vdev->config_vector);
+}
+
+static void virtio_pci_save_queue(void * opaque, int n, QEMUFile *f)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    if (msix_present(&proxy->pci_dev))
+        qemu_put_be16(f, virtio_queue_vector(proxy->vdev, n));
+}
+
+static int virtio_pci_load_config(void * opaque, QEMUFile *f)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    int ret;
+    ret = pci_device_load(&proxy->pci_dev, f);
+    if (ret)
+        return ret;
+    msix_load(&proxy->pci_dev, f);
+    if (msix_present(&proxy->pci_dev))
+        qemu_get_be16s(f, &proxy->vdev->config_vector);
+    return 0;
+}
+
+static int virtio_pci_load_queue(void * opaque, int n, QEMUFile *f)
+{
+    VirtIOPCIProxy *proxy = opaque;
+    uint16_t vector;
+    if (!msix_present(&proxy->pci_dev))
+        return 0;
+    qemu_get_be16s(f, &vector);
+    virtio_queue_set_vector(proxy->vdev, n, vector);
+    return 0;
+}
+
 static void virtio_pci_reset(void *opaque)
 {
     VirtIOPCIProxy *proxy = opaque;
@@ -317,7 +357,11 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
 }
 
 static const VirtIOBindings virtio_pci_bindings = {
-    .notify = virtio_pci_notify
+    .notify = virtio_pci_notify,
+    .save_config = virtio_pci_save_config,
+    .load_config = virtio_pci_load_config,
+    .save_queue = virtio_pci_save_queue,
+    .load_queue = virtio_pci_load_queue,
 };
 
 static void virtio_init_pci(VirtIOPCIProxy *proxy, VirtIODevice *vdev,
diff --git a/hw/virtio.c b/hw/virtio.c
index fe9f793..b773dff 100644
--- a/hw/virtio.c
+++ b/hw/virtio.c
@@ -568,9 +568,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
 {
     int i;
 
-    /* FIXME: load/save binding.  */
-    //pci_device_save(&vdev->pci_dev, f);
-    //msix_save(&vdev->pci_dev, f);
+    if (vdev->binding->save_config)
+        vdev->binding->save_config(vdev->binding_opaque, f);
 
     qemu_put_8s(f, &vdev->status);
     qemu_put_8s(f, &vdev->isr);
@@ -596,18 +595,20 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
         qemu_put_be32(f, vdev->vq[i].vring.num);
         qemu_put_be64(f, vdev->vq[i].pa);
         qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
-        if (vdev->nvectors)
-            qemu_put_be16s(f, &vdev->vq[i].vector);
+        if (vdev->binding->save_queue)
+            vdev->binding->save_queue(vdev->binding_opaque, i, f);
     }
 }
 
-void virtio_load(VirtIODevice *vdev, QEMUFile *f)
+int virtio_load(VirtIODevice *vdev, QEMUFile *f)
 {
-    int num, i;
+    int num, i, ret;
 
-    /* FIXME: load/save binding.  */
-    //pci_device_load(&vdev->pci_dev, f);
-    //r = msix_load(&vdev->pci_dev, f);
+    if (vdev->binding->load_config) {
+        ret = vdev->binding->load_config(vdev->binding_opaque, f);
+        if (ret)
+            return ret;
+    }
 
     qemu_get_8s(f, &vdev->status);
     qemu_get_8s(f, &vdev->isr);
@@ -616,10 +617,6 @@ void virtio_load(VirtIODevice *vdev, QEMUFile *f)
     vdev->config_len = qemu_get_be32(f);
     qemu_get_buffer(f, vdev->config, vdev->config_len);
 
-    if (vdev->nvectors) {
-        qemu_get_be16s(f, &vdev->config_vector);
-        //msix_vector_use(&vdev->pci_dev, vdev->config_vector);
-    }
     num = qemu_get_be32(f);
 
     for (i = 0; i < num; i++) {
@@ -630,13 +627,15 @@ void virtio_load(VirtIODevice *vdev, QEMUFile *f)
         if (vdev->vq[i].pa) {
             virtqueue_init(&vdev->vq[i]);
         }
-        if (vdev->nvectors) {
-            qemu_get_be16s(f, &vdev->vq[i].vector);
-            //msix_vector_use(&vdev->pci_dev, vdev->config_vector);
+        if (vdev->binding->load_queue) {
+            ret = vdev->binding->load_queue(vdev->binding_opaque, i, f);
+            if (ret)
+                return ret;
         }
     }
 
     virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
+    return 0;
 }
 
 void virtio_cleanup(VirtIODevice *vdev)
diff --git a/hw/virtio.h b/hw/virtio.h
index 04a3c3d..ce05517 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -72,6 +72,10 @@ typedef struct VirtQueueElement
 
 typedef struct {
     void (*notify)(void * opaque, uint16_t vector);
+    void (*save_config)(void * opaque, QEMUFile *f);
+    void (*save_queue)(void * opaque, int n, QEMUFile *f);
+    int (*load_config)(void * opaque, QEMUFile *f);
+    int (*load_queue)(void * opaque, int n, QEMUFile *f);
 } VirtIOBindings;
 
 #define VIRTIO_PCI_QUEUE_MAX 16
-- 
1.6.2.2
