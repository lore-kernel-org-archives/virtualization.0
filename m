From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 162/206] Staging: hv: Cleanup the newly created header file
Date: Mon,  9 May 2011 14:57:24 -0700
Message-ID: <1304978288-22999-162-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 include/linux/hyperv.h |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2751b10..f91e3a4 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -31,6 +31,7 @@
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/scatterlist.h>
+#include <linux/device.h>
 
 #define MAX_PAGE_BUFFER_COUNT				16
 #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
@@ -757,8 +758,6 @@ extern unsigned int vmbus_loglevel;
 #define HV_DRV_VERSION           "3.1"
 
 
-#include <linux/device.h>
-#include <linux/workqueue.h>
 
 
 struct hv_driver;
@@ -821,11 +820,6 @@ struct hv_device {
 	void *ext;
 };
 
-#include <linux/device.h>
-
-
-
-
 static inline struct hv_device *device_to_hv_device(struct device *d)
 {
 	return container_of(d, struct hv_device, device);
-- 
1.7.4.1
