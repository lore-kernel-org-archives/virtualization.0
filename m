From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 38/54] Staging: hv: osd: remove MemAlloc wrapper
Date: Fri, 17 Jul 2009 11:09:28 -0700
Message-ID: <20090717180922.078820399@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-osd-remove-memalloc-wrapper.patch
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

Use the "real" kmalloc call instead of a wrapper function.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/Channel.c     |    9 +++------
 drivers/staging/hv/ChannelMgmt.c |    3 +--
 drivers/staging/hv/Hv.c          |    2 +-
 drivers/staging/hv/NetVsc.c      |    2 +-
 drivers/staging/hv/RndisFilter.c |    1 -
 drivers/staging/hv/include/osd.h |    1 -
 drivers/staging/hv/osd.c         |    5 -----
 7 files changed, 6 insertions(+), 17 deletions(-)

--- a/drivers/staging/hv/Channel.c
+++ b/drivers/staging/hv/Channel.c
@@ -260,8 +260,7 @@ VmbusChannelOpen(
 		SendRingBufferSize);
 
 	// Create and init the channel open message
-	openInfo =
-		(VMBUS_CHANNEL_MSGINFO*)MemAlloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_OPEN_CHANNEL));
+	openInfo = kmalloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_OPEN_CHANNEL), GFP_KERNEL);
 	ASSERT(openInfo != NULL);
 
 	openInfo->WaitEvent = WaitEventCreate();
@@ -630,8 +629,7 @@ VmbusChannelTeardownGpadl(
 
 	ASSERT(GpadlHandle != 0);
 
-	info =
-		(VMBUS_CHANNEL_MSGINFO*)MemAlloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_GPADL_TEARDOWN));
+	info = kmalloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_GPADL_TEARDOWN), GFP_KERNEL);
 	ASSERT(info != NULL);
 
 	info->WaitEvent = WaitEventCreate();
@@ -693,8 +691,7 @@ VmbusChannelClose(
 	TimerStop(Channel->PollTimer);
 
 	// Send a closing message
-	info =
-		(VMBUS_CHANNEL_MSGINFO*)MemAlloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_CLOSE_CHANNEL));
+	info = kmalloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_CLOSE_CHANNEL), GFP_KERNEL);
 	ASSERT(info != NULL);
 
 	//info->waitEvent = WaitEventCreate();
--- a/drivers/staging/hv/ChannelMgmt.c
+++ b/drivers/staging/hv/ChannelMgmt.c
@@ -731,8 +731,7 @@ VmbusChannelRequestOffers(
 
 	DPRINT_ENTER(VMBUS);
 
-	msgInfo =
-		(VMBUS_CHANNEL_MSGINFO*)MemAlloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_MESSAGE_HEADER));
+	msgInfo = kmalloc(sizeof(VMBUS_CHANNEL_MSGINFO) + sizeof(VMBUS_CHANNEL_MESSAGE_HEADER), GFP_KERNEL);
 	ASSERT(msgInfo != NULL);
 
 	msgInfo->WaitEvent = WaitEventCreate();
--- a/drivers/staging/hv/Hv.c
+++ b/drivers/staging/hv/Hv.c
@@ -305,7 +305,7 @@ HvInit (
                (unsigned long)hypercallMsr.GuestPhysicalAddress << PAGE_SHIFT);
 
 	// Setup the global signal event param for the signal event hypercall
-	gHvContext.SignalEventBuffer = MemAlloc(sizeof(HV_INPUT_SIGNAL_EVENT_BUFFER));
+	gHvContext.SignalEventBuffer = kmalloc(sizeof(HV_INPUT_SIGNAL_EVENT_BUFFER), GFP_KERNEL);
 	if (!gHvContext.SignalEventBuffer)
 	{
 		goto Cleanup;
--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -121,7 +121,6 @@ extern void PageFree(void* page, unsigne
 extern void* MemMapIO(unsigned long phys, unsigned long size);
 extern void MemUnmapIO(void* virt);
 
-extern void* MemAlloc(unsigned int size);
 extern void* MemAllocZeroed(unsigned int size);
 extern void* MemAllocAtomic(unsigned int size);
 extern void MemFree(void* buf);
--- a/drivers/staging/hv/NetVsc.c
+++ b/drivers/staging/hv/NetVsc.c
@@ -361,7 +361,7 @@ NetVscInitializeReceiveBufferWithNetVsp(
 
 	netDevice->ReceiveSectionCount = initPacket->Messages.Version1Messages.SendReceiveBufferComplete.NumSections;
 
-	netDevice->ReceiveSections = MemAlloc(netDevice->ReceiveSectionCount * sizeof(NVSP_1_RECEIVE_BUFFER_SECTION));
+	netDevice->ReceiveSections = kmalloc(netDevice->ReceiveSectionCount * sizeof(NVSP_1_RECEIVE_BUFFER_SECTION), GFP_KERNEL);
 	if (netDevice->ReceiveSections == NULL)
 	{
 		ret = -1;
--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -189,11 +189,6 @@ void PageUnmapVirtualAddress(void* VirtA
 	kunmap_atomic(VirtAddr, KM_IRQ0);
 }
 
-void* MemAlloc(unsigned int size)
-{
-	return kmalloc(size, GFP_KERNEL);
-}
-
 void* MemAllocZeroed(unsigned int size)
 {
 	void *p = kmalloc(size, GFP_KERNEL);
--- a/drivers/staging/hv/RndisFilter.c
+++ b/drivers/staging/hv/RndisFilter.c
@@ -943,7 +943,6 @@ RndisFilterOnDeviceAdd(
 
 	DPRINT_ENTER(NETVSC);
 
-	//rndisDevice = MemAlloc(sizeof(RNDIS_DEVICE));
 	rndisDevice = GetRndisDevice();
 	if (!rndisDevice)
 	{
