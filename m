From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 04/33] xen: paravirt: unstatic leave_mm
Date: Tue, 22 May 2007 15:09:45 +0100
Message-ID: <20070522141251.160703868@goop.org>
References: <20070522140941.802382212@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=paravirt-unstatic-leave_mm.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Xen-devel <xen-devel@lists.xensource.com>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Make globally leave_mm visible, specifically so that Xen can use it to
shoot-down lazy uses of cr3.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/smp.c         |    5 +++--
 include/asm-i386/mmu_context.h |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

===================================================================
--- a/include/asm-i386/mmu_context.h
+++ b/include/asm-i386/mmu_context.h
@@ -31,6 +31,8 @@ static inline void enter_lazy_tlb(struct
 		per_cpu(cpu_tlbstate, cpu).state = TLBSTATE_LAZY;
 #endif
 }
+
+void leave_mm (unsigned long cpu);
 
 static inline void switch_mm(struct mm_struct *prev,
 			     struct mm_struct *next,
===================================================================
--- a/arch/i386/kernel/smp.c
+++ b/arch/i386/kernel/smp.c
@@ -22,6 +22,7 @@
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
+#include <asm/mmu_context.h>
 #include <mach_apic.h>
 
 /*
@@ -249,13 +250,13 @@ static DEFINE_SPINLOCK(tlbstate_lock);
 static DEFINE_SPINLOCK(tlbstate_lock);
 
 /*
- * We cannot call mmdrop() because we are in interrupt context, 
+ * We cannot call mmdrop() because we are in interrupt context,
  * instead update mm->cpu_vm_mask.
  *
  * We need to reload %cr3 since the page tables may be going
  * away from under us..
  */
-static inline void leave_mm (unsigned long cpu)
+void leave_mm (unsigned long cpu)
 {
 	if (per_cpu(cpu_tlbstate, cpu).state == TLBSTATE_OK)
 		BUG();

-- 
