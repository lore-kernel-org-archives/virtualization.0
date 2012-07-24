From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH 1/2] vhost-scsi: Rename vhost_vring_target -> vhost_scsi_target
Date: Tue, 24 Jul 2012 01:30:09 +0000
Message-ID: <1343093410-5843-2-git-send-email-nab@linux-iscsi.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

Rename the main IOCTL structure to vhost_scsi_target so that
it makes a little more sense than vhost_vring_target.

As requested by MST.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/vhost-scsi.c |    4 ++--
 hw/vhost-scsi.h |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vhost-scsi.c b/hw/vhost-scsi.c
index 3e3378a..3e9fa0e 100644
--- a/hw/vhost-scsi.c
+++ b/hw/vhost-scsi.c
@@ -49,7 +49,7 @@ const char *vhost_scsi_get_id(VHostSCSI *vs)
 int vhost_scsi_start(VHostSCSI *vs, VirtIODevice *vdev)
 {
     int ret;
-    struct vhost_vring_target backend;
+    struct vhost_scsi_target backend;
 
     if (!vhost_dev_query(&vs->dev, vdev)) {
         return -ENOTSUP;
@@ -86,7 +86,7 @@ void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev)
     fprintf(stderr, "vhost_scsi_stop\n");
 
     int ret;
-    struct vhost_vring_target backend;
+    struct vhost_scsi_target backend;
 
     pstrcpy((char *)backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
     backend.vhost_tpgt = vs->tpgt;
diff --git a/hw/vhost-scsi.h b/hw/vhost-scsi.h
index 84e9097..8ce974a 100644
--- a/hw/vhost-scsi.h
+++ b/hw/vhost-scsi.h
@@ -19,14 +19,14 @@
 
 /* TODO #include <linux/vhost.h> properly */
 /* For VHOST_SCSI_SET_ENDPOINT/VHOST_SCSI_CLEAR_ENDPOINT ioctl */
-struct vhost_vring_target {
+struct vhost_scsi_target {
     unsigned char vhost_wwpn[224];
     unsigned short vhost_tpgt;
 };
 
 #define VHOST_VIRTIO 0xAF
-#define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_vring_target)
-#define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_vring_target)
+#define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
+#define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
 
 VHostSCSI *find_vhost_scsi(const char *id);
 const char *vhost_scsi_get_id(VHostSCSI *vs);
-- 
1.7.2.5
