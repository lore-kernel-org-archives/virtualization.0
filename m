From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 091/206] Staging: hv: Statically initialize probe/remove
Date: Mon,  9 May 2011 14:56:13 -0700
Message-ID: <1304978288-22999-91-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/netvsc_drv.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 566865f..c5e7b93 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -440,7 +440,10 @@ static int netvsc_drv_exit_cb(struct device *dev, void *data)
 }
 
 /* The one and only one */
-static struct  netvsc_driver netvsc_drv;
+static struct  netvsc_driver netvsc_drv = {
+	.base.probe = netvsc_probe,
+	.base.remove = netvsc_remove,
+};
 
 static void netvsc_drv_exit(void)
 {
@@ -485,9 +488,6 @@ static int netvsc_drv_init(int (*drv_init)(struct hv_driver *drv))
 
 	drv->driver.name = net_drv_obj->base.name;
 
-	drv->probe = netvsc_probe;
-	drv->remove = netvsc_remove;
-
 	/* The driver belongs to vmbus */
 	ret = vmbus_child_driver_register(&drv->driver);
 
-- 
1.7.4.1
