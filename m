From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 10/24] Staging: hv: mousevsc: Cleanup error handling
Date: Thu, 29 Sep 2011 11:54:50 -0700
Message-ID: <1317322504-9788-10-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
	<1317322504-9788-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1317322504-9788-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup error handling in this driver; use standard Linux error codes.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   23 +++++++----------------
 1 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 8dd902a..fc1f3e6 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -569,7 +569,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 
 	if (!input_dev) {
 		pr_err("unable to get input device...device being destroyed?");
-		return -1;
+		return -ENODEV;
 	}
 
 
@@ -612,7 +612,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	if (!response->response.approved) {
 		pr_err("synthhid protocol request failed (version %d)",
 		       SYNTHHID_INPUT_VERSION);
-		ret = -1;
+		ret = -ENODEV;
 		goto cleanup;
 	}
 
@@ -629,7 +629,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	if (!input_dev->dev_info_status)
 		pr_info("**** input channel up and running!! ****");
 	else
-		ret = -1;
+		ret = -ENOMEM;
 
 cleanup:
 	put_input_device(device);
@@ -694,10 +694,8 @@ static int mousevsc_on_device_add(struct hv_device *device,
 
 	input_dev = alloc_input_device(device);
 
-	if (!input_dev) {
-		ret = -1;
-		goto cleanup;
-	}
+	if (!input_dev)
+		return -ENOMEM;
 
 	input_dev->init_complete = false;
 
@@ -714,7 +712,7 @@ static int mousevsc_on_device_add(struct hv_device *device,
 	if (ret != 0) {
 		pr_err("unable to open channel: %d", ret);
 		free_input_device(input_dev);
-		return -1;
+		return ret;
 	}
 
 	pr_info("InputVsc channel open: %d", ret);
@@ -743,7 +741,6 @@ static int mousevsc_on_device_add(struct hv_device *device,
 
 	input_dev->init_complete = true;
 
-cleanup:
 	return ret;
 }
 
@@ -789,16 +786,10 @@ static int mousevsc_on_device_remove(struct hv_device *device)
 static int mousevsc_probe(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
-	int ret = 0;
-
 
 	/* Call to the vsc driver to add the device */
-	ret = mousevsc_on_device_add(dev, NULL);
+	return mousevsc_on_device_add(dev, NULL);
 
-	if (ret != 0)
-		return -1;
-
-	return 0;
 }
 
 static int mousevsc_remove(struct hv_device *dev)
-- 
1.7.4.1
