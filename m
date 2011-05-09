From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 127/206] Staging: hv: Inline the copying of dev_type guid
Date: Mon,  9 May 2011 14:56:49 -0700
Message-ID: <1304978288-22999-127-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preperation to eliminating blk_vsc_initialize(), move the copying of
dev_type field.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 1e6ef6f..7e25707 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -174,8 +174,6 @@ static int blk_vsc_initialize(struct hv_driver *driver)
 
 	stor_driver = hvdr_to_stordr(driver);
 
-	memcpy(&driver->dev_type, &dev_type, sizeof(struct hv_guid));
-
 	return ret;
 }
 
@@ -841,6 +839,7 @@ static int blkvsc_drv_init(void)
 	/* Callback to client driver to complete the initialization */
 	blk_vsc_initialize(&storvsc_drv->base);
 
+	memcpy(&drv->dev_type, &dev_type, sizeof(struct hv_guid));
 	drv->name = drv_name;
 	drv->driver.name = drv_name;
 
-- 
1.7.4.1
