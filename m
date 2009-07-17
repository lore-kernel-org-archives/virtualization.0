From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 24/54] Staging: hv: remove USHORT typedef
Date: Fri, 17 Jul 2009 11:09:14 -0700
Message-ID: <20090717180919.766835141@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=staging-hv-remove-ushort-typedef.patch
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

The USHORT typedef is now removed from the Hyper-V driver code.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/include/osd.h      |    1 -
 drivers/staging/hv/include/vstorage.h |    8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -100,7 +100,6 @@ typedef struct _DLIST_ENTRY {
 
 typedef unsigned long long	ULONGLONG;
 typedef unsigned int		ULONG;
-typedef unsigned short		USHORT;
 
 //
 // signed types
--- a/drivers/staging/hv/include/vstorage.h
+++ b/drivers/staging/hv/include/vstorage.h
@@ -141,7 +141,7 @@ C_ASSERT(SENSE_BUFFER_SIZE == 0x12);
 
 typedef struct
 {
-    USHORT Length;
+    unsigned short Length;
     unsigned char SrbStatus;
     unsigned char ScsiStatus;
 
@@ -178,7 +178,7 @@ C_ASSERT((sizeof(VMSCSI_REQUEST) % 4) ==
 
 typedef struct
 {
-    USHORT ProtocolVersion;
+    unsigned short ProtocolVersion;
     unsigned char  PathId;
     unsigned char  TargetId;
 
@@ -213,7 +213,7 @@ typedef struct
     // Major (MSW) and minor (LSW) version numbers.
     //
 
-    USHORT MajorMinor;
+    unsigned short MajorMinor;
 
 
     //
@@ -222,7 +222,7 @@ typedef struct
     // indicate incompatibility--but it does indicate mismatched builds.
     //
 
-    USHORT Revision;
+    unsigned short Revision;
 
 } VMSTORAGE_PROTOCOL_VERSION, *PVMSTORAGE_PROTOCOL_VERSION;
