From: Asias He <asias@redhat.com>
Subject: [PATCH v2 3/4] tcm_vhost: Add vhost_scsi_send_bad_target() helper
Date: Wed, 10 Apr 2013 15:06:15 +0800
Message-ID: <1365577576-26183-4-git-send-email-asias@redhat.com>
References: <1365577576-26183-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365577576-26183-1-git-send-email-asias@redhat.com>
In-Reply-To: <1365564191-20928-1-git-send-email-asias@redhat.com>
References: <1365564191-20928-1-git-send-email-asias@redhat.com>
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

Share the send bad target code with other use cases.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 210d59e..1bb0fb4 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -578,6 +578,23 @@ static void tcm_vhost_submission_work(struct work_struct *work)
 	}
 }
 
+static void vhost_scsi_send_bad_target(struct vhost_scsi *vs,
+	struct vhost_virtqueue *vq, int head, unsigned out)
+{
+	struct virtio_scsi_cmd_resp __user *resp;
+	struct virtio_scsi_cmd_resp rsp;
+	int ret;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.response = VIRTIO_SCSI_S_BAD_TARGET;
+	resp = vq->iov[out].iov_base;
+	ret = __copy_to_user(resp, &rsp, sizeof(rsp));
+	if (!ret)
+		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
+	else
+		pr_err("Faulted on virtio_scsi_cmd_resp\n");
+}
+
 static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 	struct vhost_virtqueue *vq)
 {
@@ -673,19 +690,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 
 		/* Target does not exist, fail the request */
 		if (unlikely(!tv_tpg)) {
-			struct virtio_scsi_cmd_resp __user *resp;
-			struct virtio_scsi_cmd_resp rsp;
-
-			memset(&rsp, 0, sizeof(rsp));
-			rsp.response = VIRTIO_SCSI_S_BAD_TARGET;
-			resp = vq->iov[out].iov_base;
-			ret = __copy_to_user(resp, &rsp, sizeof(rsp));
-			if (!ret)
-				vhost_add_used_and_signal(&vs->dev,
-							  vq, head, 0);
-			else
-				pr_err("Faulted on virtio_scsi_cmd_resp\n");
-
+			vhost_scsi_send_bad_target(vs, vq, head, out);
 			continue;
 		}
 
-- 
1.8.1.4
