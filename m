From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH-v2] tcm_vhost: Avoid VIRTIO_RING_F_EVENT_IDX feature bit
Date: Fri, 29 Mar 2013 00:50:26 +0000
Message-ID: <1364518226-31372-1-git-send-email-nab__48559.7425177277$1364518931$gmane$org@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch adds a VHOST_SCSI_FEATURES mask minus VIRTIO_RING_F_EVENT_IDX
so that vhost-scsi-pci userspace will strip this feature bit once
GET_FEATURES reports it as being unsupported on the host.

This is to avoid a bug where ->handle_kicks() are missed when EVENT_IDX
is enabled by default in userspace code.

(mst: Rename to VHOST_SCSI_FEATURES add comment)

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Asias He <asias@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 drivers/vhost/tcm_vhost.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 0524267..4a68c1f 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -60,6 +60,15 @@ enum {
 	VHOST_SCSI_VQ_IO = 2,
 };
 
+/*
+ * VIRTIO_RING_F_EVENT_IDX seems broken. Not sure the bug is in
+ * kernel but disabling it helps.
+ * TODO: debug and remove the workaround.
+ */
+enum {
+	VHOST_SCSI_FEATURES = VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)
+};
+
 #define VHOST_SCSI_MAX_TARGET	256
 #define VHOST_SCSI_MAX_VQ	128
 
@@ -981,7 +990,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 
 static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 {
-	if (features & ~VHOST_FEATURES)
+	if (features & ~VHOST_SCSI_FEATURES)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&vs->dev.mutex);
@@ -1027,7 +1036,7 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return 0;
 	case VHOST_GET_FEATURES:
-		features = VHOST_FEATURES;
+		features = VHOST_SCSI_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
-- 
1.7.2.5
