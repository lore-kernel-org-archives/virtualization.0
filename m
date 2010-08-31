From: Hank Janssen <hjanssen@sailtheuniverse.com>
Subject: [PATCH 5/5] staging: hv: Gracefully handle SCSI resets - RESEND
Date: Tue, 31 Aug 2010 11:22:00 -0700
Message-ID: <4C7D4848.6090409@sailtheuniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, devel@driverdev.osuosl.org
Cc: haiyangz@microsoft.com
List-Id: virtualization@lists.linuxfoundation.org


(Send from a linux machine, not routed through exchange)

If we get a SCSI host bus reset we now gracefully handle it, and we 
take the device offline. This before sometimes caused hangs.

Signed-off-by:Hank Janssen <hjanssen@microsoft.com
Signed-off-by:Haiyang Zhang <haiyangz@microsoft.com


---
 drivers/staging/hv/storvsc.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 6bd2ff1..5f222cf 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -48,7 +48,9 @@ struct storvsc_device {
 
 	/* 0 indicates the device is being destroyed */
 	atomic_t RefCount;
-
+	
+	int reset;
+	spinlock_t lock;
 	atomic_t NumOutstandingRequests;
 
 	/*
@@ -93,6 +95,9 @@ static inline struct storvsc_device *AllocStorDevice(struct hv_device *Device)
 	atomic_cmpxchg(&storDevice->RefCount, 0, 2);
 
 	storDevice->Device = Device;
+	storDevice->reset  = 0;
+	spin_lock_init(&storDevice->lock);
+
 	Device->Extension = storDevice;
 
 	return storDevice;
@@ -101,6 +106,7 @@ static inline struct storvsc_device *AllocStorDevice(struct hv_device *Device)
 static inline void FreeStorDevice(struct storvsc_device *Device)
 {
 	/* ASSERT(atomic_read(&Device->RefCount) == 0); */
+	/*kfree(Device->lock);*/
 	kfree(Device);
 }
 
@@ -108,13 +114,24 @@ static inline void FreeStorDevice(struct storvsc_device *Device)
 static inline struct storvsc_device *GetStorDevice(struct hv_device *Device)
 {
 	struct storvsc_device *storDevice;
+	unsigned long flags;
 
 	storDevice = (struct storvsc_device *)Device->Extension;
+
+	spin_lock_irqsave(&storDevice->lock, flags);
+
+	if (storDevice->reset == 1) {
+		spin_unlock_irqrestore(&storDevice->lock, flags);
+		return NULL;
+	}
+
 	if (storDevice && atomic_read(&storDevice->RefCount) > 1)
 		atomic_inc(&storDevice->RefCount);
 	else
 		storDevice = NULL;
 
+	spin_unlock_irqrestore(&storDevice->lock, flags);
+
 	return storDevice;
 }
 
@@ -122,13 +139,19 @@ static inline struct storvsc_device *GetStorDevice(struct hv_device *Device)
 static inline struct storvsc_device *MustGetStorDevice(struct hv_device *Device)
 {
 	struct storvsc_device *storDevice;
+	unsigned long flags;
 
 	storDevice = (struct storvsc_device *)Device->Extension;
+
+	spin_lock_irqsave(&storDevice->lock, flags);
+
 	if (storDevice && atomic_read(&storDevice->RefCount))
 		atomic_inc(&storDevice->RefCount);
 	else
 		storDevice = NULL;
 
+	spin_unlock_irqrestore(&storDevice->lock, flags);
+
 	return storDevice;
 }
 
@@ -614,6 +637,7 @@ int StorVscOnHostReset(struct hv_device *Device)
 	struct storvsc_device *storDevice;
 	struct storvsc_request_extension *request;
 	struct vstor_packet *vstorPacket;
+	unsigned long flags;
 	int ret;
 
 	DPRINT_INFO(STORVSC, "resetting host adapter...");
@@ -625,6 +649,16 @@ int StorVscOnHostReset(struct hv_device *Device)
 		return -1;
 	}
 
+	spin_lock_irqsave(&storDevice->lock, flags);
+	storDevice->reset = 1;
+	spin_unlock_irqrestore(&storDevice->lock, flags);
+
+	/*
+	 * Wait for traffic in transit to complete
+	 */
+	while (atomic_read(&storDevice->NumOutstandingRequests))
+		udelay(1000);
+
 	request = &storDevice->ResetRequest;
 	vstorPacket = &request->VStorPacket;
 
-- 
1.6.0.2
