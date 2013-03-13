From: Asias He <asias@redhat.com>
Subject: [PATCH V2 1/3] tcm_vhost: Add missed lock in
	vhost_scsi_clear_endpoint()
Date: Wed, 13 Mar 2013 15:34:13 +0800
Message-ID: <1363160055-24605-2-git-send-email-asias@redhat.com>
References: <1363160055-24605-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363160055-24605-1-git-send-email-asias@redhat.com>
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

tv_tpg->tv_tpg_vhost_count should be protected by tv_tpg->tv_tpg_mutex.

Signed-off-by: Asias He <asias@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 9951297..79d3aea 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -850,7 +850,7 @@ static int vhost_scsi_clear_endpoint(
 	for (index = 0; index < vs->dev.nvqs; ++index) {
 		if (!vhost_vq_access_ok(&vs->vqs[index])) {
 			ret = -EFAULT;
-			goto err;
+			goto err_dev;
 		}
 	}
 	for (i = 0; i < VHOST_SCSI_MAX_TARGET; i++) {
@@ -860,10 +860,11 @@ static int vhost_scsi_clear_endpoint(
 		if (!tv_tpg)
 			continue;
 
+		mutex_lock(&tv_tpg->tv_tpg_mutex);
 		tv_tport = tv_tpg->tport;
 		if (!tv_tport) {
 			ret = -ENODEV;
-			goto err;
+			goto err_tpg;
 		}
 
 		if (strcmp(tv_tport->tport_name, t->vhost_wwpn)) {
@@ -872,16 +873,19 @@ static int vhost_scsi_clear_endpoint(
 				tv_tport->tport_name, tv_tpg->tport_tpgt,
 				t->vhost_wwpn, t->vhost_tpgt);
 			ret = -EINVAL;
-			goto err;
+			goto err_tpg;
 		}
 		tv_tpg->tv_tpg_vhost_count--;
 		vs->vs_tpg[target] = NULL;
 		vs->vs_endpoint = false;
+		mutex_unlock(&tv_tpg->tv_tpg_mutex);
 	}
 	mutex_unlock(&vs->dev.mutex);
 	return 0;
 
-err:
+err_tpg:
+	mutex_unlock(&tv_tpg->tv_tpg_mutex);
+err_dev:
 	mutex_unlock(&vs->dev.mutex);
 	return ret;
 }
-- 
1.8.1.4
