From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 17/24] Staging: hv: mousevsc: Get rid of
	mousevsc_on_device_remove() by inlining code
Date: Thu, 29 Sep 2011 11:54:57 -0700
Message-ID: <1317322504-9788-17-git-send-email-kys@microsoft.com>
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

Get rid of mousevsc_on_device_remove() by inlining code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   47 ++++++++++++++--------------------------
 1 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 75ea2db..5324429 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -660,33 +660,6 @@ static int mousevsc_on_device_add(struct hv_device *device,
 	return ret;
 }
 
-static int mousevsc_on_device_remove(struct hv_device *device)
-{
-	struct mousevsc_dev *input_dev;
-	int ret = 0;
-
-
-	input_dev = release_input_device(device);
-
-
-	/*
-	 * At this point, all outbound traffic should be disable. We only
-	 * allow inbound traffic (responses) to proceed
-	 *
-	 * so that outstanding requests can be completed.
-	 */
-
-	input_dev = final_release_input_device(device);
-
-	/* Close the channel */
-	vmbus_close(device->channel);
-
-	free_input_device(input_dev);
-
-	return ret;
-}
-
-
 static int mousevsc_probe(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -706,11 +679,25 @@ static int mousevsc_remove(struct hv_device *dev)
 		hid_destroy_device(input_dev->hid_device);
 	}
 
+
+	release_input_device(dev);
+
+
 	/*
-	 * Call to the vsc driver to let it know that the device
-	 * is being removed
+	 * At this point, all outbound traffic should be disable. We only
+	 * allow inbound traffic (responses) to proceed
+	 *
+	 * so that outstanding requests can be completed.
 	 */
-	return mousevsc_on_device_remove(dev);
+
+	input_dev = final_release_input_device(dev);
+
+	/* Close the channel */
+	vmbus_close(dev->channel);
+
+	free_input_device(input_dev);
+
+	return 0;
 }
 
 static const struct hv_vmbus_device_id id_table[] = {
-- 
1.7.4.1
