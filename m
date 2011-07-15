From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 086/117] Staging: hv: storvsc: Leverage the spinlock to manage
	ref_cnt
Date: Fri, 15 Jul 2011 10:47:14 -0700
Message-ID: <1310752065-27895-86-git-send-email-kys@microsoft.com>
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

Now that we have a spin lock protecting access to the stor device pointer,
use it manage the reference count as well.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv_storage.h |    8 ++++----
 drivers/staging/hv/storvsc.c        |   10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/hyperv_storage.h b/drivers/staging/hv/hyperv_storage.h
index 53b65be..d946211 100644
--- a/drivers/staging/hv/hyperv_storage.h
+++ b/drivers/staging/hv/hyperv_storage.h
@@ -265,7 +265,7 @@ struct storvsc_device {
 	struct hv_device *device;
 
 	/* 0 indicates the device is being destroyed */
-	atomic_t ref_count;
+	int	 ref_count;
 	bool	 destroy;
 	bool	 drain_notify;
 	atomic_t num_outstanding_req;
@@ -296,9 +296,9 @@ static inline struct storvsc_device *get_out_stor_device(
 
 	spin_lock_irqsave(&device->ext_lock, flags);
 	stor_device = (struct storvsc_device *)device->ext;
-	if (stor_device && (atomic_read(&stor_device->ref_count) > 1) &&
+	if (stor_device && (stor_device->ref_count > 1) &&
 		!stor_device->destroy)
-		atomic_inc(&stor_device->ref_count);
+		stor_device->ref_count++;
 	else
 		stor_device = NULL;
 	spin_unlock_irqrestore(&device->ext_lock, flags);
@@ -315,7 +315,7 @@ static inline void put_stor_device(struct hv_device *device)
 	spin_lock_irqsave(&device->ext_lock, flags);
 	stor_device = (struct storvsc_device *)device->ext;
 
-	atomic_dec(&stor_device->ref_count);
+	stor_device->ref_count--;
 	spin_unlock_irqrestore(&device->ext_lock, flags);
 }
 
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index c4cb170..a41be2a 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -42,7 +42,7 @@ static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
 
 	/* Set to 2 to allow both inbound and outbound traffics */
 	/* (ie get_out_stor_device() and get_in_stor_device()) to proceed. */
-	atomic_set(&stor_device->ref_count, 2);
+	stor_device->ref_count = 2;
 	stor_device->destroy = false;
 	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
@@ -61,8 +61,8 @@ static inline struct storvsc_device *get_in_stor_device(
 
 	spin_lock_irqsave(&device->ext_lock, flags);
 	stor_device = (struct storvsc_device *)device->ext;
-	if (stor_device && atomic_read(&stor_device->ref_count))
-		atomic_inc(&stor_device->ref_count);
+	if (stor_device && stor_device->ref_count)
+		stor_device->ref_count++;
 	else
 		stor_device = NULL;
 	spin_unlock_irqrestore(&device->ext_lock, flags);
@@ -379,7 +379,7 @@ int storvsc_dev_remove(struct hv_device *device)
 	 * pointer.
 	 */
 	stor_device = (struct storvsc_device *)device->ext;
-	atomic_dec(&stor_device->ref_count);
+
 	stor_device->destroy = true;
 
 	/*
@@ -391,7 +391,7 @@ int storvsc_dev_remove(struct hv_device *device)
 	storvsc_wait_to_drain(stor_device);
 
 	spin_lock_irqsave(&device->ext_lock, flags);
-	atomic_set(&stor_device->ref_count, 0);
+	stor_device->ref_count = 0;
 	device->ext = NULL;
 	spin_unlock_irqrestore(&device->ext_lock, flags);
 
-- 
1.7.4.1
