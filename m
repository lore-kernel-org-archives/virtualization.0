From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 47/54] Staging: hv: make gVmbusConnection.ChannelLock a real
	spinlock
Date: Fri, 17 Jul 2009 11:09:37 -0700
Message-ID: <20090717180923.620590305@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-make-gvmbusconnection.channellock-a-real-spinlock.patch
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
 drivers/staging/hv/Channel.c      |    5 +++--
 drivers/staging/hv/ChannelMgmt.c  |   14 ++++++++------
 drivers/staging/hv/Connection.c   |    8 ++++----
 drivers/staging/hv/VmbusPrivate.h |    2 +-
 4 files changed, 16 insertions(+), 13 deletions(-)

--- a/drivers/staging/hv/Channel.c
+++ b/drivers/staging/hv/Channel.c
@@ -686,6 +686,7 @@ VmbusChannelClose(
 	int ret=0;
 	VMBUS_CHANNEL_CLOSE_CHANNEL* msg;
 	VMBUS_CHANNEL_MSGINFO* info;
+	unsigned long flags;
 
 	DPRINT_ENTER(VMBUS);
 
@@ -729,9 +730,9 @@ VmbusChannelClose(
 	// since the caller will free the channel
 	if (Channel->State == CHANNEL_OPEN_STATE)
 	{
-		SpinlockAcquire(gVmbusConnection.ChannelLock);
+		spin_lock_irqsave(&gVmbusConnection.channel_lock, flags);
 		REMOVE_ENTRY_LIST(&Channel->ListEntry);
-		SpinlockRelease(gVmbusConnection.ChannelLock);
+		spin_unlock_irqrestore(&gVmbusConnection.channel_lock, flags);
 
 		FreeVmbusChannel(Channel);
 	}
--- a/drivers/staging/hv/ChannelMgmt.c
+++ b/drivers/staging/hv/ChannelMgmt.c
@@ -233,11 +233,12 @@ VmbusChannelProcessOffer(
 	LIST_ENTRY* curr;
 	bool fNew = true;
 	VMBUS_CHANNEL* channel;
+	unsigned long flags;
 
 	DPRINT_ENTER(VMBUS);
 
 	// Make sure this is a new offer
-	SpinlockAcquire(gVmbusConnection.ChannelLock);
+	spin_lock_irqsave(&gVmbusConnection.channel_lock, flags);
 
 	ITERATE_LIST_ENTRIES(anchor, curr, &gVmbusConnection.ChannelList)
 	{
@@ -255,7 +256,7 @@ VmbusChannelProcessOffer(
 	{
 		INSERT_TAIL_LIST(&gVmbusConnection.ChannelList, &newChannel->ListEntry);
 	}
-	SpinlockRelease(gVmbusConnection.ChannelLock);
+	spin_unlock_irqrestore(&gVmbusConnection.channel_lock, flags);
 
 	if (!fNew)
 	{
@@ -282,9 +283,9 @@ VmbusChannelProcessOffer(
 		DPRINT_ERR(VMBUS, "unable to add child device object (relid %d)",
 			newChannel->OfferMsg.ChildRelId);
 
-		SpinlockAcquire(gVmbusConnection.ChannelLock);
+		spin_lock_irqsave(&gVmbusConnection.channel_lock, flags);
 		REMOVE_ENTRY_LIST(&newChannel->ListEntry);
-		SpinlockRelease(gVmbusConnection.ChannelLock);
+		spin_unlock_irqrestore(&gVmbusConnection.channel_lock, flags);
 
 		FreeVmbusChannel(newChannel);
 	}
@@ -785,8 +786,9 @@ VmbusChannelReleaseUnattachedChannels(
 	LIST_ENTRY *entry;
 	VMBUS_CHANNEL *channel;
 	VMBUS_CHANNEL *start=NULL;
+	unsigned long flags;
 
-	SpinlockAcquire(gVmbusConnection.ChannelLock);
+	spin_lock_irqsave(&gVmbusConnection.channel_lock, flags);
 
 	while (!IsListEmpty(&gVmbusConnection.ChannelList))
 	{
@@ -813,7 +815,7 @@ VmbusChannelReleaseUnattachedChannels(
 		}
 	}
 
-	SpinlockRelease(gVmbusConnection.ChannelLock);
+	spin_unlock_irqrestore(&gVmbusConnection.channel_lock, flags);
 }
 
 // eof
--- a/drivers/staging/hv/Connection.c
+++ b/drivers/staging/hv/Connection.c
@@ -69,7 +69,7 @@ VmbusConnect(
 	spin_lock_init(&gVmbusConnection.channelmsg_lock);
 
 	INITIALIZE_LIST_HEAD(&gVmbusConnection.ChannelList);
-	gVmbusConnection.ChannelLock = SpinlockCreate();
+	spin_lock_init(&gVmbusConnection.channel_lock);
 
 	// Setup the vmbus event connection for channel interrupt abstraction stuff
 	gVmbusConnection.InterruptPage = PageAlloc(1);
@@ -156,7 +156,6 @@ Cleanup:
 	gVmbusConnection.ConnectState = Disconnected;
 
 	WorkQueueClose(gVmbusConnection.WorkQueue);
-	SpinlockClose(gVmbusConnection.ChannelLock);
 
 	if (gVmbusConnection.InterruptPage)
 	{
@@ -258,8 +257,9 @@ GetChannelFromRelId(
 	VMBUS_CHANNEL* foundChannel=NULL;
 	LIST_ENTRY* anchor;
 	LIST_ENTRY* curr;
+	unsigned long flags;
 
-	SpinlockAcquire(gVmbusConnection.ChannelLock);
+	spin_lock_irqsave(&gVmbusConnection.channel_lock, flags);
 	ITERATE_LIST_ENTRIES(anchor, curr, &gVmbusConnection.ChannelList)
 	{
 		channel = CONTAINING_RECORD(curr, VMBUS_CHANNEL, ListEntry);
@@ -270,7 +270,7 @@ GetChannelFromRelId(
 			break;
 		}
 	}
-	SpinlockRelease(gVmbusConnection.ChannelLock);
+	spin_unlock_irqrestore(&gVmbusConnection.channel_lock, flags);
 
 	return foundChannel;
 }
--- a/drivers/staging/hv/VmbusPrivate.h
+++ b/drivers/staging/hv/VmbusPrivate.h
@@ -84,7 +84,7 @@ typedef struct _VMBUS_CONNECTION {
 
 	// List of channels
 	LIST_ENTRY							ChannelList;
-	HANDLE								ChannelLock;
+	spinlock_t channel_lock;
 
 	HANDLE								WorkQueue;
 } VMBUS_CONNECTION;
