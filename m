From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 27/54] Staging: hv: remove ULONG and LONG typedefs
Date: Fri, 17 Jul 2009 11:09:17 -0700
Message-ID: <20090717180920.285605541@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-remove-ulong-and-long-typedefs.patch
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

The ULONG and LONG typedefs are now removed from the Hyper-V driver
code.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/StorVsc.c            |    2 +-
 drivers/staging/hv/include/StorVscApi.h |    2 +-
 drivers/staging/hv/include/osd.h        |   10 ----------
 drivers/staging/hv/include/vstorage.h   |   12 ++++++------
 4 files changed, 8 insertions(+), 18 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -95,16 +95,6 @@ typedef struct _DLIST_ENTRY {
 } DLIST_ENTRY;
 
 //
-// unsigned types
-//
-typedef unsigned int		ULONG;
-
-//
-// signed types
-//
-typedef int					LONG;
-
-//
 // Other types
 //
 typedef unsigned long		SIZE_T;
--- a/drivers/staging/hv/include/StorVscApi.h
+++ b/drivers/staging/hv/include/StorVscApi.h
@@ -117,7 +117,7 @@ typedef struct _STORVSC_DRIVER_OBJECT {
 } STORVSC_DRIVER_OBJECT;
 
 typedef struct _STORVSC_DEVICE_INFO {
-	ULONG	PortNumber;
+	unsigned long	PortNumber;
     unsigned char	PathId;
     unsigned char	TargetId;
 } STORVSC_DEVICE_INFO;
--- a/drivers/staging/hv/include/vstorage.h
+++ b/drivers/staging/hv/include/vstorage.h
@@ -155,7 +155,7 @@ typedef struct
     unsigned char DataIn;
     unsigned char Reserved;
 
-    ULONG DataTransferLength;
+    unsigned long DataTransferLength;
 
     union
     {
@@ -185,11 +185,11 @@ typedef struct
     //
     // Note: port number is only really known on the client side
     //
-    ULONG  PortNumber;
+    unsigned long  PortNumber;
 
-    ULONG  Flags;
+    unsigned long  Flags;
 
-    ULONG  MaxTransferBytes;
+    unsigned long  MaxTransferBytes;
 
     //
     //  This id is unique for each channel and will correspond with
@@ -249,13 +249,13 @@ typedef struct _VSTOR_PACKET
     //  Flags - see below for values
     //
 
-    ULONG     Flags;
+    unsigned long     Flags;
 
     //
     // Status of the request returned from the server side.
     //
 
-    ULONG     Status;
+    unsigned long     Status;
 
     //
     // Data payload area
--- a/drivers/staging/hv/StorVsc.c
+++ b/drivers/staging/hv/StorVsc.c
@@ -62,7 +62,7 @@ typedef struct _STORVSC_DEVICE{
 
 	//  Each unique Port/Path/Target represents 1 channel ie scsi controller. In reality, the pathid, targetid is always 0
 	// and the port is set by us
-	ULONG						PortNumber;
+	unsigned long						PortNumber;
     unsigned char						PathId;
     unsigned char						TargetId;
