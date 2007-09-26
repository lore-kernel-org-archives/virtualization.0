From: rusty@rustcorp.com.au
Subject: [patch 05/43] lguest: Example launcher should include asm/e820.h
	instead of asm-i386/
Date: Wed, 26 Sep 2007 16:36:23 +1000
Message-ID: <20070926063645.813160821@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=launcher-use-asm-include-instead-of-asm-i386.patch
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

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/lguest/lguest.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

===================================================================
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -46,7 +46,7 @@ typedef uint32_t u32;
 typedef uint16_t u16;
 typedef uint8_t u8;
 #include "../../include/linux/lguest_launcher.h"
-#include "../../include/asm-i386/e820.h"
+#include "../../include/asm/e820.h"
 /*:*/
 
 #define PAGE_PRESENT 0x7 	/* Present, RW, Execute */
-- 
1.4.4.4

-- 

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
