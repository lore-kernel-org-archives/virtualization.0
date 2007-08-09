From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4/7] Moved the io struct up to the generic lg.h
Date: Wed, 08 Aug 2007 20:32:15 -0400
Message-ID: <20070809003343.664528532__16561.9629472078$1186620283$gmane$org@goodmis.org>
References: <20070809003211.373543702@goodmis.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=0004-Moved-the-io-struct-up-to-the-generic-lg.h-file.-Also-added-a-proper-ifdef.txt
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

Move the io struct into the lg.h file since the io.c is generic to other
architectures.

Also added a proper ifdef for the generic lg.h.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/lguest/i386/lg.h |   11 ++---------
 drivers/lguest/lg.h      |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/lguest/i386/lg.h b/drivers/lguest/i386/lg.h
index 64f0abe..c5ea14c 100644
--- a/drivers/lguest/i386/lg.h
+++ b/drivers/lguest/i386/lg.h
@@ -20,6 +20,8 @@
 #include <linux/err.h>
 #include <asm/semaphore.h>
 #include "irq_vectors.h"
+/* some files include this, some include the parent */
+#include "../lg.h"
 
 #define GUEST_PL 1
 
@@ -245,15 +247,6 @@ void pin_page(struct lguest *lg, unsigned long vaddr);
 int lguest_device_init(void);
 void lguest_device_remove(void);
 
-/* io.c: */
-void lguest_io_init(void);
-int bind_dma(struct lguest *lg,
-	     unsigned long key, unsigned long udma, u16 numdmas, u8 interrupt);
-void send_dma(struct lguest *info, unsigned long key, unsigned long udma);
-void release_all_dma(struct lguest *lg);
-unsigned long get_dma_buffer(struct lguest *lg, unsigned long key,
-			     unsigned long *interrupt);
-
 /* hypercalls.c: */
 void do_hypercalls(struct lguest *lg);
 void write_timestamp(struct lguest *lg);
diff --git a/drivers/lguest/lg.h b/drivers/lguest/lg.h
index 4c4356e..3147bf6 100644
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -1,3 +1,19 @@
+#ifndef _LGUEST_LG_GENERIC
+#define _LGUEST_LG_GENERIC
+
+struct lguest;
+
+/* io.c: */
+void lguest_io_init(void);
+int bind_dma(struct lguest *lg,
+	     unsigned long key, unsigned long udma, u16 numdmas, u8 interrupt);
+void send_dma(struct lguest *info, unsigned long key, unsigned long udma);
+void release_all_dma(struct lguest *lg);
+unsigned long get_dma_buffer(struct lguest *lg, unsigned long key,
+			     unsigned long *interrupt);
+
 #ifdef CONFIG_X86_32
 #include "i386/lg.h"
 #endif
+
+#endif /* _LGUEST_LG_GENERIC */
-- 
1.4.4.4

-- 
