From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/77] Staging: hv: vmbus: Properly handle the error in hv_acpi_init()
Date: Thu, 16 Jun 2011 13:16:38 -0700
Message-ID: <1308255470-3826-5-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Properly handle the error in hv_acpi_init().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index be158be..1c949f5 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -788,7 +788,10 @@ static int __init hv_acpi_init(void)
 		return -ENODEV;
 	}
 
-	return vmbus_bus_init(irq);
+	ret = vmbus_bus_init(irq);
+	if (ret)
+		acpi_bus_unregister_driver(&vmbus_acpi_driver);
+	return ret;
 }
 
 
-- 
1.7.4.1
