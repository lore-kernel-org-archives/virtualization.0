From: Asias He <asias@redhat.com>
Subject: [PATCH 1/3] tcm_vhost: Fix tv_cmd leak in vhost_scsi_handle_vq
Date: Wed, 10 Apr 2013 11:23:09 +0800
Message-ID: <1365564191-20928-2-git-send-email-asias@redhat.com>
References: <1365564191-20928-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365564191-20928-1-git-send-email-asias@redhat.com>
In-Reply-To: <1365522402.24346.146.camel@haakon2.linux-iscsi.org>
References: <1365522402.24346.146.camel@haakon2.linux-iscsi.org>
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

If we fail to submit the allocated tv_vmd to tcm_vhost_submission_work,
we will leak the tv_vmd. Free tv_vmd on fail path.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 10f2d30..e8d1a1f 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -715,7 +715,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 				" exceeds SCSI_MAX_VARLEN_CDB_SIZE: %d\n",
 				scsi_command_size(tv_cmd->tvc_cdb),
 				TCM_VHOST_MAX_CDB_SIZE);
-			break; /* TODO */
+			goto err;
 		}
 		tv_cmd->tvc_lun = ((v_req.lun[2] << 8) | v_req.lun[3]) & 0x3FFF;
 
@@ -728,7 +728,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 					data_direction == DMA_TO_DEVICE);
 			if (unlikely(ret)) {
 				vq_err(vq, "Failed to map iov to sgl\n");
-				break; /* TODO */
+				goto err;
 			}
 		}
 
@@ -749,6 +749,11 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 	}
 
 	mutex_unlock(&vq->mutex);
+	return;
+
+err:
+	vhost_scsi_free_cmd(tv_cmd);
+	mutex_unlock(&vq->mutex);
 }
 
 static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
-- 
1.8.1.4
