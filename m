From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 093/206] Staging: hv: Move the declaration of the variable mousevsc_drv
Date: Mon,  9 May 2011 14:56:15 -0700
Message-ID: <1304978288-22999-93-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Move the declaration of the variable mousevsc_drv.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index cc3c1d4..c5e50b4 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -794,8 +794,6 @@ struct input_device_context {
 };
 
 
-static struct  mousevsc_drv_obj mousevsc_drv;
-
 static void deviceinfo_callback(struct hv_device *dev, struct hv_input_dev_info *info)
 {
 	struct input_device_context *input_device_ctx =
@@ -945,6 +943,8 @@ static int mousevsc_drv_exit_cb(struct device *dev, void *data)
 	return 1;
 }
 
+static struct  mousevsc_drv_obj mousevsc_drv;
+
 static void mousevsc_drv_exit(void)
 {
 	struct hv_driver *drv = &mousevsc_drv.base;
-- 
1.7.4.1
