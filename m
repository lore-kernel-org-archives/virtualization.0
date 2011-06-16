From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 28/77] Staging: hv: blkvsc: Get rid of the dev_type guid from blkvsc_drv.c
Date: Thu, 16 Jun 2011 13:17:01 -0700
Message-ID: <1308255470-3826-28-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the dev_type guid from blkvsc_drv.c as it is no longer used.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 9496abe..1abe7f4 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -111,13 +111,6 @@ struct block_device_context {
 
 static const char *drv_name = "blkvsc";
 
-/* {32412632-86cb-44a2-9b5c-50d1417354f5} */
-static const struct hv_guid dev_type = {
-	.data = {
-		0x32, 0x26, 0x41, 0x32, 0xcb, 0x86, 0xa2, 0x44,
-		0x9b, 0x5c, 0x50, 0xd1, 0x41, 0x73, 0x54, 0xf5
-	}
-};
 
 /*
  * There is a circular dependency involving blkvsc_request_completion()
@@ -834,7 +827,6 @@ static int blkvsc_drv_init(void)
 
 	BUILD_BUG_ON(sizeof(sector_t) != 8);
 
-	memcpy(&drv->dev_type, &dev_type, sizeof(struct hv_guid));
 	drv->driver.name = drv_name;
 
 	/* The driver belongs to vmbus */
-- 
1.7.4.1
