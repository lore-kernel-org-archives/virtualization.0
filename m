From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 139/206] Staging: hv: Move the assignment of name to the hv_driver
Date: Mon,  9 May 2011 14:57:01 -0700
Message-ID: <1304978288-22999-139-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preperation to eliminate the function storvsc_initialize()
move the name assignment.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index e342bcc..9447130 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -86,7 +86,6 @@ static int storvsc_initialize(struct hv_driver *driver)
 
 	/* Make sure we are at least 2 pages since 1 page is used for control */
 
-	driver->name = driver_name;
 	memcpy(&driver->dev_type, &gStorVscDeviceType,
 	       sizeof(struct hv_guid));
 
@@ -806,6 +805,7 @@ static int storvsc_drv_init(void)
 	    STORVSC_MAX_IO_REQUESTS)
 		return -1;
 
+	drv->name = driver_name;
 	drv->driver.name = driver_name;
 
 
-- 
1.7.4.1
