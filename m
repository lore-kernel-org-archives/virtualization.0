From: Asias He <asias@redhat.com>
Subject: [PATCH v2 11/11] vhost-scsi: Rename struct tcm_vhost_cmd *tv_cmd to
	*cmd
Date: Mon,  6 May 2013 16:38:29 +0800
Message-ID: <1367829509-5371-12-git-send-email-asias__9216.58132360808$1367829659$gmane$org@redhat.com>
References: <1367829509-5371-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367829509-5371-1-git-send-email-asias@redhat.com>
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

This way, we use cmd for struct tcm_vhost_cmd and evt for struct
tcm_vhost_cmd.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/scsi.c | 142 +++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 353145f..d860b58 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -499,28 +499,28 @@ static int tcm_vhost_get_cmd_state(struct se_cmd *se_cmd)
 	return 0;
 }
 
-static void vhost_scsi_complete_cmd(struct tcm_vhost_cmd *tv_cmd)
+static void vhost_scsi_complete_cmd(struct tcm_vhost_cmd *cmd)
 {
-	struct vhost_scsi *vs = tv_cmd->tvc_vhost;
+	struct vhost_scsi *vs = cmd->tvc_vhost;
 
-	llist_add(&tv_cmd->tvc_completion_list, &vs->vs_completion_list);
+	llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
 
 	vhost_work_queue(&vs->dev, &vs->vs_completion_work);
 }
 
 static int tcm_vhost_queue_data_in(struct se_cmd *se_cmd)
 {
-	struct tcm_vhost_cmd *tv_cmd = container_of(se_cmd,
+	struct tcm_vhost_cmd *cmd = container_of(se_cmd,
 				struct tcm_vhost_cmd, tvc_se_cmd);
-	vhost_scsi_complete_cmd(tv_cmd);
+	vhost_scsi_complete_cmd(cmd);
 	return 0;
 }
 
 static int tcm_vhost_queue_status(struct se_cmd *se_cmd)
 {
-	struct tcm_vhost_cmd *tv_cmd = container_of(se_cmd,
+	struct tcm_vhost_cmd *cmd = container_of(se_cmd,
 				struct tcm_vhost_cmd, tvc_se_cmd);
-	vhost_scsi_complete_cmd(tv_cmd);
+	vhost_scsi_complete_cmd(cmd);
 	return 0;
 }
 
@@ -561,24 +561,24 @@ tcm_vhost_allocate_evt(struct vhost_scsi *vs,
 	return evt;
 }
 
-static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
+static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *cmd)
 {
-	struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
+	struct se_cmd *se_cmd = &cmd->tvc_se_cmd;
 
 	/* TODO locking against target/backend threads? */
 	transport_generic_free_cmd(se_cmd, 1);
 
-	if (tv_cmd->tvc_sgl_count) {
+	if (cmd->tvc_sgl_count) {
 		u32 i;
-		for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
-			put_page(sg_page(&tv_cmd->tvc_sgl[i]));
+		for (i = 0; i < cmd->tvc_sgl_count; i++)
+			put_page(sg_page(&cmd->tvc_sgl[i]));
 
-		kfree(tv_cmd->tvc_sgl);
+		kfree(cmd->tvc_sgl);
 	}
 
-	tcm_vhost_put_inflight(tv_cmd->inflight);
+	tcm_vhost_put_inflight(cmd->inflight);
 
-	kfree(tv_cmd);
+	kfree(cmd);
 }
 
 static void
@@ -661,7 +661,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 					vs_completion_work);
 	DECLARE_BITMAP(signal, VHOST_SCSI_MAX_VQ);
 	struct virtio_scsi_cmd_resp v_rsp;
-	struct tcm_vhost_cmd *tv_cmd;
+	struct tcm_vhost_cmd *cmd;
 	struct llist_node *llnode;
 	struct se_cmd *se_cmd;
 	int ret, vq;
@@ -669,32 +669,32 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
 	llnode = llist_del_all(&vs->vs_completion_list);
 	while (llnode) {
-		tv_cmd = llist_entry(llnode, struct tcm_vhost_cmd,
+		cmd = llist_entry(llnode, struct tcm_vhost_cmd,
 				     tvc_completion_list);
 		llnode = llist_next(llnode);
-		se_cmd = &tv_cmd->tvc_se_cmd;
+		se_cmd = &cmd->tvc_se_cmd;
 
 		pr_debug("%s tv_cmd %p resid %u status %#02x\n", __func__,
-			tv_cmd, se_cmd->residual_count, se_cmd->scsi_status);
+			cmd, se_cmd->residual_count, se_cmd->scsi_status);
 
 		memset(&v_rsp, 0, sizeof(v_rsp));
 		v_rsp.resid = se_cmd->residual_count;
 		/* TODO is status_qualifier field needed? */
 		v_rsp.status = se_cmd->scsi_status;
 		v_rsp.sense_len = se_cmd->scsi_sense_length;
-		memcpy(v_rsp.sense, tv_cmd->tvc_sense_buf,
+		memcpy(v_rsp.sense, cmd->tvc_sense_buf,
 		       v_rsp.sense_len);
-		ret = copy_to_user(tv_cmd->tvc_resp, &v_rsp, sizeof(v_rsp));
+		ret = copy_to_user(cmd->tvc_resp, &v_rsp, sizeof(v_rsp));
 		if (likely(ret == 0)) {
 			struct vhost_scsi_virtqueue *q;
-			vhost_add_used(tv_cmd->tvc_vq, tv_cmd->tvc_vq_desc, 0);
-			q = container_of(tv_cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
+			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
+			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
 			vq = q - vs->vqs;
 			__set_bit(vq, signal);
 		} else
 			pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
-		vhost_scsi_free_cmd(tv_cmd);
+		vhost_scsi_free_cmd(cmd);
 	}
 
 	vq = -1;
@@ -710,7 +710,7 @@ vhost_scsi_allocate_cmd(struct vhost_virtqueue *vq,
 			u32 exp_data_len,
 			int data_direction)
 {
-	struct tcm_vhost_cmd *tv_cmd;
+	struct tcm_vhost_cmd *cmd;
 	struct tcm_vhost_nexus *tv_nexus;
 
 	tv_nexus = tpg->tpg_nexus;
@@ -719,19 +719,19 @@ vhost_scsi_allocate_cmd(struct vhost_virtqueue *vq,
 		return ERR_PTR(-EIO);
 	}
 
-	tv_cmd = kzalloc(sizeof(struct tcm_vhost_cmd), GFP_ATOMIC);
-	if (!tv_cmd) {
+	cmd = kzalloc(sizeof(struct tcm_vhost_cmd), GFP_ATOMIC);
+	if (!cmd) {
 		pr_err("Unable to allocate struct tcm_vhost_cmd\n");
 		return ERR_PTR(-ENOMEM);
 	}
-	tv_cmd->tvc_tag = v_req->tag;
-	tv_cmd->tvc_task_attr = v_req->task_attr;
-	tv_cmd->tvc_exp_data_len = exp_data_len;
-	tv_cmd->tvc_data_direction = data_direction;
-	tv_cmd->tvc_nexus = tv_nexus;
-	tv_cmd->inflight = tcm_vhost_get_inflight(vq);
+	cmd->tvc_tag = v_req->tag;
+	cmd->tvc_task_attr = v_req->task_attr;
+	cmd->tvc_exp_data_len = exp_data_len;
+	cmd->tvc_data_direction = data_direction;
+	cmd->tvc_nexus = tv_nexus;
+	cmd->inflight = tcm_vhost_get_inflight(vq);
 
-	return tv_cmd;
+	return cmd;
 }
 
 /*
@@ -788,7 +788,7 @@ out:
 }
 
 static int
-vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
+vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *cmd,
 			  struct iovec *iov,
 			  unsigned int niov,
 			  int write)
@@ -807,25 +807,25 @@ vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
 
 	/* TODO overflow checking */
 
-	sg = kmalloc(sizeof(tv_cmd->tvc_sgl[0]) * sgl_count, GFP_ATOMIC);
+	sg = kmalloc(sizeof(cmd->tvc_sgl[0]) * sgl_count, GFP_ATOMIC);
 	if (!sg)
 		return -ENOMEM;
 	pr_debug("%s sg %p sgl_count %u is_err %d\n", __func__,
 	       sg, sgl_count, !sg);
 	sg_init_table(sg, sgl_count);
 
-	tv_cmd->tvc_sgl = sg;
-	tv_cmd->tvc_sgl_count = sgl_count;
+	cmd->tvc_sgl = sg;
+	cmd->tvc_sgl_count = sgl_count;
 
 	pr_debug("Mapping %u iovecs for %u pages\n", niov, sgl_count);
 	for (i = 0; i < niov; i++) {
 		ret = vhost_scsi_map_to_sgl(sg, sgl_count, &iov[i], write);
 		if (ret < 0) {
-			for (i = 0; i < tv_cmd->tvc_sgl_count; i++)
-				put_page(sg_page(&tv_cmd->tvc_sgl[i]));
-			kfree(tv_cmd->tvc_sgl);
-			tv_cmd->tvc_sgl = NULL;
-			tv_cmd->tvc_sgl_count = 0;
+			for (i = 0; i < cmd->tvc_sgl_count; i++)
+				put_page(sg_page(&cmd->tvc_sgl[i]));
+			kfree(cmd->tvc_sgl);
+			cmd->tvc_sgl = NULL;
+			cmd->tvc_sgl_count = 0;
 			return ret;
 		}
 
@@ -837,15 +837,15 @@ vhost_scsi_map_iov_to_sgl(struct tcm_vhost_cmd *tv_cmd,
 
 static void tcm_vhost_submission_work(struct work_struct *work)
 {
-	struct tcm_vhost_cmd *tv_cmd =
+	struct tcm_vhost_cmd *cmd =
 		container_of(work, struct tcm_vhost_cmd, work);
 	struct tcm_vhost_nexus *tv_nexus;
-	struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
+	struct se_cmd *se_cmd = &cmd->tvc_se_cmd;
 	struct scatterlist *sg_ptr, *sg_bidi_ptr = NULL;
 	int rc, sg_no_bidi = 0;
 
-	if (tv_cmd->tvc_sgl_count) {
-		sg_ptr = tv_cmd->tvc_sgl;
+	if (cmd->tvc_sgl_count) {
+		sg_ptr = cmd->tvc_sgl;
 /* FIXME: Fix BIDI operation in tcm_vhost_submission_work() */
 #if 0
 		if (se_cmd->se_cmd_flags & SCF_BIDI) {
@@ -856,13 +856,13 @@ static void tcm_vhost_submission_work(struct work_struct *work)
 	} else {
 		sg_ptr = NULL;
 	}
-	tv_nexus = tv_cmd->tvc_nexus;
+	tv_nexus = cmd->tvc_nexus;
 
 	rc = target_submit_cmd_map_sgls(se_cmd, tv_nexus->tvn_se_sess,
-			tv_cmd->tvc_cdb, &tv_cmd->tvc_sense_buf[0],
-			tv_cmd->tvc_lun, tv_cmd->tvc_exp_data_len,
-			tv_cmd->tvc_task_attr, tv_cmd->tvc_data_direction,
-			0, sg_ptr, tv_cmd->tvc_sgl_count,
+			cmd->tvc_cdb, &cmd->tvc_sense_buf[0],
+			cmd->tvc_lun, cmd->tvc_exp_data_len,
+			cmd->tvc_task_attr, cmd->tvc_data_direction,
+			0, sg_ptr, cmd->tvc_sgl_count,
 			sg_bidi_ptr, sg_no_bidi);
 	if (rc < 0) {
 		transport_send_check_condition_and_sense(se_cmd,
@@ -896,7 +896,7 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 	struct tcm_vhost_tpg **vs_tpg;
 	struct virtio_scsi_cmd_req v_req;
 	struct tcm_vhost_tpg *tpg;
-	struct tcm_vhost_cmd *tv_cmd;
+	struct tcm_vhost_cmd *cmd;
 	u32 exp_data_len, data_first, data_num, data_direction;
 	unsigned out, in, i;
 	int head, ret;
@@ -993,46 +993,46 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		for (i = 0; i < data_num; i++)
 			exp_data_len += vq->iov[data_first + i].iov_len;
 
-		tv_cmd = vhost_scsi_allocate_cmd(vq, tpg, &v_req,
+		cmd = vhost_scsi_allocate_cmd(vq, tpg, &v_req,
 					exp_data_len, data_direction);
-		if (IS_ERR(tv_cmd)) {
+		if (IS_ERR(cmd)) {
 			vq_err(vq, "vhost_scsi_allocate_cmd failed %ld\n",
-					PTR_ERR(tv_cmd));
+					PTR_ERR(cmd));
 			goto err_cmd;
 		}
 		pr_debug("Allocated tv_cmd: %p exp_data_len: %d, data_direction"
-			": %d\n", tv_cmd, exp_data_len, data_direction);
+			": %d\n", cmd, exp_data_len, data_direction);
 
-		tv_cmd->tvc_vhost = vs;
-		tv_cmd->tvc_vq = vq;
-		tv_cmd->tvc_resp = vq->iov[out].iov_base;
+		cmd->tvc_vhost = vs;
+		cmd->tvc_vq = vq;
+		cmd->tvc_resp = vq->iov[out].iov_base;
 
 		/*
-		 * Copy in the recieved CDB descriptor into tv_cmd->tvc_cdb
+		 * Copy in the recieved CDB descriptor into cmd->tvc_cdb
 		 * that will be used by tcm_vhost_new_cmd_map() and down into
 		 * target_setup_cmd_from_cdb()
 		 */
-		memcpy(tv_cmd->tvc_cdb, v_req.cdb, TCM_VHOST_MAX_CDB_SIZE);
+		memcpy(cmd->tvc_cdb, v_req.cdb, TCM_VHOST_MAX_CDB_SIZE);
 		/*
 		 * Check that the recieved CDB size does not exceeded our
 		 * hardcoded max for tcm_vhost
 		 */
 		/* TODO what if cdb was too small for varlen cdb header? */
-		if (unlikely(scsi_command_size(tv_cmd->tvc_cdb) >
+		if (unlikely(scsi_command_size(cmd->tvc_cdb) >
 					TCM_VHOST_MAX_CDB_SIZE)) {
 			vq_err(vq, "Received SCSI CDB with command_size: %d that"
 				" exceeds SCSI_MAX_VARLEN_CDB_SIZE: %d\n",
-				scsi_command_size(tv_cmd->tvc_cdb),
+				scsi_command_size(cmd->tvc_cdb),
 				TCM_VHOST_MAX_CDB_SIZE);
 			goto err_free;
 		}
-		tv_cmd->tvc_lun = ((v_req.lun[2] << 8) | v_req.lun[3]) & 0x3FFF;
+		cmd->tvc_lun = ((v_req.lun[2] << 8) | v_req.lun[3]) & 0x3FFF;
 
 		pr_debug("vhost_scsi got command opcode: %#02x, lun: %d\n",
-			tv_cmd->tvc_cdb[0], tv_cmd->tvc_lun);
+			cmd->tvc_cdb[0], cmd->tvc_lun);
 
 		if (data_direction != DMA_NONE) {
-			ret = vhost_scsi_map_iov_to_sgl(tv_cmd,
+			ret = vhost_scsi_map_iov_to_sgl(cmd,
 					&vq->iov[data_first], data_num,
 					data_direction == DMA_TO_DEVICE);
 			if (unlikely(ret)) {
@@ -1046,22 +1046,22 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
 		 * complete the virtio-scsi request in TCM callback context via
 		 * tcm_vhost_queue_data_in() and tcm_vhost_queue_status()
 		 */
-		tv_cmd->tvc_vq_desc = head;
+		cmd->tvc_vq_desc = head;
 		/*
 		 * Dispatch tv_cmd descriptor for cmwq execution in process
 		 * context provided by tcm_vhost_workqueue.  This also ensures
 		 * tv_cmd is executed on the same kworker CPU as this vhost
 		 * thread to gain positive L2 cache locality effects..
 		 */
-		INIT_WORK(&tv_cmd->work, tcm_vhost_submission_work);
-		queue_work(tcm_vhost_workqueue, &tv_cmd->work);
+		INIT_WORK(&cmd->work, tcm_vhost_submission_work);
+		queue_work(tcm_vhost_workqueue, &cmd->work);
 	}
 
 	mutex_unlock(&vq->mutex);
 	return;
 
 err_free:
-	vhost_scsi_free_cmd(tv_cmd);
+	vhost_scsi_free_cmd(cmd);
 err_cmd:
 	vhost_scsi_send_bad_target(vs, vq, head, out);
 	mutex_unlock(&vq->mutex);
-- 
1.8.1.4
