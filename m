From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 094/206] Staging: hv: Statically initialize probe/remove
Date: Mon,  9 May 2011 14:56:16 -0700
Message-ID: <1304978288-22999-94-git-send-email-kys@microsoft.com>
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

Statically initialize probe/remove.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index c5e50b4..4475534 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -943,7 +943,10 @@ static int mousevsc_drv_exit_cb(struct device *dev, void *data)
 	return 1;
 }
 
-static struct  mousevsc_drv_obj mousevsc_drv;
+static struct  mousevsc_drv_obj mousevsc_drv = {
+	.base.probe = mousevsc_probe,
+	.base.remove = mousevsc_remove,
+};
 
 static void mousevsc_drv_exit(void)
 {
@@ -996,9 +999,6 @@ static int __init mousevsc_init(void)
 
 	drv->driver.name = input_drv_obj->base.name;
 
-	drv->probe = mousevsc_probe;
-	drv->remove = mousevsc_remove;
-
 	/* The driver belongs to vmbus */
 	vmbus_child_driver_register(&drv->driver);
 
-- 
1.7.4.1
