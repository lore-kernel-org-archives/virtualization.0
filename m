From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 19/54] Staging: hv: remove VOID typedef
Date: Fri, 17 Jul 2009 11:09:09 -0700
Message-ID: <20090717180918.943767124@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=staging-hv-remove-void-typedef.patch
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
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Greg KH <greg@kroah.com>
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

The VOID typedef is now removed from the Hyper-V driver code.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/Channel.c      |    2 +-
 drivers/staging/hv/ChannelMgmt.c  |    6 +++---
 drivers/staging/hv/ChannelMgmt.h  |    2 +-
 drivers/staging/hv/Connection.c   |    6 +++---
 drivers/staging/hv/Hv.c           |    4 ++--
 drivers/staging/hv/Hv.h           |   12 ++++++------
 drivers/staging/hv/RingBuffer.c   |    2 +-
 drivers/staging/hv/RndisFilter.c  |    4 ++--
 drivers/staging/hv/VmbusPrivate.h |   16 ++++++++--------
 drivers/staging/hv/include/List.h |   14 +++++++-------
 drivers/staging/hv/include/osd.h  |    3 +--
 drivers/staging/hv/osd.c          |    8 ++++----
 12 files changed, 39 insertions(+), 40 deletions(-)

--- a/drivers/staging/hv/Channel.c
+++ b/drivers/staging/hv/Channel.c
@@ -677,7 +677,7 @@ Description:
 	Close the specified channel
 
 --*/
-VOID
+void
 VmbusChannelClose(
 	VMBUS_CHANNEL	*Channel
 	)
--- a/drivers/staging/hv/ChannelMgmt.c
+++ b/drivers/staging/hv/ChannelMgmt.c
@@ -672,7 +672,7 @@ Description:
 	This is invoked in the vmbus worker thread context.
 
 --*/
-VOID
+void
 VmbusOnChannelMessage(
 	void *Context
 	)
