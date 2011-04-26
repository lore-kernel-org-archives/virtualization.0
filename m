From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 06/25] Staging: hv: Get rid of the references to the priv
	element of struct hv_driver in storvsc_drv.c
Date: Tue, 26 Apr 2011 09:20:23 -0700
Message-ID: <1303834842-5022-6-git-send-email-kys@microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
	<1303834842-5022-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1303834842-5022-1-git-send-email-kys@microsoft.com>
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

In preparation for getting rid of the priv element from struct hv_driver,
get rid of the references to the priv element of struct
hv_driver in storvsc_drv.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index f819c6a..5ac2904 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -197,8 +197,6 @@ static int storvsc_drv_init(void)
 	/* Callback to client driver to complete the initialization */
 	stor_vsc_initialize(&storvsc_drv_obj->base);
 
-	drv->priv = storvsc_drv_obj;
-
 	DPRINT_INFO(STORVSC_DRV,
 		    "max outstanding reqs %u",
 		    storvsc_drv_obj->max_outstanding_req_per_channel);
@@ -325,9 +323,8 @@ static void storvsc_drv_exit(void)
 static int storvsc_probe(struct device *device)
 {
 	int ret;
-	struct hv_driver *drv =
-				drv_to_hv_drv(device->driver);
-	struct storvsc_driver_object *storvsc_drv_obj = drv->priv;
+	struct storvsc_driver_object *storvsc_drv_obj =
+				 drv_to_stordrv(device->driver);
 	struct hv_device *device_obj = device_to_hv_device(device);
 	struct Scsi_Host *host;
 	struct host_device_context *host_device_ctx;
@@ -404,9 +401,8 @@ static int storvsc_probe(struct device *device)
  */
 static int storvsc_remove(struct device *device)
 {
-	struct hv_driver *drv =
-			drv_to_hv_drv(device->driver);
-	struct storvsc_driver_object *storvsc_drv_obj = drv->priv;
+	struct storvsc_driver_object *storvsc_drv_obj =
+			 drv_to_stordrv(device->driver);
 	struct hv_device *device_obj = device_to_hv_device(device);
 	struct Scsi_Host *host = dev_get_drvdata(device);
 	struct host_device_context *host_device_ctx =
@@ -692,9 +688,8 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 	struct host_device_context *host_device_ctx =
 		(struct host_device_context *)scmnd->device->host->hostdata;
 	struct hv_device *device_ctx = host_device_ctx->device_ctx;
-	struct hv_driver *drv =
-		drv_to_hv_drv(device_ctx->device.driver);
-	struct storvsc_driver_object *storvsc_drv_obj = drv->priv;
+	struct storvsc_driver_object *storvsc_drv_obj =
+		drv_to_stordrv(device_ctx->device.driver);
 	struct hv_storvsc_request *request;
 	struct storvsc_cmd_request *cmd_request;
 	unsigned int request_size = 0;
-- 
1.7.4.1
