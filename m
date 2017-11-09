From: Byungchul Park <byungchul.park@lge.com>
Subject: [PATCH] vhost/scsi: Use safe iteration in
	vhost_scsi_complete_cmd_work()
Date: Thu,  9 Nov 2017 09:17:29 +0900
Message-ID: <1510186649-9765-1-git-send-email-byungchul.park__2230.59032946384$1511414680$gmane$org@lge.com>
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
To: nab@linux-iscsi.org, mst@redhat.com, jasowang@redhat.com
Cc: kernel-team@lge.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I am sorry for having made a mistake on it.

-----8<-----
From ba9a0f76dffceffa4fa3aa2d9be49cdb0d9b7d4f Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Thu, 9 Nov 2017 09:00:21 +0900
Subject: [PATCH] vhost/scsi: Use safe iteration in vhost_scsi_complete_cmd_work()

The following patch changed the behavior which originally did safe
iteration. Make it safe as it was.

   12bdcbd539c6327c09da0503c674733cb2d82cb5
   vhost/scsi: Don't reinvent the wheel but use existing llist API

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 drivers/vhost/scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 046f6d2..46539ca 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -519,7 +519,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 					vs_completion_work);
 	DECLARE_BITMAP(signal, VHOST_SCSI_MAX_VQ);
 	struct virtio_scsi_cmd_resp v_rsp;
-	struct vhost_scsi_cmd *cmd;
+	struct vhost_scsi_cmd *cmd, *t;
 	struct llist_node *llnode;
 	struct se_cmd *se_cmd;
 	struct iov_iter iov_iter;
@@ -527,7 +527,7 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 
 	bitmap_zero(signal, VHOST_SCSI_MAX_VQ);
 	llnode = llist_del_all(&vs->vs_completion_list);
-	llist_for_each_entry(cmd, llnode, tvc_completion_list) {
+	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
 		se_cmd = &cmd->tvc_se_cmd;
 
 		pr_debug("%s tv_cmd %p resid %u status %#02x\n", __func__,
-- 
1.9.1
