From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 144/206] Staging: hv: Make blkvsc_drv an instance of struct hv_driver
Date: Mon,  9 May 2011 14:57:06 -0700
Message-ID: <1304978288-22999-144-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Make blkvsc_drv an instance of struct hv_driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index c04aaa3..10da9bb 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -801,10 +801,10 @@ static void blkvsc_request(struct request_queue *queue)
 
 
 /* The one and only one */
-static  struct storvsc_driver blkvsc_drv = {
-	.base.probe =  blkvsc_probe,
-	.base.remove =  blkvsc_remove,
-	.base.shutdown = blkvsc_shutdown,
+static  struct hv_driver blkvsc_drv = {
+	.probe =  blkvsc_probe,
+	.remove =  blkvsc_remove,
+	.shutdown = blkvsc_shutdown,
 };
 
 static const struct block_device_operations block_ops = {
@@ -820,7 +820,7 @@ static const struct block_device_operations block_ops = {
  */
 static int blkvsc_drv_init(void)
 {
-	struct hv_driver *drv = &blkvsc_drv.base;
+	struct hv_driver *drv = &blkvsc_drv;
 	int ret;
 
 	BUILD_BUG_ON(sizeof(sector_t) != 8);
@@ -844,7 +844,7 @@ static int blkvsc_drv_exit_cb(struct device *dev, void *data)
 
 static void blkvsc_drv_exit(void)
 {
-	struct hv_driver *drv = &blkvsc_drv.base;
+	struct hv_driver *drv = &blkvsc_drv;
 	struct device *current_dev;
 	int ret;
 
-- 
1.7.4.1
