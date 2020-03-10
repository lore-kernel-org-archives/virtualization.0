From: John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v2 18/24] aacraid: use private commands
Date: Wed, 11 Mar 2020 00:25:44 +0800
Message-ID: <1583857550-12049-19-git-send-email-john.garry@huawei.com>
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

Use private commands to allocate internal commands.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/aacraid/aacraid.h |  6 +++--
 drivers/scsi/aacraid/commsup.c | 47 ++++++++++++----------------------
 drivers/scsi/aacraid/linit.c   |  1 +
 3 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index e3e4ecbea726..0bef32a62e41 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -1291,13 +1291,16 @@ struct fsa_dev_info {
 };
 
 struct fib {
-	void			*next;	/* this is used by the allocator */
 	s16			type;
 	s16			size;
 	/*
 	 *	The Adapter that this I/O is destined for.
 	 */
 	struct aac_dev		*dev;
+	/*
+	 * The associated scsi command
+	 */
+	struct scsi_cmnd 	*scmd;
 	/*
 	 *	This is the event the sendfib routine will wait on if the
 	 *	caller did not pass one and this is synch io.
@@ -1552,7 +1555,6 @@ struct aac_dev
 	 */
 	struct fib              *fibs;
 
-	struct fib		*free_fib;
 	spinlock_t		fib_lock;
 
 	struct mutex		ioctl_mutex;
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index 5a8a999606ea..225d67b3177a 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -35,6 +35,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_tcq.h>
 
 #include "aacraid.h"
 
@@ -173,7 +174,6 @@ int aac_fib_setup(struct aac_dev * dev)
 		fibptr->dev = dev;
 		fibptr->hw_fib_va = hw_fib;
 		fibptr->data = (void *) fibptr->hw_fib_va->data;
-		fibptr->next = fibptr+1;	/* Forward chain the fibs */
 		init_completion(&fibptr->event_wait);
 		spin_lock_init(&fibptr->event_lock);
 		hw_fib->header.XferState = cpu_to_le32(0xffffffff);
@@ -200,14 +200,6 @@ int aac_fib_setup(struct aac_dev * dev)
 	 */
 	aac_fib_vector_assign(dev);
 
-	/*
-	 *	Add the fib chain to the free list
-	 */
-	dev->fibs[dev->scsi_host_ptr->can_queue + AAC_NUM_MGT_FIB - 1].next = NULL;
-	/*
-	*	Set 8 fibs aside for management tools
-	*/
-	dev->free_fib = &dev->fibs[dev->scsi_host_ptr->can_queue];
 	return 0;
 }
 
@@ -233,6 +225,7 @@ struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 	fibptr->callback_data = NULL;
 	fibptr->callback = NULL;
 	fibptr->flags = 0;
+	fibptr->scmd = scmd;
 
 	return fibptr;
 }
@@ -247,29 +240,19 @@ struct fib *aac_fib_alloc_tag(struct aac_dev *dev, struct scsi_cmnd *scmd)
 
 struct fib *aac_fib_alloc(struct aac_dev *dev)
 {
-	struct fib * fibptr;
+	struct scsi_cmnd *scmd;
+	struct fib * fibptr = NULL;
 	unsigned long flags;
+
 	spin_lock_irqsave(&dev->fib_lock, flags);
-	fibptr = dev->free_fib;
-	if(!fibptr){
-		spin_unlock_irqrestore(&dev->fib_lock, flags);
-		return fibptr;
-	}
-	dev->free_fib = fibptr->next;
+	scmd = scsi_get_reserved_cmd(dev->scsi_host_ptr);
+	if (scmd)
+		fibptr = aac_fib_alloc_tag(dev, scmd);
 	spin_unlock_irqrestore(&dev->fib_lock, flags);
-	/*
-	 *	Set the proper node type code and node byte size
-	 */
-	fibptr->type = FSAFS_NTC_FIB_CONTEXT;
+	if (!fibptr)
+		return NULL;
+
 	fibptr->size = sizeof(struct fib);
-	/*
-	 *	Null out fields that depend on being zero at the start of
-	 *	each I/O
-	 */
-	fibptr->hw_fib_va->header.XferState = 0;
-	fibptr->flags = 0;
-	fibptr->callback = NULL;
-	fibptr->callback_data = NULL;
 
 	return fibptr;
 }
@@ -297,8 +280,12 @@ void aac_fib_free(struct fib *fibptr)
 			 (void*)fibptr,
 			 le32_to_cpu(fibptr->hw_fib_va->header.XferState));
 	}
-	fibptr->next = fibptr->dev->free_fib;
-	fibptr->dev->free_fib = fibptr;
+	if (fibptr->scmd) {
+		struct scsi_cmnd *scmd = fibptr->scmd;
+
+		fibptr->scmd = NULL;
+		scsi_put_reserved_cmd(scmd);
+	}
 	spin_unlock_irqrestore(&fibptr->dev->fib_lock, flags);
 }
 
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 0e084b09615d..f027e91656c9 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1678,6 +1678,7 @@ static int aac_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->use_cmd_list = 1;
 	shost->max_id = MAXIMUM_NUM_CONTAINERS;
 	shost->max_lun = AAC_MAX_LUN;
+	shost->nr_reserved_cmds = AAC_NUM_MGT_FIB;
 	shost->sg_tablesize = HBA_MAX_SG_SEPARATE;
 
 	if (aac_cfg_major == AAC_CHARDEV_NEEDS_REINIT)
-- 
2.17.1
