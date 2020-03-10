From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 04/24] scsi: Add scsi_{get, put}_reserved_cmd()
Date: Wed, 11 Mar 2020 00:25:30 +0800
Message-ID: <1583857550-12049-5-git-send-email-john.garry@huawei.com>
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

Implement a function to allocate a SCSI command from the reserved
tag pool using the host-wide reserved command queue.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_lib.c  | 30 ++++++++++++++++++++++++++++++
 include/scsi/scsi_cmnd.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e809b0e30a11..af4f56cd0093 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1927,6 +1927,36 @@ void scsi_mq_destroy_tags(struct Scsi_Host *shost)
 	blk_mq_free_tag_set(&shost->tag_set);
 }
 
+struct scsi_cmnd *scsi_get_reserved_cmd(struct Scsi_Host *shost)
+{
+	struct scsi_cmnd *scmd;
+	struct request *rq;
+
+	if (WARN_ON(!shost->reserved_cmd_q))
+		return NULL;
+
+	rq = blk_mq_alloc_request(shost->reserved_cmd_q,
+				  REQ_OP_DRV_OUT | REQ_NOWAIT,
+				  BLK_MQ_REQ_RESERVED);
+	if (IS_ERR(rq))
+		return NULL;
+	WARN_ON(rq->tag == -1);
+	scmd = blk_mq_rq_to_pdu(rq);
+	scmd->request = rq;
+
+	return scmd;
+}
+EXPORT_SYMBOL_GPL(scsi_get_reserved_cmd);
+
+void scsi_put_reserved_cmd(struct scsi_cmnd *scmd)
+{
+	struct request *rq = blk_mq_rq_from_pdu(scmd);
+
+	if (blk_mq_rq_is_reserved(rq))
+		blk_mq_free_request(rq);
+}
+EXPORT_SYMBOL_GPL(scsi_put_reserved_cmd);
+
 /**
  * scsi_device_from_queue - return sdev associated with a request_queue
  * @q: The request queue to return the sdev from
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index a2849bb9cd19..82a4499539b3 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -159,6 +159,9 @@ static inline struct scsi_driver *scsi_cmd_to_driver(struct scsi_cmnd *cmd)
 	return *(struct scsi_driver **)cmd->request->rq_disk->private_data;
 }
 
+struct scsi_cmnd *scsi_get_reserved_cmd(struct Scsi_Host *shost);
+void scsi_put_reserved_cmd(struct scsi_cmnd *);
+
 extern void scsi_put_command(struct scsi_cmnd *);
 extern void scsi_finish_command(struct scsi_cmnd *cmd);
 
-- 
2.17.1
