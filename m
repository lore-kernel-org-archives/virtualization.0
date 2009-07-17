From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 44/54] Staging: hv: make Device->RequestLock a real spinlock
Date: Fri, 17 Jul 2009 11:09:34 -0700
Message-ID: <20090717180923.079382551@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-make-device-requestlock-a-real-spinlock.patch
In-Reply-To: <20090720160025.GA20249@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Don't use the wrapper functions for this lock, make it a real
lock so that we know what is going on.

I don't think we really want to be doing a irqsave for this code, but I
left it alone to preserve the original codepath.  It should be reviewed
later.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/RndisFilter.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/drivers/staging/hv/RndisFilter.c
+++ b/drivers/staging/hv/RndisFilter.c
@@ -54,7 +54,7 @@ typedef struct _RNDIS_DEVICE {
 	u32					LinkStatus;
 	u32					NewRequestId;
 
-	HANDLE					RequestLock;
+	spinlock_t request_lock;
 	LIST_ENTRY				RequestList;
 
 	unsigned char					HwMacAddr[HW_MACADDR_LEN];
@@ -216,12 +216,7 @@ static inline RNDIS_DEVICE* GetRndisDevi
 		return NULL;
 	}
 
-	device->RequestLock = SpinlockCreate();
-	if (!device->RequestLock)
-	{
-		kfree(device);
-		return NULL;
-	}
+	spin_lock_init(&device->request_lock);
 
 	INITIALIZE_LIST_HEAD(&device->RequestList);
 
@@ -232,7 +227,6 @@ static inline RNDIS_DEVICE* GetRndisDevi
 
 static inline void PutRndisDevice(RNDIS_DEVICE *Device)
 {
-	SpinlockClose(Device->RequestLock);
 	kfree(Device);
 }
 
@@ -241,6 +235,7 @@ static inline RNDIS_REQUEST* GetRndisReq
 	RNDIS_REQUEST *request;
 	RNDIS_MESSAGE *rndisMessage;
 	RNDIS_SET_REQUEST *set;
+	unsigned long flags;
 
 	request = kzalloc(sizeof(RNDIS_REQUEST), GFP_KERNEL);
 	if (!request)
@@ -265,18 +260,20 @@ static inline RNDIS_REQUEST* GetRndisReq
 	set->RequestId = InterlockedIncrement((int*)&Device->NewRequestId);
 
 	// Add to the request list
-	SpinlockAcquire(Device->RequestLock);
+	spin_lock_irqsave(&Device->request_lock, flags);
 	INSERT_TAIL_LIST(&Device->RequestList, &request->ListEntry);
-	SpinlockRelease(Device->RequestLock);
+	spin_unlock_irqrestore(&Device->request_lock, flags);
 
 	return request;
 }
 
 static inline void PutRndisRequest(RNDIS_DEVICE *Device, RNDIS_REQUEST *Request)
 {
-	SpinlockAcquire(Device->RequestLock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&Device->request_lock, flags);
 	REMOVE_ENTRY_LIST(&Request->ListEntry);
-	SpinlockRelease(Device->RequestLock);
+	spin_unlock_irqrestore(&Device->request_lock, flags);
 
 	WaitEventClose(Request->WaitEvent);
 	kfree(Request);
@@ -385,10 +382,11 @@ RndisFilterReceiveResponse(
 	LIST_ENTRY *curr;
 	RNDIS_REQUEST *request=NULL;
 	bool found = false;
+	unsigned long flags;
 
 	DPRINT_ENTER(NETVSC);
 
-	SpinlockAcquire(Device->RequestLock);
+	spin_lock_irqsave(&Device->request_lock, flags);
 	ITERATE_LIST_ENTRIES(anchor, curr, &Device->RequestList)
 	{
 		request = CONTAINING_RECORD(curr, RNDIS_REQUEST, ListEntry);
@@ -403,7 +401,7 @@ RndisFilterReceiveResponse(
 			break;
 		}
 	}
-	SpinlockRelease(Device->RequestLock);
+	spin_unlock_irqrestore(&Device->request_lock, flags);
 
 	if (found)
 	{
