From: Asias He <asias@redhat.com>
Subject: [PATCH v4 2/2] tcm_vhost: Wait for pending requests in
	vhost_scsi_flush()
Date: Sat, 13 Apr 2013 11:29:14 +0800
Message-ID: <1365823754-27730-3-git-send-email-asias__13771.1046300412$1365823783$gmane$org@redhat.com>
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

This patch makes vhost_scsi_flush() wait for all the pending requests
issued before the flush operation to be finished.

Changes in v4:
- Introduce vhost_scsi_inflight
- Drop array to track flush
- Use RCU to protect vs_inflight explicitly

Changes in v3:
- Rebase
- Drop 'tcm_vhost: Wait for pending requests in
  vhost_scsi_clear_endpoint()' in this series, we already did that in
  'tcm_vhost: Use vq->private_data to indicate if the endpoint is setup'

Changes in v2:
- Increase/Decrease inflight requests in
  vhost_scsi_{allocate,free}_cmd and tcm_vhost_{allocate,free}_evt

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/vhost/tcm_vhost.h |  5 ++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index e09f0fe..5dde525 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -74,6 +74,11 @@ enum {
 #define VHOST_SCSI_MAX_VQ	128
 #define VHOST_SCSI_MAX_EVENT	128
 
+struct vhost_scsi_inflight {
+	wait_queue_head_t wait;
+	atomic_t count;
+};
+
 struct vhost_scsi {
 	/* Protected by vhost_scsi->dev.mutex */
 	struct tcm_vhost_tpg **vs_tpg;
@@ -91,6 +96,8 @@ struct vhost_scsi {
 	struct mutex vs_events_lock; /* protect vs_events_dropped,events_nr */
 	bool vs_events_dropped; /* any missed events */
 	int vs_events_nr; /* num of pending events */
+
+	struct vhost_scsi_inflight __rcu *vs_inflight; /* track inflight req */
 };
 
 /* Local pointer to allocated TCM configfs fabric module */
@@ -108,6 +115,51 @@ static int iov_num_pages(struct iovec *iov)
 	       ((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT;
 }
 
+static struct vhost_scsi_inflight *
+tcm_vhost_alloc_inflight(struct vhost_scsi *vs)
+{
+	struct vhost_scsi_inflight *inflight;
+
+	inflight = kzalloc(sizeof(*inflight), GFP_KERNEL);
+	if (inflight) {
+		atomic_set(&inflight->count, 0);
+		init_waitqueue_head(&inflight->wait);
+	}
+	rcu_assign_pointer(vs->vs_inflight, inflight);
+	synchronize_rcu();
+
+	return inflight;
+}
+
+static struct vhost_scsi_inflight *
+tcm_vhost_inc_inflight(struct vhost_scsi *vs)
+{
+	struct vhost_scsi_inflight *inflight;
+
+	rcu_read_lock();
+	inflight = rcu_dereference(vs->vs_inflight);
+	if (inflight)
+		atomic_inc(&inflight->count);
+	rcu_read_unlock();
+
+	return inflight;
+}
+
+static void tcm_vhost_dec_inflight(struct vhost_scsi_inflight *inflight)
+{
+	/*
+	 * Wakeup the waiter when all the requests issued before the flush
+	 * operation are finished.
+	 */
+	if (inflight && !atomic_dec_return(&inflight->count))
+		wake_up(&inflight->wait);
+}
+
+static bool tcm_vhost_done_inflight(struct vhost_scsi_inflight *inflight)
+{
+	return atomic_read(&inflight->count) == 0;
+}
+
 static bool tcm_vhost_check_feature(struct vhost_scsi *vs, int feature)
 {
 	bool ret = false;
@@ -402,6 +454,7 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
 static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
 {
 	mutex_lock(&vs->vs_events_lock);
+	tcm_vhost_dec_inflight(evt->inflight);
 	vs->vs_events_nr--;
 	kfree(evt);
 	mutex_unlock(&vs->vs_events_lock);
@@ -423,6 +476,7 @@ static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
 	if (evt) {
 		evt->event.event = event;
 		evt->event.reason = reason;
+		evt->inflight = tcm_vhost_inc_inflight(vs);
 		vs->vs_events_nr++;
 	}
 	mutex_unlock(&vs->vs_events_lock);
@@ -445,6 +499,8 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
 		kfree(tv_cmd->tvc_sgl);
 	}
 
+	tcm_vhost_dec_inflight(tv_cmd->inflight);
+
 	kfree(tv_cmd);
 }
 
@@ -595,6 +651,7 @@ static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
 	tv_cmd->tvc_data_direction = data_direction;
 	tv_cmd->tvc_nexus = tv_nexus;
 	tv_cmd->tvc_vhost = vs;
+	tv_cmd->inflight = tcm_vhost_inc_inflight(vs);
 
 	return tv_cmd;
 }
@@ -983,10 +1040,22 @@ static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
 static void vhost_scsi_flush(struct vhost_scsi *vs)
 {
 	int i;
+	struct vhost_scsi_inflight *inflight;
+
+	inflight = ACCESS_ONCE(vs->vs_inflight);
+	if (!tcm_vhost_alloc_inflight(vs))
+		return;
 
 	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
 		vhost_scsi_flush_vq(vs, i);
 	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
+	vhost_work_flush(&vs->dev, &vs->vs_event_work);
+
+	/* Wait until all requests issued before the flush to be finished */
+	if (inflight) {
+		wait_event(inflight->wait, tcm_vhost_done_inflight(inflight));
+		kfree(inflight);
+	}
 }
 
 /*
@@ -1195,6 +1264,9 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 	s->vs_events_dropped = false;
 	mutex_init(&s->vs_events_lock);
 
+	if (!tcm_vhost_alloc_inflight(s))
+		return -ENOMEM;
+
 	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
 	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
 	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++)
@@ -1220,6 +1292,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	vhost_scsi_clear_endpoint(s, &t);
 	vhost_dev_stop(&s->dev);
 	vhost_dev_cleanup(&s->dev, false);
+	kfree(s->vs_inflight);
 	kfree(s);
 	return 0;
 }
diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
index 94e9ee53..7567767 100644
--- a/drivers/vhost/tcm_vhost.h
+++ b/drivers/vhost/tcm_vhost.h
@@ -2,6 +2,7 @@
 #define TCM_VHOST_NAMELEN 256
 #define TCM_VHOST_MAX_CDB_SIZE 32
 
+struct vhost_scsi_inflight;
 struct tcm_vhost_cmd {
 	/* Descriptor from vhost_get_vq_desc() for virt_queue segment */
 	int tvc_vq_desc;
@@ -37,6 +38,8 @@ struct tcm_vhost_cmd {
 	unsigned char tvc_sense_buf[TRANSPORT_SENSE_BUFFER];
 	/* Completed commands list, serviced from vhost worker thread */
 	struct llist_node tvc_completion_list;
+	/* Used to track inflight req */
+	struct vhost_scsi_inflight *inflight;
 };
 
 struct tcm_vhost_nexus {
@@ -91,6 +94,8 @@ struct tcm_vhost_evt {
 	struct virtio_scsi_event event;
 	/* virtio_scsi event list, serviced from vhost worker thread */
 	struct llist_node list;
+	/* Used to track inflight req */
+	struct vhost_scsi_inflight *inflight;
 };
 
 /*
-- 
1.8.1.4
