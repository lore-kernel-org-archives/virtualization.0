From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 071/117] Staging: hv: mouse: Change the jump label Cleanup to
	cleanup
Date: Fri, 15 Jul 2011 10:46:59 -0700
Message-ID: <1310752065-27895-71-git-send-email-kys@microsoft.com>
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

Change the jump label "Cleanup" to "cleanup".

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 30aa709..1c17658 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -339,7 +339,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	if (!input_device->hid_desc) {
 		pr_err("unable to allocate hid descriptor - size %d", desc->bLength);
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	memcpy(input_device->hid_desc, desc, desc->bLength);
@@ -352,7 +352,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	if (!input_device->report_desc) {
 		pr_err("unable to allocate report descriptor - size %d",
 			   input_device->report_desc_size);
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	memcpy(input_device->report_desc,
@@ -379,7 +379,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	if (ret != 0) {
 		pr_err("unable to send synthhid device info ack - ret %d",
 			   ret);
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	input_device->device_wait_condition = 1;
@@ -387,7 +387,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	return;
 
-Cleanup:
+cleanup:
 	kfree(input_device->hid_desc);
 	input_device->hid_desc = NULL;
 
@@ -606,7 +606,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 					VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret != 0) {
 		pr_err("unable to send synthhid protocol request.");
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	input_dev->protocol_wait_condition = 0;
@@ -614,7 +614,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 		input_dev->protocol_wait_condition, msecs_to_jiffies(1000));
 	if (input_dev->protocol_wait_condition == 0) {
 		ret = -ETIMEDOUT;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	response = &input_dev->protocol_resp;
@@ -623,7 +623,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 		pr_err("synthhid protocol request failed (version %d)",
 		       SYNTHHID_INPUT_VERSION);
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	input_dev->device_wait_condition = 0;
@@ -631,7 +631,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 		input_dev->device_wait_condition, msecs_to_jiffies(1000));
 	if (input_dev->device_wait_condition == 0) {
 		ret = -ETIMEDOUT;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	/*
@@ -643,7 +643,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	else
 		ret = -1;
 
-Cleanup:
+cleanup:
 	put_input_device(device);
 
 	return ret;
@@ -661,7 +661,7 @@ static int mousevsc_on_device_add(struct hv_device *device,
 
 	if (!input_dev) {
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	input_dev->init_complete = false;
@@ -714,7 +714,7 @@ static int mousevsc_on_device_add(struct hv_device *device,
 
 	input_dev->init_complete = true;
 
-Cleanup:
+cleanup:
 	return ret;
 }
 
-- 
1.7.4.1
