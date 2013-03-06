From: Asias He <asias@redhat.com>
Subject: [PATCH 4/5] tcm_vhost: Fix vs->vs_endpoint checking in
	vhost_scsi_handle_vq()
Date: Wed,  6 Mar 2013 14:16:29 +0800
Message-ID: <1362550590-3534-5-git-send-email-asias@redhat.com>
References: <1362550590-3534-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1362550590-3534-1-git-send-email-asias@redhat.com>
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

vs->vs_endpoint is protected by the vs->dev.mutex. Use
tcm_vhost_check_endpoint() to do check. The helper does the needed
locking for us.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index ff56b1d..f9daf39 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -608,7 +608,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 	u8 target;
 
 	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
-	if (unlikely(!vs->vs_endpoint))
+	if (!tcm_vhost_check_endpoint(vs))
 		return;
 
 	mutex_lock(&vq->mutex);
-- 
1.8.1.4
