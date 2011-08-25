From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 56/59] Staging: hv: mouse: Change the jump label Cleanup to cleanup
Date: Thu, 25 Aug 2011 09:49:22 -0700
Message-ID: <1314290965-2698-56-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Change the jump label "Cleanup" to "cleanup".

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 2e04948..cbb837b 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -338,7 +338,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	if (!input_device->hid_desc) {
 		pr_err("unable to allocate hid descriptor - size %d", desc->bLength);
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	memcpy(input_device->hid_desc, desc, desc->bLength);
@@ -351,7 +351,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	if (!input_device->report_desc) {
 		pr_err("unable to allocate report descriptor - size %d",
 			   input_device->report_desc_size);
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	memcpy(input_device->report_desc,
@@ -378,7 +378,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	if (ret != 0) {
 		pr_err("unable to send synthhid device info ack - ret %d",
 			   ret);
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	input_device->device_wait_condition = 1;
@@ -386,7 +386,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	return;
 
-Cleanup:
+cleanup:
 	kfree(input_device->hid_desc);
 	input_device->hid_desc = NULL;
 
@@ -605,7 +605,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 					VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret != 0) {
 		pr_err("unable to send synthhid protocol request.");
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	input_dev->protocol_wait_condition = 0;
@@ -613,7 +613,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 		input_dev->protocol_wait_condition, msecs_to_jiffies(1000));
 	if (input_dev->protocol_wait_condition == 0) {
 		ret = -ETIMEDOUT;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	response = &input_dev->protocol_resp;
@@ -622,7 +622,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 		pr_err("synthhid protocol request failed (version %d)",
 		       SYNTHHID_INPUT_VERSION);
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	input_dev->device_wait_condition = 0;
@@ -630,7 +630,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 		input_dev->device_wait_condition, msecs_to_jiffies(1000));
 	if (input_dev->device_wait_condition == 0) {
 		ret = -ETIMEDOUT;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	/*
@@ -642,7 +642,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	else
 		ret = -1;
 
-Cleanup:
+cleanup:
 	put_input_device(device);
 
 	return ret;
@@ -660,7 +660,7 @@ static int mousevsc_on_device_add(struct hv_device *device,
 
 	if (!input_dev) {
 		ret = -1;
-		goto Cleanup;
+		goto cleanup;
 	}
 
 	input_dev->init_complete = false;
@@ -713,7 +713,7 @@ static int mousevsc_on_device_add(struct hv_device *device,
 
 	input_dev->init_complete = true;
 
-Cleanup:
+cleanup:
 	return ret;
 }
 
-- 
1.7.4.1
