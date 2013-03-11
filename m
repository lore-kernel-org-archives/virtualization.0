From: Asias He <asias@redhat.com>
Subject: [PATCH 1/2] tcm_vhost: Wait for pending requests in vhost_scsi_flush()
Date: Mon, 11 Mar 2013 13:09:38 +0800
Message-ID: <1362978579-13322-2-git-send-email-asias@redhat.com>
References: <1362978579-13322-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362978579-13322-1-git-send-email-asias@redhat.com>
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

This patch makes vhost_scsi_flush() wait for all the pending requests
issued before the flush operation to be finished.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 115 ++++++++++++++++++++++++++++++++++++++--------
 drivers/vhost/tcm_vhost.h |   4 ++
 2 files changed, 101 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index f80a545..5f8342c 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -84,6 +84,15 @@ struct vhost_scsi {
 	bool vs_events_dropped; /* any missed events, protected by dev.mutex */
 	u64 vs_events_nr; /* # of pennding events, protected by dev.mutex */
 
+	/*
+	 * vs_inflight[0]/[1] are used to track requests issued
+	 * before/during the flush operation
+	 */
+	u64 vs_inflight[2];
+	wait_queue_head_t vs_flush_wait; /* wait queue for flush operation */
+	spinlock_t vs_flush_lock; /* lock to protect vs_during_flush */
+	int vs_during_flush; /* flag to indicate if we are in flush operation */
+
 };
 
 /* Local pointer to allocated TCM configfs fabric module */
@@ -101,6 +110,46 @@ static int iov_num_pages(struct iovec *iov)
 	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
 }
 
+static int tcm_vhost_inc_inflight(struct vhost_scsi *vs)
+{
+	int during_flush;
+
+	spin_lock(&vs->vs_flush_lock);
+	during_flush = vs->vs_during_flush;
+	vs->vs_inflight[during_flush]++;
+	spin_unlock(&vs->vs_flush_lock);
+
+	return during_flush;
+}
+
+static void tcm_vhost_dec_inflight(struct vhost_scsi *vs, int during_flush)
+{
+	u64 inflight;
+
+	spin_lock(&vs->vs_flush_lock);
+	inflight = vs->vs_inflight[during_flush]--;
+	/*
+	 * Wakeup the waiter when all the requests issued before the flush
+	 * operation are finished and we are during the flush operation.
+	 */
+	if (!inflight && !during_flush && vs->vs_during_flush)
+		wake_up(&vs->vs_flush_wait);
+	spin_unlock(&vs->vs_flush_lock);
+}
+
+static bool tcm_vhost_done_inflight(struct vhost_scsi *vs)
+{
+	bool ret = false;
+
+	/* The requests issued before the flush operation are finished ? */
+	spin_lock(&vs->vs_flush_lock);
+	if (!vs->vs_inflight[0])
+		ret = true;
+	spin_unlock(&vs->vs_flush_lock);
+
+	return ret;
+}
+
 static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
 {
 	bool ret = false;
@@ -433,9 +482,10 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
 }
 
 static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
-	struct virtio_scsi_event *event)
+	struct tcm_vhost_evt *evt)
 {
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
+	struct virtio_scsi_event *event = &evt->event;
 	struct virtio_scsi_event __user *eventp;
 	unsigned out, in;
 	int head, ret;
@@ -493,13 +543,16 @@ static void tcm_vhost_evt_work(struct vhost_work *work)
 					vs_event_work);
 	struct tcm_vhost_evt *evt;
 	struct llist_node *llnode;
+	int during_flush;
 
 	llnode = llist_del_all(&vs->vs_event_list);
 	while (llnode) {
 		evt = llist_entry(llnode, struct tcm_vhost_evt, list);
 		llnode = llist_next(llnode);
-		tcm_vhost_do_evt_work(vs, &evt->event);
+		tcm_vhost_do_evt_work(vs, evt);
+		during_flush = evt->during_flush;
 		tcm_vhost_free_evt(vs, evt);
+		tcm_vhost_dec_inflight(vs, during_flush);
 	}
 }
 
@@ -516,8 +569,8 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 	struct virtio_scsi_cmd_resp v_rsp;
 	struct tcm_vhost_cmd *tv_cmd;
 	struct llist_node *llnode;
+	int ret, vq, during_flush;
 	struct se_cmd *se_cmd;
-	int ret, vq;
 
 	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
 	llnode = llist_del_all(&vs->vs_completion_list);
@@ -545,7 +598,9 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		} else
 			pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
+		during_flush = tv_cmd->during_flush;
 		vhost_scsi_free_cmd(tv_cmd);
+		tcm_vhost_dec_inflight(vs, during_flush);
 	}
 
 	vq = -1;
