From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 10/25] Staging: hv: vmbus: Return proper error code in vmbus_remove()
Date: Thu,  8 Sep 2011 07:24:21 -0700
Message-ID: <1315491876-9554-10-git-send-email-kys@microsoft.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
 <1315491876-9554-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315491876-9554-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Return proper error code in vmbus_remove().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index b9aeb76..95d33a4 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -325,7 +325,7 @@ static int vmbus_probe(struct device *child_device)
  */
 static int vmbus_remove(struct device *child_device)
 {
-	int ret;
+	int ret = 0;
 	struct hv_driver *drv;
 
 	struct hv_device *dev = device_to_hv_device(child_device);
@@ -349,7 +349,7 @@ static int vmbus_remove(struct device *child_device)
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 
-- 
1.7.4.1
