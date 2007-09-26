From: rusty@rustcorp.com.au
Subject: [patch 13/43] lguest: Move lguest hcalls to arch-specific header
Date: Wed, 26 Sep 2007 16:36:31 +1000
Message-ID: <20070926063647.262292916@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=arch-indep-lg_hcall.diff
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
Cc: Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Move architecture specific portion of lg_hcall code to asm-i386/lg_hcall.h
and have it included from linux/lguest.h.

[Changed to asm-i386/lguest_hcall.h so documentation finds it -RR]

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jes Sorensen <jes@sgi.com>
---
 include/asm-i386/lguest_hcall.h |   67 +++++++++++++++++++++++++++++++++++++
 include/linux/lguest.h          |   69 ++-------------------------------------
 2 files changed, 71 insertions(+), 65 deletions(-)

===================================================================
--- /dev/null
+++ linux-2.6-lguest/include/asm-i386/lguest_hcall.h
@@ -0,0 +1,67 @@
+/* Architecture specific portion of the lguest hypercalls */
+#ifndef _I386_LGUEST_HCALL_H
+#define _I386_LGUEST_HCALL_H
+
+#define LHCALL_FLUSH_ASYNC	0
+#define LHCALL_LGUEST_INIT	1
+#define LHCALL_CRASH		2
+#define LHCALL_LOAD_GDT		3
+#define LHCALL_NEW_PGTABLE	4
+#define LHCALL_FLUSH_TLB	5
+#define LHCALL_LOAD_IDT_ENTRY	6
+#define LHCALL_SET_STACK	7
+#define LHCALL_TS		8
+#define LHCALL_SET_CLOCKEVENT	9
+#define LHCALL_HALT		10
+#define LHCALL_BIND_DMA		12
+#define LHCALL_SEND_DMA		13
+#define LHCALL_SET_PTE		14
+#define LHCALL_SET_PMD		15
+#define LHCALL_LOAD_TLS		16
+
+/*G:031 First, how does our Guest contact the Host to ask for privileged
+ * operations?  There are two ways: the direct way is to make a "hypercall",
+ * to make requests of the Host Itself.
+ *
+ * Our hypercall mechanism uses the highest unused trap code (traps 32 and
+ * above are used by real hardware interrupts).  Seventeen hypercalls are
+ * available: the hypercall number is put in the %eax register, and the
+ * arguments (when required) are placed in %edx, %ebx and %ecx.  If a return
+ * value makes sense, it's returned in %eax.
+ *
+ * Grossly invalid calls result in Sudden Death at the hands of the vengeful
+ * Host, rather than returning failure.  This reflects Winston Churchill's
+ * definition of a gentleman: "someone who is only rude intentionally". */
+#define LGUEST_TRAP_ENTRY 0x1F
+
+static inline unsigned long
+hcall(unsigned long call,
+      unsigned long arg1, unsigned long arg2, unsigned long arg3)
+{
+	/* "int" is the Intel instruction to trigger a trap. */
+	asm volatile("int $" __stringify(LGUEST_TRAP_ENTRY)
+		       /* The call is in %eax (aka "a"), and can be replaced */
+		     : "=a"(call)
+		       /* The other arguments are in %eax, %edx, %ebx & %ecx */
+		     : "a"(call), "d"(arg1), "b"(arg2), "c"(arg3)
+		       /* "memory" means this might write somewhere in memory.
+			* This isn't true for all calls, but it's safe to tell
+			* gcc that it might happen so it doesn't get clever. */
+		     : "memory");
+	return call;
+}
+/*:*/
+
+void async_hcall(unsigned long call,
+		 unsigned long arg1, unsigned long arg2, unsigned long arg3);
+
+/* Can't use our min() macro here: needs to be a constant */
+#define LGUEST_IRQS (NR_IRQS < 32 ? NR_IRQS: 32)
+
+#define LHCALL_RING_SIZE 64
+struct hcall_ring
+{
+	u32 eax, edx, ebx, ecx;
+};
+
+#endif	/* _I386_LGUEST_HCALL_H */
===================================================================
--- linux-2.6-lguest.orig/include/linux/lguest.h
+++ linux-2.6-lguest/include/linux/lguest.h
@@ -1,76 +1,15 @@
 /* Things the lguest guest needs to know.  Note: like all lguest interfaces,
  * this is subject to wild and random change between versions. */
