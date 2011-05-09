From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 083/206] Staging: hv: Cleanup mouse_vsc_initialize()
Date: Mon,  9 May 2011 14:56:05 -0700
Message-ID: <1304978288-22999-83-git-send-email-kys@microsoft.com>
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

Now that we have gotten rid of the indirection, cleanup 
mouse_vsc_initialize().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 41bfa3f..523c428 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -980,19 +980,11 @@ static void mousevsc_drv_exit(void)
 
 static int mouse_vsc_initialize(struct hv_driver *driver)
 {
-	struct mousevsc_drv_obj *input_drv =
-		(struct mousevsc_drv_obj *)driver;
-	int ret = 0;
-
 	driver->name = driver_name;
 	memcpy(&driver->dev_type, &mouse_guid,
 	       sizeof(struct hv_guid));
 
-	/* Setup the dispatch table */
-	input_drv->base.dev_add = mousevsc_on_device_add;
-	input_drv->base.dev_rm = mousevsc_on_device_remove;
-
-	return ret;
+	return 0;
 }
 
 
-- 
1.7.4.1
