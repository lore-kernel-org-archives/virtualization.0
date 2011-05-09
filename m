From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 161/206] Staging: hv: Include the contents of vmbus.h
Date: Mon,  9 May 2011 14:57:23 -0700
Message-ID: <1304978288-22999-161-git-send-email-kys@microsoft.com>
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
 include/linux/hyperv.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3707fcb..2751b10 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -821,4 +821,26 @@ struct hv_device {
 	void *ext;
 };
 
+#include <linux/device.h>
+
+
+
+
+static inline struct hv_device *device_to_hv_device(struct device *d)
+{
+	return container_of(d, struct hv_device, device);
+}
+
+static inline struct hv_driver *drv_to_hv_drv(struct device_driver *d)
+{
+	return container_of(d, struct hv_driver, driver);
+}
+
+
+int vmbus_child_driver_register(struct device_driver *drv);
+void vmbus_child_driver_unregister(struct device_driver *drv);
+
+extern struct completion hv_channel_ready;
+
+
 #endif /* _HYPERV_H_ */
-- 
1.7.4.1
