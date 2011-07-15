From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 085/117] Staging: hv: storvsc: Get rid of
	final_release_stor_device() by inlining code
Date: Fri, 15 Jul 2011 10:47:13 -0700
Message-ID: <1310752065-27895-85-git-send-email-kys@microsoft.com>
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

Get rid of final_release_stor_device() by inlining code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index f52e610..c4cb170 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -70,25 +70,6 @@ static inline struct storvsc_device *get_in_stor_device(
 	return stor_device;
 }
 
-/* Drop ref count to 0. No one can use stor_device object. */
-static inline struct storvsc_device *final_release_stor_device(
-			struct hv_device *device)
-{
-	struct storvsc_device *stor_device;
-	unsigned long flags;
-
-	stor_device = (struct storvsc_device *)device->ext;
-
-	/* Busy wait until the ref drop to 1, then set it to 0 */
-	while (atomic_cmpxchg(&stor_device->ref_count, 1, 0) != 1)
-		udelay(100);
-
-	spin_lock_irqsave(&device->ext_lock, flags);
-	device->ext = NULL;
-	spin_unlock_irqrestore(&device->ext_lock, flags);
-	return stor_device;
-}
-
 static int storvsc_channel_init(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
@@ -390,6 +371,7 @@ int storvsc_dev_add(struct hv_device *device,
 int storvsc_dev_remove(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
+	unsigned long flags;
 
 	/*
 	 * Since we currently hold a reference on the stor
@@ -408,7 +390,10 @@ int storvsc_dev_remove(struct hv_device *device)
 
 	storvsc_wait_to_drain(stor_device);
 
-	stor_device = final_release_stor_device(device);
+	spin_lock_irqsave(&device->ext_lock, flags);
+	atomic_set(&stor_device->ref_count, 0);
+	device->ext = NULL;
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 
 	/* Close the channel */
 	vmbus_close(device->channel);
-- 
1.7.4.1
