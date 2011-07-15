From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 111/117] Staging: hv: vmbus: Change the signature of
	vmbus_child_driver_unregister()
Date: Fri, 15 Jul 2011 10:47:39 -0700
Message-ID: <1310752065-27895-111-git-send-email-kys@microsoft.com>
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

Change the signature of vmbus_child_driver_unregister() to conform to the
Linux driver model.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c    |    2 +-
 drivers/staging/hv/hv_util.c     |    2 +-
 drivers/staging/hv/hyperv.h      |    2 +-
 drivers/staging/hv/netvsc_drv.c  |    2 +-
 drivers/staging/hv/storvsc_drv.c |    2 +-
 drivers/staging/hv/vmbus_drv.c   |    7 ++++---
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 0dfaa6a..28bd2c5 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -936,7 +936,7 @@ static struct  hv_driver mousevsc_drv = {
 
 static void mousevsc_drv_exit(void)
 {
-	vmbus_child_driver_unregister(&mousevsc_drv.driver);
+	vmbus_child_driver_unregister(&mousevsc_drv);
 }
 
 static int __init mousevsc_init(void)
diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index a4320dc..4712d22 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -332,7 +332,7 @@ static void exit_hyperv_utils(void)
 	kfree(shut_txf_buf);
 	kfree(time_txf_buf);
 	kfree(hbeat_txf_buf);
-	vmbus_child_driver_unregister(&util_drv.driver);
+	vmbus_child_driver_unregister(&util_drv);
 }
 
 module_init(init_hyperv_utils);
diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index a760e89..9b9ff71 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -847,7 +847,7 @@ static inline struct hv_driver *drv_to_hv_drv(struct device_driver *d)
 
 /* Vmbus interface */
 int vmbus_child_driver_register(struct hv_driver *hv_drv);
-void vmbus_child_driver_unregister(struct device_driver *drv);
+void vmbus_child_driver_unregister(struct hv_driver *hv_drv);
 
 /*
  * Common header for Hyper-V ICs
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index a204ea7..474c5f0 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -438,7 +438,7 @@ static struct  hv_driver netvsc_drv = {
 
 static void __exit netvsc_drv_exit(void)
 {
-	vmbus_child_driver_unregister(&netvsc_drv.driver);
+	vmbus_child_driver_unregister(&netvsc_drv);
 }
 
 
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 149ef00..6fbe146 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -1559,7 +1559,7 @@ static int __init storvsc_drv_init(void)
 
 static void __exit storvsc_drv_exit(void)
 {
-	vmbus_child_driver_unregister(&storvsc_drv.driver);
+	vmbus_child_driver_unregister(&storvsc_drv);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index bd5a5a7..f271e8d 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -553,11 +553,12 @@ EXPORT_SYMBOL(vmbus_child_driver_register);
  *
  * Mainly used by Hyper-V drivers.
  */
-void vmbus_child_driver_unregister(struct device_driver *drv)
+void vmbus_child_driver_unregister(struct hv_driver *hv_drv)
 {
-	pr_info("child driver unregistering - name %s\n", drv->name);
+	pr_info("child driver unregistering - name %s\n",
+		 hv_drv->driver.name);
 
-	driver_unregister(drv);
+	driver_unregister(&hv_drv->driver);
 
 }
 EXPORT_SYMBOL(vmbus_child_driver_unregister);
-- 
1.7.4.1
