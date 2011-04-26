From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 10/25] Staging: hv: Get rid of the priv pointer in struct hv_driver
Date: Tue, 26 Apr 2011 09:20:27 -0700
Message-ID: <1303834842-5022-10-git-send-email-kys@microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303834842-5022-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that we have gotten rid of all uses of the priv element in
struct hv_driver, get rid of the priv pointer.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_api.h |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/vmbus_api.h b/drivers/staging/hv/vmbus_api.h
index f0d96eb..51fa952 100644
--- a/drivers/staging/hv/vmbus_api.h
+++ b/drivers/staging/hv/vmbus_api.h
@@ -94,16 +94,6 @@ struct hv_driver {
 	/* the device type supported by this driver */
 	struct hv_guid dev_type;
 
-	/*
-	 * Device type specific drivers (net, blk etc.)
-	 * need a mechanism to get a pointer to
-	 * device type specific driver structure given
-	 * a pointer to the base hyperv driver structure.
-	 * The current code solves this problem using
-	 * a hack. Support this need explicitly
-	 */
-	void *priv;
-
 	struct device_driver driver;
 
 	int (*dev_add)(struct hv_device *device, void *data);
-- 
1.7.4.1
