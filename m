From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/4] Staging: hv: util: Deal with driver register failures
Date: Wed, 31 Aug 2011 14:35:54 -0700
Message-ID: <1314826557-28755-1-git-send-email-kys@microsoft.com>
References: <1314826529-28716-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314826529-28716-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Properly deal with vmbus_driver_register() failures.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_util.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index e29a2a2..6039217 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -277,6 +277,7 @@ static  struct hv_driver util_drv = {
 
 static int __init init_hyperv_utils(void)
 {
+	int ret;
 	pr_info("Registering HyperV Utility Driver\n");
 
 	if (hv_kvp_init())
@@ -289,12 +290,15 @@ static int __init init_hyperv_utils(void)
 
 	if (!shut_txf_buf || !time_txf_buf || !hbeat_txf_buf) {
 		pr_info("Unable to allocate memory for receive buffer\n");
-		kfree(shut_txf_buf);
-		kfree(time_txf_buf);
-		kfree(hbeat_txf_buf);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err;
 	}
 
+	ret = vmbus_driver_register(&util_drv);
+
+	if (ret != 0)
+		goto err;
+
 	hv_cb_utils[HV_SHUTDOWN_MSG].callback = &shutdown_onchannelcallback;
 
 	hv_cb_utils[HV_TIMESYNC_MSG].callback = &timesync_onchannelcallback;
@@ -303,7 +307,14 @@ static int __init init_hyperv_utils(void)
 
 	hv_cb_utils[HV_KVP_MSG].callback = &hv_kvp_onchannelcallback;
 
-	return vmbus_driver_register(&util_drv);
+	return 0;
+
+err:
+	kfree(shut_txf_buf);
+	kfree(time_txf_buf);
+	kfree(hbeat_txf_buf);
+
+	return ret;
 }
 
 static void exit_hyperv_utils(void)
-- 
1.7.4.1
