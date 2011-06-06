From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/49] Staging: hv: storvsc: Cleanup some dated/unnecessary
	comments
Date: Mon,  6 Jun 2011 15:49:29 -0700
Message-ID: <1307400613-13234-5-git-send-email-kys@microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
	<1307400613-13234-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1307400613-13234-1-git-send-email-kys@microsoft.com>
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

Cleanup some dated/unnecessary comments.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index fd474d6..499e1d7 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -308,9 +308,6 @@ static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
 }
 
 
-/*
- * storvsc_remove - Callback when our device is removed
- */
 static int storvsc_remove(struct hv_device *dev)
 {
 	struct Scsi_Host *host = dev_get_drvdata(&dev->device);
@@ -322,10 +319,7 @@ static int storvsc_remove(struct hv_device *dev)
 
 	DPRINT_INFO(STORVSC, "releasing host adapter (%p)...", host);
 	scsi_host_put(host);
-	/*
-	 * Call to the vsc driver to let it know that the device is being
-	 * removed
-	 */
+
 	storvsc_dev_remove(dev);
 	if (host_dev->request_pool) {
 		kmem_cache_destroy(host_dev->request_pool);
@@ -423,7 +417,6 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 	DPRINT_INFO(STORVSC_DRV, "sdev (%p) dev obj (%p) - host resetting...",
 		    scmnd->device, dev);
 
-	/* Invokes the vsc to reset the host/bus */
 	ret = storvsc_host_reset(dev);
 	if (ret != 0)
 		return ret;
@@ -477,7 +470,6 @@ static void storvsc_commmand_completion(struct hv_storvsc_request *request)
 	scmnd->host_scribble = NULL;
 	scmnd->scsi_done = NULL;
 
-	/* !!DO NOT MODIFY the scmnd after this call */
 	scsi_done_fn(scmnd);
 
 	kmem_cache_free(host_dev->request_pool, cmd_request);
@@ -750,10 +742,6 @@ static struct hv_driver storvsc_drv = {
 	.remove = storvsc_remove,
 };
 
-
-/*
- * storvsc_drv_init - StorVsc driver initialization.
- */
 static int __init storvsc_drv_init(void)
 {
 	int ret;
-- 
1.7.4.1
