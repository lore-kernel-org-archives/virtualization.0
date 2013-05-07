From: Asias He <asias@redhat.com>
Subject: [PATCH 3/4] vhost-scsi: Always access vq->private_data under vq mutex
Date: Tue,  7 May 2013 14:54:35 +0800
Message-ID: <1367909676-11788-4-git-send-email-asias@redhat.com>
References: <1367909676-11788-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367909676-11788-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/scsi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 5531ebc..d78768b 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -896,19 +896,15 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 	int head, ret;
 	u8 target;
 
+	mutex_lock(&vq->mutex);
 	/*
 	 * We can handle the vq only after the endpoint is setup by calling the
 	 * VHOST_SCSI_SET_ENDPOINT ioctl.
-	 *
-	 * TODO: Check that we are running from vhost_worker which acts
-	 * as read-side critical section for vhost kind of RCU.
-	 * See the comments in struct vhost_virtqueue in drivers/vhost/vhost.h
 	 */
-	vs_tpg = rcu_dereference_check(vq->private_data, 1);
+	vs_tpg = vq->private_data;
 	if (!vs_tpg)
-		return;
+		goto out;
 
-	mutex_lock(&vq->mutex);
 	vhost_disable_notify(&vs->dev, vq);
 
 	for (;;) {
@@ -1058,6 +1054,7 @@ err_free:
 	vhost_scsi_free_cmd(cmd);
 err_cmd:
 	vhost_scsi_send_bad_target(vs, vq, head, out);
+out:
 	mutex_unlock(&vq->mutex);
 }
 
-- 
1.8.1.4
