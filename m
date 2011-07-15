From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 082/117] Staging: hv: storvsc: Use the newly introduced lock
	in accessing ext field
Date: Fri, 15 Jul 2011 10:47:10 -0700
Message-ID: <1310752065-27895-82-git-send-email-kys@microsoft.com>
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

Use the newly introduced lock in accessing ext field.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv_storage.h |    6 ++++++
 drivers/staging/hv/storvsc.c        |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv_storage.h b/drivers/staging/hv/hyperv_storage.h
index d93bf93..6b20f1d 100644
--- a/drivers/staging/hv/hyperv_storage.h
+++ b/drivers/staging/hv/hyperv_storage.h
@@ -292,12 +292,15 @@ static inline struct storvsc_device *get_out_stor_device(
 					struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
+	unsigned long flags;
 
+	spin_lock_irqsave(&device->ext_lock, flags);
 	stor_device = (struct storvsc_device *)device->ext;
 	if (stor_device && atomic_read(&stor_device->ref_count) > 1)
 		atomic_inc(&stor_device->ref_count);
 	else
 		stor_device = NULL;
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 
 	return stor_device;
 }
@@ -306,10 +309,13 @@ static inline struct storvsc_device *get_out_stor_device(
 static inline void put_stor_device(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
+	unsigned long flags;
 
+	spin_lock_irqsave(&device->ext_lock, flags);
 	stor_device = (struct storvsc_device *)device->ext;
 
 	atomic_dec(&stor_device->ref_count);
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 }
 
 static inline void storvsc_wait_to_drain(struct storvsc_device *dev)
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 357b08a..d1b6c4e 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -57,12 +57,15 @@ static inline struct storvsc_device *get_in_stor_device(
 					struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
+	unsigned long flags;
 
+	spin_lock_irqsave(&device->ext_lock, flags);
 	stor_device = (struct storvsc_device *)device->ext;
 	if (stor_device && atomic_read(&stor_device->ref_count))
 		atomic_inc(&stor_device->ref_count);
 	else
 		stor_device = NULL;
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 
 	return stor_device;
 }
@@ -87,6 +90,7 @@ static inline struct storvsc_device *final_release_stor_device(
 			struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
+	unsigned long flags;
 
 	stor_device = (struct storvsc_device *)device->ext;
 
@@ -94,7 +98,9 @@ static inline struct storvsc_device *final_release_stor_device(
 	while (atomic_cmpxchg(&stor_device->ref_count, 1, 0) != 1)
 		udelay(100);
 
+	spin_lock_irqsave(&device->ext_lock, flags);
 	device->ext = NULL;
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 	return stor_device;
 }
 
-- 
1.7.4.1
