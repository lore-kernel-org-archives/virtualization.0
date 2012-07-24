From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH 2/2] vhost-scsi: Add support for VHOST_SCSI_GET_ABI_VERSION
	ioctl
Date: Tue, 24 Jul 2012 01:30:10 +0000
Message-ID: <1343093410-5843-3-git-send-email-nab__20235.2601605982$1343093613$gmane$org@linux-iscsi.org>
References: <1343093410-5843-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343093410-5843-1-git-send-email-nab@linux-iscsi.org>
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

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch adds support in vhost-scsi QEMU userspace code to check the
running tcm_vhost ABI version using VHOST_SCSI_GET_ABI_VERSION.

This series selects VHOST_SCSI_ABI_VERSION=1 for current code, and
requires the pre-requsite tcm_vhost patch to expose an ABI version number.

This patch patch will fail to initialize vhost_scsi_start() unless both
vhost-scsi <-> tcm_vhost agree on VHOST_SCSI_ABI_VERSION=1.

Reported-by: Anthony Liguori <aliguori@us.ibm.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/vhost-scsi.c |   17 +++++++++++++++++
 hw/vhost-scsi.h |   11 +++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/hw/vhost-scsi.c b/hw/vhost-scsi.c
index 3e9fa0e..9ab314c 100644
--- a/hw/vhost-scsi.c
+++ b/hw/vhost-scsi.c
@@ -68,6 +68,23 @@ int vhost_scsi_start(VHostSCSI *vs, VirtIODevice *vdev)
         return ret;
     }
 
+    memset(&backend, 0, sizeof(backend));
+    ret = ioctl(vs->dev.control, VHOST_SCSI_GET_ABI_VERSION, &backend);
+    if (ret < 0) {
+        ret = -errno;
+        vhost_dev_stop(&vs->dev, vdev);
+        return ret;
+    }
+    if (backend.abi_version > VHOST_SCSI_ABI_VERSION) {
+        fprintf(stderr, "The running tcm_vhost kernel abi_version: %d is greater"
+		" than vhost_scsi userspace supports: %d\n", backend.abi_version,
+		VHOST_SCSI_ABI_VERSION);
+        ret = -ENOSYS;
+        vhost_dev_stop(&vs->dev, vdev);
+        return ret;
+    }
+    printf("Using TCM_Vhost ABI version: %d\n", backend.abi_version);
+
     pstrcpy((char *)backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
     backend.vhost_tpgt = vs->tpgt;
     ret = ioctl(vs->dev.control, VHOST_SCSI_SET_ENDPOINT, &backend);
diff --git a/hw/vhost-scsi.h b/hw/vhost-scsi.h
index 8ce974a..393fe39 100644
--- a/hw/vhost-scsi.h
+++ b/hw/vhost-scsi.h
@@ -17,9 +17,19 @@
 #include "qemu-common.h"
 #include "qemu-option.h"
 
+/*
+ * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
+ *
+ * ABI Rev 0: All pre 2012 revisions used by prototype out-of-tree code
+ * ABI Rev 1: 2012 version for v3.6 kernel merge candiate
+ */
+
+#define VHOST_SCSI_ABI_VERSION	1
+
 /* TODO #include <linux/vhost.h> properly */
 /* For VHOST_SCSI_SET_ENDPOINT/VHOST_SCSI_CLEAR_ENDPOINT ioctl */
 struct vhost_scsi_target {
+    int abi_version;
     unsigned char vhost_wwpn[224];
     unsigned short vhost_tpgt;
 };
@@ -27,6 +37,7 @@ struct vhost_scsi_target {
 #define VHOST_VIRTIO 0xAF
 #define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
 #define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
+#define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, struct vhost_scsi_target)
 
 VHostSCSI *find_vhost_scsi(const char *id);
 const char *vhost_scsi_get_id(VHostSCSI *vs);
-- 
1.7.2.5
