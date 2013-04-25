From: Asias He <asias@redhat.com>
Subject: [PATCH v9 3/3] tcm_vhost: Add ioctl to get and set events missed flag
Date: Thu, 25 Apr 2013 11:10:06 +0800
Message-ID: <1366859406-8963-4-git-send-email-asias__20622.0762142495$1366859460$gmane$org@redhat.com>
References: <1366859406-8963-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1366859406-8963-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 17 +++++++++++++++++
 drivers/vhost/tcm_vhost.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 137ae34..9c01d2a 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -1202,8 +1202,11 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
 	struct vhost_scsi_target backend;
 	void __user *argp = (void __user *)arg;
 	u64 __user *featurep = argp;
+	u32 __user *eventsp = argp;
+	u32 events_missed;
 	u64 features;
 	int r, abi_version = VHOST_SCSI_ABI_VERSION;
+	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
 
 	switch (ioctl) {
 	case VHOST_SCSI_SET_ENDPOINT:
@@ -1224,6 +1227,20 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
 		if (copy_to_user(argp, &abi_version, sizeof abi_version))
 			return -EFAULT;
 		return 0;
+	case VHOST_SCSI_SET_EVENTS_MISSED:
+		if (get_user(events_missed, eventsp))
+			return -EFAULT;
+		mutex_lock(&vq->mutex);
+		vs->vs_events_missed = events_missed;
+		mutex_unlock(&vq->mutex);
+		return 0;
+	case VHOST_SCSI_GET_EVENTS_MISSED:
+		mutex_lock(&vq->mutex);
+		events_missed = vs->vs_events_missed;
+		mutex_unlock(&vq->mutex);
+		if (put_user(events_missed, eventsp))
+			return -EFAULT;
+		return 0;
 	case VHOST_GET_FEATURES:
 		features = VHOST_SCSI_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof features))
diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
index a545a5b..514b9fd 100644
--- a/drivers/vhost/tcm_vhost.h
+++ b/drivers/vhost/tcm_vhost.h
@@ -123,3 +123,6 @@ struct vhost_scsi_target {
 #define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
 /* Changing this breaks userspace. */
 #define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, int)
+/* Set and get the events missed flag */
+#define VHOST_SCSI_SET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x43, __u32)
+#define VHOST_SCSI_GET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x44, __u32)
-- 
1.8.1.4
