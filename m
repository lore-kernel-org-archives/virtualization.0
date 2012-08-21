From: Cong Meng <mc@linux.vnet.ibm.com>
Subject: [PATCH 2/2 v1] virtio-scsi: set per-LUN queue limits for sg devices
Date: Tue, 21 Aug 2012 16:23:47 +0800
Message-ID: <1345537427-21601-2-git-send-email-mc@linux.vnet.ibm.com>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
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
Cc: stefanha@linux.vnet.ibm.com, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Each virtio scsi HBA has global request queue limits. But the passthrough
LUNs (scsi-generic) come from different host HBAs may have different request
queue limits. If the guest sends commands that exceed the host limits, the
commands will be rejected by host HAB. 

To address the issue, this patch responses the newly added virtio control
queue request by returning the per-LUN queue limits.

Signed-off-by: Cong Meng <mc@linux.vnet.ibm.com>
---
 hw/virtio-scsi.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
index c4a5b22..3c0bd99 100644
--- a/hw/virtio-scsi.c
+++ b/hw/virtio-scsi.c
@@ -28,6 +28,7 @@
 #define VIRTIO_SCSI_F_INOUT                    0
 #define VIRTIO_SCSI_F_HOTPLUG                  1
 #define VIRTIO_SCSI_F_CHANGE                   2
+#define VIRTIO_SCSI_F_LUN_QUERY                3
 
 /* Response codes */
 #define VIRTIO_SCSI_S_OK                       0
@@ -48,6 +49,7 @@
 #define VIRTIO_SCSI_T_TMF                      0
 #define VIRTIO_SCSI_T_AN_QUERY                 1
 #define VIRTIO_SCSI_T_AN_SUBSCRIBE             2
+#define VIRTIO_SCSI_T_LUN_QUERY                3
 
 /* Valid TMF subtypes.  */
 #define VIRTIO_SCSI_T_TMF_ABORT_TASK           0
@@ -66,6 +68,11 @@
 #define VIRTIO_SCSI_T_ASYNC_NOTIFY             2
 #define VIRTIO_SCSI_T_PARAM_CHANGE             3
 
+/* LUN Query */
+#define VIRTIO_SCSI_T_LQ_MAX_SECTORS           0
+#define VIRTIO_SCSI_T_LQ_MAX_SEGMENTS          1
+#define VIRTIO_SCSI_T_LQ_MAX_SEGMENT_SIZE      2
+
 /* Reasons for transport reset event */
 #define VIRTIO_SCSI_EVT_RESET_HARD             0
 #define VIRTIO_SCSI_EVT_RESET_RESCAN           1
@@ -115,6 +122,18 @@ typedef struct {
     uint8_t response;
 } QEMU_PACKED VirtIOSCSICtrlANResp;
 
+/* LUN qeury */
+typedef struct {
+    uint32_t type;
+    uint8_t lun[8];
+    uint32_t subtype;
+} QEMU_PACKED VirtIOSCSICtrlLQReq;
+
+typedef struct {
+    uint32_t response;
+    uint32_t value;
+} QEMU_PACKED VirtIOSCSICtrlLQResp;
+
 typedef struct {
     uint32_t event;
     uint8_t lun[8];
@@ -160,6 +179,7 @@ typedef struct VirtIOSCSIReq {
         VirtIOSCSICmdReq      *cmd;
         VirtIOSCSICtrlTMFReq  *tmf;
         VirtIOSCSICtrlANReq   *an;
+        VirtIOSCSICtrlLQReq   *lq;
     } req;
     union {
         char                  *buf;
@@ -167,6 +187,7 @@ typedef struct VirtIOSCSIReq {
         VirtIOSCSICtrlTMFResp *tmf;
         VirtIOSCSICtrlANResp  *an;
         VirtIOSCSIEvent       *event;
+        VirtIOSCSICtrlLQResp  *lq;
     } resp;
 } VirtIOSCSIReq;
 
@@ -285,6 +306,43 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
     return req;
 }
 
+static void virtio_scsi_do_lun_query(VirtIOSCSI *s, VirtIOSCSIReq *req)
+{
+    SCSIDevice *d = virtio_scsi_device_find(s, req->req.lq->lun);
+
+    if (!d) {
+        goto fail;
+    }
+
+    switch (req->req.lq->subtype) {
+    case VIRTIO_SCSI_T_LQ_MAX_SECTORS:
+        req->resp.lq->value = get_queue_max_sectors(d->conf.bs);
+        if (!req->resp.lq->value) {
+            goto fail;
+        }
+        break;
+    case VIRTIO_SCSI_T_LQ_MAX_SEGMENTS:
+        req->resp.lq->value = get_queue_max_segments(d->conf.bs);
+        if (!req->resp.lq->value) {
+            goto fail;
+        }
+        break;
+    case VIRTIO_SCSI_T_LQ_MAX_SEGMENT_SIZE:
+        req->resp.lq->value = get_queue_max_segment_size(d->conf.bs);
+        if (!req->resp.lq->value) {
+            goto fail;
+        }
+        break;
+    default:
+        goto fail;
+    }
+
+    req->resp.lq->response = VIRTIO_SCSI_S_OK;
+    return;
+fail:
+    req->resp.lq->response = VIRTIO_SCSI_S_FAILURE;
+}
+
 static void virtio_scsi_do_tmf(VirtIOSCSI *s, VirtIOSCSIReq *req)
 {
     SCSIDevice *d = virtio_scsi_device_find(s, req->req.tmf->lun);
@@ -414,6 +472,12 @@ static void virtio_scsi_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
             }
             req->resp.an->event_actual = 0;
             req->resp.an->response = VIRTIO_SCSI_S_OK;
+        } else if (req->req.lq->type == VIRTIO_SCSI_T_LUN_QUERY) {
+            if (out_size < sizeof(VirtIOSCSICtrlLQReq) ||
+                in_size < sizeof(VirtIOSCSICtrlLQResp)) {
+                virtio_scsi_bad_req();
+            }
+            virtio_scsi_do_lun_query(s, req);
         }
         virtio_scsi_complete_req(req);
     }
@@ -557,6 +621,7 @@ static uint32_t virtio_scsi_get_features(VirtIODevice *vdev,
 {
     requested_features |= (1UL << VIRTIO_SCSI_F_HOTPLUG);
     requested_features |= (1UL << VIRTIO_SCSI_F_CHANGE);
+    requested_features |= (1UL << VIRTIO_SCSI_F_LUN_QUERY);
     return requested_features;
 }
 
-- 
1.7.7.6
