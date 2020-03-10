From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 01/24] scsi: add 'nr_reserved_cmds' field to the SCSI host template
Date: Wed, 11 Mar 2020 00:25:27 +0800
Message-ID: <1583857550-12049-2-git-send-email-john.garry@huawei.com>
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

Add a new field 'nr_reserved_cmds' to the SCSI host template to
instruct the block layer to set aside a tag space for reserved
commands.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_lib.c  | 1 +
 include/scsi/scsi_host.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 610ee41fa54c..2967325df7a0 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1896,6 +1896,7 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 		shost->tag_set.ops = &scsi_mq_ops_no_commit;
 	shost->tag_set.nr_hw_queues = shost->nr_hw_queues ? : 1;
 	shost->tag_set.queue_depth = shost->can_queue;
+	shost->tag_set.reserved_tags = shost->nr_reserved_cmds;
 	shost->tag_set.cmd_size = cmd_size;
 	shost->tag_set.numa_node = NUMA_NO_NODE;
 	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index f577647bf5f2..3f860c8ad623 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -599,6 +599,12 @@ struct Scsi_Host {
 	 * is nr_hw_queues * can_queue.
 	 */
 	unsigned nr_hw_queues;
+
+	/*
+	 * Number of reserved commands, if any.
+	 */
+	unsigned nr_reserved_cmds;
+
 	unsigned active_mode:2;
 	unsigned unchecked_isa_dma:1;
 
-- 
2.17.1
