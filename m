From: Asias He <asias@redhat.com>
Subject: [PATCH V2 5/6] tcm_vhost: Add hotplug/hotunplug support
Date: Fri,  8 Mar 2013 10:21:46 +0800
Message-ID: <1362709307-12554-6-git-send-email-asias__32015.3113142171$1362709389$gmane$org@redhat.com>
References: <1362709307-12554-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362709307-12554-1-git-send-email-asias@redhat.com>
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

In commit 365a7150094 ([SCSI] virtio-scsi: hotplug support for
virtio-scsi), hotplug support is added to virtio-scsi.

This patch adds hotplug and hotunplug support to tcm_vhost.

You can create or delete a LUN in targetcli to hotplug or hotunplug a
LUN in guest.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 211 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/vhost/tcm_vhost.h |  10 +++
 2 files changed, 216 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 6739d67..af80c7f 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -62,6 +62,9 @@ enum {
 
 #define VHOST_SCSI_MAX_TARGET	256
 #define VHOST_SCSI_MAX_VQ	128
+#define VHOST_SCSI_MAX_EVENT	128
+
+#define VHOST_SCSI_FEATURES (VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_HOTPLUG))
 
 struct vhost_scsi {
 	/* Protected by vhost_scsi->dev.mutex */
@@ -74,6 +77,13 @@ struct vhost_scsi {
 
 	struct vhost_work vs_completion_work; /* cmd completion work item */
 	struct llist_head vs_completion_list; /* cmd completion queue */
+
+	struct vhost_work vs_event_work; /* evt injection work item */
+	struct llist_head vs_event_list; /* evt injection queue */
+
+	bool vs_events_dropped; /* any missed events, protected by dev.mutex */
+	u64 vs_events_nr; /* # of pennding events, protected by dev.mutex */
+
 };
 
 /* Local pointer to allocated TCM configfs fabric module */
@@ -115,6 +125,16 @@ static bool tcm_vhost_check_endpoint(struct vhost_scsi *vs)
 	return ret;
 }
 
+static bool tcm_vhost_check_events_dropped(struct vhost_scsi *vs)
+{
+	bool ret;
+
+	mutex_lock(&vs->dev.mutex);
+	ret = vs->vs_events_dropped;
+	mutex_unlock(&vs->dev.mutex);
+
+	return ret;
+}
 static int tcm_vhost_check_true(struct se_portal_group *se_tpg)
 {
 	return 1;
@@ -365,6 +385,35 @@ static int tcm_vhost_queue_tm_rsp(struct se_cmd *se_cmd)
 	return 0;
 }
 
+static void tcm_vhost_free_evt(struct vhost_scsi *vs, struct tcm_vhost_evt *evt)
+{
+	mutex_lock(&vs->dev.mutex);
+	vs->vs_events_nr--;
+	kfree(evt);
+	mutex_unlock(&vs->dev.mutex);
+}
+
+static struct tcm_vhost_evt *tcm_vhost_allocate_evt(struct vhost_scsi *vs,
+	u32 event, u32 reason)
+{
+	struct tcm_vhost_evt *evt;
+
+	mutex_lock(&vs->dev.mutex);
+	if (vs->vs_events_nr > VHOST_SCSI_MAX_EVENT) {
+		mutex_unlock(&vs->dev.mutex);
+		return NULL;
+	}
+
+	evt = kzalloc(sizeof(*evt), GFP_KERNEL);
+	if (evt) {
+		evt->event.event = event;
+		evt->event.reason = reason;
+		vs->vs_events_nr++;
+	}
+	mutex_unlock(&vs->dev.mutex);
+	return evt;
+}
+
 static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
 {
 	struct se_cmd *se_cmd = &tv_cmd->tvc_se_cmd;
@@ -383,6 +432,77 @@ static void vhost_scsi_free_cmd(struct tcm_vhost_cmd *tv_cmd)
 	kfree(tv_cmd);
 }
 
+static void tcm_vhost_do_evt_work(struct vhost_scsi *vs,
+	struct virtio_scsi_event *event)
+{
+	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT];
+	struct virtio_scsi_event __user *eventp;
+	unsigned out, in;
+	int head, ret;
+
+	if (!tcm_vhost_check_endpoint(vs))
+		return;
+
+	mutex_lock(&vq->mutex);
+again:
+	vhost_disable_notify(&vs->dev, vq);
+	head = vhost_get_vq_desc(&vs->dev, vq, vq->iov,
+			ARRAY_SIZE(vq->iov), &out, &in,
+			NULL, NULL);
+	if (head < 0) {
+		mutex_lock(&vs->dev.mutex);
+		vs->vs_events_dropped = true;
+		mutex_unlock(&vs->dev.mutex);
+		goto out;
+	}
+	if (head == vq->num) {
+		if (vhost_enable_notify(&vs->dev, vq))
+			goto again;
+		mutex_lock(&vs->dev.mutex);
+		vs->vs_events_dropped = true;
+		mutex_unlock(&vs->dev.mutex);
+		goto out;
+	}
+
+	if ((vq->iov[out].iov_len != sizeof(struct virtio_scsi_event))) {
+		vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
+				vq->iov[out].iov_len);
+		goto out;
+	}
+
+	mutex_lock(&vs->dev.mutex);
+	if (vs->vs_events_dropped) {
+		event->event |= VIRTIO_SCSI_T_EVENTS_MISSED;
+		vs->vs_events_dropped = false;
+	}
+	mutex_unlock(&vs->dev.mutex);
+
+	eventp = vq->iov[out].iov_base;
+	ret = __copy_to_user(eventp, event, sizeof(*event));
+	if (!ret)
+		vhost_add_used_and_signal(&vs->dev, vq, head, 0);
+	else
+		vq_err(vq, "Faulted on tcm_vhost_send_event\n");
+out:
+	mutex_unlock(&vq->mutex);
+}
+
+static void tcm_vhost_evt_work(struct vhost_work *work)
+{
+	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
+					vs_event_work);
+	struct tcm_vhost_evt *evt;
+	struct llist_node *llnode;
+
+	llnode = llist_del_all(&vs->vs_event_list);
+	while (llnode) {
+		evt = llist_entry(llnode, struct tcm_vhost_evt, list);
+		llnode = llist_next(llnode);
+		tcm_vhost_do_evt_work(vs, &evt->event);
+		tcm_vhost_free_evt(vs, evt);
+	}
+}
+
 /* Fill in status and signal that we are done processing this command
  *
  * This is scheduled in the vhost work queue so we are called with the owner
@@ -781,9 +901,46 @@ static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
 	pr_debug("%s: The handling func for control queue.\n", __func__);
 }
 
+static int tcm_vhost_send_evt(struct vhost_scsi *vs, struct tcm_vhost_tpg *tpg,
+	struct se_lun *lun, u32 event, u32 reason)
+{
+	struct tcm_vhost_evt *evt;
+
+	if (!tcm_vhost_check_endpoint(vs))
+		return -EOPNOTSUPP;
+
+	evt = tcm_vhost_allocate_evt(vs, event, reason);
+	if (!evt) {
+		mutex_lock(&vs->dev.mutex);
+		vs->vs_events_dropped = true;
+		mutex_unlock(&vs->dev.mutex);
+		return -ENOMEM;
+	}
+
+	if (tpg && lun) {
+		/* TODO: share lun setup code with virtio-scsi.ko */
+		evt->event.lun[0] = 0x01;
+		evt->event.lun[1] = tpg->tport_tpgt & 0xFF;
+		if (lun->unpacked_lun >= 256)
+			evt->event.lun[2] = lun->unpacked_lun >> 8 | 0x40 ;
+		evt->event.lun[3] = lun->unpacked_lun & 0xFF;
+	}
+
+	llist_add(&evt->list, &vs->vs_event_list);
+	vhost_work_queue(&vs->dev, &vs->vs_event_work);
+
+	return 0;
+}
+
 static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
 {
-	pr_debug("%s: The handling func for event queue.\n", __func__);
+	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
+						poll.work);
+	struct vhost_scsi *vs = container_of(vq->dev, struct vhost_scsi, dev);
+
+	if (tcm_vhost_check_events_dropped(vs))
+		tcm_vhost_send_evt(vs, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
+
 }
 
 static void vhost_scsi_handle_kick(struct vhost_work *work)
