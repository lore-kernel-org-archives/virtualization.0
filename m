From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Drivers:hv: Fix a bug in vmbus_driver_unregister()
Date: Tue, 27 Dec 2011 13:49:37 -0800
Message-ID: <1325022577-23081-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Fuzhou Chen <fuzhouch@microsoft.com>, Sasha Levin <levinsasha928@gmail.com>, stable <stable@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The function vmbus_exists() was introduced recently to deal with cases where
the vmbus driver failed to initialize and yet other Hyper-V drivers attempted
to register with the vmbus bus driver. This patch introduced a bug where
vmbus_driver_unregister() would fail to unregister the driver. This patch 
fixes the problem.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Fuzhou Chen <fuzhouch@microsoft.com>
Cc: Sasha Levin <levinsasha928@gmail.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/hv/vmbus_drv.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index c3875f7..a220e57 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -627,10 +627,7 @@ void vmbus_driver_unregister(struct hv_driver *hv_driver)
 	pr_info("unregistering driver %s\n", hv_driver->name);
 
 	if (!vmbus_exists())
-		return;
-
-	driver_unregister(&hv_driver->driver);
-
+		driver_unregister(&hv_driver->driver);
 }
 EXPORT_SYMBOL_GPL(vmbus_driver_unregister);
 
-- 
1.7.4.1
