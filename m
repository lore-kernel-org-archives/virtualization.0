From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 02/16] Staging: hv: Use generic device_driver remove function
Date: Mon,  7 Mar 2011 13:21:47 -0800
Message-ID: <1299532907-22528-1-git-send-email-kys@microsoft.com>
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
to struct hv_driver, eliminate the remove() function from
struct driver_context and use generic device_driver remove()
function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    2 +-
 drivers/staging/hv/hv_mouse.c    |    2 +-
 drivers/staging/hv/netvsc_drv.c  |    2 +-
 drivers/staging/hv/storvsc_drv.c |    2 +-
 drivers/staging/hv/vmbus_drv.c   |    4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 0dff557..3e86a56 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -187,7 +187,7 @@ static int blkvsc_drv_init(int (*drv_init)(struct hv_driver *drv))
 	       sizeof(struct hv_guid));
 
 	drv_ctx->driver.probe = blkvsc_probe;
-	drv_ctx->remove = blkvsc_remove;
+	drv_ctx->driver.remove = blkvsc_remove;
 	drv_ctx->shutdown = blkvsc_shutdown;
 
 	/* The driver belongs to vmbus */
diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 4a25f3b..6e2a937 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -1022,7 +1022,7 @@ static int __init mousevsc_init(void)
 	       sizeof(struct hv_guid));
 
 	drv_ctx->driver.probe = mousevsc_probe;
-	drv_ctx->remove = mousevsc_remove;
+	drv_ctx->driver.remove = mousevsc_remove;
 
 	/* The driver belongs to vmbus */
 	vmbus_child_driver_register(drv_ctx);
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 083f0d3..e2013b5 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -512,7 +512,7 @@ static int netvsc_drv_init(int (*drv_init)(struct hv_driver *drv))
 	       sizeof(struct hv_guid));
 
 	drv_ctx->driver.probe = netvsc_probe;
-	drv_ctx->remove = netvsc_remove;
+	drv_ctx->driver.remove = netvsc_remove;
 
 	/* The driver belongs to vmbus */
 	ret = vmbus_child_driver_register(drv_ctx);
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 3fe4bdb..3855271 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -165,7 +165,7 @@ static int storvsc_drv_init(int (*drv_init)(struct hv_driver *drv))
 	       sizeof(struct hv_guid));
 
 	drv_ctx->driver.probe = storvsc_probe;
-	drv_ctx->remove = storvsc_remove;
+	drv_ctx->driver.remove = storvsc_remove;
 
 	/* The driver belongs to vmbus */
 	ret = vmbus_child_driver_register(drv_ctx);
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index fee2a8f..4df2be0 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -964,8 +964,8 @@ static int vmbus_remove(struct device *child_device)
 		 * Let the specific open-source driver handles the removal if
 		 * it can
 		 */
-		if (driver_ctx->remove) {
-			ret = driver_ctx->remove(child_device);
+		if (driver_ctx->driver.remove) {
+			ret = driver_ctx->driver.remove(child_device);
 		} else {
 			DPRINT_ERR(VMBUS_DRV,
 				   "remove() method not set for driver - %s",
-- 
1.5.5.6
