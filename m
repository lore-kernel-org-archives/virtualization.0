From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 38/77] Staging: hv: vmbus: Get rid of the unused dev_type field in hv_device and hv_driver
Date: Thu, 16 Jun 2011 13:17:11 -0700
Message-ID: <1308255470-3826-38-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, get rid of the unused dev_type field in hv_device and hv_driver as they
are not used.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hyperv.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 3bf1c46..370b096 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -808,7 +808,6 @@ struct hv_vmbus_device_id {
 /* Base driver object */
 struct hv_driver {
 	/* the device type supported by this driver */
-	struct hv_guid dev_type;
 	const struct hv_vmbus_device_id *id_table;
 
 	struct device_driver driver;
@@ -822,7 +821,6 @@ struct hv_driver {
 /* Base device object */
 struct hv_device {
 	/* the device type id of this device */
-	struct hv_guid dev_type;
 	const char *device_type;
 
 	/* the device instance id of this device */
-- 
1.7.4.1
