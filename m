From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 148/206] Staging: hv: Move the code to copy dev_type information
Date: Mon,  9 May 2011 14:57:10 -0700
Message-ID: <1304978288-22999-148-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation to eliminate mouse_vsc_initialize,
move the code that copies the dev_type info.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index b4c087f..85b95d8 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -979,8 +979,6 @@ static void mousevsc_drv_exit(void)
 
 static int mouse_vsc_initialize(struct hv_driver *driver)
 {
-	memcpy(&driver->dev_type, &mouse_guid,
-	       sizeof(struct hv_guid));
 
 	return 0;
 }
@@ -995,6 +993,8 @@ static int __init mousevsc_init(void)
 
 	/* Callback to client driver to complete the initialization */
 	mouse_vsc_initialize(&input_drv_obj->base);
+	memcpy(&drv->dev_type, &mouse_guid,
+	       sizeof(struct hv_guid));
 
 	drv->driver.name = driver_name;
 	drv->name = driver_name;
-- 
1.7.4.1