-#ifndef _ASM_LGUEST_H
-#define _ASM_LGUEST_H
+#ifndef _LINUX_LGUEST_H
+#define _LINUX_LGUEST_H
 
 #ifndef __ASSEMBLY__
 #include <asm/irq.h>
-
-#define LHCALL_FLUSH_ASYNC	0
-#define LHCALL_LGUEST_INIT	1
-#define LHCALL_CRASH		2
-#define LHCALL_LOAD_GDT		3
-#define LHCALL_NEW_PGTABLE	4
-#define LHCALL_FLUSH_TLB	5
-#define LHCALL_LOAD_IDT_ENTRY	6
-#define LHCALL_SET_STACK	7
-#define LHCALL_TS		8
-#define LHCALL_SET_CLOCKEVENT	9
-#define LHCALL_HALT		10
-#define LHCALL_BIND_DMA		12
-#define LHCALL_SEND_DMA		13
-#define LHCALL_SET_PTE		14
-#define LHCALL_SET_PMD		15
-#define LHCALL_LOAD_TLS		16
+#include <asm/lguest_hcall.h>
 
 #define LG_CLOCK_MIN_DELTA	100UL
 #define LG_CLOCK_MAX_DELTA	ULONG_MAX
 
-/*G:031 First, how does our Guest contact the Host to ask for privileged
- * operations?  There are two ways: the direct way is to make a "hypercall",
- * to make requests of the Host Itself.
- *
- * Our hypercall mechanism uses the highest unused trap code (traps 32 and
- * above are used by real hardware interrupts).  Seventeen hypercalls are
- * available: the hypercall number is put in the %eax register, and the
- * arguments (when required) are placed in %edx, %ebx and %ecx.  If a return
- * value makes sense, it's returned in %eax.
- *
- * Grossly invalid calls result in Sudden Death at the hands of the vengeful
- * Host, rather than returning failure.  This reflects Winston Churchill's
- * definition of a gentleman: "someone who is only rude intentionally". */
-#define LGUEST_TRAP_ENTRY 0x1F
-
-static inline unsigned long
-hcall(unsigned long call,
-      unsigned long arg1, unsigned long arg2, unsigned long arg3)
-{
-	/* "int" is the Intel instruction to trigger a trap. */
-	asm volatile("int $" __stringify(LGUEST_TRAP_ENTRY)
-		       /* The call is in %eax (aka "a"), and can be replaced */
-		     : "=a"(call)
-		       /* The other arguments are in %eax, %edx, %ebx & %ecx */
-		     : "a"(call), "d"(arg1), "b"(arg2), "c"(arg3)
-		       /* "memory" means this might write somewhere in memory.
-			* This isn't true for all calls, but it's safe to tell
-			* gcc that it might happen so it doesn't get clever. */
-		     : "memory");
-	return call;
-}
-/*:*/
-
-void async_hcall(unsigned long call,
-		 unsigned long arg1, unsigned long arg2, unsigned long arg3);
-
-/* Can't use our min() macro here: needs to be a constant */
-#define LGUEST_IRQS (NR_IRQS < 32 ? NR_IRQS: 32)
-
-#define LHCALL_RING_SIZE 64
-struct hcall_ring
-{
-	u32 eax, edx, ebx, ecx;
-};
-
 /*G:032 The second method of communicating with the Host is to via "struct
  * lguest_data".  The Guest's very first hypercall is to tell the Host where
  * this is, and then the Guest and Host both publish information in it. :*/
@@ -113,4 +52,4 @@ struct lguest_data
 };
 extern struct lguest_data lguest_data;
 #endif /* __ASSEMBLY__ */
-#endif	/* _ASM_LGUEST_H */
+#endif	/* _LINUX_LGUEST_H */

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
