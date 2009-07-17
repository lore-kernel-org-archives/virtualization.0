From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 40/54] Staging: hv: osd: remove MemAllocAtomic wrapper
Date: Fri, 17 Jul 2009 11:09:30 -0700
Message-ID: <20090717180922.419965495@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-osd-remove-memallocatomic-wrapper.patch
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
 drivers/staging/hv/ChannelMgmt.c |    3 +--
 drivers/staging/hv/Hv.c          |    2 +-
 drivers/staging/hv/NetVsc.c      |    2 +-
 drivers/staging/hv/Vmbus.c       |    2 +-
 drivers/staging/hv/include/osd.h |    1 -
 drivers/staging/hv/osd.c         |    5 -----
 6 files changed, 4 insertions(+), 11 deletions(-)

--- a/drivers/staging/hv/ChannelMgmt.c
+++ b/drivers/staging/hv/ChannelMgmt.c
@@ -143,13 +143,12 @@ VMBUS_CHANNEL* AllocVmbusChannel(void)
 {
 	VMBUS_CHANNEL* channel;
 
-	channel = (VMBUS_CHANNEL*) MemAllocAtomic(sizeof(VMBUS_CHANNEL));
+	channel = kzalloc(sizeof(VMBUS_CHANNEL), GFP_ATOMIC);
 	if (!channel)
 	{
 		return NULL;
 	}
 
-	memset(channel, 0,sizeof(VMBUS_CHANNEL));
 	channel->InboundLock = SpinlockCreate();
 	if (!channel->InboundLock)
 	{
--- a/drivers/staging/hv/Hv.c
+++ b/drivers/staging/hv/Hv.c
@@ -414,7 +414,7 @@ HvPostMessage(
 		return -1;
 	}
 
-	addr = (unsigned long)MemAllocAtomic(sizeof(struct alignedInput));
+	addr = (unsigned long)kmalloc(sizeof(struct alignedInput), GFP_ATOMIC);
 
 	if (!addr)
 	{
--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -121,7 +121,6 @@ extern void PageFree(void* page, unsigne
 extern void* MemMapIO(unsigned long phys, unsigned long size);
 extern void MemUnmapIO(void* virt);
 
-extern void* MemAllocAtomic(unsigned int size);
 extern void MemFree(void* buf);
 extern void MemoryFence(void);
 
--- a/drivers/staging/hv/NetVsc.c
+++ b/drivers/staging/hv/NetVsc.c
@@ -1480,7 +1480,7 @@ NetVscOnChannelCallback(
 		}
 		else if (ret == -2) // Handle large packet
 		{
-			buffer = MemAllocAtomic(bytesRecvd);
+			buffer = kmalloc(bytesRecvd, GFP_ATOMIC);
 			if (buffer == NULL)
 			{
 				// Try again next time around
--- a/drivers/staging/hv/osd.c
+++ b/drivers/staging/hv/osd.c
@@ -189,11 +189,6 @@ void PageUnmapVirtualAddress(void* VirtA
 	kunmap_atomic(VirtAddr, KM_IRQ0);
 }
 
-void* MemAllocAtomic(unsigned int size)
-{
-	return kmalloc(size, GFP_ATOMIC);
-}
-
 void MemFree(void* buf)
 {
 	kfree(buf);
--- a/drivers/staging/hv/Vmbus.c
+++ b/drivers/staging/hv/Vmbus.c
@@ -411,7 +411,7 @@ VmbusOnMsgDPC(
 		}
 		else
 		{
-			copied = MemAllocAtomic(sizeof(HV_MESSAGE));
+			copied = kmalloc(sizeof(HV_MESSAGE), GFP_ATOMIC);
 			if (copied == NULL)
 			{
 				continue;
