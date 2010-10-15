From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
Subject: [PATCH 3/5] staging: hv: Convert camel cased parameter in channel_interface.h to lower case
Date: Fri, 15 Oct 2010 10:14:05 -0700
Message-ID: <1287162847-27536-3-git-send-email-haiyangz@linuxonhyperv.com>
References: <1287162847-27536-1-git-send-email-haiyangz@linuxonhyperv.com>
 <1287162847-27536-2-git-send-email-haiyangz@linuxonhyperv.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1287162847-27536-2-git-send-email-haiyangz@linuxonhyperv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

From: Haiyang Zhang <haiyangz@microsoft.com>

Convert camel cased parameter in channel_interface.h to lower case

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/channel_interface.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/channel_interface.h b/drivers/staging/hv/channel_interface.h
index 1007612..82cff3d 100644
--- a/drivers/staging/hv/channel_interface.h
+++ b/drivers/staging/hv/channel_interface.h
@@ -27,7 +27,7 @@
 
 #include "vmbus_api.h"
 
-void get_channel_info(struct hv_device *Device,
-		    struct hv_device_info *DeviceInfo);
+void get_channel_info(struct hv_device *device,
+		    struct hv_device_info *info);
 
 #endif /* _CHANNEL_INTERFACE_H_ */
-- 
1.6.3.2
