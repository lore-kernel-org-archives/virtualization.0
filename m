From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 080/206] Staging: hv: Get rid of the indirection to invoke
	mousevsc_on_device_add()
Date: Mon,  9 May 2011 14:56:02 -0700
Message-ID: <1304978288-22999-80-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/hv_mouse.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index d49a51e..43f5158 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -836,9 +836,6 @@ static int mousevsc_probe(struct hv_device *dev)
 {
 	int ret = 0;
 
-	struct mousevsc_drv_obj *mousevsc_drv_obj =
-		drv_to_mousedrv(dev->device.driver);
-
 	struct input_device_context *input_dev_ctx;
 
 	input_dev_ctx = kmalloc(sizeof(struct input_device_context),
@@ -847,7 +844,7 @@ static int mousevsc_probe(struct hv_device *dev)
 	dev_set_drvdata(&dev->device, input_dev_ctx);
 
 	/* Call to the vsc driver to add the device */
-	ret = mousevsc_drv_obj->base.dev_add(dev, NULL);
+	ret = mousevsc_on_device_add(dev, NULL);
 
 	if (ret != 0) {
 		DPRINT_ERR(INPUTVSC_DRV, "unable to add input vsc device");
-- 
1.7.4.1
