From: Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>
Subject: [PATCH] vhost: scsi: notify TCM about the maximum sg entries
 supported per command.
Date: Mon, 11 May 2020 22:18:52 +0000
Message-ID: <1589235532-10333-1-git-send-email-sudhakar.panneerselvam@oracle.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

vhost-scsi pre-allocates the maximum sg entries per command and if a
command requires more than VHOST_SCSI_PREALLOC_SGLS entries, then that
command is failed by it. This patch lets vhost communicate the max sg limit
when it registers vhost_scsi_ops with TCM. With this change, TCM would
report the max sg entries through "Block Limits" VPD page which will be
typically queried by the SCSI initiator during device discovery. By knowing
this limit, the initiator could ensure the maximum transfer length is less
than or equal to what is reported by vhost-scsi.

Signed-off-by: Sudhakar Panneerselvam <sudhakar.panneerselvam@oracle.com>
---
 drivers/vhost/scsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index c39952243fd3..8b104f76f324 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2280,6 +2280,7 @@ static void vhost_scsi_drop_tport(struct se_wwn *wwn)
 static const struct target_core_fabric_ops vhost_scsi_ops = {
 	.module				= THIS_MODULE,
 	.fabric_name			= "vhost",
+	.max_data_sg_nents		= VHOST_SCSI_PREALLOC_SGLS,
 	.tpg_get_wwn			= vhost_scsi_get_fabric_wwn,
 	.tpg_get_tag			= vhost_scsi_get_tpgt,
 	.tpg_check_demo_mode		= vhost_scsi_check_true,
-- 
1.8.3.1
