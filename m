From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 10/11] s390x/virtio-ccw: support virtio-1 set_vq format
Date: Tue,  7 Oct 2014 16:40:06 +0200
Message-ID: <1412692807-12398-11-git-send-email-cornelia.huck@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Support the new CCW_CMD_SET_VQ format for virtio-1 devices.

While we're at it, refactor the code a bit and enforce big endian
fields (which had always been required, even for legacy).

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c |  114 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 34 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 0d414f6..80efe88 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -238,11 +238,20 @@ VirtualCssBus *virtual_css_bus_init(void)
 }
 
 /* Communication blocks used by several channel commands. */
-typedef struct VqInfoBlock {
+typedef struct VqInfoBlockLegacy {
     uint64_t queue;
     uint32_t align;
     uint16_t index;
     uint16_t num;
+} QEMU_PACKED VqInfoBlockLegacy;
+
+typedef struct VqInfoBlock {
+    uint64_t desc;
+    uint32_t res0;
+    uint16_t index;
+    uint16_t num;
+    uint64_t avail;
+    uint64_t used;
 } QEMU_PACKED VqInfoBlock;
 
 typedef struct VqConfigBlock {
@@ -269,17 +278,20 @@ typedef struct VirtioRevInfo {
 } QEMU_PACKED VirtioRevInfo;
 
 /* Specify where the virtqueues for the subchannel are in guest memory. */
-static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
-                              uint16_t index, uint16_t num)
+static int virtio_ccw_set_vqs(SubchDev *sch, VqInfoBlock *info,
+                              VqInfoBlockLegacy *linfo)
 {
     VirtIODevice *vdev = virtio_ccw_get_vdev(sch);
+    uint16_t index = info ? info->index : linfo->index;
+    uint16_t num = info ? info->num : linfo->num;
+    uint64_t desc = info ? info->desc : linfo->queue;
 
     if (index > VIRTIO_PCI_QUEUE_MAX) {
         return -EINVAL;
     }
 
     /* Current code in virtio.c relies on 4K alignment. */
-    if (addr && (align != 4096)) {
+    if (linfo && desc && (linfo->align != 4096)) {
         return -EINVAL;
     }
 
@@ -287,8 +299,12 @@ static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
         return -EINVAL;
     }
 
-    virtio_queue_set_addr(vdev, index, addr);
-    if (!addr) {
+    if (info) {
+        virtio_queue_set_rings(vdev, index, desc, info->avail, info->used);
+    } else {
+        virtio_queue_set_addr(vdev, index, desc);
+    }
+    if (!desc) {
         virtio_queue_set_vector(vdev, index, 0);
     } else {
         /* Fail if we don't have a big enough queue. */
@@ -303,10 +319,66 @@ static int virtio_ccw_set_vqs(SubchDev *sch, uint64_t addr, uint32_t align,
     return 0;
 }
 
-static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
+static int virtio_ccw_handle_set_vq(SubchDev *sch, CCW1 ccw, bool check_len,
+                                    bool is_legacy)
 {
     int ret;
     VqInfoBlock info;
+    VqInfoBlockLegacy linfo;
+    size_t info_len = is_legacy ? sizeof(linfo) : sizeof(info);
+
+    if (check_len) {
+        if (ccw.count != info_len) {
+            return -EINVAL;
+        }
+    } else if (ccw.count < info_len) {
+        /* Can't execute command. */
+        return -EINVAL;
+    }
+    if (!ccw.cda) {
+        return -EFAULT;
+    }
+    if (is_legacy) {
+        linfo.queue = ldq_be_phys(&address_space_memory, ccw.cda);
+        linfo.align = ldl_be_phys(&address_space_memory,
+                                  ccw.cda + sizeof(linfo.queue));
+        linfo.index = lduw_be_phys(&address_space_memory,
+                                   ccw.cda + sizeof(linfo.queue)
+                                   + sizeof(linfo.align));
+        linfo.num = lduw_be_phys(&address_space_memory,
+                                 ccw.cda + sizeof(linfo.queue)
+                                 + sizeof(linfo.align)
+                                 + sizeof(linfo.index));
+        ret = virtio_ccw_set_vqs(sch, NULL, &linfo);
+    } else {
+        info.desc = ldq_be_phys(&address_space_memory, ccw.cda);
+        info.index = lduw_be_phys(&address_space_memory,
+                                  ccw.cda + sizeof(info.desc)
+                                  + sizeof(info.res0));
+        info.num = lduw_be_phys(&address_space_memory,
+                                ccw.cda + sizeof(info.desc)
+                              + sizeof(info.res0)
+                              + sizeof(info.index));
+        info.avail = ldq_be_phys(&address_space_memory,
+                                 ccw.cda + sizeof(info.desc)
+                                 + sizeof(info.res0)
+                                 + sizeof(info.index)
+                                 + sizeof(info.num));
+        info.used = ldq_be_phys(&address_space_memory,
+                                ccw.cda + sizeof(info.desc)
+                                + sizeof(info.res0)
+                                + sizeof(info.index)
+                                + sizeof(info.num)
+                                + sizeof(info.avail));
+        ret = virtio_ccw_set_vqs(sch, &info, NULL);
+    }
+    sch->curr_status.scsw.count = 0;
+    return ret;
+}
+
+static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
+{
+    int ret;
     VirtioRevInfo revinfo;
     uint8_t status;
     VirtioFeatDesc features;
@@ -331,33 +403,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
     /* Look at the command. */
     switch (ccw.cmd_code) {
     case CCW_CMD_SET_VQ:
-        if (check_len) {
-            if (ccw.count != sizeof(info)) {
-                ret = -EINVAL;
-                break;
-            }
-        } else if (ccw.count < sizeof(info)) {
-            /* Can't execute command. */
-            ret = -EINVAL;
-            break;
-        }
-        if (!ccw.cda) {
-            ret = -EFAULT;
-        } else {
-            info.queue = ldq_phys(&address_space_memory, ccw.cda);
-            info.align = ldl_phys(&address_space_memory,
-                                  ccw.cda + sizeof(info.queue));
-            info.index = lduw_phys(&address_space_memory,
-                                   ccw.cda + sizeof(info.queue)
-                                   + sizeof(info.align));
-            info.num = lduw_phys(&address_space_memory,
-                                 ccw.cda + sizeof(info.queue)
-                                 + sizeof(info.align)
-                                 + sizeof(info.index));
-            ret = virtio_ccw_set_vqs(sch, info.queue, info.align, info.index,
-                                     info.num);
-            sch->curr_status.scsw.count = 0;
-        }
+        ret = virtio_ccw_handle_set_vq(sch, ccw, check_len, dev->revision < 1);
         break;
     case CCW_CMD_VDEV_RESET:
         virtio_ccw_stop_ioeventfd(dev);
-- 
1.7.9.5
