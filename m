From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC 7/9] virtio-scsi: Start/stop vhost
Date: Tue, 24 Jul 2012 22:34:04 +0000
Message-ID: <1343169246-17636-8-git-send-email-nab__10206.2058555477$1343169503$gmane$org@linux-iscsi.org>
References: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: target-devel <target-devel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

This patch starts and stops vhost as the virtio device transitions
through its status phases.  Vhost can only be started once the guest
reports its driver has successfully initialized, which means the
virtqueues have been set up by the guest.

(v2: Squash virtio-scsi: use the vhost-scsi host device from stefan)

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Signed-off-by: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/virtio-pci.c  |    2 ++
 hw/virtio-scsi.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 0f0f766..64f2f0d 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -1060,6 +1060,8 @@ static int virtio_scsi_exit_pci(PCIDevice *pci_dev)
 }
 
 static Property virtio_scsi_properties[] = {
+    DEFINE_PROP_VHOST_SCSI("vhost-scsi", VirtIOPCIProxy,
+                            scsi.vhost_scsi),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
     DEFINE_VIRTIO_SCSI_PROPERTIES(VirtIOPCIProxy, host_features, scsi),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
index dea3269..b0adfde 100644
--- a/hw/virtio-scsi.c
+++ b/hw/virtio-scsi.c
@@ -15,6 +15,7 @@
 
 #include "qemu-common.h"
 #include "qemu-error.h"
+#include "vhost-scsi.h"
 #include "virtio-scsi.h"
 #include <hw/scsi.h>
 #include <hw/scsi-defs.h>
@@ -601,6 +602,38 @@ static struct SCSIBusInfo virtio_scsi_scsi_info = {
     .load_request = virtio_scsi_load_request,
 };
 
+static bool virtio_scsi_started(VirtIOSCSI *s, uint8_t val)
+{
+    return (val & VIRTIO_CONFIG_S_DRIVER_OK) && s->vdev.vm_running;
+}
+
+static void virtio_scsi_set_status(VirtIODevice *vdev, uint8_t val)
+{
+    VirtIOSCSI *s = to_virtio_scsi(vdev);
+    bool start = virtio_scsi_started(s, val);
+
+    if (s->vhost_started == start) {
+        return;
+    }
+
+    if (start) {
+        int ret;
+
+        ret = vhost_scsi_start(s->vhost_scsi, vdev);
+        if (ret < 0) {
+            error_report("virtio-scsi: unable to start vhost: %s\n",
+                         strerror(-ret));
+
+            /* There is no userspace virtio-scsi fallback so exit */
+            exit(1);
+        }
+    } else {
+        vhost_scsi_stop(s->vhost_scsi, vdev);
+    }
+
+    s->vhost_started = start;
+}
+
 VirtIODevice *virtio_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf)
 {
     VirtIOSCSI *s;
@@ -622,6 +655,9 @@ VirtIODevice *virtio_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf)
     s->vdev.set_config = virtio_scsi_set_config;
     s->vdev.get_features = virtio_scsi_get_features;
     s->vdev.reset = virtio_scsi_reset;
+    if (s->vhost_scsi) {
+        s->vdev.set_status = virtio_scsi_set_status;
+    }
 
     s->ctrl_vq = virtio_add_queue(&s->vdev, VIRTIO_SCSI_VQ_SIZE,
                                    virtio_scsi_handle_ctrl);
@@ -647,6 +683,9 @@ void virtio_scsi_exit(VirtIODevice *vdev)
 {
     VirtIOSCSI *s = (VirtIOSCSI *)vdev;
     unregister_savevm(s->qdev, "virtio-scsi", s);
-    vhost_dev_cleanup(&s->vhost_scsi);
+
+    /* This will stop vhost backend if appropriate. */
+    virtio_scsi_set_status(vdev, 0);
+
     virtio_cleanup(vdev);
 }
-- 
1.7.2.5
