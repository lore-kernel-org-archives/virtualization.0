From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/46] Staging: hv: storvsc: Get rid of release_stor_device()
	by inlining the code
Date: Sat, 27 Aug 2011 11:31:07 -0700
Message-ID: <1314469905-7058-8-git-send-email-kys@microsoft.com>
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

Get rid of release_stor_device() by inlining the code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 0f8c609..1976a34 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -67,21 +67,6 @@ static inline struct storvsc_device *get_in_stor_device(
 	return stor_device;
 }
 
-/* Drop ref count to 1 to effectively disable get_out_stor_device() */
-static inline struct storvsc_device *release_stor_device(
-					struct hv_device *device)
-{
-	struct storvsc_device *stor_device;
-
-	stor_device = (struct storvsc_device *)device->ext;
-
-	/* Busy wait until the ref drop to 2, then set it to 1 */
-	while (atomic_cmpxchg(&stor_device->ref_count, 2, 1) != 2)
-		udelay(100);
-
-	return stor_device;
-}
-
 /* Drop ref count to 0. No one can use stor_device object. */
 static inline struct storvsc_device *final_release_stor_device(
 			struct hv_device *device)
@@ -401,8 +386,8 @@ int storvsc_dev_remove(struct hv_device *device)
 	struct storvsc_device *stor_device;
 	unsigned long flags;
 
-
-	stor_device = release_stor_device(device);
+	stor_device = (struct storvsc_device *)device->ext;
+	atomic_dec(&stor_device->ref_count);
 
 	spin_lock_irqsave(&device->channel->inbound_lock, flags);
 	stor_device->destroy = true;
-- 
1.7.4.1
