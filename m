From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 30/77] Staging: hv: netvsc: Get rid of the dev_type guid from netvsc.c
Date: Thu, 16 Jun 2011 13:17:03 -0700
Message-ID: <1308255470-3826-30-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the dev_type guid from netvsc.c, as it is no longer used.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 1bd920f..d59b9bd 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -35,15 +35,6 @@
 /* Globals */
 static const char *driver_name = "netvsc";
 
-/* {F8615163-DF3E-46c5-913F-F2D2F965ED0E} */
-static const struct hv_guid netvsc_device_type = {
-	.data = {
-		0x63, 0x51, 0x61, 0xF8, 0x3E, 0xDF, 0xc5, 0x46,
-		0x91, 0x3F, 0xF2, 0xD2, 0xF9, 0x65, 0xED, 0x0E
-	}
-};
-
-
 static struct netvsc_device *alloc_net_device(struct hv_device *device)
 {
 	struct netvsc_device *net_device;
@@ -1009,7 +1000,6 @@ int netvsc_initialize(struct hv_driver *drv)
 {
 
 	drv->name = driver_name;
-	memcpy(&drv->dev_type, &netvsc_device_type, sizeof(struct hv_guid));
 
 	return 0;
 }
-- 
1.7.4.1
