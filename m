From: Asias He <asias@redhat.com>
Subject: [PATCH] tcm_vhost: Multi-queue support
Date: Wed,  6 Feb 2013 13:20:59 +0800
Message-ID: <1360128059-5238-1-git-send-email-asias__46954.5951149941$1360128137$gmane$org@redhat.com>
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
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This adds virtio-scsi multi-queue support to tcm_vhost.

Guest side virtio-scsi multi-queue support can be found here:

   https://lkml.org/lkml/2012/12/18/166

Some initial perf numbers:
1 queue,  4 targets, 1 lun per target
4K request size, 50% randread + 50% randwrite: 127K/127k IOPS

4 queues, 4 targets, 1 lun per target
4K request size, 50% randread + 50% randwrite: 181K/181k IOPS

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 46 +++++++++++++++++++++++++++++-----------------
 drivers/vhost/tcm_vhost.h |  2 ++
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 81ecda5..9951297 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -48,6 +48,7 @@
 #include <linux/virtio_net.h> /* TODO vhost.h currently depends on this */
 #include <linux/virtio_scsi.h>
 #include <linux/llist.h>
+#include <linux/bitmap.h>
 
 #include "vhost.c"
 #include "vhost.h"
@@ -59,7 +60,8 @@ enum {
 	VHOST_SCSI_VQ_IO = 2,
 };
 
-#define VHOST_SCSI_MAX_TARGET 256
+#define VHOST_SCSI_MAX_TARGET	256
+#define VHOST_SCSI_MAX_VQ	128
 
 struct vhost_scsi {
 	/* Protected by vhost_scsi->dev.mutex */
@@ -68,7 +70,7 @@ struct vhost_scsi {
 	bool vs_endpoint;
 
 	struct vhost_dev dev;
-	struct vhost_virtqueue vqs[3];
+	struct vhost_virtqueue vqs[VHOST_SCSI_MAX_VQ];
 
 	struct vhost_work vs_completion_work; /* cmd completion work item */
 	struct llist_head vs_completion_list; /* cmd completion queue */
@@ -366,12 +368,14 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 {
 	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
 					vs_completion_work);
+	DECLARE_BITMAP(signal, VHOST_SCSI_MAX_VQ);
 	struct virtio_scsi_cmd_resp v_rsp;
 	struct tcm_vhost_cmd *tv_cmd;
 	struct llist_node *llnode;
 	struct se_cmd *se_cmd;
-	int ret;
+	int ret, vq;
 
+	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
 	llnode = llist_del_all(&vs->vs_completion_list);
 	while (llnode) {
 		tv_cmd = llist_entry(llnode, struct tcm_vhost_cmd,
@@ -390,15 +394,20 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		memcpy(v_rsp.sense, tv_cmd->tvc_sense_buf,
 		       v_rsp.sense_len);
 		ret = copy_to_user(tv_cmd->tvc_resp, &v_rsp, sizeof(v_rsp));
-		if (likely(ret == 0))
-			vhost_add_used(&vs->vqs[2], tv_cmd->tvc_vq_desc, 0);
-		else
+		if (likely(ret == 0)) {
+			vhost_add_used(tv_cmd->tvc_vq, tv_cmd->tvc_vq_desc, 0);
+			vq = tv_cmd->tvc_vq - vs->vqs;
+			__set_bit(vq, signal);
+		} else
 			pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
 		vhost_scsi_free_cmd(tv_cmd);
 	}
 
-	vhost_signal(&vs->dev, &vs->vqs[2]);
+	vq = -1;
+	while ((vq = find_next_bit(signal, VHOST_SCSI_MAX_VQ, vq + 1))
+		< VHOST_SCSI_MAX_VQ)
+		vhost_signal(&vs->dev, &vs->vqs[vq]);
 }
 
 static struct tcm_vhost_cmd *vhost_scsi_allocate_cmd(
@@ -561,9 +570,9 @@ static void tcm_vhost_submission_work(struct work_struct *work)
 	}
 }
 
-static void vhost_scsi_handle_vq(struct vhost_scsi *vs)
+static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
+	struct vhost_virtqueue *vq)
 {
-	struct vhost_virtqueue *vq = &vs->vqs[2];
 	struct virtio_scsi_cmd_req v_req;
 	struct tcm_vhost_tpg *tv_tpg;
 	struct tcm_vhost_cmd *tv_cmd;
@@ -656,7 +665,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs)
 			ret = __copy_to_user(resp, &rsp, sizeof(rsp));
 			if (!ret)
 				vhost_add_used_and_signal(&vs->dev,
-						&vs->vqs[2], head, 0);
+							  vq, head, 0);
 			else
 				pr_err("Faulted on virtio_scsi_cmd_resp\n");
 
@@ -678,6 +687,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs)
 			": %d\n", tv_cmd, exp_data_len, data_direction);
 
 		tv_cmd->tvc_vhost = vs;
+		tv_cmd->tvc_vq = vq;
 
 		if (unlikely(vq->iov[out].iov_len !=
 				sizeof(struct virtio_scsi_cmd_resp))) {
@@ -758,7 +768,7 @@ static void vhost_scsi_handle_kick(struct vhost_work *work)
 						poll.work);
 	struct vhost_scsi *vs = container_of(vq->dev, struct vhost_scsi, dev);
 
-	vhost_scsi_handle_vq(vs);
+	vhost_scsi_handle_vq(vs, vq);
 }
 
 /*
@@ -879,7 +889,7 @@ err:
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
 	struct vhost_scsi *s;
-	int r;
+	int r, i;
 
 	s = kzalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
@@ -889,8 +899,9 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 
 	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
 	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
-	s->vqs[VHOST_SCSI_VQ_IO].handle_kick = vhost_scsi_handle_kick;
-	r = vhost_dev_init(&s->dev, s->vqs, 3);
+	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++)
+		s->vqs[i].handle_kick = vhost_scsi_handle_kick;
+	r = vhost_dev_init(&s->dev, s->vqs, VHOST_SCSI_MAX_VQ);
 	if (r < 0) {
 		kfree(s);
 		return r;
@@ -922,9 +933,10 @@ static void vhost_scsi_flush_vq(struct vhost_scsi *vs, int index)
 
 static void vhost_scsi_flush(struct vhost_scsi *vs)
 {
-	vhost_scsi_flush_vq(vs, VHOST_SCSI_VQ_CTL);
-	vhost_scsi_flush_vq(vs, VHOST_SCSI_VQ_EVT);
-	vhost_scsi_flush_vq(vs, VHOST_SCSI_VQ_IO);
+	int i;
+
+	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
+		vhost_scsi_flush_vq(vs, i);
 }
 
 static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
diff --git a/drivers/vhost/tcm_vhost.h b/drivers/vhost/tcm_vhost.h
index 519a550..1d2ae7a 100644
--- a/drivers/vhost/tcm_vhost.h
+++ b/drivers/vhost/tcm_vhost.h
@@ -23,6 +23,8 @@ struct tcm_vhost_cmd {
 	struct virtio_scsi_cmd_resp __user *tvc_resp;
 	/* Pointer to vhost_scsi for our device */
 	struct vhost_scsi *tvc_vhost;
+	/* Pointer to vhost_virtqueue for the cmd */
+	struct vhost_virtqueue *tvc_vq;
 	/* Pointer to vhost nexus memory */
 	struct tcm_vhost_nexus *tvc_nexus;
 	/* The TCM I/O descriptor that is accessed via container_of() */
-- 
1.8.1
