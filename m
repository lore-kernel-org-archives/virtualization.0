From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH 4/5] virtio-scsi: Add start/stop functionality for vhost-scsi
Date: Fri,  7 Sep 2012 06:48:18 +0000
Message-ID: <1347000499-28701-5-git-send-email-nab__8713.42081013626$1347000813$gmane$org@linux-iscsi.org>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

This patch starts and stops vhost as the virtio device transitions
through its status phases.  Vhost can only be started once the guest
reports its driver has successfully initialized, which means the
virtqueues have been set up by the guest.

v3: - Add vhost-scsi.h include for DEFINE_PROP_VHOST_SCSI (mst + nab)
    - Move vhost-scsi related struct members ahead of *cmd_vqs[0] within
      VirtIOSCSI definition.  (paolo + nab)

v2: - Squash virtio-scsi: use the vhost-scsi host device from stefan (nab)
    - Fix up virtio_scsi_properties[] conflict w/ upstream qemu (nab)
    - Drop usage of to_virtio_scsi() in virtio_scsi_set_status()
      (reported by paolo)
    - Use modern VirtIOSCSIConf define in virtio-scsi.h (reported by paolo)
    - Use s->conf->vhost_scsi instead of proxyconf->vhost_scsi in
      virtio_scsi_init() (reported by paolo)
    - Only register QEMU SCSI bus is vhost-scsi is not active (reported
      by paolo)

Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/virtio-pci.c  |    2 ++
 hw/virtio-scsi.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio-scsi.h |    1 +
 3 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 125eded..8ec7cf1 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -22,6 +22,7 @@
 #include "virtio-net.h"
 #include "virtio-serial.h"
 #include "virtio-scsi.h"
+#include "vhost-scsi.h"
 #include "pci.h"
 #include "qemu-error.h"
 #include "msi.h"
@@ -1036,6 +1037,7 @@ static void virtio_scsi_exit_pci(PCIDevice *pci_dev)
 }
 
 static Property virtio_scsi_properties[] = {
+    DEFINE_PROP_VHOST_SCSI("vhost-scsi", VirtIOPCIProxy, scsi.vhost_scsi),
     DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags, VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, DEV_NVECTORS_UNSPECIFIED),
     DEFINE_VIRTIO_SCSI_PROPERTIES(VirtIOPCIProxy, host_features, scsi),
diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
index 5f737ac..edda097 100644
--- a/hw/virtio-scsi.c
+++ b/hw/virtio-scsi.c
@@ -13,9 +13,13 @@
  *
  */
 
+#include "qemu-common.h"
+#include "qemu-error.h"
+#include "vhost-scsi.h"
 #include "virtio-scsi.h"
 #include <hw/scsi.h>
 #include <hw/scsi-defs.h>
+#include "vhost.h"
 
 #define VIRTIO_SCSI_VQ_SIZE     128
 #define VIRTIO_SCSI_CDB_SIZE    32
@@ -144,6 +148,10 @@ typedef struct {
     uint32_t cdb_size;
     int resetting;
     bool events_dropped;
+
+    bool vhost_started;
+    VHostSCSI *vhost_scsi;
+
     VirtQueue *ctrl_vq;
     VirtQueue *event_vq;
     VirtQueue *cmd_vqs[0];
@@ -699,6 +707,38 @@ static struct SCSIBusInfo virtio_scsi_scsi_info = {
     .load_request = virtio_scsi_load_request,
 };
 
+static bool virtio_scsi_started(VirtIOSCSI *s, uint8_t val)
+{
+    return (val & VIRTIO_CONFIG_S_DRIVER_OK) && s->vdev.vm_running;
+}
+
+static void virtio_scsi_set_status(VirtIODevice *vdev, uint8_t val)
+{
+    VirtIOSCSI *s = (VirtIOSCSI *)vdev;
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
@@ -712,12 +752,17 @@ VirtIODevice *virtio_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf)
 
     s->qdev = dev;
     s->conf = proxyconf;
+    s->vhost_started = false;
+    s->vhost_scsi = s->conf->vhost_scsi;
 
     /* TODO set up vdev function pointers */
     s->vdev.get_config = virtio_scsi_get_config;
     s->vdev.set_config = virtio_scsi_set_config;
     s->vdev.get_features = virtio_scsi_get_features;
     s->vdev.reset = virtio_scsi_reset;
+    if (s->vhost_scsi) {
+        s->vdev.set_status = virtio_scsi_set_status;
+    }
 
     s->ctrl_vq = virtio_add_queue(&s->vdev, VIRTIO_SCSI_VQ_SIZE,
                                    virtio_scsi_handle_ctrl);
@@ -743,5 +788,9 @@ void virtio_scsi_exit(VirtIODevice *vdev)
 {
     VirtIOSCSI *s = (VirtIOSCSI *)vdev;
     unregister_savevm(s->qdev, "virtio-scsi", s);
+
+    /* This will stop vhost backend if appropriate. */
+    virtio_scsi_set_status(vdev, 0);
+
     virtio_cleanup(vdev);
 }
diff --git a/hw/virtio-scsi.h b/hw/virtio-scsi.h
index 4bc889d..74e9422 100644
--- a/hw/virtio-scsi.h
+++ b/hw/virtio-scsi.h
@@ -22,6 +22,7 @@
 #define VIRTIO_SCSI_F_CHANGE                   2
 
 struct VirtIOSCSIConf {
+    VHostSCSI *vhost_scsi;
     uint32_t num_queues;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
-- 
1.7.2.5
