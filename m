From: Asias He <asias@redhat.com>
Subject: [PATCH 1/4] tcm_vhost: Add missed lock in vhost_scsi_clear_endpoint()
Date: Tue, 12 Mar 2013 10:42:48 +0800
Message-ID: <1363056171-5854-2-git-send-email-asias@redhat.com>
References: <1363056171-5854-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363056171-5854-1-git-send-email-asias@redhat.com>
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
 drivers/vhost/tcm_vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 9951297..b3e50d7 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -860,9 +860,11 @@ static int vhost_scsi_clear_endpoint(
 		if (!tv_tpg)
 			continue;
 
+		mutex_lock(&tv_tpg->tv_tpg_mutex);
 		tv_tport = tv_tpg->tport;
 		if (!tv_tport) {
 			ret = -ENODEV;
+			mutex_unlock(&tv_tpg->tv_tpg_mutex);
 			goto err;
 		}
 
@@ -872,11 +874,13 @@ static int vhost_scsi_clear_endpoint(
 				tv_tport->tport_name, tv_tpg->tport_tpgt,
 				t->vhost_wwpn, t->vhost_tpgt);
 			ret = -EINVAL;
+			mutex_unlock(&tv_tpg->tv_tpg_mutex);
 			goto err;
 		}
 		tv_tpg->tv_tpg_vhost_count--;
 		vs->vs_tpg[target] = NULL;
 		vs->vs_endpoint = false;
+		mutex_unlock(&tv_tpg->tv_tpg_mutex);
 	}
 	mutex_unlock(&vs->dev.mutex);
 	return 0;
-- 
1.8.1.4
