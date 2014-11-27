From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v4 12/16] virtio: allow to fail setting status
Date: Thu, 27 Nov 2014 16:16:45 +0100
Message-ID: <1417101409-29482-13-git-send-email-cornelia.huck__37291.1235354424$1417101558$gmane$org@de.ibm.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

virtio-1 allow setting of the FEATURES_OK status bit to fail if
the negotiated feature bits are inconsistent: let's fail
virtio_set_status() in that case and update virtio-ccw to post an
error to the guest.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c      |   20 ++++++++++++--------
 hw/virtio/virtio.c         |   24 +++++++++++++++++++++++-
 include/hw/virtio/virtio.h |    3 ++-
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 60d67a3..65bef4b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -547,15 +547,19 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
                 virtio_ccw_stop_ioeventfd(dev);
             }
-            virtio_set_status(vdev, status);
-            if (vdev->status == 0) {
-                virtio_reset(vdev);
-            }
-            if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
-                virtio_ccw_start_ioeventfd(dev);
+            if (virtio_set_status(vdev, status) == 0) {
+                if (vdev->status == 0) {
+                    virtio_reset(vdev);
+                }
+                if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
+                    virtio_ccw_start_ioeventfd(dev);
+                }
+                sch->curr_status.scsw.count = ccw.count - sizeof(status);
+                ret = 0;
+            } else {
+                /* Trigger a command reject. */
+                ret = -ENOSYS;
             }
-            sch->curr_status.scsw.count = ccw.count - sizeof(status);
-            ret = 0;
         }
         break;
     case CCW_CMD_SET_IND:
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8cdc0cb..ab5c671 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -548,15 +548,37 @@ void virtio_update_irq(VirtIODevice *vdev)
     virtio_notify_vector(vdev, VIRTIO_NO_VECTOR);
 }
 
-void virtio_set_status(VirtIODevice *vdev, uint8_t val)
+static int virtio_validate_features(VirtIODevice *vdev)
+{
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+
+    if (k->validate_features) {
+        return k->validate_features(vdev);
+    } else {
+        return 0;
+    }
+}
+
+int virtio_set_status(VirtIODevice *vdev, uint8_t val)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
     trace_virtio_set_status(vdev, val);
 
+    if (!virtio_device_is_legacy(vdev)) {
+        if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
+            val & VIRTIO_CONFIG_S_FEATURES_OK) {
+            int ret = virtio_validate_features(vdev);
+
+            if (ret) {
+                return ret;
+            }
+        }
+    }
     if (k->set_status) {
         k->set_status(vdev, val);
     }
     vdev->status = val;
+    return 0;
 }
 
 bool target_words_bigendian(void);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index ec1be3b..601578f 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -152,6 +152,7 @@ typedef struct VirtioDeviceClass {
                              uint32_t requested_features);
     uint32_t (*bad_features)(VirtIODevice *vdev, unsigned int index);
     void (*set_features)(VirtIODevice *vdev, unsigned int index, uint32_t val);
+    int (*validate_features)(VirtIODevice *vdev);
     void (*get_config)(VirtIODevice *vdev, uint8_t *config);
     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
     void (*reset)(VirtIODevice *vdev);
@@ -235,7 +236,7 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
 void virtio_queue_notify(VirtIODevice *vdev, int n);
 uint16_t virtio_queue_vector(VirtIODevice *vdev, int n);
 void virtio_queue_set_vector(VirtIODevice *vdev, int n, uint16_t vector);
-void virtio_set_status(VirtIODevice *vdev, uint8_t val);
+int virtio_set_status(VirtIODevice *vdev, uint8_t val);
 void virtio_reset(void *opaque);
 void virtio_update_irq(VirtIODevice *vdev);
 int virtio_set_features(VirtIODevice *vdev, unsigned int index, uint32_t val);
-- 
1.7.9.5
