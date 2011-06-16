From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 31/77] Staging: hv: netvsc: Initialize the driver name directly
Date: Thu, 16 Jun 2011 13:17:04 -0700
Message-ID: <1308255470-3826-31-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Initialize the driver name directly in netvsc_drv.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 9075a73..05d8e32 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -41,6 +41,8 @@
 #include "hyperv.h"
 #include "hyperv_net.h"
 
+static const char *driver_name = "netvsc";
+
 struct net_device_context {
 	/* point back to our device context */
 	struct hv_device *device_ctx;
@@ -439,7 +441,7 @@ static int __init netvsc_drv_init(void)
 	/* Callback to client driver to complete the initialization */
 	netvsc_initialize(drv);
 
-	drv->driver.name = drv->name;
+	drv->driver.name = driver_name;
 
 	/* The driver belongs to vmbus */
 	ret = vmbus_child_driver_register(&drv->driver);
-- 
1.7.4.1
