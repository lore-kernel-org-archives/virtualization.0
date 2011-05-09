From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 122/206] Staging: hv: Get rid of unnecessary state from struct storvsc_driver
Date: Mon,  9 May 2011 14:56:44 -0700
Message-ID: <1304978288-22999-122-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

This is unused state; get rid of it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_api.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 1887940..055902b 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -83,9 +83,6 @@ struct storvsc_driver {
 	/* Maximum # of requests in flight per channel/device */
 	u32 max_outstanding_req_per_channel;
 
-	/* Specific to this driver */
-	int (*on_io_request)(struct hv_device *device,
-			   struct hv_storvsc_request *request);
 };
 
 struct storvsc_device_info {
-- 
1.7.4.1
