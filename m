From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 21/22] Staging: hv: Move module parameter to earlier in the
	file
Date: Mon, 28 Mar 2011 10:00:52 -0700
Message-ID: <1301331653-26265-21-git-send-email-kys@microsoft.com>
References: <1301331615-26226-1-git-send-email-kys@microsoft.com>
	<1301331653-26265-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1301331653-26265-1-git-send-email-kys@microsoft.com>
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

Move module parameter to be earlier in the file.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 95653da..14cc2ed 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -126,6 +126,9 @@ static void blkvsc_request_completion(struct hv_storvsc_request *request);
 
 static int blkvsc_ringbuffer_size = BLKVSC_RING_BUFFER_SIZE;
 
+module_param(blkvsc_ringbuffer_size, int, S_IRUGO);
+MODULE_PARM_DESC(ring_size, "Ring buffer size (in bytes)");
+
 /*
  * There is a circular dependency involving blkvsc_probe()
  * and block_ops.
@@ -1219,9 +1222,6 @@ static void blkvsc_request(struct request_queue *queue)
 }
 
 
-module_param(blkvsc_ringbuffer_size, int, S_IRUGO);
-MODULE_PARM_DESC(ring_size, "Ring buffer size (in bytes)");
-
 /* The one and only one */
 static  struct storvsc_driver_object g_blkvsc_drv;
 
-- 
1.7.4.1
