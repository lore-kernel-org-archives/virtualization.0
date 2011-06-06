From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/49] Staging: hv: storvsc: Cleanup the module init function
	in storvsc_drv.c
Date: Mon,  6 Jun 2011 15:49:27 -0700
Message-ID: <1307400613-13234-3-git-send-email-kys@microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
	<1307400613-13234-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1307400613-13234-1-git-send-email-kys@microsoft.com>
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

Get rid of unnecessary layering in the module init path.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index e21f7e6..33bce87 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -756,7 +756,7 @@ static struct hv_driver storvsc_drv = {
 /*
  * storvsc_drv_init - StorVsc driver initialization.
  */
-static int storvsc_drv_init(void)
+static int __init storvsc_drv_init(void)
 {
 	int ret;
 	struct hv_driver *drv = &storvsc_drv;
@@ -797,17 +797,8 @@ static void __exit storvsc_drv_exit(void)
 	vmbus_child_driver_unregister(&storvsc_drv.driver);
 }
 
-static int __init storvsc_init(void)
-{
-	int ret;
-
-	DPRINT_INFO(STORVSC_DRV, "Storvsc initializing....");
-	ret = storvsc_drv_init();
-	return ret;
-}
-
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
 MODULE_DESCRIPTION("Microsoft Hyper-V virtual storage driver");
-module_init(storvsc_init);
+module_init(storvsc_drv_init);
 module_exit(storvsc_drv_exit);
-- 
1.7.4.1
