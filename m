From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 21/24] dpt_i2o: drop cmd_list usage
Date: Wed, 11 Mar 2020 00:25:47 +0800
Message-ID: <1583857550-12049-22-git-send-email-john.garry@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Sender: linux-scsi-owner@vger.kernel.org
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hannes Reinecke <hare@suse.com>

Now each command has a unique tag, so we can drop the legacy 'cmd_list'
usage and rely on the tag to identify the command.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/dpt_i2o.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index abc74fd474dc..4c7305bf6b57 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -2335,7 +2335,6 @@ static s32 adpt_scsi_host_alloc(adpt_hba* pHba, struct scsi_host_template *sht)
 	host->unique_id = (u32)sys_tbl_pa + pHba->unit;
 	host->sg_tablesize = pHba->sg_tablesize;
 	host->can_queue = pHba->post_fifo_size;
-	host->use_cmd_list = 1;
 
 	return 0;
 }
@@ -2647,20 +2646,18 @@ static s32 adpt_i2o_reparse_lct(adpt_hba* pHba)
 	return 0;
 }
 
-static void adpt_fail_posted_scbs(adpt_hba* pHba)
+static bool adpt_fail_posted_scbs_iter(struct request *req, void *data, bool reserved)
 {
-	struct scsi_cmnd* 	cmd = NULL;
-	struct scsi_device* 	d = NULL;
+	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 
-	shost_for_each_device(d, pHba->host) {
-		unsigned long flags;
-		spin_lock_irqsave(&d->list_lock, flags);
-		list_for_each_entry(cmd, &d->cmd_list, list) {
-			cmd->result = (DID_OK << 16) | (QUEUE_FULL <<1);
-			cmd->scsi_done(cmd);
-		}
-		spin_unlock_irqrestore(&d->list_lock, flags);
-	}
+	cmd->result = (DID_OK << 16) | (QUEUE_FULL <<1);
+	cmd->scsi_done(cmd);
+	return true;
+}
+
+static void adpt_fail_posted_scbs(adpt_hba* pHba)
+{
+	blk_mq_tagset_busy_iter(&pHba->host->tag_set, adpt_fail_posted_scbs_iter, NULL);
 }
 
 
-- 
2.17.1
