From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 047/206] Staging: hv: Get rid of the forward declaration of
	storvsc_remove()
Date: Mon,  9 May 2011 14:55:29 -0700
Message-ID: <1304978288-22999-47-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/storvsc_drv.c |   62 +++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 807ba89..6f23f52 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -350,11 +350,41 @@ static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
 	return total_copied;
 }
 
+
+/*
+ * storvsc_remove - Callback when our device is removed
+ */
+static int storvsc_remove(struct hv_device *dev)
+{
+	struct storvsc_driver *storvsc_drv_obj =
+			 drv_to_stordrv(dev->device.driver);
+	struct Scsi_Host *host = dev_get_drvdata(&dev->device);
+	struct hv_host_device *host_dev =
+			(struct hv_host_device *)host->hostdata;
+
+	/*
+	 * Call to the vsc driver to let it know that the device is being
+	 * removed
+	 */
+	storvsc_drv_obj->base.dev_rm(dev);
+
+	if (host_dev->request_pool) {
+		kmem_cache_destroy(host_dev->request_pool);
+		host_dev->request_pool = NULL;
+	}
+
+	DPRINT_INFO(STORVSC, "removing host adapter (%p)...", host);
+	scsi_remove_host(host);
+
+	DPRINT_INFO(STORVSC, "releasing host adapter (%p)...", host);
+	scsi_host_put(host);
+	return 0;
+}
+
 /* Static decl */
 static int storvsc_probe(struct hv_device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
 static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd);
-static int storvsc_remove(struct hv_device *dev);
 
 static int storvsc_get_chs(struct scsi_device *sdev, struct block_device *bdev,
 			   sector_t capacity, int *info);
@@ -589,36 +619,6 @@ static int storvsc_probe(struct hv_device *device)
 }
 
 /*
- * storvsc_remove - Callback when our device is removed
- */
-static int storvsc_remove(struct hv_device *dev)
-{
-	struct storvsc_driver *storvsc_drv_obj =
-			 drv_to_stordrv(dev->device.driver);
-	struct Scsi_Host *host = dev_get_drvdata(&dev->device);
-	struct hv_host_device *host_dev =
-			(struct hv_host_device *)host->hostdata;
-
-	/*
-	 * Call to the vsc driver to let it know that the device is being
-	 * removed
-	 */
-	storvsc_drv_obj->base.dev_rm(dev);
-
-	if (host_dev->request_pool) {
-		kmem_cache_destroy(host_dev->request_pool);
-		host_dev->request_pool = NULL;
-	}
-
-	DPRINT_INFO(STORVSC, "removing host adapter (%p)...", host);
-	scsi_remove_host(host);
-
-	DPRINT_INFO(STORVSC, "releasing host adapter (%p)...", host);
-	scsi_host_put(host);
-	return 0;
-}
-
-/*
  * storvsc_commmand_completion - Command completion processing
  */
 static void storvsc_commmand_completion(struct hv_storvsc_request *request)
-- 
1.7.4.1
