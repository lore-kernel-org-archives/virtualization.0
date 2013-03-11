From: Asias He <asias@redhat.com>
Subject: [PATCH 2/2] tcm_vhost: Wait for pending requests in
	vhost_scsi_clear_endpoint()
Date: Mon, 11 Mar 2013 13:09:39 +0800
Message-ID: <1362978579-13322-3-git-send-email-asias@redhat.com>
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

Wait for termination of all pending requests in clear endpoint
operation, otherwise you cannot reset virtio devices safely.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 5f8342c..4b0cb12 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -1152,9 +1152,13 @@ static int vhost_scsi_clear_endpoint(
 		tv_tpg->tv_tpg_vhost_count--;
 		tv_tpg->vhost_scsi = NULL;
 		vs->vs_tpg[target] = NULL;
+		/* After this, no further requests can be queued */
 		vs->vs_endpoint = false;
 		mutex_unlock(&tv_tpg->tv_tpg_mutex);
 	}
+	/* Flush the pending requests and wait for them to finish */
+	vhost_scsi_flush(vs);
+
 	mutex_unlock(&vs->dev.mutex);
 	return 0;
 
-- 
1.8.1.4
