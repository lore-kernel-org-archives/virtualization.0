From: Asias He <asias@redhat.com>
Subject: [PATCH v11 1/4] tcm_vhost: Refactor the lock nesting rule
Date: Thu, 25 Apr 2013 15:35:20 +0800
Message-ID: <1366875323-17639-2-git-send-email-asias@redhat.com>
References: <1366875323-17639-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1366875323-17639-1-git-send-email-asias@redhat.com>
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

We want to use tcm_vhost_mutex to make sure hotplug/hotunplug will not
happen when set_endpoint/clear_endpoint is in process.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 957a0b9..822cd1f 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -808,6 +808,9 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 /*
  * Called from vhost_scsi_ioctl() context to walk the list of available
  * tcm_vhost_tpg with an active struct tcm_vhost_nexus
+ *
+ *  The lock nesting rule is:
+ *    tcm_vhost_mutex -> vs->dev.mutex -> tpg->tv_tpg_mutex -> vq->mutex
  */
 static int vhost_scsi_set_endpoint(
 	struct vhost_scsi *vs,
@@ -820,26 +823,27 @@ static int vhost_scsi_set_endpoint(
 	int index, ret, i, len;
 	bool match = false;
 
+	mutex_lock(&tcm_vhost_mutex);
 	mutex_lock(&vs->dev.mutex);
+
 	/* Verify that ring has been setup correctly. */
 	for (index = 0; index < vs->dev.nvqs; ++index) {
 		/* Verify that ring has been setup correctly. */
 		if (!vhost_vq_access_ok(&vs->vqs[index])) {
-			mutex_unlock(&vs->dev.mutex);
-			return -EFAULT;
+			ret = -EFAULT;
+			goto out;
 		}
 	}
 
 	len = sizeof(vs_tpg[0]) * VHOST_SCSI_MAX_TARGET;
 	vs_tpg = kzalloc(len, GFP_KERNEL);
 	if (!vs_tpg) {
-		mutex_unlock(&vs->dev.mutex);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	if (vs->vs_tpg)
 		memcpy(vs_tpg, vs->vs_tpg, len);
 
-	mutex_lock(&tcm_vhost_mutex);
 	list_for_each_entry(tv_tpg, &tcm_vhost_list, tv_tpg_list) {
 		mutex_lock(&tv_tpg->tv_tpg_mutex);
 		if (!tv_tpg->tpg_nexus) {
@@ -854,11 +858,10 @@ static int vhost_scsi_set_endpoint(
 
 		if (!strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
 			if (vs->vs_tpg && vs->vs_tpg[tv_tpg->tport_tpgt]) {
-				mutex_unlock(&tv_tpg->tv_tpg_mutex);
-				mutex_unlock(&tcm_vhost_mutex);
-				mutex_unlock(&vs->dev.mutex);
 				kfree(vs_tpg);
-				return -EEXIST;
+				mutex_unlock(&tv_tpg->tv_tpg_mutex);
+				ret = -EEXIST;
+				goto out;
 			}
 			tv_tpg->tv_tpg_vhost_count++;
 			vs_tpg[tv_tpg->tport_tpgt] = tv_tpg;
@@ -867,7 +870,6 @@ static int vhost_scsi_set_endpoint(
 		}
 		mutex_unlock(&tv_tpg->tv_tpg_mutex);
 	}
-	mutex_unlock(&tcm_vhost_mutex);
 
 	if (match) {
 		memcpy(vs->vs_vhost_wwpn, t->vhost_wwpn,
@@ -893,7 +895,9 @@ static int vhost_scsi_set_endpoint(
 	kfree(vs->vs_tpg);
 	vs->vs_tpg = vs_tpg;
 
+out:
 	mutex_unlock(&vs->dev.mutex);
+	mutex_unlock(&tcm_vhost_mutex);
 	return ret;
 }
 
@@ -908,6 +912,7 @@ static int vhost_scsi_clear_endpoint(
 	int index, ret, i;
 	u8 target;
 
+	mutex_lock(&tcm_vhost_mutex);
 	mutex_lock(&vs->dev.mutex);
 	/* Verify that ring has been setup correctly. */
 	for (index = 0; index < vs->dev.nvqs; ++index) {
@@ -918,8 +923,8 @@ static int vhost_scsi_clear_endpoint(
 	}
 
 	if (!vs->vs_tpg) {
-		mutex_unlock(&vs->dev.mutex);
-		return 0;
+		ret = 0;
+		goto err_dev;
 	}
 
 	for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
@@ -965,13 +970,14 @@ static int vhost_scsi_clear_endpoint(
 	kfree(vs->vs_tpg);
 	vs->vs_tpg = NULL;
 	mutex_unlock(&vs->dev.mutex);
-
+	mutex_unlock(&tcm_vhost_mutex);
 	return 0;
 
 err_tpg:
 	mutex_unlock(&tv_tpg->tv_tpg_mutex);
 err_dev:
 	mutex_unlock(&vs->dev.mutex);
+	mutex_unlock(&tcm_vhost_mutex);
 	return ret;
 }
 
-- 
1.8.1.4