@@ -839,6 +996,7 @@ static int vhost_scsi_set_endpoint(
 				return -EEXIST;
 			}
 			tv_tpg->tv_tpg_vhost_count++;
+			tv_tpg->vhost_scsi = vs;
 			vs->vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
 			smp_mb__after_atomic_inc();
 			match = true;
@@ -902,6 +1060,7 @@ static int vhost_scsi_clear_endpoint(
 			goto err;
 		}
 		tv_tpg->tv_tpg_vhost_count--;
+		tv_tpg->vhost_scsi = NULL;
 		vs->vs_tpg[target] = NULL;
 		vs->vs_endpoint = false;
 		mutex_unlock(&tv_tpg->tv_tpg_mutex);
@@ -924,6 +1083,9 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 		return -ENOMEM;
 
 	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
+	vhost_work_init(&s->vs_event_work, tcm_vhost_evt_work);
+
+	s->vs_events_nr = 0;
 
 	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
 	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
@@ -969,7 +1131,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 
 static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 {
-	if (features & ~VHOST_FEATURES)
+	if (features & ~VHOST_SCSI_FEATURES)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&vs->dev.mutex);
@@ -1015,7 +1177,7 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		return 0;
 	case VHOST_GET_FEATURES:
-		features = VHOST_FEATURES;
+		features = VHOST_SCSI_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof features))
 			return -EFAULT;
 		return 0;
