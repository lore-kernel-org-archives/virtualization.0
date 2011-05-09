From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 012/206] Staging: hv: Rename the function stor_vsc_on_device_remove
Date: Mon,  9 May 2011 14:54:54 -0700
Message-ID: <1304978288-22999-12-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    2 +-
 drivers/staging/hv/storvsc.c     |    2 +-
 drivers/staging/hv/storvsc_api.h |    2 +-
 drivers/staging/hv/storvsc_drv.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 908c169..830f257 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -197,7 +197,7 @@ static int blk_vsc_initialize(struct hv_driver *driver)
 		    stor_driver->max_outstanding_req_per_channel);
 
 	/* Setup the dispatch table */
-	stor_driver->base.dev_rm = stor_vsc_on_device_remove;
+	stor_driver->base.dev_rm = storvsc_dev_remove;
 	stor_driver->base.cleanup = stor_vsc_on_cleanup;
 	stor_driver->on_io_request = stor_vsc_on_io_request;
 
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 503c6bf..976f382 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -483,7 +483,7 @@ cleanup:
 /*
  * stor_vsc_on_device_remove - Callback when the our device is being removed
  */
-int stor_vsc_on_device_remove(struct hv_device *device)
+int storvsc_dev_remove(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
 
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 0200154..b3207a0 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -165,7 +165,7 @@ struct storvsc_driver *drv_to_stordrv(struct device_driver *d)
 
 int storvsc_dev_add(struct hv_device *device,
 				void *additional_info);
-int stor_vsc_on_device_remove(struct hv_device *device);
+int storvsc_dev_remove(struct hv_device *device);
 
 int stor_vsc_on_io_request(struct hv_device *device,
 				struct hv_storvsc_request *request);
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 5168eb7..903ecbe 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -114,7 +114,7 @@ static int stor_vsc_initialize(struct hv_driver *driver)
 
 	/* Setup the dispatch table */
 	stor_driver->base.dev_add	= storvsc_dev_add;
-	stor_driver->base.dev_rm	= stor_vsc_on_device_remove;
+	stor_driver->base.dev_rm	= storvsc_dev_remove;
 	stor_driver->base.cleanup	= stor_vsc_on_cleanup;
 
 	stor_driver->on_io_request	= stor_vsc_on_io_request;
-- 
1.7.4.1
