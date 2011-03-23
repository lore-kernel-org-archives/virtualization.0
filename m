From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/16] Staging: hv: Cleanup the initialization of storvsc
	driver
Date: Wed, 23 Mar 2011 10:50:27 -0700
Message-ID: <1300902635-1347-9-git-send-email-kys@microsoft.com>
References: <1300902537-1290-1-git-send-email-kys@microsoft.com>
	<1300902635-1347-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1300902635-1347-1-git-send-email-kys@microsoft.com>
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

Cleanup the initialization sequence for the storvsc driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index af6a37d..2c51a07 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -191,7 +191,7 @@ static struct scsi_host_template scsi_driver = {
 /*
  * storvsc_drv_init - StorVsc driver initialization.
  */
-static int storvsc_drv_init(int (*drv_init)(struct hv_driver *drv))
+static int storvsc_drv_init(void)
 {
 	int ret;
 	struct storvsc_driver_object *storvsc_drv_obj = &g_storvsc_drv;
@@ -200,7 +200,7 @@ static int storvsc_drv_init(int (*drv_init)(struct hv_driver *drv))
 	storvsc_drv_obj->ring_buffer_size = storvsc_ringbuffer_size;
 
 	/* Callback to client driver to complete the initialization */
-	drv_init(&storvsc_drv_obj->base);
+	stor_vsc_initialize(&storvsc_drv_obj->base);
 
 	drv->priv = storvsc_drv_obj;
 
@@ -986,7 +986,7 @@ static int __init storvsc_init(void)
 	int ret;
 
 	DPRINT_INFO(STORVSC_DRV, "Storvsc initializing....");
-	ret = storvsc_drv_init(stor_vsc_initialize);
+	ret = storvsc_drv_init();
 	return ret;
 }
 
-- 
1.7.4.1
