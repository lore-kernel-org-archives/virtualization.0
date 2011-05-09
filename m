From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 018/206] Staging: hv: Statically initialize pointers for probe
	etc
Date: Mon,  9 May 2011 14:55:00 -0700
Message-ID: <1304978288-22999-18-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/blkvsc_drv.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 9de7df7a..bca36b5 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -841,7 +841,11 @@ static void blkvsc_request(struct request_queue *queue)
 
 
 /* The one and only one */
-static  struct storvsc_driver blkvsc_drv;
+static  struct storvsc_driver blkvsc_drv = {
+	.base.probe =  blkvsc_probe,
+	.base.remove =  blkvsc_remove,
+	.base.shutdown = blkvsc_shutdown,
+};
 
 static const struct block_device_operations block_ops = {
 	.owner = THIS_MODULE,
@@ -867,10 +871,6 @@ static int blkvsc_drv_init(void)
 
 	drv->driver.name = storvsc_drv->base.name;
 
-	drv->probe = blkvsc_probe;
-	drv->remove = blkvsc_remove;
-	drv->shutdown = blkvsc_shutdown;
-
 	/* The driver belongs to vmbus */
 	ret = vmbus_child_driver_register(&drv->driver);
 
-- 
1.7.4.1
