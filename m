From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 16/24] Staging: hv: mousevsc: Cleanup mousevsc_connect_to_vsp()
Date: Thu, 29 Sep 2011 11:54:56 -0700
Message-ID: <1317322504-9788-16-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
 <1317322504-9788-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317322504-9788-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup mousevsc_connect_to_vsp(). There is no need to take reference on the
mousevsc device object when we are setting up the device. As part of this
cleanup get rid of get_input_device() as this function is only used here.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   34 +---------------------------------
 1 files changed, 1 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index fc0ba68..75ea2db 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -204,32 +204,6 @@ static void free_input_device(struct mousevsc_dev *device)
 }
 
 /*
- * Get the inputdevice object if exists and its refcount > 1
- */
-static struct mousevsc_dev *get_input_device(struct hv_device *device)
-{
-	struct mousevsc_dev *input_dev;
-
-	input_dev = hv_get_drvdata(device);
-
-/*
- *	FIXME
- *	This sure isn't a valid thing to print for debugging, no matter
- *	what the intention is...
- *
- *	printk(KERN_ERR "-------------------------> REFCOUNT = %d",
- *	       input_dev->ref_count);
- */
-
-	if (input_dev && atomic_read(&input_dev->ref_count) > 1)
-		atomic_inc(&input_dev->ref_count);
-	else
-		input_dev = NULL;
-
-	return input_dev;
-}
-
-/*
  * Get the inputdevice object iff exists and its refcount > 0
  */
 static struct mousevsc_dev *must_get_input_device(struct hv_device *device)
@@ -520,15 +494,10 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 {
 	int ret = 0;
 	int t;
-	struct mousevsc_dev *input_dev;
+	struct mousevsc_dev *input_dev = hv_get_drvdata(device);
 	struct mousevsc_prt_msg *request;
 	struct mousevsc_prt_msg *response;
 
-	input_dev = get_input_device(device);
-
-	if (!input_dev)
-		return -ENODEV;
-
 
 	request = &input_dev->protocol_req;
 
@@ -584,7 +553,6 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 		ret = -ENOMEM;
 
 cleanup:
-	put_input_device(device);
 
 	return ret;
 }
-- 
1.7.4.1
