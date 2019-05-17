From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 4/4] vhost: scsi: add weight support
Date: Fri, 17 May 2019 00:29:52 -0400
Message-ID: <1558067392-11740-5-git-send-email-jasowang__17999.0935184591$1558067467$gmane$org@redhat.com>
References: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch will check the weight and exit the loop if we exceeds the
weight. This is useful for preventing scsi kthread from hogging cpu
which is guest triggerable.

This addresses CVE-2019-3900.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/scsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index d830579..3a59f47 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -918,7 +918,7 @@ static void vhost_scsi_submission_work(struct work_struct *work)
 	struct iov_iter in_iter, prot_iter, data_iter;
 	u64 tag;
 	u32 exp_data_len, data_direction;
-	int ret, prot_bytes;
+	int ret, prot_bytes, c = 0;
 	u16 lun;
 	u8 task_attr;
 	bool t10_pi = vhost_has_feature(vq, VIRTIO_SCSI_F_T10_PI);
@@ -938,7 +938,7 @@ static void vhost_scsi_submission_work(struct work_struct *work)
 
 	vhost_disable_notify(&vs->dev, vq);
 
-	for (;;) {
+	do {
 		ret = vhost_scsi_get_desc(vs, vq, &vc);
 		if (ret)
 			goto err;
@@ -1118,7 +1118,7 @@ static void vhost_scsi_submission_work(struct work_struct *work)
 			break;
 		else if (ret == -EIO)
 			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out);
-	}
+	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
 }
@@ -1177,7 +1177,7 @@ static void vhost_scsi_submission_work(struct work_struct *work)
 	} v_req;
 	struct vhost_scsi_ctx vc;
 	size_t typ_size;
-	int ret;
+	int ret, c = 0;
 
 	mutex_lock(&vq->mutex);
 	/*
@@ -1191,7 +1191,7 @@ static void vhost_scsi_submission_work(struct work_struct *work)
 
 	vhost_disable_notify(&vs->dev, vq);
 
-	for (;;) {
+	do {
 		ret = vhost_scsi_get_desc(vs, vq, &vc);
 		if (ret)
 			goto err;
@@ -1270,7 +1270,7 @@ static void vhost_scsi_submission_work(struct work_struct *work)
 			break;
 		else if (ret == -EIO)
 			vhost_scsi_send_bad_target(vs, vq, vc.head, vc.out);
-	}
+	} while (likely(!vhost_exceeds_weight(vq, ++c, 0)));
 out:
 	mutex_unlock(&vq->mutex);
 }
-- 
1.8.3.1
