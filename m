From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 43/54] Staging: hv: make RingInfo->RingLock a real spinlock
Date: Fri, 17 Jul 2009 11:09:33 -0700
Message-ID: <20090717180922.909597625@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-make-ringinfo-ringlock-a-real-spinlock.patch
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
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, shemminger@linux-foundation.org
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
 drivers/staging/hv/RingBuffer.c |   24 +++++++++++++-----------
 drivers/staging/hv/RingBuffer.h |    2 +-
 2 files changed, 14 insertions(+), 12 deletions(-)

--- a/drivers/staging/hv/RingBuffer.c
+++ b/drivers/staging/hv/RingBuffer.c
@@ -315,7 +315,7 @@ RingBufferInit(
 	RingInfo->RingSize = BufferLen;
 	RingInfo->RingDataSize = BufferLen - sizeof(RING_BUFFER);
 
-	RingInfo->RingLock = SpinlockCreate();
+	spin_lock_init(&RingInfo->ring_lock);
 
 	return 0;
 }
@@ -334,7 +334,6 @@ RingBufferCleanup(
 	RING_BUFFER_INFO* RingInfo
 	)
 {
-	SpinlockClose(RingInfo->RingLock);
 }
 
 /*++
@@ -360,6 +359,7 @@ RingBufferWrite(
 
 	volatile u32 nextWriteLocation;
 	u64 prevIndices=0;
+	unsigned long flags;
 
 	DPRINT_ENTER(VMBUS);
 
@@ -370,7 +370,7 @@ RingBufferWrite(
 
 	totalBytesToWrite += sizeof(u64);
 
-	SpinlockAcquire(OutRingInfo->RingLock);
+	spin_lock_irqsave(&OutRingInfo->ring_lock, flags);
 
 	GetRingBufferAvailBytes(OutRingInfo, &byteAvailToRead, &byteAvailToWrite);
 
@@ -384,7 +384,7 @@ RingBufferWrite(
 	{
 		DPRINT_DBG(VMBUS, "No more space left on outbound ring buffer (needed %u, avail %u)", totalBytesToWrite, byteAvailToWrite);
 
-		SpinlockRelease(OutRingInfo->RingLock);
+		spin_unlock_irqrestore(&OutRingInfo->ring_lock, flags);
 
 		DPRINT_EXIT(VMBUS);
 
@@ -418,7 +418,7 @@ RingBufferWrite(
 
 	//DumpRingInfo(OutRingInfo, "AFTER ");
 
-	SpinlockRelease(OutRingInfo->RingLock);
+	spin_unlock_irqrestore(&OutRingInfo->ring_lock, flags);
 
 	DPRINT_EXIT(VMBUS);
 
@@ -445,8 +445,9 @@ RingBufferPeek(
 	u32 bytesAvailToWrite;
 	u32 bytesAvailToRead;
 	u32 nextReadLocation=0;
+	unsigned long flags;
 
-	SpinlockAcquire(InRingInfo->RingLock);
+	spin_lock_irqsave(&InRingInfo->ring_lock, flags);
 
 	GetRingBufferAvailBytes(InRingInfo, &bytesAvailToRead, &bytesAvailToWrite);
 
@@ -455,7 +456,7 @@ RingBufferPeek(
 	{
 		//DPRINT_DBG(VMBUS, "got callback but not enough to read <avail to read %d read size %d>!!", bytesAvailToRead, BufferLen);
 
-		SpinlockRelease(InRingInfo->RingLock);
+		spin_unlock_irqrestore(&InRingInfo->ring_lock, flags);
 
 		return -1;
 	}
@@ -468,7 +469,7 @@ RingBufferPeek(
 											BufferLen,
 											nextReadLocation);
 
-	SpinlockRelease(InRingInfo->RingLock);
+	spin_unlock_irqrestore(&InRingInfo->ring_lock, flags);
 
 	return 0;
 }
@@ -495,10 +496,11 @@ RingBufferRead(
 	u32 bytesAvailToRead;
 	u32 nextReadLocation=0;
 	u64 prevIndices=0;
+	unsigned long flags;
 
 	ASSERT(BufferLen > 0);
 
-	SpinlockAcquire(InRingInfo->RingLock);
+	spin_lock_irqsave(&InRingInfo->ring_lock, flags);
 
 	GetRingBufferAvailBytes(InRingInfo, &bytesAvailToRead, &bytesAvailToWrite);
 
@@ -511,7 +513,7 @@ RingBufferRead(
 	{
 		DPRINT_DBG(VMBUS, "got callback but not enough to read <avail to read %d read size %d>!!", bytesAvailToRead, BufferLen);
 
-		SpinlockRelease(InRingInfo->RingLock);
+		spin_unlock_irqrestore(&InRingInfo->ring_lock, flags);
 
 		return -1;
 	}
@@ -537,7 +539,7 @@ RingBufferRead(
 
 	//DumpRingInfo(InRingInfo, "AFTER ");
 
-	SpinlockRelease(InRingInfo->RingLock);
+	spin_unlock_irqrestore(&InRingInfo->ring_lock, flags);
 
 	return 0;
 }
--- a/drivers/staging/hv/RingBuffer.h
+++ b/drivers/staging/hv/RingBuffer.h
@@ -48,7 +48,7 @@ typedef struct _RING_BUFFER {
 typedef struct _RING_BUFFER_INFO {
     RING_BUFFER*	RingBuffer;
     u32			RingSize;			// Include the shared header
-	HANDLE			RingLock;
+	spinlock_t ring_lock;
 
     u32			RingDataSize;		// < ringSize
 	u32			RingDataStartOffset;
