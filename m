From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/46] Staging: hv: storvsc: Get rid of
	final_release_stor_device() by inlining code
Date: Sat, 27 Aug 2011 11:31:08 -0700
Message-ID: <1314469905-7058-9-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of final_release_stor_device() by inlining code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 1976a34..3e9829f 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -67,22 +67,6 @@ static inline struct storvsc_device *get_in_stor_device(
 	return stor_device;
 }
 
-/* Drop ref count to 0. No one can use stor_device object. */
-static inline struct storvsc_device *final_release_stor_device(
-			struct hv_device *device)
-{
-	struct storvsc_device *stor_device;
-
-	stor_device = (struct storvsc_device *)device->ext;
-
-	/* Busy wait until the ref drop to 1, then set it to 0 */
-	while (atomic_cmpxchg(&stor_device->ref_count, 1, 0) != 1)
-		udelay(100);
-
-	device->ext = NULL;
-	return stor_device;
-}
-
 static int storvsc_channel_init(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
@@ -401,7 +385,12 @@ int storvsc_dev_remove(struct hv_device *device)
 
 	storvsc_wait_to_drain(stor_device);
 
-	stor_device = final_release_stor_device(device);
+	/*
+	 * Since we have already drained, we don't need to busy wait
+	 * as was done in final_release_stor_device()
+	 */
+	atomic_set(&stor_device->ref_count, 0);
+	device->ext = NULL;
 
 	/* Close the channel */
 	vmbus_close(device->channel);
-- 
1.7.4.1
