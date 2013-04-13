From: Asias He <asias@redhat.com>
Subject: [PATCH v4 1/2] tcm_vhost: Pass vhost_scsi to vhost_scsi_allocate_cmd
Date: Sat, 13 Apr 2013 11:29:13 +0800
Message-ID: <1365823754-27730-2-git-send-email-asias@redhat.com>
References: <1365823754-27730-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365823754-27730-1-git-send-email-asias@redhat.com>
In-Reply-To: <20130412113331.GD23467@redhat.com>
References: <20130412113331.GD23467@redhat.com>
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

It is needed in next patch.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index aa457d2..e09f0fe 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -569,6 +569,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 }
 
 static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
+	struct vhost_scsi *vs,
 	struct tcm_vhost_tpg *tv_tpg,
 	struct virtio_scsi_cmd_req *v_req,
 	u32 exp_data_len,
@@ -593,6 +594,7 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
 	tv_cmd->tvc_exp_data_len = exp_data_len;
 	tv_cmd->tvc_data_direction = data_direction;
 	tv_cmd->tvc_nexus = tv_nexus;
+	tv_cmd->tvc_vhost = vs;
 
 	return tv_cmd;
 }
@@ -848,7 +850,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 		for (i = 0; i < data_num; i++)
 			exp_data_len += vq->iov[data_first + i].iov_len;
 
-		tv_cmd = vhost_scsi_allocate_cmd(tv_tpg, &v_req,
+		tv_cmd = vhost_scsi_allocate_cmd(vs, tv_tpg, &v_req,
 					exp_data_len, data_direction);
 		if (IS_ERR(tv_cmd)) {
 			vq_err(vq, "vhost_scsi_allocate_cmd failed %ld\n",
@@ -858,7 +860,6 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 		pr_debug("Allocated tv_cmd: %p exp_data_len: %d, data_direction"
 			": %d\n", tv_cmd, exp_data_len, data_direction);
 
-		tv_cmd->tvc_vhost = vs;
 		tv_cmd->tvc_vq = vq;
 		tv_cmd->tvc_resp = vq->iov[out].iov_base;
 
-- 
1.8.1.4
