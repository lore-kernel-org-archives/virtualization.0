From: Asias He <asias@redhat.com>
Subject: [PATCH V3 1/2] tcm_vhost: Use vq->private_data to indicate if the
	endpoint is setup
Date: Wed,  3 Apr 2013 14:17:37 +0800
Message-ID: <1364969858-9410-2-git-send-email-asias@redhat.com>
References: <1364969858-9410-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364969858-9410-1-git-send-email-asias@redhat.com>
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

Currently, vs->vs_endpoint is used indicate if the endpoint is setup or
not. It is set or cleared in vhost_scsi_set_endpoint() or
vhost_scsi_clear_endpoint() under the vs->dev.mutex lock. However, when
we check it in vhost_scsi_handle_vq(), we ignored the lock.

Instead of using the vs->vs_endpoint and the vs->dev.mutex lock to
indicate the status of the endpoint, we use per virtqueue
vq->private_data to indicate it. In this way, we can only take the
vq->mutex lock which is per queue and make the concurrent multiqueue
process having less lock contention. Further, in the read side of
vq->private_data, we can even do not take the lock if it is accessed in
the vhost worker thread, because it is protected by "vhost rcu".

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 144 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 43 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 61f9eab..11121ea 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -65,9 +65,8 @@ enum {
 
 struct vhost_scsi {
 	/* Protected by vhost_scsi->dev.mutex */
-	struct tcm_vhost_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
+	struct tcm_vhost_tpg **vs_tpg;
 	char vs_vhost_wwpn[TRANSPORT_IQN_LEN];
-	bool vs_endpoint;
 
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[VHOST_SCSI_MAX_VQ];
@@ -573,6 +572,7 @@ static void tcm_vhost_submission_work(struct work_struct *work)
 static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 	struct vhost_virtqueue *vq)
 {
+	struct tcm_vhost_tpg **vs_tpg;
 	struct virtio_scsi_cmd_req v_req;
 	struct tcm_vhost_tpg *tv_tpg;
 	struct tcm_vhost_cmd *tv_cmd;
@@ -581,8 +581,16 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 	int head, ret;
 	u8 target;
 
-	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
-	if (unlikely(!vs->vs_endpoint))
+	/*
+	 * We can handle the vq only after the endpoint is setup by calling the
+	 * VHOST_SCSI_SET_ENDPOINT ioctl.
+	 *
+	 * TODO: Check that we are running from vhost_worker which acts
+	 * as read-side critical section for vhost kind of RCU.
+	 * See the comments in struct vhost_virtqueue in drivers/vhost/vhost.h
+	 */
+	vs_tpg = rcu_dereference_check(vq->private_data, 1);
+	if (!vs_tpg)
 		return;
 
 	mutex_lock(&vq->mutex);
@@ -652,7 +660,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 
 		/* Extract the tpgt */
 		target = v_req.lun[1];
-		tv_tpg = ACCESS_ONCE(vs->vs_tpg[target]);
+		tv_tpg = ACCESS_ONCE(vs_tpg[target]);
 
 		/* Target does not exist, fail the request */
 		if (unlikely(!tv_tpg)) {
@@ -771,6 +779,20 @@ static void vhost_scsi_handle_kick(struct vhost_work *work)
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
+	for (i = 0; i < VHOST_SCSI_MAX_VQ; i++)
+		vhost_scsi_flush_vq(vs, i);
+	vhost_work_flush(&vs->dev, &vs->vs_completion_work);
+}
+
 /*
  * Called from vhost_scsi_ioctl() context to walk the list of available
  * tcm_vhost_tpg with an active struct tcm_vhost_nexus
@@ -781,8 +803,10 @@ static int vhost_scsi_set_endpoint(
 {
 	struct tcm_vhost_tport *tv_tport;
 	struct tcm_vhost_tpg *tv_tpg;
+	struct tcm_vhost_tpg **vs_tpg;
+	struct vhost_virtqueue *vq;
+	int index, ret, i, len;
 	bool match = false;
-	int index, ret;
 
 	mutex_lock(&vs->dev.mutex);
 	/* Verify that ring has been setup correctly. */
@@ -794,6 +818,15 @@ static int vhost_scsi_set_endpoint(
 		}
 	}
 
+	len = sizeof(vs_tpg[0]) * VHOST_SCSI_MAX_TARGET;
+	vs_tpg = kzalloc(len, GFP_KERNEL);
+	if (!vs_tpg) {
+		mutex_unlock(&vs->dev.mutex);
+		return -ENOMEM;
+	}
+	if (vs->vs_tpg)
+		memcpy(vs_tpg, vs->vs_tpg, len);
+
 	mutex_lock(&tcm_vhost_mutex);
 	list_for_each_entry(tv_tpg, &tcm_vhost_list, tv_tpg_list) {
 		mutex_lock(&tv_tpg->tv_tpg_mutex);
@@ -808,14 +841,15 @@ static int vhost_scsi_set_endpoint(
 		tv_tport = tv_tpg->tport;
 
 		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
-			if (vs->vs_tpg[tv_tpg->tport_tpgt]) {
+			if (vs->vs_tpg && vs->vs_tpg[tv_tpg->tport_tpgt]) {
 				mutex_unlock(&tv_tpg->tv_tpg_mutex);
 				mutex_unlock(&tcm_vhost_mutex);
 				mutex_unlock(&vs->dev.mutex);
+				kfree(vs_tpg);
 				return -EEXIST;
 			}
 			tv_tpg->tv_tpg_vhost_count++;
-			vs->vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
+			vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
 			smp_mb__after_atomic_inc();
 			match = true;
 		}
@@ -826,12 +860,26 @@ static int vhost_scsi_set_endpoint(
 	if (match) {
 		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
 		       sizeof(vs->vs_vhost_wwpn));
-		vs->vs_endpoint = true;
+		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
+			vq = &vs->vqs[i];
+			/* Flushing the vhost_work acts as synchronize_rcu */
+			mutex_lock(&vq->mutex);
+			rcu_assign_pointer(vq->private_data, vs_tpg);
+			mutex_unlock(&vq->mutex);
+		}
 		ret = 0;
 	} else {
 		ret = -EEXIST;
 	}
 
+	/*
+	 * Act as synchronize_rcu to make sure access to
+	 * old vs->vs_tpg is finished.
+	 */
+	vhost_scsi_flush(vs);
+	kfree(vs->vs_tpg);
+	vs->vs_tpg = vs_tpg;
+
 	mutex_unlock(&vs->dev.mutex);
 	return ret;
 }
@@ -842,6 +890,8 @@ static int vhost_scsi_clear_endpoint(
 {
 	struct tcm_vhost_tport *tv_tport;
 	struct tcm_vhost_tpg *tv_tpg;
+	struct vhost_virtqueue *vq;
+	bool match = false;
 	int index, ret, i;
 	u8 target;
 
@@ -853,9 +903,14 @@ static int vhost_scsi_clear_endpoint(
 			goto err_dev;
 		}
 	}
+
+	if (!vs->vs_tpg) {
+		mutex_unlock(&vs->dev.mutex);
+		return 0;
+	}
+
 	for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
 		target = i;
-
 		tv_tpg = vs->vs_tpg[target];
 		if (!tv_tpg)
 			continue;
@@ -877,10 +932,27 @@ static int vhost_scsi_clear_endpoint(
 		}
 		tv_tpg->tv_tpg_vhost_count--;
 		vs->vs_tpg[target] = NULL;
-		vs->vs_endpoint = false;
+		match = true;
 		mutex_unlock(&tv_tpg->tv_tpg_mutex);
 	}
+	if (match) {
+		for (i = 0; i < VHOST_SCSI_MAX_VQ; i++) {
+			vq = &vs->vqs[i];
+			/* Flushing the vhost_work acts as synchronize_rcu */
+			mutex_lock(&vq->mutex);
+			rcu_assign_pointer(vq->private_data, NULL);
+			mutex_unlock(&vq->mutex);
+		}
+	}
+	/*
+	 * Act as synchronize_rcu to make sure access to
+	 * old vs->vs_tpg is finished.
+	 */
+	vhost_scsi_flush(vs);
+	kfree(vs->vs_tpg);
+	vs->vs_tpg = NULL;
 	mutex_unlock(&vs->dev.mutex);
+
 	return 0;
 
 err_tpg:
@@ -890,6 +962,24 @@ err_dev:
 	return ret;
 }
 
+static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
+{
+	if (features & ~VHOST_FEATURES)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&vs->dev.mutex);
+	if ((features & (1 << VHOST_F_LOG_ALL)) &&
+	    !vhost_log_access_ok(&vs->dev)) {
+		mutex_unlock(&vs->dev.mutex);
+		return -EFAULT;
+	}
+	vs->dev.acked_features = features;
+	smp_wmb();
+	vhost_scsi_flush(vs);
+	mutex_unlock(&vs->dev.mutex);
+	return 0;
+}
+
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
 	struct vhost_scsi *s;
@@ -930,38 +1020,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
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
-}
-
-static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
-{
-	if (features & ~VHOST_FEATURES)
-		return -EOPNOTSUPP;
-
-	mutex_lock(&vs->dev.mutex);
-	if ((features & (1 << VHOST_F_LOG_ALL)) &&
-	    !vhost_log_access_ok(&vs->dev)) {
-		mutex_unlock(&vs->dev.mutex);
-		return -EFAULT;
-	}
-	vs->dev.acked_features = features;
-	smp_wmb();
-	vhost_scsi_flush(vs);
-	mutex_unlock(&vs->dev.mutex);
-	return 0;
-}
-
 static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
 				unsigned long arg)
 {
-- 
1.8.1.4
