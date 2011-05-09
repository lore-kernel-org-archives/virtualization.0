From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 036/206] Staging: hv: Rename variables pointing to struct
	hv_device
Date: Mon,  9 May 2011 14:55:18 -0700
Message-ID: <1304978288-22999-36-git-send-email-kys@microsoft.com>
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

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index c183220..c654172 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -368,7 +368,6 @@ static int storvsc_probe(struct hv_device *device)
 		return -1;
 	}
 
-	/* host_device_ctx->port = device_info.PortNumber; */
 	host_dev->path = device_info.path_id;
 	host_dev->target = device_info.target_id;
 
@@ -685,9 +684,9 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 	int ret;
 	struct hv_host_device *host_dev =
 		(struct hv_host_device *)scmnd->device->host->hostdata;
-	struct hv_device *device_ctx = host_dev->dev;
+	struct hv_device *dev = host_dev->dev;
 	struct storvsc_driver *storvsc_drv_obj =
-		drv_to_stordrv(device_ctx->device.driver);
+		drv_to_stordrv(dev->device.driver);
 	struct hv_storvsc_request *request;
 	struct storvsc_cmd_request *cmd_request;
 	unsigned int request_size = 0;
@@ -831,7 +830,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 
 retry_request:
 	/* Invokes the vsc to start an IO */
-	ret = storvsc_drv_obj->on_io_request(device_ctx,
+	ret = storvsc_drv_obj->on_io_request(dev,
 					   &cmd_request->request);
 	if (ret == -1) {
 		/* no more space */
@@ -918,18 +917,18 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 	int ret;
 	struct hv_host_device *host_dev =
 		(struct hv_host_device *)scmnd->device->host->hostdata;
-	struct hv_device *device_ctx = host_dev->dev;
+	struct hv_device *dev = host_dev->dev;
 
 	DPRINT_INFO(STORVSC_DRV, "sdev (%p) dev obj (%p) - host resetting...",
-		    scmnd->device, device_ctx);
+		    scmnd->device, dev);
 
 	/* Invokes the vsc to reset the host/bus */
-	ret = stor_vsc_on_host_reset(device_ctx);
+	ret = stor_vsc_on_host_reset(dev);
 	if (ret != 0)
 		return ret;
 
 	DPRINT_INFO(STORVSC_DRV, "sdev (%p) dev obj (%p) - host reseted",
-		    scmnd->device, device_ctx);
+		    scmnd->device, dev);
 
 	return ret;
 }
-- 
1.7.4.1
