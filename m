From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 30/54] Staging: hv: remove BOOL and BOOLEAN typedefs
Date: Fri, 17 Jul 2009 11:09:20 -0700
Message-ID: <20090717180920.806261936@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-remove-bool-and-boolean-typedefs.patch
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
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

The BOOL and BOOLEAN typedefs are now removed from the Hyper-V driver
code.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/ChannelMgmt.c               |    2 +-
 drivers/staging/hv/Hv.h                        |    2 +-
 drivers/staging/hv/NetVsc.c                    |    2 +-
 drivers/staging/hv/RndisFilter.c               |    2 +-
 drivers/staging/hv/include/ChannelMessages.h   |    6 +++---
 drivers/staging/hv/include/List.h              |    2 +-
 drivers/staging/hv/include/NetVscApi.h         |    4 ++--
 drivers/staging/hv/include/VmbusPacketFormat.h |    2 +-
 drivers/staging/hv/include/osd.h               |    2 --
 9 files changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/staging/hv/ChannelMgmt.c
+++ b/drivers/staging/hv/ChannelMgmt.c
@@ -240,7 +240,7 @@ VmbusChannelProcessOffer(
 	VMBUS_CHANNEL* newChannel=(VMBUS_CHANNEL*)context;
 	LIST_ENTRY* anchor;
 	LIST_ENTRY* curr;
-	BOOL fNew=TRUE;
+	bool fNew=TRUE;
 	VMBUS_CHANNEL* channel;
 
 	DPRINT_ENTER(VMBUS);
--- a/drivers/staging/hv/Hv.h
+++ b/drivers/staging/hv/Hv.h
@@ -113,7 +113,7 @@ typedef struct {
 	u64	GuestId;			// XenLinux or native Linux. If XenLinux, the hypercall and synic pages has already been initialized
 	void*	HypercallPage;
 
-	BOOL	SynICInitialized;
+	bool	SynICInitialized;
 	// This is used as an input param to HvCallSignalEvent hypercall. The input param is immutable
 	// in our usage and must be dynamic mem (vs stack or global).
 	HV_INPUT_SIGNAL_EVENT_BUFFER *SignalEventBuffer;
--- a/drivers/staging/hv/include/ChannelMessages.h
+++ b/drivers/staging/hv/include/ChannelMessages.h
@@ -82,7 +82,7 @@ typedef struct _VMBUS_CHANNEL_QUERY_VMBU
 typedef struct _VMBUS_CHANNEL_VERSION_SUPPORTED
 {
     VMBUS_CHANNEL_MESSAGE_HEADER Header;
-    BOOLEAN VersionSupported;
+    bool VersionSupported;
 } VMBUS_CHANNEL_VERSION_SUPPORTED, *PVMBUS_CHANNEL_VERSION_SUPPORTED;
 
 // Offer Channel parameters
@@ -92,7 +92,7 @@ typedef struct _VMBUS_CHANNEL_OFFER_CHAN
     VMBUS_CHANNEL_OFFER Offer;
     u32  ChildRelId;
     u8   MonitorId;
-    BOOLEAN MonitorAllocated;
+    bool MonitorAllocated;
 } VMBUS_CHANNEL_OFFER_CHANNEL, *PVMBUS_CHANNEL_OFFER_CHANNEL;
 
 //
@@ -264,7 +264,7 @@ typedef struct _VMBUS_CHANNEL_INITIATE_C
 typedef struct _VMBUS_CHANNEL_VERSION_RESPONSE
 {
     VMBUS_CHANNEL_MESSAGE_HEADER Header;
-    BOOLEAN     VersionSupported;
+    bool     VersionSupported;
 } VMBUS_CHANNEL_VERSION_RESPONSE, *PVMBUS_CHANNEL_VERSION_RESPONSE;
 
 typedef VMBUS_CHANNEL_MESSAGE_HEADER VMBUS_CHANNEL_UNLOAD, *PVMBUS_CHANNEL_UNLOAD;
--- a/drivers/staging/hv/include/List.h
+++ b/drivers/staging/hv/include/List.h
@@ -56,7 +56,7 @@ typedef DLIST_ENTRY *PLIST_ENTRY;
 
 
 /*
- *  BOOLEAN
+ *  bool
  *  IsListEmpty(
  *      PLIST_ENTRY ListHead
  *      );
--- a/drivers/staging/hv/include/NetVscApi.h
+++ b/drivers/staging/hv/include/NetVscApi.h
@@ -72,7 +72,7 @@ typedef struct _NETVSC_PACKET {
 	DLIST_ENTRY				ListEntry;
 
 	DEVICE_OBJECT			*Device;
-	BOOL					IsDataPacket;
+	bool					IsDataPacket;
 
 	// Valid only for receives when we break a xfer page packet into multiple netvsc packets
 	XFERPAGE_PACKET		*XferPagePacket;
@@ -131,7 +131,7 @@ typedef struct _NETVSC_DRIVER_OBJECT {
 
 typedef struct _NETVSC_DEVICE_INFO {
     unsigned char	MacAddr[6];
-    BOOL	LinkState;	// 0 - link up, 1 - link down
+    bool	LinkState;	// 0 - link up, 1 - link down
 } NETVSC_DEVICE_INFO;
 
 //
--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -98,8 +98,6 @@ typedef struct _DLIST_ENTRY {
 // Other types
 //
 //typedef unsigned char		GUID[16];
-typedef unsigned char		BOOL;
-typedef unsigned char		BOOLEAN;
 typedef void*				HANDLE;
 
 typedef struct {
--- a/drivers/staging/hv/include/VmbusPacketFormat.h
+++ b/drivers/staging/hv/include/VmbusPacketFormat.h
@@ -113,7 +113,7 @@ typedef struct VMTRANSFER_PAGE_PACKET_HE
 #endif
 
     u16                  TransferPageSetId;
-    BOOLEAN                 SenderOwnsSet;
+    bool                 SenderOwnsSet;
     u8                   Reserved;
     u32                  RangeCount;
     VMTRANSFER_PAGE_RANGE   Ranges[1];
--- a/drivers/staging/hv/NetVsc.c
+++ b/drivers/staging/hv/NetVsc.c
@@ -1344,7 +1344,7 @@ NetVscOnReceiveCompletion(
 	DEVICE_OBJECT *device = (DEVICE_OBJECT*)packet->Device;
 	NETVSC_DEVICE* netDevice;
 	u64	transactionId=0;
-	BOOL fSendReceiveComp = FALSE;
+	bool fSendReceiveComp = FALSE;
 
 	DPRINT_ENTER(NETVSC);
 
--- a/drivers/staging/hv/RndisFilter.c
+++ b/drivers/staging/hv/RndisFilter.c
@@ -383,7 +383,7 @@ RndisFilterReceiveResponse(
 	LIST_ENTRY *anchor;
 	LIST_ENTRY *curr;
 	RNDIS_REQUEST *request=NULL;
-	BOOL found=FALSE;
+	bool found=FALSE;
 
 	DPRINT_ENTER(NETVSC);
