From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 16/25] Staging: hv: storvsc: Get rid of alloc_stor_device() by
	inlining the code
Date: Thu,  8 Sep 2011 07:24:27 -0700
Message-ID: <1315491876-9554-16-git-send-email-kys@microsoft.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1315491876-9554-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of alloc_stor_device() by inlining the code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   24 ++++++------------------
 1 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index ef93205..e7d0f92 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -332,23 +332,6 @@ static inline void storvsc_wait_to_drain(struct storvsc_device *dev)
 	dev->drain_notify = false;
 }
 
-static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
-{
-	struct storvsc_device *stor_device;
-
-	stor_device = kzalloc(sizeof(struct storvsc_device), GFP_KERNEL);
-	if (!stor_device)
-		return NULL;
-
-	stor_device->destroy = false;
-	init_waitqueue_head(&stor_device->waiting_to_drain);
-	stor_device->device = device;
-	device->ext = stor_device;
-
-	return stor_device;
-}
-
-
 static inline struct storvsc_device *get_in_stor_device(
 					struct hv_device *device)
 {
@@ -1382,13 +1365,18 @@ static int storvsc_probe(struct hv_device *device,
 		return -ENOMEM;
 	}
 
-	stor_device = alloc_stor_device(device);
+	stor_device = kzalloc(sizeof(struct storvsc_device), GFP_KERNEL);
 	if (!stor_device) {
 		kmem_cache_destroy(host_dev->request_pool);
 		scsi_host_put(host);
 		return -ENOMEM;
 	}
 
+	stor_device->destroy = false;
+	init_waitqueue_head(&stor_device->waiting_to_drain);
+	stor_device->device = device;
+	device->ext = stor_device;
+
 	stor_device->port_number = host->host_no;
 	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size);
 	if (ret) {
-- 
1.7.4.1
