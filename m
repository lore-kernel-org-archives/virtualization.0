From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 004/206] Staging: hv: Rename driver name variable
Date: Mon,  9 May 2011 14:54:46 -0700
Message-ID: <1304978288-22999-4-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Rename the variable g_blk_driver_name.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 8a577bc..b54130b 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -112,7 +112,7 @@ struct block_device_context {
 	int users;
 };
 
-static const char *g_blk_driver_name = "blkvsc";
+static const char *drv_name = "blkvsc";
 
 /* {32412632-86cb-44a2-9b5c-50d1417354f5} */
 static const struct hv_guid g_blk_device_type = {
@@ -177,7 +177,7 @@ static int blk_vsc_initialize(struct hv_driver *driver)
 
 	/* Make sure we are at least 2 pages since 1 page is used for control */
 
-	driver->name = g_blk_driver_name;
+	driver->name = drv_name;
 	memcpy(&driver->dev_type, &g_blk_device_type, sizeof(struct hv_guid));
 
 
-- 
1.7.4.1
