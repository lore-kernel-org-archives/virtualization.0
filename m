From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 02/24] scsi: allocate separate queue for reserved commands
Date: Wed, 11 Mar 2020 00:25:28 +0800
Message-ID: <1583857550-12049-3-git-send-email-john.garry@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hannes Reinecke <hare@suse.com>

Allocate a separate 'reserved_cmd_q' for sending reserved commands.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_lib.c  | 17 ++++++++++++++++-
 include/scsi/scsi_host.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2967325df7a0..e809b0e30a11 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1881,6 +1881,7 @@ struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
 int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
+	int ret;
 
 	sgl_size = max_t(unsigned int, sizeof(struct scatterlist),
 				scsi_mq_inline_sgl_size(shost));
@@ -1904,11 +1905,25 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
 	shost->tag_set.driver_data = shost;
 
-	return blk_mq_alloc_tag_set(&shost->tag_set);
+	ret = blk_mq_alloc_tag_set(&shost->tag_set);
+	if (ret)
+		return ret;
+
+	if (shost->nr_reserved_cmds) {
+		shost->reserved_cmd_q = blk_mq_init_queue(&shost->tag_set);
+		if (IS_ERR(shost->reserved_cmd_q)) {
+			blk_mq_free_tag_set(&shost->tag_set);
+			ret = PTR_ERR(shost->reserved_cmd_q);
+			shost->reserved_cmd_q = NULL;
+		}
+	}
+	return ret;
 }
 
 void scsi_mq_destroy_tags(struct Scsi_Host *shost)
 {
+	if (shost->reserved_cmd_q)
+		blk_cleanup_queue(shost->reserved_cmd_q);
 	blk_mq_free_tag_set(&shost->tag_set);
 }
 
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 3f860c8ad623..2258a4f7b4d8 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -604,6 +604,7 @@ struct Scsi_Host {
 	 * Number of reserved commands, if any.
 	 */
 	unsigned nr_reserved_cmds;
+	struct request_queue *reserved_cmd_q;
 
 	unsigned active_mode:2;
 	unsigned unchecked_isa_dma:1;
-- 
2.17.1
