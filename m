From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 11/12] xen: add some debug output for failed
	multicalls
Date: Mon, 15 Oct 2007 13:48:51 -0700
Message-ID: <20071015210115.429058413@goop.org>
References: <20071015204840.074767068@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=xen-mc-debug.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: xen-devel@lists.xensource.com, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Stable Kernel <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Multicalls are expected to never fail, and the normal response to a
failed multicall is very terse.  In the interests of better
debuggability, add some more verbose output.  It may be worth turning
this off once it all seems more tested.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/x86/xen/multicalls.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

===================================================================
--- a/arch/x86/xen/multicalls.c
+++ b/arch/x86/xen/multicalls.c
@@ -26,11 +26,16 @@
 
 #include "multicalls.h"
 
+#define MC_DEBUG	1
+
 #define MC_BATCH	32
 #define MC_ARGS		(MC_BATCH * 16 / sizeof(u64))
 
 struct mc_buffer {
 	struct multicall_entry entries[MC_BATCH];
+#if MC_DEBUG
+	struct multicall_entry debug[MC_BATCH];
+#endif
 	u64 args[MC_ARGS];
 	struct callback {
 		void (*fn)(void *);
@@ -56,11 +61,31 @@ void xen_mc_flush(void)
 	local_irq_save(flags);
 
 	if (b->mcidx) {
+#if MC_DEBUG
+		memcpy(b->debug, b->entries,
+		       b->mcidx * sizeof(struct multicall_entry));
+#endif
+
 		if (HYPERVISOR_multicall(b->entries, b->mcidx) != 0)
 			BUG();
 		for (i = 0; i < b->mcidx; i++)
 			if (b->entries[i].result < 0)
 				ret++;
+
+#if MC_DEBUG
+		if (ret) {
+			printk(KERN_ERR "%d multicall(s) failed: cpu %d\n",
+			       ret, smp_processor_id());
+			for(i = 0; i < b->mcidx; i++) {
+				printk("  call %2d/%d: op=%lu arg=[%lx] result=%ld\n",
+				       i+1, b->mcidx,
+				       b->debug[i].op,
+				       b->debug[i].args[0],
+				       b->entries[i].result);
+			}
+		}
+#endif
+
 		b->mcidx = 0;
 		b->argidx = 0;
 	} else

-- 