@@ -722,7 +722,7 @@ Description:
 --*/
 int
 VmbusChannelRequestOffers(
-	VOID
+	void
 	)
 {
 	int ret=0;
@@ -785,7 +785,7 @@ Description:
 --*/
 void
 VmbusChannelReleaseUnattachedChannels(
-	VOID
+	void
 	)
 {
 	LIST_ENTRY *entry;
--- a/drivers/staging/hv/ChannelMgmt.h
+++ b/drivers/staging/hv/ChannelMgmt.h
@@ -59,7 +59,7 @@ typedef struct _VMBUS_CHANNEL {
 	UINT32						RingBufferGpadlHandle;
 
 	// Allocated memory for ring buffer
-	VOID*						RingBufferPages;
+	void *						RingBufferPages;
 	UINT32						RingBufferPageCount;
 	RING_BUFFER_INFO			Outbound;	// send to parent
 	RING_BUFFER_INFO			Inbound;	// receive from parent
--- a/drivers/staging/hv/Connection.c
+++ b/drivers/staging/hv/Connection.c
@@ -195,7 +195,7 @@ Description:
 --*/
 int
 VmbusDisconnect(
-	VOID
+	void
 	)
 {
 	int ret=0;
@@ -323,9 +323,9 @@ Description:
 	Handler for events
 
 --*/
-VOID
+void
 VmbusOnEvents(
-  VOID
+  void
 	)
 {
 	int dword;
--- a/drivers/staging/hv/Hv.c
+++ b/drivers/staging/hv/Hv.c
@@ -621,9 +621,9 @@ Description:
 	Cleanup routine for HvSynicInit().
 
 --*/
-VOID
+void
 HvSynicCleanup(
-	VOID
+	void
 	)
 {
     HV_SYNIC_SINT	sharedSint;
--- a/drivers/staging/hv/Hv.h
+++ b/drivers/staging/hv/Hv.h
@@ -150,12 +150,12 @@ static inline void WriteMsr(int msr, UIN
 //
 static int
 HvInit(
-    VOID
+    void
     );
 
-static VOID
+static void
 HvCleanup(
-    VOID
+    void
     );
 
 static HV_STATUS
@@ -168,7 +168,7 @@ HvPostMessage(
 
 static HV_STATUS
 HvSignalEvent(
-	VOID
+	void
 	);
 
 static int
@@ -176,9 +176,9 @@ HvSynicInit(
 	UINT32		irqVector
 	);
 
-static VOID
+static void
 HvSynicCleanup(
-	VOID
+	void
 	);
 
 #endif // __HV_H__
--- a/drivers/staging/hv/include/List.h
+++ b/drivers/staging/hv/include/List.h
@@ -44,7 +44,7 @@ typedef DLIST_ENTRY *PLIST_ENTRY;
 
 
 /*
- *  VOID
+ *  void
  *  InitializeListHead(
  *      PLIST_ENTRY ListHead
  *      );
@@ -132,7 +132,7 @@ typedef DLIST_ENTRY *PLIST_ENTRY;
 
 
 /*
- *  VOID
+ *  void
  *  RemoveEntryList(
  *      PLIST_ENTRY Entry
  *      );
@@ -148,7 +148,7 @@ typedef DLIST_ENTRY *PLIST_ENTRY;
 
 
 /*
- *  VOID
+ *  void
  *  AttachList(
  *      PLIST_ENTRY ListHead,
  *      PLIST_ENTRY ListEntry
@@ -168,7 +168,7 @@ typedef DLIST_ENTRY *PLIST_ENTRY;
 
 
 /*
- *  VOID
+ *  void
  *  InsertTailList(
  *      PLIST_ENTRY ListHead,
  *      PLIST_ENTRY Entry
@@ -188,7 +188,7 @@ typedef DLIST_ENTRY *PLIST_ENTRY;
 
 
 /*
- *  VOID
+ *  void
  *  InsertHeadList(
  *      PLIST_ENTRY ListHead,
  *      PLIST_ENTRY Entry
@@ -207,7 +207,7 @@ typedef DLIST_ENTRY *PLIST_ENTRY;
 
 
 /*
- *  VOID
+ *  void
  *  IterateListEntries(
  *      PLIST_ENTRY anchor,
  *      PLIST_ENTRY index,
@@ -245,7 +245,7 @@ typedef DLIST_ENTRY *PLIST_ENTRY;
 
 
 /*
- *  VOID
+ *  void
  *  PushEntryList(
  *      PSINGLE_LIST_ENTRY ListHead,
  *		PSINGLE_LIST_ENTRY Entry
--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -131,7 +131,6 @@ typedef long long			LONGLONG;
 // Other types
 //
 typedef unsigned long		SIZE_T;
-typedef void				VOID;
 //typedef unsigned char		GUID[16];
 typedef unsigned char		BOOL;
 typedef unsigned char		BOOLEAN;
@@ -219,7 +218,7 @@ extern void* MemAlloc(unsigned int size)
 extern void* MemAllocZeroed(unsigned int size);
 extern void* MemAllocAtomic(unsigned int size);
 extern void MemFree(void* buf);
-extern void MemoryFence(VOID);
+extern void MemoryFence(void);
 
 extern HANDLE TimerCreate(PFN_TIMER_CALLBACK pfnTimerCB, void* context);
 extern void TimerClose(HANDLE hTimer);
--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -375,7 +375,7 @@ int WaitEventWaitEx(HANDLE hWait, UINT32
 	return ret;
 }
 
-HANDLE SpinlockCreate(VOID)
+HANDLE SpinlockCreate(void)
 {
 	SPINLOCK* spin = kmalloc(sizeof(SPINLOCK), GFP_KERNEL);
 	if (!spin)
@@ -387,21 +387,21 @@ HANDLE SpinlockCreate(VOID)
 	return spin;
 }
 
-VOID SpinlockAcquire(HANDLE hSpin)
+void SpinlockAcquire(HANDLE hSpin)
 {
 	SPINLOCK* spin = (SPINLOCK* )hSpin;
 
 	spin_lock_irqsave(&spin->lock, spin->flags);
 }
 
-VOID SpinlockRelease(HANDLE hSpin)
+void SpinlockRelease(HANDLE hSpin)
 {
 	SPINLOCK* spin = (SPINLOCK* )hSpin;
 
 	spin_unlock_irqrestore(&spin->lock, spin->flags);
 }
 
-VOID SpinlockClose(HANDLE hSpin)
+void SpinlockClose(HANDLE hSpin)
 {
 	SPINLOCK* spin = (SPINLOCK* )hSpin;
 	kfree(spin);
--- a/drivers/staging/hv/RingBuffer.c
+++ b/drivers/staging/hv/RingBuffer.c
@@ -301,7 +301,7 @@ Description:
 int
 RingBufferInit(
 	RING_BUFFER_INFO	*RingInfo,
-	VOID				*Buffer,
+	void				*Buffer,
 	UINT32				BufferLen
 	)
 {
--- a/drivers/staging/hv/RndisFilter.c
+++ b/drivers/staging/hv/RndisFilter.c
@@ -120,7 +120,7 @@ static int
 RndisFilterQueryDevice(
 	RNDIS_DEVICE	*Device,
 	UINT32			Oid,
-	VOID			*Result,
+	void			*Result,
 	UINT32			*ResultSize
 	);
 
@@ -585,7 +585,7 @@ static int
 RndisFilterQueryDevice(
 	RNDIS_DEVICE	*Device,
 	UINT32			Oid,
-	VOID			*Result,
+	void			*Result,
 	UINT32			*ResultSize
 	)
 {
--- a/drivers/staging/hv/VmbusPrivate.h
+++ b/drivers/staging/hv/VmbusPrivate.h
@@ -73,12 +73,12 @@ typedef struct _VMBUS_CONNECTION {
 	// calls Hv to generate a port event. The other end
 	// receives the port event and parse the recvInterruptPage
 	// to see which bit is set
-	VOID*								InterruptPage;
-	VOID*								SendInterruptPage;
-	VOID*								RecvInterruptPage;
+	void *								InterruptPage;
+	void *								SendInterruptPage;
+	void *								RecvInterruptPage;
 
 	// 2 pages - 1st page for parent->child notification and 2nd is child->parent notification
-	VOID*								MonitorPages;
+	void *								MonitorPages;
 	LIST_ENTRY							ChannelMsgList;
 	HANDLE								ChannelMsgLock;
 
@@ -138,12 +138,12 @@ GetChannelFromRelId(
 //
 static int
 VmbusConnect(
-	VOID
+	void
 	);
 
 static int
 VmbusDisconnect(
-	VOID
+	void
 	);
 
 static int
@@ -157,9 +157,9 @@ VmbusSetEvent(
 	UINT32 childRelId
 	);
 
-static VOID
+static void
 VmbusOnEvents(
-  VOID
+  void
 	);
