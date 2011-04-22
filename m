From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 16/18] Staging: hv: Move some definitions/declarations to be earlier in the file
Date: Fri, 22 Apr 2011 14:13:37 -0700
Message-ID: <1303506819-1913-16-git-send-email-kys@microsoft.com>
References: <1303506780-1872-1-git-send-email-kys@microsoft.com>
 <1303506819-1913-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303506819-1913-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Move some definitions/declarations to be earlier in the file.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index a63778e4..f421208 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -124,6 +124,14 @@ static const struct hv_guid g_blk_device_type = {
  */
 static void blkvsc_request_completion(struct hv_storvsc_request *request);
 
+static int blkvsc_ringbuffer_size = BLKVSC_RING_BUFFER_SIZE;
+
+/*
+ * There is a circular dependency involving blkvsc_probe()
+ * and block_ops.
+ */
+static int blkvsc_probe(struct device *dev);
+
 static int blk_vsc_on_device_add(struct hv_device *device,
 				void *additional_info)
 {
@@ -1205,10 +1213,7 @@ static void blkvsc_request(struct request_queue *queue)
 	}
 }
 
-/* Static decl */
-static int blkvsc_probe(struct device *dev);
 
-static int blkvsc_ringbuffer_size = BLKVSC_RING_BUFFER_SIZE;
 module_param(blkvsc_ringbuffer_size, int, S_IRUGO);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (in bytes)");
 
-- 
1.7.4.1
