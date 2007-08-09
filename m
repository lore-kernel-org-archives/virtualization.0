From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/5 -v2] Change lguest launcher to use asm generic include
Date: Thu, 09 Aug 2007 00:36:28 -0400
Message-ID: <20070809044125.115351934__34531.6468076364$1186635090$gmane$org@goodmis.org>
References: <20070809043626.830486783@goodmis.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=0002-Change-lguest-launcher-to-use-asm-generic-include.txt
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, lguest <lguest@ozlabs.org>, Jes Sorensen <jes@sgi.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Have the lguest launcher include e820.h via asm/e820.h instead of explicitly
saying i386.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/lguest/lguest.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
index f791840..eb7a01c 100644
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
