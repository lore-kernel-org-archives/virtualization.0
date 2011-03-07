From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/16] Staging: hv: Use generic device_driver shutdown function
Date: Mon,  7 Mar 2011 13:22:20 -0800
Message-ID: <1299532940-22553-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for moving all the state from struct driver_context
to struct hv_driver, eliminate the shutdown() function from
struct driver_context and use generic device_driver shutdown()
function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    2 +-
 drivers/staging/hv/vmbus_drv.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 3e86a56..9ccd5dc 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -188,7 +188,7 @@ static int blkvsc_drv_init(int (*drv_init)(struct hv_driver *drv))
 
 	drv_ctx->driver.probe = blkvsc_probe;
 	drv_ctx->driver.remove = blkvsc_remove;
-	drv_ctx->shutdown = blkvsc_shutdown;
+	drv_ctx->driver.shutdown = blkvsc_shutdown;
 
 	/* The driver belongs to vmbus */
 	ret = vmbus_child_driver_register(drv_ctx);
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 4df2be0..6ef5bee 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -1000,8 +1000,8 @@ static void vmbus_shutdown(struct device *child_device)
 	driver_ctx = driver_to_driver_context(child_device->driver);
 
 	/* Let the specific open-source driver handles the removal if it can */
-	if (driver_ctx->shutdown)
-		driver_ctx->shutdown(child_device);
+	if (driver_ctx->driver.shutdown)
+		driver_ctx->driver.shutdown(child_device);
 
 	return;
 }
-- 
1.5.5.6
