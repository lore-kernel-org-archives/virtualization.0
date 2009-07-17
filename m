From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 33/54] Staging: hv: remove PAGE_SIZE and PAGE_SHIFT and
	__builtin functions
Date: Fri, 17 Jul 2009 11:09:23 -0700
Message-ID: <20090717180921.278799299@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-remove-page_size-and-page_shift-and-__builtin-functions.patch
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

The kernel provides all of this, and actually gets it correct, so don't
try to redefine these types of things.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/staging/hv/BlkVsc.c      |    1 +
 drivers/staging/hv/NetVsc.c      |    1 +
 drivers/staging/hv/RndisFilter.c |    1 +
 drivers/staging/hv/StorVsc.c     |    2 ++
 drivers/staging/hv/Vmbus.c       |    1 +
 drivers/staging/hv/include/osd.h |   28 ----------------------------
 6 files changed, 6 insertions(+), 28 deletions(-)

--- a/drivers/staging/hv/BlkVsc.c
+++ b/drivers/staging/hv/BlkVsc.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include "StorVsc.c"
 
 static const char* gBlkDriverName="blkvsc";
--- a/drivers/staging/hv/include/osd.h
+++ b/drivers/staging/hv/include/osd.h
@@ -29,34 +29,6 @@
 // Defines
 //
 
-#ifndef PAGE_SIZE
-#define PAGE_SIZE 0x1000
-#endif
-
-#ifndef PAGE_SHIFT
-#define PAGE_SHIFT 12
-#endif
-
-#ifndef memcpy
-#define memcpy		__builtin_memcpy
-#endif
-
-#ifndef memset
-#define memset		__builtin_memset
-#endif
-
-#ifndef memcmp
-#define memcmp		__builtin_memcmp
-#endif
-
-#ifndef strcpy
-#define strcpy		__builtin_strcpy
-#endif
-
-//
-//#ifndef sprintf
-//#define sprintf				__builtin_sprintf
-//#endif
 
 #define STRUCT_PACKED		__attribute__((__packed__))
 #define STRUCT_ALIGNED(x)	__attribute__((__aligned__(x)))
--- a/drivers/staging/hv/NetVsc.c
+++ b/drivers/staging/hv/NetVsc.c
@@ -23,6 +23,7 @@
 #define KERNEL_2_6_27
 
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include "include/logging.h"
 #include "NetVsc.h"
 #include "RndisFilter.h"
--- a/drivers/staging/hv/RndisFilter.c
+++ b/drivers/staging/hv/RndisFilter.c
@@ -24,6 +24,7 @@
 #define KERNEL_2_6_27
 
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include "include/logging.h"
 
 #include "include/NetVscApi.h"
--- a/drivers/staging/hv/StorVsc.c
+++ b/drivers/staging/hv/StorVsc.c
@@ -24,6 +24,8 @@
 #define KERNEL_2_6_27
 
 #include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/mm.h>
 #include "include/logging.h"
 
 #include "include/StorVscApi.h"
--- a/drivers/staging/hv/Vmbus.c
+++ b/drivers/staging/hv/Vmbus.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include "include/logging.h"
 #include "VersionInfo.h"
 #include "VmbusPrivate.h"
