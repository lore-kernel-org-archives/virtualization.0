From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 092/206] Staging: hv: Rename the variable g_mousevsc_drv
Date: Mon,  9 May 2011 14:56:14 -0700
Message-ID: <1304978288-22999-92-git-send-email-kys@microsoft.com>
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

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index b708663..cc3c1d4 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -794,7 +794,7 @@ struct input_device_context {
 };
 
 
-static struct  mousevsc_drv_obj g_mousevsc_drv;
+static struct  mousevsc_drv_obj mousevsc_drv;
 
 static void deviceinfo_callback(struct hv_device *dev, struct hv_input_dev_info *info)
 {
@@ -947,7 +947,7 @@ static int mousevsc_drv_exit_cb(struct device *dev, void *data)
 
 static void mousevsc_drv_exit(void)
 {
-	struct hv_driver *drv = &g_mousevsc_drv.base;
+	struct hv_driver *drv = &mousevsc_drv.base;
 	int ret;
 
 	struct device *current_dev = NULL;
@@ -986,8 +986,8 @@ static int mouse_vsc_initialize(struct hv_driver *driver)
 
 static int __init mousevsc_init(void)
 {
-	struct mousevsc_drv_obj *input_drv_obj = &g_mousevsc_drv;
-	struct hv_driver *drv = &g_mousevsc_drv.base;
+	struct mousevsc_drv_obj *input_drv_obj = &mousevsc_drv;
+	struct hv_driver *drv = &mousevsc_drv.base;
 
 	DPRINT_INFO(INPUTVSC_DRV, "Hyper-V Mouse driver initializing.");
 
-- 
1.7.4.1
