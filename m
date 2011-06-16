From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 21/77] Staging: hv: vmbus: Get rid of an unnecessary include line in vmbus_drv.c
Date: Thu, 16 Jun 2011 13:16:54 -0700
Message-ID: <1308255470-3826-21-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of an unnecessary include line in vmbus_drv.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index af657a9..cbb80ec 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -28,7 +28,6 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/sysctl.h>
-#include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
-- 
1.7.4.1
