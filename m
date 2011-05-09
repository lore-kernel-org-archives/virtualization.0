From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 021/206] Staging: hv: Introduce a function to wait to drain
	outgoing I/O
Date: Mon,  9 May 2011 14:55:03 -0700
Message-ID: <1304978288-22999-21-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

Rather than busy loop waiting to drain I/O, introduce a function 
that does not burn CPU cycles waiting.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c     |    6 +++++-
 drivers/staging/hv/storvsc_api.h |   12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 8ee1ad0..36458b8 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -47,6 +47,7 @@ static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
 	/* (ie get_stor_device() and must_get_stor_device()) to proceed. */
 	atomic_cmpxchg(&stor_device->ref_count, 0, 2);
 
+	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
 	device->ext = stor_device;
 
@@ -332,7 +333,10 @@ static void stor_vsc_on_io_completion(struct hv_device *device,
 
 	request->on_io_completion(request);
 
-	atomic_dec(&stor_device->num_outstanding_req);
+	if (atomic_dec_and_test(&stor_device->num_outstanding_req) &&
+		stor_device->drain_notify)
+		wake_up(&stor_device->waiting_to_drain);
+
 
 	put_stor_device(device);
 }
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 32228c0..1887940 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -26,6 +26,7 @@
 #define _STORVSC_API_H_
 
 #include <linux/kernel.h>
+#include <linux/wait.h>
 #include "vstorage.h"
 #include "vmbus_api.h"
 #include "vmbus.h"
@@ -108,8 +109,11 @@ struct storvsc_device {
 	/* 0 indicates the device is being destroyed */
 	atomic_t ref_count;
 
+	bool	 drain_notify;
 	atomic_t num_outstanding_req;
 
+	wait_queue_head_t waiting_to_drain;
+
 	/*
 	 * Each unique Port/Path/Target represents 1 channel ie scsi
 	 * controller. In reality, the pathid, targetid is always 0
@@ -161,6 +165,14 @@ struct storvsc_driver *drv_to_stordrv(struct device_driver *d)
 	return hvdr_to_stordr(hvdrv);
 }
 
+static inline void storvsc_wait_to_drain(struct storvsc_device *dev)
+{
+	dev->drain_notify = true;
+	wait_event(dev->waiting_to_drain,
+		   atomic_read(&dev->num_outstanding_req) == 0);
+	dev->drain_notify = false;
+}
+
 /* Interface */
 
 int storvsc_dev_add(struct hv_device *device,
-- 
1.7.4.1
