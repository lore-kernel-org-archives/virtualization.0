From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 128/206] Staging: hv: Now get rid of the empty function
Date: Mon,  9 May 2011 14:56:50 -0700
Message-ID: <1304978288-22999-128-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, get rid of the empty function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 7e25707..f8a3bce 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -166,18 +166,6 @@ static int blkvsc_device_add(struct hv_device *device,
 	return ret;
 }
 
-
-static int blk_vsc_initialize(struct hv_driver *driver)
-{
-	struct storvsc_driver *stor_driver;
-	int ret = 0;
-
-	stor_driver = hvdr_to_stordr(driver);
-
-	return ret;
-}
-
-
 static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 			void (*request_completion)(struct hv_storvsc_request *))
 {
@@ -836,9 +824,6 @@ static int blkvsc_drv_init(void)
 
 	storvsc_drv->ring_buffer_size = blkvsc_ringbuffer_size;
 
-	/* Callback to client driver to complete the initialization */
-	blk_vsc_initialize(&storvsc_drv->base);
-
 	memcpy(&drv->dev_type, &dev_type, sizeof(struct hv_guid));
 	drv->name = drv_name;
 	drv->driver.name = drv_name;
-- 
1.7.4.1
