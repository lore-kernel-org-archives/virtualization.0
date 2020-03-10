From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 22/24] scsi: drop scsi command list
Date: Wed, 11 Mar 2020 00:25:48 +0800
Message-ID: <1583857550-12049-23-git-send-email-john.garry@huawei.com>
References: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <1583857550-12049-1-git-send-email-john.garry@huawei.com>
Sender: linux-block-owner@vger.kernel.org
To: axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de, ming.lei@redhat.com, bvanassche@acm.org, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org, esc.storagedev@microsemi.com, chenxiang66@hisilicon.com, Hannes Reinecke <hare@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hannes Reinecke <hare@suse.com>

No users left, kill it.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi.c        |  1 -
 drivers/scsi/scsi_lib.c    | 32 --------------------------------
 drivers/scsi/scsi_scan.c   |  1 -
 include/scsi/scsi_cmnd.h   |  1 -
 include/scsi/scsi_device.h |  1 -
 include/scsi/scsi_host.h   |  2 --
 6 files changed, 38 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 930e4803d888..8ca36d778bcf 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -104,7 +104,6 @@ EXPORT_SYMBOL(scsi_sd_pm_domain);
  */
 void scsi_put_command(struct scsi_cmnd *cmd)
 {
-	scsi_del_cmd_from_list(cmd);
 	BUG_ON(delayed_work_pending(&cmd->abort_work));
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index af4f56cd0093..1253893007d3 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -562,7 +562,6 @@ static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
 {
 	scsi_mq_free_sgtables(cmd);
 	scsi_uninit_cmd(cmd);
-	scsi_del_cmd_from_list(cmd);
 }
 
 /* Returns false when no more bytes to process, true if there are more */
@@ -1098,35 +1097,6 @@ static void scsi_cleanup_rq(struct request *rq)
 	}
 }
 
-/* Add a command to the list used by the aacraid and dpt_i2o drivers */
-void scsi_add_cmd_to_list(struct scsi_cmnd *cmd)
-{
-	struct scsi_device *sdev = cmd->device;
-	struct Scsi_Host *shost = sdev->host;
-	unsigned long flags;
-
-	if (shost->use_cmd_list) {
-		spin_lock_irqsave(&sdev->list_lock, flags);
-		list_add_tail(&cmd->list, &sdev->cmd_list);
-		spin_unlock_irqrestore(&sdev->list_lock, flags);
-	}
-}
-
-/* Remove a command from the list used by the aacraid and dpt_i2o drivers */
-void scsi_del_cmd_from_list(struct scsi_cmnd *cmd)
-{
-	struct scsi_device *sdev = cmd->device;
-	struct Scsi_Host *shost = sdev->host;
-	unsigned long flags;
-
-	if (shost->use_cmd_list) {
-		spin_lock_irqsave(&sdev->list_lock, flags);
-		BUG_ON(list_empty(&cmd->list));
-		list_del_init(&cmd->list);
-		spin_unlock_irqrestore(&sdev->list_lock, flags);
-	}
-}
-
 /* Called after a request has been started. */
 void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 {
@@ -1159,8 +1129,6 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
 	cmd->retries = retries;
 	if (in_flight)
 		__set_bit(SCMD_STATE_INFLIGHT, &cmd->state);
-
-	scsi_add_cmd_to_list(cmd);
 }
 
 static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 058079f915f1..f2437a7570ce 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -236,7 +236,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	sdev->sdev_state = SDEV_CREATED;
 	INIT_LIST_HEAD(&sdev->siblings);
 	INIT_LIST_HEAD(&sdev->same_target_siblings);
-	INIT_LIST_HEAD(&sdev->cmd_list);
 	INIT_LIST_HEAD(&sdev->starved_entry);
 	INIT_LIST_HEAD(&sdev->event_list);
 	spin_lock_init(&sdev->list_lock);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index c73280b3706d..50addc112212 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -68,7 +68,6 @@ struct scsi_pointer {
 struct scsi_cmnd {
 	struct scsi_request req;
 	struct scsi_device *device;
-	struct list_head list;  /* scsi_cmnd participates in queue lists */
 	struct list_head eh_entry; /* entry for the host eh_cmd_q */
 	struct delayed_work abort_work;
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index f8312a3e5b42..f146a4557787 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -110,7 +110,6 @@ struct scsi_device {
 	atomic_t device_blocked;	/* Device returned QUEUE_FULL. */
 
 	spinlock_t list_lock;
-	struct list_head cmd_list;	/* queue of in use SCSI Command structures */
 	struct list_head starved_entry;
 	unsigned short queue_depth;	/* How deep of a queue we want */
 	unsigned short max_queue_depth;	/* max queue depth */
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 663aef22437a..dc62794f4cb5 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -634,8 +634,6 @@ struct Scsi_Host {
 	/* The controller does not support WRITE SAME */
 	unsigned no_write_same:1;
 
-	unsigned use_cmd_list:1;
-
 	/* Host responded with short (<36 bytes) INQUIRY result */
 	unsigned short_inquiry:1;
 
-- 
2.17.1