@@ -711,6 +766,7 @@ static void tcm_vhost_submission_work(struct work_struct *work)
 		transport_send_check_condition_and_sense(se_cmd,
 				TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE, 0);
 		transport_generic_free_cmd(se_cmd, 0);
+		tcm_vhost_dec_inflight(tv_cmd->tvc_vhost, tv_cmd->during_flush);
 	}
 }
 
@@ -883,6 +939,9 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 		 * tcm_vhost_queue_data_in() and tcm_vhost_queue_status()
 		 */
 		tv_cmd->tvc_vq_desc = head;
+
+		tv_cmd->during_flush = tcm_vhost_inc_inflight(vs);
+
 		/*
 		 * Dispatch tv_cmd descriptor for cmwq execution in process
 		 * context provided by tcm_vhost_workqueue.  This also ensures
@@ -926,6 +985,8 @@ static int tcm_vhost_send_evt(struct vhost_scsi *vs, struct tcm_vhost_tpg *tpg,
 		evt->event.lun[3] = lun->unpacked_lun & 0xFF;
 	}
 
+	evt->during_flush = tcm_vhost_inc_inflight(vs);
+
 	llist_add(&evt->list, &vs->vs_event_list);
 	vhost_work_queue(&vs->dev, &vs->vs_event_work);
 
@@ -952,6 +1013,34 @@ static void vhost_scsi_handle_kick(struct vhost_work *work)
 	vhost_scsi_handle_vq(vs, vq);
 }
 
+static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
+{
+	vhost_poll_flush(&vs->dev.vqs[index].poll);
+}
+
+static void vhost_scsi_flush(struct vhost_scsi *vs)
+{
+	int i;
+
+	/* Flush operation is started */
+	spin_lock(&vs->vs_flush_lock);
+	vs->vs_during_flush = 1;
+	spin_unlock(&vs->vs_flush_lock);
+
+	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
+		vhost_scsi_flush_vq(vs, i);
+	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
+	vhost_work_flush(&vs->dev, &vs->vs_event_work);
+
+	/* Wait until all requests issued before the flush to be finished */
+	wait_event(vs->vs_flush_wait, tcm_vhost_done_inflight(vs));
+
+	/* Flush operation is finished */
+	spin_lock(&vs->vs_flush_lock);
+	vs->vs_during_flush = 0;
+	spin_unlock(&vs->vs_flush_lock);
+}
+
 /*
  * Called from vhost_scsi_ioctl() context to walk the list of available
  * tcm_vhost_tpg with an active struct tcm_vhost_nexus
@@ -1028,6 +1117,7 @@ static int vhost_scsi_clear_endpoint(
 	u8 target;
 
 	mutex_lock(&vs->dev.mutex);
+
 	/* Verify that ring has been setup correctly. */
 	for (index = 0; index < vs->dev.nvqs; ++index) {
 		if (!vhost_vq_access_ok(&vs->vqs[index])) {
@@ -1086,6 +1176,10 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
 
 	s->vs_events_nr = 0;
+	s->vs_inflight[0] = 0;
+	s->vs_inflight[1] = 0;
+	spin_lock_init(&s->vs_flush_lock);
+	init_waitqueue_head(&s->vs_flush_wait);
 
 	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
 	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
@@ -1116,21 +1210,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	return 0;
 }
 
-static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
-{
-	vhost_poll_flush(&vs->dev.vqs[index].poll);
-}
-
-static void vhost_scsi_flush(struct vhost_scsi *vs)
-{
-	int i;
-
-	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
-		vhost_scsi_flush_vq(vs, i);
-	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
-	vhost_work_flush(&vs->dev, &vs->vs_event_work);
-}
-
 static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 {
 	if (features & ~VHOST_SCSI_FEATURES)
diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
index 94e9ee53..dd84622 100644
--- a/drivers/vhost/tcm_vhost.h
+++ b/drivers/vhost/tcm_vhost.h
@@ -37,6 +37,8 @@ struct tcm_vhost_cmd {
 	unsigned char tvc_sense_buf[TRANSPORT_SENSE_BUFFER];
 	/* Completed commands list, serviced from vhost worker thread */
 	struct llist_node tvc_completion_list;
+	/* Indicate this command is issued during the flush operaton */
+	int during_flush;
 };
 
 struct tcm_vhost_nexus {
@@ -91,6 +93,8 @@ struct tcm_vhost_evt {
 	struct virtio_scsi_event event;
 	/* virtio_scsi event list, serviced from vhost worker thread */
 	struct llist_node list;
+	/* Indicate this event is issued during the flush operaton */
+	int during_flush;
 };
 
 /*
-- 
1.8.1.4