@@ -1085,6 +1247,42 @@ static char *tcm_vhost_dump_proto_id(struct tcm_vhost_tport *tport)
 	return "Unknown";
 }
 
+static int tcm_vhost_do_plug(struct tcm_vhost_tpg *tpg,
+	struct se_lun *lun, bool plug)
+{
+
+	struct vhost_scsi *vs = tpg->vhost_scsi;
+	u32 reason;
+
+	mutex_lock(&tpg->tv_tpg_mutex);
+	vs = tpg->vhost_scsi;
+	mutex_unlock(&tpg->tv_tpg_mutex);
+	if (!vs)
+		return -EOPNOTSUPP;
+
+	if (!tcm_vhost_check_feature(vs, VIRTIO_SCSI_F_HOTPLUG))
+		return -EOPNOTSUPP;
+
+	if (plug)
+		reason = VIRTIO_SCSI_EVT_RESET_RESCAN;
+	else
+		reason = VIRTIO_SCSI_EVT_RESET_REMOVED;
+
+	return tcm_vhost_send_evt(vs, tpg, lun,
+			VIRTIO_SCSI_T_TRANSPORT_RESET,
+			reason);
+}
+
+static int tcm_vhost_hotplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
+{
+	return tcm_vhost_do_plug(tpg, lun, true);
+}
+
+static int tcm_vhost_hotunplug(struct tcm_vhost_tpg *tpg, struct se_lun *lun)
+{
+	return tcm_vhost_do_plug(tpg, lun, false);
+}
+
 static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
 	struct se_lun *lun)
 {
@@ -1095,18 +1293,21 @@ static int tcm_vhost_port_link(struct se_portal_group *se_tpg,
 	tv_tpg->tv_tpg_port_count++;
 	mutex_unlock(&tv_tpg->tv_tpg_mutex);
 
+	tcm_vhost_hotplug(tv_tpg, lun);
+
 	return 0;
 }
 
 static void tcm_vhost_port_unlink(struct se_portal_group *se_tpg,
-	struct se_lun *se_lun)
+	struct se_lun *lun)
 {
 	struct tcm_vhost_tpg *tv_tpg = container_of(se_tpg,
 				struct tcm_vhost_tpg, se_tpg);
-
 	mutex_lock(&tv_tpg->tv_tpg_mutex);
 	tv_tpg->tv_tpg_port_count--;
 	mutex_unlock(&tv_tpg->tv_tpg_mutex);
+
+	tcm_vhost_hotunplug(tv_tpg, lun);
 }
 
 static struct se_node_acl *tcm_vhost_make_nodeacl(
diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
index 1d2ae7a..94e9ee53 100644
--- a/drivers/vhost/tcm_vhost.h
+++ b/drivers/vhost/tcm_vhost.h
@@ -53,6 +53,7 @@ struct tcm_vhost_nacl {
 	struct se_node_acl se_node_acl;
 };
 
+struct vhost_scsi;
 struct tcm_vhost_tpg {
 	/* Vhost port target portal group tag for TCM */
 	u16 tport_tpgt;
@@ -70,6 +71,8 @@ struct tcm_vhost_tpg {
 	struct tcm_vhost_tport *tport;
 	/* Returned by tcm_vhost_make_tpg() */
 	struct se_portal_group se_tpg;
+	/* Pointer back to struct vhost_scsi, protected by tv_tpg_mutex */
+	struct vhost_scsi *vhost_scsi;
 };
 
 struct tcm_vhost_tport {
@@ -83,6 +86,13 @@ struct tcm_vhost_tport {
 	struct se_wwn tport_wwn;
 };
 
+struct tcm_vhost_evt {
+	/* virtio_scsi event */
+	struct virtio_scsi_event event;
+	/* virtio_scsi event list, serviced from vhost worker thread */
+	struct llist_node list;
+};
+
 /*
  * As per request from MST, keep TCM_VHOST related ioctl defines out of
  * linux/vhost.h (user-space) for now..
-- 
1.8.1.4
