From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 11/20] Staging: hv: storvsc: Get rid of some unnecessary state and definitions
Date: Tue, 13 Sep 2011 10:59:47 -0700
Message-ID: <1315936796-20662-11-git-send-email-kys@microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315936796-20662-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, get rid of some unnecessary state and definitions.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index ce8652e..5e306a5 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -245,7 +245,6 @@ enum storvsc_request_type {
 
 
 struct hv_storvsc_request {
-	struct hv_storvsc_request *request;
 	struct hv_device *device;
 
 	/* Synchronize the request/response if needed */
@@ -260,14 +259,6 @@ struct hv_storvsc_request {
 };
 
 
-struct storvsc_device_info {
-	u32 ring_buffer_size;
-	unsigned int port_number;
-	unsigned char path_id;
-	unsigned char target_id;
-};
-
-
 /* A storvsc device is a device object that contains a vmbus channel */
 struct storvsc_device {
 	struct hv_device *device;
-- 
1.7.4.1
