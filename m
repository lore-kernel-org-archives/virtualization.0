From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 34/77] Staging: hv: vmbus: Get rid of the unused name field in struct hv_driver
Date: Thu, 16 Jun 2011 13:17:07 -0700
Message-ID: <1308255470-3826-34-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the unused name field in struct hv_driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hyperv.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 28fe7f9..3bf1c46 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -807,8 +807,6 @@ struct hv_vmbus_device_id {
 
 /* Base driver object */
 struct hv_driver {
-	const char *name;
-
 	/* the device type supported by this driver */
 	struct hv_guid dev_type;
 	const struct hv_vmbus_device_id *id_table;
-- 
1.7.4.1
