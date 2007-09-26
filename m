From: rusty@rustcorp.com.au
Subject: [patch 10/43] lguest: Make lguest_launcher.h types
	userspace-friendly
Date: Wed, 26 Sep 2007 16:36:28 +1000
Message-ID: <20070926063646.707821205@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=launcher-include-dir.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

lguest_launcher.h uses "u32" not "__u32", which sets a bad example.  Fix that,
and include <linux/types.h>.

This means we need to use -I on the Launcher build line so types.h is found.

(Note: the example launcher also includes asm/e820.h which uses u32/u64,
but at least this cleans up the lguest code).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 Documentation/lguest/Makefile   |    2 +-
 Documentation/lguest/lguest.c   |    4 ++--
 include/linux/lguest_launcher.h |   21 +++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

===================================================================
--- a/Documentation/lguest/Makefile
+++ b/Documentation/lguest/Makefile
@@ -11,7 +11,7 @@ include $(KBUILD_OUTPUT)/.config
 include $(KBUILD_OUTPUT)/.config
 LGUEST_GUEST_TOP := ($(CONFIG_PAGE_OFFSET) - 0x08000000)
 
-CFLAGS:=-Wall -Wmissing-declarations -Wmissing-prototypes -O3 -Wl,-T,lguest.lds
+CFLAGS:=-Wall -Wmissing-declarations -Wmissing-prototypes -O3 -I../../include -Wl,-T,lguest.lds
 LDLIBS:=-lz
 # Removing this works for some versions of ld.so (eg. Ubuntu Feisty) and
 # not others (eg. FC7).
===================================================================
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -45,8 +45,8 @@ typedef uint32_t u32;
 typedef uint32_t u32;
 typedef uint16_t u16;
 typedef uint8_t u8;
-#include "../../include/linux/lguest_launcher.h"
-#include "../../include/asm/e820.h"
+#include "linux/lguest_launcher.h"
+#include "asm/e820.h"
 /*:*/
 
 #define PAGE_PRESENT 0x7 	/* Present, RW, Execute */
===================================================================
--- a/include/linux/lguest_launcher.h
+++ b/include/linux/lguest_launcher.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_LGUEST_USER
 #define _ASM_LGUEST_USER
 /* Everything the "lguest" userspace program needs to know. */
+#include <linux/types.h>
 /* They can register up to 32 arrays of lguest_dma. */
 #define LGUEST_MAX_DMA		32
 /* At most we can dma 16 lguest_dma in one op. */
@@ -37,9 +38,9 @@ struct lguest_dma
 struct lguest_dma
 {
 	/* 0 if free to be used, filled by the Host. */
- 	u32 used_len;
+ 	__u32 used_len;
+	__u16 len[LGUEST_MAX_DMA_SECTIONS];
 	unsigned long addr[LGUEST_MAX_DMA_SECTIONS];
-	u16 len[LGUEST_MAX_DMA_SECTIONS];
 };
 /*:*/
 
@@ -52,11 +53,11 @@ struct lguest_block_page
 {
 	/* 0 is a read, 1 is a write. */
 	int type;
-	u32 sector; 	/* Offset in device = sector * 512. */
-	u32 bytes;	/* Length expected to be read/written in bytes */
+	__u32 sector; 	/* Offset in device = sector * 512. */
+	__u32 bytes;	/* Length expected to be read/written in bytes */
 	/* 0 = pending, 1 = done, 2 = done, error */
 	int result;
-	u32 num_sectors; /* Disk length = num_sectors * 512 */
+	__u32 num_sectors; /* Disk length = num_sectors * 512 */
 };
 
 /*D:520 The network device is basically a memory page where all the Guests on
@@ -86,21 +87,21 @@ struct lguest_net
  */
 struct lguest_device_desc {
 	/* The device type: console, network, disk etc. */
-	u16 type;
+	__u16 type;
 #define LGUEST_DEVICE_T_CONSOLE	1
 #define LGUEST_DEVICE_T_NET	2
 #define LGUEST_DEVICE_T_BLOCK	3
 
 	/* The specific features of this device: these depends on device type
 	 * except for LGUEST_DEVICE_F_RANDOMNESS. */
-	u16 features;
+	__u16 features;
 #define LGUEST_NET_F_NOCSUM		0x4000 /* Don't bother checksumming */
 #define LGUEST_DEVICE_F_RANDOMNESS	0x8000 /* IRQ is fairly random */
 
 	/* This is how the Guest reports status of the device: the Host can set
 	 * LGUEST_DEVICE_S_REMOVED to indicate removal, but the rest are only
 	 * ever manipulated by the Guest, and only ever set. */
-	u16 status;
+	__u16 status;
 /* 256 and above are device specific. */
 #define LGUEST_DEVICE_S_ACKNOWLEDGE	1 /* We have seen device. */
 #define LGUEST_DEVICE_S_DRIVER		2 /* We have found a driver */
@@ -111,8 +112,8 @@ struct lguest_device_desc {
 
 	/* Each device exists somewhere in Guest physical memory, over some
 	 * number of pages. */
-	u16 num_pages;
-	u32 pfn;
+	__u16 num_pages;
+	__u32 pfn;
 };
 /*:*/
 

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
