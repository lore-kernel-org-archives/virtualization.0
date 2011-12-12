From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/4] Drivers: hv: Support building the vmbus driver as part of the kernel
Date: Mon, 12 Dec 2011 09:29:19 -0800
Message-ID: <1323710959-29655-4-git-send-email-kys@microsoft.com>
References: <1323710931-29616-1-git-send-email-kys@microsoft.com>
 <1323710959-29655-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323710959-29655-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Support building the vmbus driver as part of the kernel. 

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/hv/vmbus_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index aafee6b..1d3d809 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -793,5 +793,5 @@ static void __exit vmbus_exit(void)
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
 
-module_init(hv_acpi_init);
+subsys_initcall(hv_acpi_init);
 module_exit(vmbus_exit);
-- 
1.7.4.1
