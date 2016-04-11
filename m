From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/2] s390x/virtio-ccw: respond to READ_STATUS command
Date: Mon, 11 Apr 2016 13:23:23 +0200
Message-ID: <1460373804-43477-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1460373804-43477-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1460373804-43477-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

This patch adds the response to the READ_STATUS CCW command.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c | 20 ++++++++++++++++++++
 hw/s390x/virtio-ccw.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index d51642d..569ab26 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -525,6 +525,26 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             }
         }
         break;
+    case CCW_CMD_READ_STATUS:
+        if (check_len) {
+            if (ccw.count != sizeof(status)) {
+                ret = -EINVAL;
+                break;
+            }
+        } else if (ccw.count < sizeof(status)) {
+            /* Can't execute command. */
+            ret = -EINVAL;
+            break;
+        }
+        if (!ccw.cda) {
+            ret = -EFAULT;
+        } else {
+            address_space_stb(&address_space_memory, ccw.cda, vdev->status,
+                                        MEMTXATTRS_UNSPECIFIED, NULL);
+            sch->curr_status.scsw.count = ccw.count - sizeof(vdev->status);
+            ret = 0;
+        }
+        break;
     case CCW_CMD_WRITE_STATUS:
         if (check_len) {
             if (ccw.count != sizeof(status)) {
diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 66c831b..6bc14ee 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -41,6 +41,7 @@
 #define CCW_CMD_SET_IND      0x43
 #define CCW_CMD_SET_CONF_IND 0x53
 #define CCW_CMD_READ_VQ_CONF 0x32
+#define CCW_CMD_READ_STATUS  0x72
 #define CCW_CMD_SET_IND_ADAPTER 0x73
 #define CCW_CMD_SET_VIRTIO_REV 0x83
 
-- 
2.6.6
