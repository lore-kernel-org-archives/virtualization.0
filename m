From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 13/21] Staging: hv: Cleanup storvsc_remove()
Date: Fri, 22 Apr 2011 14:55:18 -0700
Message-ID: <1303509326-3094-13-git-send-email-kys@microsoft.com>
References: <1303509246-3053-1-git-send-email-kys@microsoft.com>
	<1303509326-3094-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1303509326-3094-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

storvsc_remove() cannot fail, clean it up accordingly.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index ae61735..f819c6a 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -404,7 +404,6 @@ static int storvsc_probe(struct device *device)
  */
 static int storvsc_remove(struct device *device)
 {
-	int ret;
 	struct hv_driver *drv =
 			drv_to_hv_drv(device->driver);
 	struct storvsc_driver_object *storvsc_drv_obj = drv->priv;
@@ -413,20 +412,11 @@ static int storvsc_remove(struct device *device)
 	struct host_device_context *host_device_ctx =
 			(struct host_device_context *)host->hostdata;
 
-
-	if (!storvsc_drv_obj->base.dev_rm)
-		return -1;
-
 	/*
 	 * Call to the vsc driver to let it know that the device is being
 	 * removed
 	 */
-	ret = storvsc_drv_obj->base.dev_rm(device_obj);
-	if (ret != 0) {
-		/* TODO: */
-		DPRINT_ERR(STORVSC, "unable to remove vsc device (ret %d)",
-			   ret);
-	}
+	storvsc_drv_obj->base.dev_rm(device_obj);
 
 	if (host_device_ctx->request_pool) {
 		kmem_cache_destroy(host_device_ctx->request_pool);
@@ -438,7 +428,7 @@ static int storvsc_remove(struct device *device)
 
 	DPRINT_INFO(STORVSC, "releasing host adapter (%p)...", host);
 	scsi_host_put(host);
-	return ret;
+	return 0;
 }
 
 /*
-- 
1.7.4.1
