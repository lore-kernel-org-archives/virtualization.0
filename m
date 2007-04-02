From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 02/17] Remove CONFIG_DEBUG_PARAVIRT
Date: Sun, 01 Apr 2007 22:56:54 -0700
Message-ID: <20070402055704.049622121@goop.org>
References: <20070402055652.610711908@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932796AbXDBF7G@vger.kernel.org>
Content-Disposition: inline; filename=remove-CONFIG_DEBUG_PARAVIRT.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Remove CONFIG_DEBUG_PARAVIRT.  When inlining code, this option
attempts to trash registers in the patch-site's "clobber" field, on
the grounds that this should find bugs with incorrect clobbers.
Unfortunately, the clobber field really means "registers modified by
this patch site", which includes return values.

Because of this, this option has outlived its usefulness, so remove
it.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>

---
 arch/i386/Kconfig.debug        |   10 ----------
 arch/i386/kernel/alternative.c |   14 +-------------
 2 files changed, 1 insertion(+), 23 deletions(-)

===================================================================
--- a/arch/i386/Kconfig.debug
+++ b/arch/i386/Kconfig.debug
@@ -85,14 +85,4 @@ config DOUBLEFAULT
           option saves about 4k and might cause you much additional grey
           hair.
 
-config DEBUG_PARAVIRT
-	bool "Enable some paravirtualization debugging"
-	default n
-	depends on PARAVIRT && DEBUG_KERNEL
-	help
-	  Currently deliberately clobbers regs which are allowed to be
-	  clobbered in inlined paravirt hooks, even in native mode.
-	  If turning this off solves a problem, then DISABLE_INTERRUPTS() or
-	  ENABLE_INTERRUPTS() is lying about what registers can be clobbered.
-
 endmenu
===================================================================
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -359,19 +359,7 @@ void apply_paravirt(struct paravirt_patc
 
 		used = paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
 					  p->len);
-#ifdef CONFIG_DEBUG_PARAVIRT
-		{
-		int i;
-		/* Deliberately clobber regs using "not %reg" to find bugs. */
-		for (i = 0; i < 3; i++) {
-			if (p->len - used >= 2 && (p->clobbers & (1 << i))) {
-				memcpy(p->instr + used, "\xf7\xd0", 2);
-				p->instr[used+1] |= i;
-				used += 2;
-			}
-		}
-		}
-#endif
+
 		/* Pad the rest with nops */
 		nop_out(p->instr + used, p->len - used);
 	}

-- 
