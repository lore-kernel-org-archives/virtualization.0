From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 39/54] Staging: hv: osd: remove MemAllocZeroed wrapper
Date: Fri, 17 Jul 2009 11:09:29 -0700
Message-ID: <20090717180922.259556004@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-osd-remove-memalloczeroed-wrapper.patch
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

Use the "real" kzalloc call instead of a wrapper function.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/Channel.c     |    8 ++++----
 drivers/staging/hv/Connection.c  |    4 ++--
 drivers/staging/hv/NetVsc.c      |    4 ++--
 drivers/staging/hv/RndisFilter.c |    4 ++--
 drivers/staging/hv/StorVsc.c     |    2 +-
 drivers/staging/hv/include/osd.h |    1 -
 drivers/staging/hv/osd.c         |    7 -------
 7 files changed, 11 insertions(+), 19 deletions(-)

--- a/drivers/staging/hv/Channel.c
+++ b/drivers/staging/hv/Channel.c
@@ -226,7 +226,7 @@ VmbusChannelOpen(
 
 	// Allocate the ring buffer
 	out = PageAlloc((SendRingBufferSize + RecvRingBufferSize) >> PAGE_SHIFT);
-	//out = MemAllocZeroed(sendRingBufferSize + recvRingBufferSize);
+	//out = kzalloc(sendRingBufferSize + recvRingBufferSize, GFP_KERNEL);
 	ASSERT(out);
 	ASSERT(((unsigned long)out & (PAGE_SIZE-1)) == 0);
 
@@ -421,7 +421,7 @@ VmbusChannelCreateGpadlHeader(
 	{
 		// fill in the header
 		msgSize = sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_GPADL_HEADER) + sizeof(GPA_RANGE) + pfnCount*sizeof(u64);
-		msgHeader =  MemAllocZeroed(msgSize);
+		msgHeader =  kzalloc(msgSize, GFP_KERNEL);
 
 		INITIALIZE_LIST_HEAD(&msgHeader->SubMsgList);
 		msgHeader->MessageSize=msgSize;
@@ -458,7 +458,7 @@ VmbusChannelCreateGpadlHeader(
 			}
 
 			msgSize = sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_GPADL_BODY) + pfnCurr*sizeof(u64);
-			msgBody =  MemAllocZeroed(msgSize);
+			msgBody = kzalloc(msgSize, GFP_KERNEL);
 			ASSERT(msgBody);
 			msgBody->MessageSize = msgSize;
 			(*MessageCount)++;
@@ -481,7 +481,7 @@ VmbusChannelCreateGpadlHeader(
 	{
 		// everything fits in a header
 		msgSize = sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_GPADL_HEADER) + sizeof(GPA_RANGE) + pageCount*sizeof(u64);
-		msgHeader =  MemAllocZeroed(msgSize);
+		msgHeader = kzalloc(msgSize, GFP_KERNEL);
 		msgHeader->MessageSize=msgSize;
 
 		gpaHeader = (VMBUS_CHANNEL_GPADL_HEADER*)msgHeader->Msg;
--- a/drivers/staging/hv/Connection.c
+++ b/drivers/staging/hv/Connection.c
@@ -89,7 +89,7 @@ VmbusConnect(
 		goto Cleanup;
 	}
 
-	msgInfo = (VMBUS_CHANNEL_MSGINFO*)MemAllocZeroed(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_INITIATE_CONTACT));
+	msgInfo = kzalloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_INITIATE_CONTACT), GFP_KERNEL);
 	if (msgInfo == NULL)
 	{
 		ret = -1;
@@ -207,7 +207,7 @@ VmbusDisconnect(
 	if (gVmbusConnection.ConnectState != Connected)
 		return -1;
 
-	msg = MemAllocZeroed(sizeof(VMBUS_CHANNEL_UNLOAD));
+	msg = kzalloc(sizeof(VMBUS_CHANNEL_UNLOAD), GFP_KERNEL);
 
 	msg->MessageType = ChannelMessageUnload;
 
--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -121,7 +121,6 @@ extern void PageFree(void* page, unsigne
 extern void* MemMapIO(unsigned long phys, unsigned long size);
 extern void MemUnmapIO(void* virt);
 
-extern void* MemAllocZeroed(unsigned int size);
 extern void* MemAllocAtomic(unsigned int size);
 extern void MemFree(void* buf);
 extern void MemoryFence(void);
--- a/drivers/staging/hv/NetVsc.c
+++ b/drivers/staging/hv/NetVsc.c
@@ -122,7 +122,7 @@ static inline NETVSC_DEVICE* AllocNetDev
 {
 	NETVSC_DEVICE *netDevice;
 
-	netDevice = MemAllocZeroed(sizeof(NETVSC_DEVICE));
+	netDevice = kzalloc(sizeof(NETVSC_DEVICE), GFP_KERNEL);
 	if (!netDevice)
 		return NULL;
 
@@ -815,7 +815,7 @@ NetVscOnDeviceAdd(
 
 	for (i=0; i < NETVSC_RECEIVE_PACKETLIST_COUNT; i++)
 	{
-		packet = MemAllocZeroed(sizeof(NETVSC_PACKET) + (NETVSC_RECEIVE_SG_COUNT* sizeof(PAGE_BUFFER)));
+		packet = kzalloc(sizeof(NETVSC_PACKET) + (NETVSC_RECEIVE_SG_COUNT* sizeof(PAGE_BUFFER)), GFP_KERNEL);
 		if (!packet)
 		{
 			DPRINT_DBG(NETVSC, "unable to allocate netvsc pkts for receive pool (wanted %d got %d)", NETVSC_RECEIVE_PACKETLIST_COUNT, i);
--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -189,13 +189,6 @@ void PageUnmapVirtualAddress(void* VirtA
 	kunmap_atomic(VirtAddr, KM_IRQ0);
 }
 
-void* MemAllocZeroed(unsigned int size)
-{
-	void *p = kmalloc(size, GFP_KERNEL);
-	if (p) memset(p, 0, size);
-	return p;
-}
-
 void* MemAllocAtomic(unsigned int size)
 {
 	return kmalloc(size, GFP_ATOMIC);
--- a/drivers/staging/hv/RndisFilter.c
+++ b/drivers/staging/hv/RndisFilter.c
@@ -210,7 +210,7 @@ static inline RNDIS_DEVICE* GetRndisDevi
 {
 	RNDIS_DEVICE *device;
 
-	device = MemAllocZeroed(sizeof(RNDIS_DEVICE));
+	device = kzalloc(sizeof(RNDIS_DEVICE), GFP_KERNEL);
 	if (!device)
 	{
 		return NULL;
@@ -242,7 +242,7 @@ static inline RNDIS_REQUEST* GetRndisReq
 	RNDIS_MESSAGE *rndisMessage;
 	RNDIS_SET_REQUEST *set;
 
-	request = MemAllocZeroed(sizeof(RNDIS_REQUEST));
+	request = kzalloc(sizeof(RNDIS_REQUEST), GFP_KERNEL);
 	if (!request)
 	{
 		return NULL;
--- a/drivers/staging/hv/StorVsc.c
+++ b/drivers/staging/hv/StorVsc.c
@@ -147,7 +147,7 @@ static inline STORVSC_DEVICE* AllocStorD
 {
 	STORVSC_DEVICE *storDevice;
 
-	storDevice = MemAllocZeroed(sizeof(STORVSC_DEVICE));
+	storDevice = kzalloc(sizeof(STORVSC_DEVICE), GFP_KERNEL);
 	if (!storDevice)
 		return NULL;
