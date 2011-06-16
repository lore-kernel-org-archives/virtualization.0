From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 75/77] Staging: hv: mouse: Disable auto-loading of the mouse driver
Date: Thu, 16 Jun 2011 13:17:48 -0700
Message-ID: <1308255470-3826-75-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Disable auto-loading of the mouse driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 1b30f26..ab5f1da 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -950,7 +950,7 @@ static void __exit mousevsc_exit(void)
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
-MODULE_ALIAS("vmbus:hv_mouse");
+/*MODULE_ALIAS("vmbus:hv_mouse");*/
 module_init(mousevsc_init);
 module_exit(mousevsc_exit);
 
-- 
1.7.4.1
