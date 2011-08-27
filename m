From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/46] Staging: hv: storvsc: Inline free_stor_device()
Date: Sat, 27 Aug 2011 11:31:00 -0700
Message-ID: <1314469905-7058-1-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314469874-7017-1-git-send-email-kys@microsoft.com>
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

Inline the code for  free_stor_device() and get rid of the function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 827b6a3..8c62829 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -51,10 +51,6 @@ static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
 	return stor_device;
 }
 
-static inline void free_stor_device(struct storvsc_device *device)
-{
-	kfree(device);
-}
 
 /* Get the stordevice object iff exists and its refcount > 0 */
 static inline struct storvsc_device *must_get_stor_device(
@@ -394,7 +390,7 @@ int storvsc_dev_add(struct hv_device *device,
 	/* Send it back up */
 	ret = storvsc_connect_to_vsp(device, device_info->ring_buffer_size);
 	if (ret) {
-		free_stor_device(stor_device);
+		kfree(stor_device);
 		return ret;
 	}
 	device_info->path_id = stor_device->path_id;
@@ -422,7 +418,7 @@ int storvsc_dev_remove(struct hv_device *device)
 	/* Close the channel */
 	vmbus_close(device->channel);
 
-	free_stor_device(stor_device);
+	kfree(stor_device);
 	return 0;
 }
 
-- 
1.7.4.1
