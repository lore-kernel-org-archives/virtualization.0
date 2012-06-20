From: Cong Meng <mc@linux.vnet.ibm.com>
Subject: [PATCH 2/2] virtio-scsi: Implement hotplug support for virtio-scsi
Date: Wed, 20 Jun 2012 14:47:11 +0800
Message-ID: <69a1a349ba21144e66843ab335cb3a243926bba8.1340022196.git.mc__26711.9338539944$1340300251$gmane$org@linux.vnet.ibm.com>
References: <cover.1340022196.git.mc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1340022196.git.mc@linux.vnet.ibm.com>
In-Reply-To: <cover.1340022196.git.mc@linux.vnet.ibm.com>
References: <cover.1340022196.git.mc@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: stefanha@linux.vnet.ibm.com, qemu-devel@nongnu.org, zwanp@cn.ibm.com, linuxram@us.ibm.com, senwang@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Implement the hotplug() and hot_unplug() interfaces in virtio-scsi, by signal
the virtio_scsi.ko in guest kernel via event virtual queue.

The counterpart patch of virtio_scsi.ko will be sent soon in another thread.

Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
Signed-off-by: Sen Wang <senwang@linux.vnet.ibm.com>
---
 hw/virtio-scsi.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
index e8328f4..626ec5f 100644
--- a/hw/virtio-scsi.c
+++ b/hw/virtio-scsi.c
@@ -24,6 +24,10 @@
 #define VIRTIO_SCSI_MAX_TARGET  255
 #define VIRTIO_SCSI_MAX_LUN     16383
 
+/* Feature Bits */
+#define VIRTIO_SCSI_F_INOUT                    0
+#define VIRTIO_SCSI_F_HOTPLUG                  1
+
 /* Response codes */
 #define VIRTIO_SCSI_S_OK                       0
 #define VIRTIO_SCSI_S_OVERRUN                  1
@@ -60,6 +64,11 @@
 #define VIRTIO_SCSI_T_TRANSPORT_RESET          1
 #define VIRTIO_SCSI_T_ASYNC_NOTIFY             2
 
+/* Reasons of transport reset event */     
+#define VIRTIO_SCSI_EVT_RESET_HARD             0
+#define VIRTIO_SCSI_EVT_RESET_RESCAN           1
+#define VIRTIO_SCSI_EVT_RESET_REMOVED          2
+
 /* SCSI command request, followed by data-out */
 typedef struct {
     uint8_t lun[8];              /* Logical Unit Number */
@@ -206,11 +215,12 @@ static void qemu_sgl_init_external(QEMUSGList *qsgl, struct iovec *sg,
 static void virtio_scsi_parse_req(VirtIOSCSI *s, VirtQueue *vq,
                                   VirtIOSCSIReq *req)
 {
-    assert(req->elem.out_num && req->elem.in_num);
+    assert(req->elem.in_num);
     req->vq = vq;
     req->dev = s;
     req->sreq = NULL;
-    req->req.buf = req->elem.out_sg[0].iov_base;
+    if (req->elem.out_num)
+        req->req.buf = req->elem.out_sg[0].iov_base;
     req->resp.buf = req->elem.in_sg[0].iov_base;
 
     if (req->elem.out_num > 1) {
@@ -405,6 +415,10 @@ static void virtio_scsi_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
     }
 }
 
+static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
 static void virtio_scsi_command_complete(SCSIRequest *r, uint32_t status,
                                          size_t resid)
 {
@@ -541,6 +555,7 @@ static void virtio_scsi_set_config(VirtIODevice *vdev,
 static uint32_t virtio_scsi_get_features(VirtIODevice *vdev,
                                          uint32_t requested_features)
 {
+    requested_features |= (1UL << VIRTIO_SCSI_F_HOTPLUG);
     return requested_features;
 }
 
@@ -568,6 +583,55 @@ static int virtio_scsi_load(QEMUFile *f, void *opaque, int version_id)
     return 0;
 }
 
+static void virtio_scsi_push_event(VirtIOSCSI *s, uint32_t target, uint32_t lun,
+                                   uint32_t event, uint32_t reason)
+{
+    VirtIOSCSIReq *req;
+    VirtIOSCSIEvent *evt;
+
+    if ((req = virtio_scsi_pop_req(s, s->event_vq))) {
+        int in_size;
+        if (req->elem.out_num || req->elem.in_num != 1) {
+            virtio_scsi_bad_req();
+        }
+
+        in_size = req->elem.in_sg[0].iov_len;
+        if (in_size < sizeof(VirtIOSCSIEvent)) {
+            virtio_scsi_bad_req();
+        }
+
+        evt = req->resp.event;
+        evt->event = event;
+        evt->reason = reason;
+        evt->lun[0] = 0;
+        evt->lun[1] = target;
+        evt->lun[2] = (lun >> 8);
+        evt->lun[3] = lun & 0xFF;
+        virtio_scsi_complete_req(req);
+    }
+}
+
+static void virtio_scsi_hotplug(SCSIBus *bus, SCSIDevice *dev)
+{
+    VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
+
+    if (((s->vdev.guest_features >> VIRTIO_SCSI_F_HOTPLUG) & 1) &&
+        (s->vdev.status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+        virtio_scsi_push_event(s, dev->id, dev->lun, 
+            VIRTIO_SCSI_T_TRANSPORT_RESET, VIRTIO_SCSI_EVT_RESET_RESCAN);
+    }
+}
+
+static void virtio_scsi_hot_unplug(SCSIBus *bus, SCSIDevice *dev)
+{
+    VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
+
+    if ((s->vdev.guest_features >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
+        virtio_scsi_push_event(s, dev->id, dev->lun, 
+            VIRTIO_SCSI_T_TRANSPORT_RESET, VIRTIO_SCSI_EVT_RESET_REMOVED);
+    }
+}
+
 static struct SCSIBusInfo virtio_scsi_scsi_info = {
     .tcq = true,
     .max_channel = VIRTIO_SCSI_MAX_CHANNEL,
@@ -576,6 +640,8 @@ static struct SCSIBusInfo virtio_scsi_scsi_info = {
 
     .complete = virtio_scsi_command_complete,
     .cancel = virtio_scsi_request_cancelled,
+    .hotplug = virtio_scsi_hotplug,
+    .hot_unplug = virtio_scsi_hot_unplug,
     .get_sg_list = virtio_scsi_get_sg_list,
     .save_request = virtio_scsi_save_request,
     .load_request = virtio_scsi_load_request,
@@ -604,7 +670,7 @@ VirtIODevice *virtio_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf)
     s->ctrl_vq = virtio_add_queue(&s->vdev, VIRTIO_SCSI_VQ_SIZE,
                                    virtio_scsi_handle_ctrl);
     s->event_vq = virtio_add_queue(&s->vdev, VIRTIO_SCSI_VQ_SIZE,
-                                   NULL);
+                                   virtio_scsi_handle_event);
     for (i = 0; i < s->conf->num_queues; i++) {
         s->cmd_vqs[i] = virtio_add_queue(&s->vdev, VIRTIO_SCSI_VQ_SIZE,
                                          virtio_scsi_handle_cmd);
-- 
1.7.7
