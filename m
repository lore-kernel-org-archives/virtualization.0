From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 014/206] Staging: hv: Rename the function stor_vsc_on_cleanup
Date: Mon,  9 May 2011 14:54:56 -0700
Message-ID: <1304978288-22999-14-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/blkvsc_drv.c  |    5 ++---
 drivers/staging/hv/storvsc.c     |    2 +-
 drivers/staging/hv/storvsc_api.h |    2 +-
 drivers/staging/hv/storvsc_drv.c |    2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 8b8d960..1d0b6ed 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -17,8 +17,7 @@
  * Authors:
  *   Haiyang Zhang <haiyangz@microsoft.com>
  *   Hank Janssen  <hjanssen@microsoft.com>
- *
- * 4/3/2011: K. Y. Srinivasan - Significant restructuring and cleanup.
+ *   K. Y. Srinivasan <kys@microsoft.com>
  */
 #include <linux/init.h>
 #include <linux/module.h>
@@ -197,7 +196,7 @@ static int blk_vsc_initialize(struct hv_driver *driver)
 		    stor_driver->max_outstanding_req_per_channel);
 
 	/* Setup the dispatch table */
-	stor_driver->base.cleanup = stor_vsc_on_cleanup;
+	stor_driver->base.cleanup = storvsc_cleanup;
 	stor_driver->on_io_request = stor_vsc_on_io_request;
 
 	return ret;
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 976f382..2e276b4 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -663,7 +663,7 @@ int stor_vsc_get_major_info(struct storvsc_device_info *device_info,
 /*
  * stor_vsc_on_cleanup - Perform any cleanup when the driver is removed
  */
-void stor_vsc_on_cleanup(struct hv_driver *driver)
+void storvsc_cleanup(struct hv_driver *driver)
 {
 }
 
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index b3207a0..3168161 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -169,7 +169,7 @@ int storvsc_dev_remove(struct hv_device *device);
 
 int stor_vsc_on_io_request(struct hv_device *device,
 				struct hv_storvsc_request *request);
-void stor_vsc_on_cleanup(struct hv_driver *driver);
+void storvsc_cleanup(struct hv_driver *driver);
 
 int stor_vsc_get_major_info(struct storvsc_device_info *device_info,
 				struct storvsc_major_info *major_info);
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 903ecbe..86f2bab 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -115,7 +115,7 @@ static int stor_vsc_initialize(struct hv_driver *driver)
 	/* Setup the dispatch table */
 	stor_driver->base.dev_add	= storvsc_dev_add;
 	stor_driver->base.dev_rm	= storvsc_dev_remove;
-	stor_driver->base.cleanup	= stor_vsc_on_cleanup;
+	stor_driver->base.cleanup	= storvsc_cleanup;
 
 	stor_driver->on_io_request	= stor_vsc_on_io_request;
 
-- 
1.7.4.1
