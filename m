From: Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH] vhost/scsi: fix reuse of &vq->iov[out] in response
Date: Mon,  6 Jun 2016 18:01:48 -0400
Message-ID: <1465250508-33133-1-git-send-email-bcodding@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The address of the iovec &vq->iov[out] is not guaranteed to contain the scsi
command's response iovec throughout the lifetime of the command.  Rather, it
is more likely to contain an iovec from an immediately following command
after looping back around to vhost_get_vq_desc().  Pass along the iovec
entirely instead.

Fixes: 79c14141a487 ("vhost/scsi: Convert completion path to use copy_to_iter")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 drivers/vhost/scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 0e6fd55..c93e125 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -88,7 +88,7 @@ struct vhost_scsi_cmd {
 	struct scatterlist *tvc_prot_sgl;
 	struct page **tvc_upages;
 	/* Pointer to response header iovec */
-	struct iovec *tvc_resp_iov;
+	struct iovec tvc_resp_iov;
 	/* Pointer to vhost_scsi for our device */
 	struct vhost_scsi *tvc_vhost;
 	/* Pointer to vhost_virtqueue for the cmd */
@@ -557,7 +557,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		memcpy(v_rsp.sense, cmd->tvc_sense_buf,
 		       se_cmd->scsi_sense_length);
 
-		iov_iter_init(&iov_iter, READ, cmd->tvc_resp_iov,
+		iov_iter_init(&iov_iter, READ, &cmd->tvc_resp_iov,
 			      cmd->tvc_in_iovs, sizeof(v_rsp));
 		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
 		if (likely(ret == sizeof(v_rsp))) {
@@ -1054,7 +1054,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		}
 		cmd->tvc_vhost = vs;
 		cmd->tvc_vq = vq;
-		cmd->tvc_resp_iov = &vq->iov[out];
+		cmd->tvc_resp_iov = vq->iov[out];
 		cmd->tvc_in_iovs = in;
 
 		pr_debug("vhost_scsi got command opcode: %#02x, lun: %d\n",
-- 
2.5.5
