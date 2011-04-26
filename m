From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 02/25] Staging: hv: Get rid of the references to the priv
	element of struct hv_driver in block driver
Date: Tue, 26 Apr 2011 09:20:19 -0700
Message-ID: <1303834842-5022-2-git-send-email-kys@microsoft.com>
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
get rid of the references to the priv element of struct hv_driver
in blkvsc_drv.c and storvsc.c


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   14 +++-----------
 drivers/staging/hv/storvsc.c    |    2 +-
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index acc5435..ec6a761 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -214,10 +214,8 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 {
 	struct block_device_context *blkdev = blkvsc_req->dev;
 	struct hv_device *device_ctx = blkdev->device_ctx;
-	struct hv_driver *drv =
-			drv_to_hv_drv(device_ctx->device.driver);
 	struct storvsc_driver_object *storvsc_drv_obj =
-			drv->priv;
+			drv_to_stordrv(device_ctx->device.driver);
 	struct hv_storvsc_request *storvsc_req;
 	struct vmscsi_request *vm_srb;
 	int ret;
@@ -541,10 +539,8 @@ out:
  */
 static int blkvsc_remove(struct device *device)
 {
-	struct hv_driver *drv =
-				drv_to_hv_drv(device->driver);
 	struct storvsc_driver_object *storvsc_drv_obj =
-				drv->priv;
+				drv_to_stordrv(device->driver);
 	struct hv_device *device_obj = device_to_hv_device(device);
 	struct block_device_context *blkdev = dev_get_drvdata(device);
 	unsigned long flags;
@@ -881,8 +877,6 @@ static int blkvsc_drv_init(void)
 
 	storvsc_drv_obj->ring_buffer_size = blkvsc_ringbuffer_size;
 
-	drv->priv = storvsc_drv_obj;
-
 	/* Callback to client driver to complete the initialization */
 	blk_vsc_initialize(&storvsc_drv_obj->base);
 
@@ -945,10 +939,8 @@ static void blkvsc_drv_exit(void)
  */
 static int blkvsc_probe(struct device *device)
 {
-	struct hv_driver *drv =
-				drv_to_hv_drv(device->driver);
 	struct storvsc_driver_object *storvsc_drv_obj =
-				drv->priv;
+				drv_to_stordrv(device->driver);
 	struct hv_device *device_obj = device_to_hv_device(device);
 
 	struct block_device_context *blkdev = NULL;
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 85bae5a..d53aa97 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -414,7 +414,7 @@ static int stor_vsc_connect_to_vsp(struct hv_device *device)
 	struct storvsc_driver_object *stor_driver;
 	int ret;
 
-	stor_driver = (struct storvsc_driver_object *)device->drv;
+	stor_driver = drv_to_stordrv(device->device.driver);
 	memset(&props, 0, sizeof(struct vmstorage_channel_properties));
 
 	/* Open the channel */
-- 
1.7.4.1
