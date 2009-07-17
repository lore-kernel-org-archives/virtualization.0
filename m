From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 25/54] Staging: hv: remove ULONGLONG and LONGLONG typedefs
Date: Fri, 17 Jul 2009 11:09:15 -0700
Message-ID: <20090717180919.937702806@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-remove-ulonglong-and-longlong-typedefs.patch
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

The ULONGLONG and LONGLONG typedefs are now removed from the Hyper-V
driver code.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/include/VmbusPacketFormat.h |    2 +-
 drivers/staging/hv/include/osd.h               |    3 ---
 drivers/staging/hv/include/vstorage.h          |    2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -97,15 +97,12 @@ typedef struct _DLIST_ENTRY {
 //
 // unsigned types
 //
-
-typedef unsigned long long	ULONGLONG;
 typedef unsigned int		ULONG;
 
 //
 // signed types
 //
 typedef int					LONG;
-typedef long long			LONGLONG;
 
 //
 // Other types
--- a/drivers/staging/hv/include/VmbusPacketFormat.h
+++ b/drivers/staging/hv/include/VmbusPacketFormat.h
@@ -44,7 +44,7 @@ typedef struct
             volatile u32  In;        // Offset in bytes from the ring base
             volatile u32  Out;       // Offset in bytes from the ring base
         };
-        volatile LONGLONG    InOut;
+        volatile long long InOut;
     };
 
     //
--- a/drivers/staging/hv/include/vstorage.h
+++ b/drivers/staging/hv/include/vstorage.h
@@ -196,7 +196,7 @@ typedef struct
     //  vendor specific data in the inquirydata
     //
 
-    ULONGLONG UniqueId;
+    unsigned long long UniqueId;
 
 } VMSTORAGE_CHANNEL_PROPERTIES, *PVMSTORAGE_CHANNEL_PROPERTIES;
