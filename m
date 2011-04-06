From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 20/22] Staging: hv: Move some definitions/declarations to be
	earlier in the file
Date: Wed,  6 Apr 2011 14:35:18 -0700
Message-ID: <1302125720-10808-20-git-send-email-kys@microsoft.com>
References: <1302125655-10741-1-git-send-email-kys@microsoft.com>
	<1302125720-10808-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1302125720-10808-1-git-send-email-kys@microsoft.com>
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

Move some definitions/declarations to be earlier in the file.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 55ba9de..865b4dc 100644
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
@@ -1213,10 +1221,7 @@ static void blkvsc_request(struct request_queue *queue)
 	}
 }
 
-/* Static decl */
-static int blkvsc_probe(struct device *dev);
 
-static int blkvsc_ringbuffer_size = BLKVSC_RING_BUFFER_SIZE;
 module_param(blkvsc_ringbuffer_size, int, S_IRUGO);
 MODULE_PARM_DESC(ring_size, "Ring buffer size (in bytes)");
 
-- 
1.7.4.1
