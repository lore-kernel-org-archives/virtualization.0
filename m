From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 23/24] Staging: hv: mousevsc: Enable autoloading of the mouse driver
Date: Thu, 29 Sep 2011 11:55:03 -0700
Message-ID: <1317322504-9788-23-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
 <1317322504-9788-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317322504-9788-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that the mouse driver is functional, enable the auto-loading of the driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 98ae062..71b460b 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -596,10 +596,7 @@ static const struct hv_vmbus_device_id id_table[] = {
 	{ },
 };
 
-/*
- * The mouse driver is not functional; do not auto-load it.
- */
-/* MODULE_DEVICE_TABLE(vmbus, id_table); */
+MODULE_DEVICE_TABLE(vmbus, id_table);
 
 static struct  hv_driver mousevsc_drv = {
 	.name = "mousevsc",
-- 
1.7.4.1
