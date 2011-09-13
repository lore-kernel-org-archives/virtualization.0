From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/20] Staging: hv: vmbus: Cleanup vmbus_remove()
Date: Tue, 13 Sep 2011 10:59:44 -0700
Message-ID: <1315936796-20662-8-git-send-email-kys@microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
	<1315936796-20662-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1315936796-20662-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

vmbus_remove() cannot fail; clean it up accordingly.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 2fccb1f..466425a 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -334,22 +334,14 @@ static int vmbus_probe(struct device *child_device)
  */
 static int vmbus_remove(struct device *child_device)
 {
-	int ret;
-	struct hv_driver *drv;
-
+	struct hv_driver *drv = drv_to_hv_drv(child_device->driver);
 	struct hv_device *dev = device_to_hv_device(child_device);
 
-	if (child_device->driver) {
-		drv = drv_to_hv_drv(child_device->driver);
-
-		if (drv->remove) {
-			ret = drv->remove(dev);
-		} else {
-			pr_err("remove not set for driver %s\n",
-				dev_name(child_device));
-			ret = -ENODEV;
-		}
-	}
+	if (drv->remove)
+		drv->remove(dev);
+	else
+		pr_err("remove not set for driver %s\n",
+			dev_name(child_device));
 
 	return 0;
 }
-- 
1.7.4.1
