From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 10/20] s390x/virtio-ccw: add virtio set-revision call
Date: Thu, 11 Dec 2014 14:25:12 +0100
Message-ID: <1418304322-7546-11-git-send-email-cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Handle the virtio-ccw revision according to what the guest sets.
When revision 1 is selected, we have a virtio-1 standard device
with byteswapping for the virtio rings.

When a channel gets disabled, we have to revert to the legacy behavior
in case the next user of the device does not negotiate the revision 1
anymore (e.g. the boot firmware uses revision 1, but the operating
system only uses the legacy mode).

Note that revisions > 0 are still disabled.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h |    8 ++++++++
 2 files changed, 60 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index fbd909d..ea2c6f0 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -20,9 +20,11 @@
 #include "hw/virtio/virtio-net.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
+#include "hw/virtio/virtio-access.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/s390x/adapter.h"
 #include "hw/s390x/s390_flic.h"
+#include "linux/virtio_config.h"
 
 #include "ioinst.h"
 #include "css.h"
@@ -260,6 +262,12 @@ typedef struct VirtioThinintInfo {
     uint8_t isc;
 } QEMU_PACKED VirtioThinintInfo;
 
+typedef struct VirtioRevInfo {
+    uint16_t revision;
+    uint16_t length;
+    uint8_t data[0];
+} QEMU_PACKED VirtioRevInfo;
+
 /* Specify where the virtqueues for the subchannel are in guest memory. */
 static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
                               uint16_t index, uint16_t num)
@@ -299,6 +307,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
 {
     int ret;
     VqInfoBlock info;
+    VirtioRevInfo revinfo;
     uint8_t status;
     VirtioFeatDesc features;
     void *config;
@@ -375,6 +384,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 features.features = (uint32_t)dev->host_features;
             } else if (features.index == 1) {
                 features.features = (uint32_t)(dev->host_features >> 32);
+                /*
+                 * Don't offer version 1 to the guest if it did not
+                 * negotiate at least revision 1.
+                 */
+                if (dev->revision <= 0) {
+                    features.features &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+                }
             } else {
                 /* Return zeroes if the guest supports more feature bits. */
                 features.features = 0;
@@ -406,6 +422,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                     (vdev->guest_features & 0xffffffff00000000) |
                                     features.features);
             } else if (features.index == 1) {
+                /*
+                 * The guest should not set version 1 if it didn't
+                 * negotiate a revision >= 1.
+                 */
+                if (dev->revision <= 0) {
+                    features.features &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+                }
                 virtio_set_features(vdev,
                                     (vdev->guest_features & 0x00000000ffffffff) |
                                     ((uint64_t)features.features << 32));
@@ -608,6 +631,25 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             }
         }
         break;
+    case CCW_CMD_SET_VIRTIO_REV:
+        len = sizeof(revinfo);
+        if (ccw.count < len || (check_len && ccw.count > len)) {
+            ret = -EINVAL;
+            break;
+        }
+        if (!ccw.cda) {
+            ret = -EFAULT;
+            break;
+        }
+        cpu_physical_memory_read(ccw.cda, &revinfo, len);
+        if (dev->revision >= 0 ||
+            revinfo.revision > virtio_ccw_rev_max(dev)) {
+            ret = -ENOSYS;
+            break;
+        }
+        ret = 0;
+        dev->revision = revinfo.revision;
+        break;
     default:
         ret = -ENOSYS;
         break;
@@ -615,6 +657,13 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
     return ret;
 }
 
+static void virtio_sch_disable_cb(SubchDev *sch)
+{
+    VirtioCcwDevice *dev = sch->driver_data;
+
+    dev->revision = -1;
+}
+
 static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
 {
     unsigned int cssid = 0;
@@ -740,6 +789,7 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     css_sch_build_virtual_schib(sch, 0, VIRTIO_CCW_CHPID_TYPE);
 
     sch->ccw_cb = virtio_ccw_cb;
+    sch->disable_cb = virtio_sch_disable_cb;
 
     /* Build senseid data. */
     memset(&sch->id, 0, sizeof(SenseId));
@@ -747,6 +797,8 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     sch->id.cu_type = VIRTIO_CCW_CU_TYPE;
     sch->id.cu_model = vdev->device_id;
 
+    dev->revision = -1;
+
     /* Set default feature bits that are offered by the host. */
     virtio_add_feature(&dev->host_features, VIRTIO_F_NOTIFY_ON_EMPTY);
     virtio_add_feature(&dev->host_features, VIRTIO_F_BAD_FEATURE);
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 9087f7a..778ccb9 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -40,6 +40,7 @@
 #define CCW_CMD_SET_CONF_IND 0x53
 #define CCW_CMD_READ_VQ_CONF 0x32
 #define CCW_CMD_SET_IND_ADAPTER 0x73
+#define CCW_CMD_SET_VIRTIO_REV 0x83
 
 #define TYPE_VIRTIO_CCW_DEVICE "virtio-ccw-device"
 #define VIRTIO_CCW_DEVICE(obj) \
@@ -86,6 +87,7 @@ struct VirtioCcwDevice {
     SubchDev *sch;
     char *bus_id;
     uint64_t host_features;
+    int revision;
     VirtioBusState bus;
     bool ioeventfd_started;
     bool ioeventfd_disabled;
@@ -99,6 +101,12 @@ struct VirtioCcwDevice {
     uint64_t ind_bit;
 };
 
+/* The maximum virtio revision we support. */
+static inline int virtio_ccw_rev_max(VirtioCcwDevice *dev)
+{
+    return 0;
+}
+
 /* virtual css bus type */
 typedef struct VirtualCssBus {
     BusState parent_obj;
-- 
1.7.9.5
