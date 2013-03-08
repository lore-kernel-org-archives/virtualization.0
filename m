From: Asias He <asias@redhat.com>
Subject: [PATCH V2 4/6] tcm_vhost: Fix vs->vs_endpoint checking in
	vhost_scsi_handle_vq()
Date: Fri,  8 Mar 2013 10:21:45 +0800
Message-ID: <1362709307-12554-5-git-send-email-asias__4675.58863242647$1362709383$gmane$org@redhat.com>
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

vs->vs_endpoint is protected by the vs->dev.mutex. Use
tcm_vhost_check_endpoint() to do check. The helper does the needed
locking for us.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index b71e946..6739d67 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -606,7 +606,7 @@ static void vhost_scsi_handle_vq(struct vhost_scsi *vs,
 	u8 target;
 
 	/* Must use ioctl VHOST_SCSI_SET_ENDPOINT */
-	if (unlikely(!vs->vs_endpoint))
+	if (!tcm_vhost_check_endpoint(vs))
 		return;
 
 	mutex_lock(&vq->mutex);
-- 
1.8.1.4
