From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 024/117] Staging: hv: netvsc: Get rid of the DMI signature in
	netvsc_drv.c
Date: Fri, 15 Jul 2011 10:46:12 -0700
Message-ID: <1310752065-27895-24-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that we have implemented a vmbus specific mechanism for auto-loading,
get rid of the DMI signature.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 9352277..43be9db 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -33,7 +33,6 @@
 #include <linux/skbuff.h>
 #include <linux/in.h>
 #include <linux/slab.h>
-#include <linux/dmi.h>
 #include <net/arp.h>
 #include <net/route.h>
 #include <net/sock.h>
@@ -443,20 +442,6 @@ static void __exit netvsc_drv_exit(void)
 }
 
 
-static const struct dmi_system_id __initconst
-hv_netvsc_dmi_table[] __maybe_unused  = {
-	{
-		.ident = "Hyper-V",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
-			DMI_MATCH(DMI_BOARD_NAME, "Virtual Machine"),
-		},
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(dmi, hv_netvsc_dmi_table);
-
 static int __init netvsc_drv_init(void)
 {
 	struct hv_driver *drv = &netvsc_drv;
@@ -464,10 +449,6 @@ static int __init netvsc_drv_init(void)
 
 	pr_info("initializing....");
 
-	if (!dmi_check_system(hv_netvsc_dmi_table))
-		return -ENODEV;
-
-
 	/* Callback to client driver to complete the initialization */
 	netvsc_initialize(drv);
 
-- 
1.7.4.1
