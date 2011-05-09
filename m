From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 041/206] Staging: hv: Get rid of the forward declaration for
	storvsc_device_configure()
Date: Mon,  9 May 2011 14:55:23 -0700
Message-ID: <1304978288-22999-41-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the forward declaration by moving the code around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   39 ++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 44dbaae..4196d6a 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -129,10 +129,28 @@ static int storvsc_merge_bvec(struct request_queue *q,
 	return bvec->bv_len;
 }
 
+static int storvsc_device_configure(struct scsi_device *sdevice)
+{
+	scsi_adjust_queue_depth(sdevice, MSG_SIMPLE_TAG,
+				STORVSC_MAX_IO_REQUESTS);
+
+	DPRINT_INFO(STORVSC_DRV, "sdev (%p) - setting max segment size to %ld",
+		    sdevice, PAGE_SIZE);
+	blk_queue_max_segment_size(sdevice->request_queue, PAGE_SIZE);
+
+	DPRINT_INFO(STORVSC_DRV, "sdev (%p) - adding merge bio vec routine",
+		    sdevice);
+	blk_queue_merge_bvec(sdevice->request_queue, storvsc_merge_bvec);
+
+	blk_queue_bounce_limit(sdevice->request_queue, BLK_BOUNCE_ANY);
+	/* sdevice->timeout = (2000 * HZ);//(75 * HZ); */
+
+	return 0;
+}
+
 /* Static decl */
 static int storvsc_probe(struct hv_device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
-static int storvsc_device_configure(struct scsi_device *);
 static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd);
 static int storvsc_remove(struct hv_device *dev);
 
@@ -830,25 +848,6 @@ retry_request:
 
 static DEF_SCSI_QCMD(storvsc_queuecommand)
 
-static int storvsc_device_configure(struct scsi_device *sdevice)
-{
-	scsi_adjust_queue_depth(sdevice, MSG_SIMPLE_TAG,
-				STORVSC_MAX_IO_REQUESTS);
-
-	DPRINT_INFO(STORVSC_DRV, "sdev (%p) - setting max segment size to %ld",
-		    sdevice, PAGE_SIZE);
-	blk_queue_max_segment_size(sdevice->request_queue, PAGE_SIZE);
-
-	DPRINT_INFO(STORVSC_DRV, "sdev (%p) - adding merge bio vec routine",
-		    sdevice);
-	blk_queue_merge_bvec(sdevice->request_queue, storvsc_merge_bvec);
-
-	blk_queue_bounce_limit(sdevice->request_queue, BLK_BOUNCE_ANY);
-	/* sdevice->timeout = (2000 * HZ);//(75 * HZ); */
-
-	return 0;
-}
-
 /*
  * storvsc_host_reset_handler - Reset the scsi HBA
  */
-- 
1.7.4.1
