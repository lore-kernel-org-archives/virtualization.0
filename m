From: Asias He <asias@redhat.com>
Subject: [PATCH v2 4/4] tcm_vhost: Send bad target to guest when cmd fails
Date: Wed, 10 Apr 2013 15:06:16 +0800
Message-ID: <1365577576-26183-5-git-send-email-asias__5809.47674247927$1365577636$gmane$org@redhat.com>
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

Send bad target to guest in case:
1) we can not allocate the cmd
2) fail to submit the cmd

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 1bb0fb4..957a0b9 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -703,7 +703,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 		if (IS_ERR(tv_cmd)) {
 			vq_err(vq, "vhost_scsi_allocate_cmd failed %ld\n",
 					PTR_ERR(tv_cmd));
-			break;
+			goto err_cmd;
 		}
 		pr_debug("Allocated tv_cmd: %p exp_data_len: %d, data_direction"
 			": %d\n", tv_cmd, exp_data_len, data_direction);
@@ -729,7 +729,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 				" exceeds SCSI_MAX_VARLEN_CDB_SIZE: %d\n",
 				scsi_command_size(tv_cmd->tvc_cdb),
 				TCM_VHOST_MAX_CDB_SIZE);
-			goto err;
+			goto err_free;
 		}
 		tv_cmd->tvc_lun = ((v_req.lun[2] << 8) | v_req.lun[3]) & 0x3FFF;
 
@@ -742,7 +742,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 					data_direction == DMA_TO_DEVICE);
 			if (unlikely(ret)) {
 				vq_err(vq, "Failed to map iov to sgl\n");
-				goto err;
+				goto err_free;
 			}
 		}
 
@@ -765,8 +765,10 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 	mutex_unlock(&vq->mutex);
 	return;
 
-err:
+err_free:
 	vhost_scsi_free_cmd(tv_cmd);
+err_cmd:
+	vhost_scsi_send_bad_target(vs, vq, head, out);
 	mutex_unlock(&vq->mutex);
 }
 
-- 
1.8.1.4
