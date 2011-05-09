From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 077/206] Staging: hv: Get rid of call to cleanup()
Date: Mon,  9 May 2011 14:55:59 -0700
Message-ID: <1304978288-22999-77-git-send-email-kys@microsoft.com>
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

cleanup() is an empty function; get rid of it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 3fc39cd..0e81a93 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -444,7 +444,6 @@ static int netvsc_drv_exit_cb(struct device *dev, void *data)
 
 static void netvsc_drv_exit(void)
 {
-	struct netvsc_driver *netvsc_drv_obj = &g_netvsc_drv;
 	struct hv_driver *drv = &g_netvsc_drv.base;
 	struct device *current_dev;
 	int ret;
@@ -466,9 +465,6 @@ static void netvsc_drv_exit(void)
 		device_unregister(current_dev);
 	}
 
-	if (netvsc_drv_obj->base.cleanup)
-		netvsc_drv_obj->base.cleanup(&netvsc_drv_obj->base);
-
 	vmbus_child_driver_unregister(&drv->driver);
 
 	return;
-- 
1.7.4.1
