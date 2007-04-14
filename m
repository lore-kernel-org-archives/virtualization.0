From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 11/28] x86: incremental update for i386 and x86-64 check_bugs
Date: Sat, 14 Apr 2007 13:42:05 -0700
Message-ID: <20070414204924.227634121@goop.org>
References: <20070414204154.871250608@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753862AbXDNVWY@vger.kernel.org>
Content-Disposition: inline; filename=cleanup-cleanup-asm-bugs_h.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

i386 bugs.c shouldn't refer to identify_boot_cpu yet, since it doesn't
get introduced until the identify_cpu patch.

Remove spurious comments, headers and keywords from x86-64 bugs.[ch].

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/cpu/bugs.c |    2 +-
 arch/x86_64/kernel/bugs.c   |    9 +--------
 include/asm-i386/bugs.h     |    2 +-
 3 files changed, 3 insertions(+), 10 deletions(-)

===================================================================
--- a/arch/i386/kernel/cpu/bugs.c
+++ b/arch/i386/kernel/cpu/bugs.c
@@ -177,7 +177,7 @@ static void __init check_config(void)
 
 void __init check_bugs(void)
 {
-	identify_boot_cpu();
+	identify_cpu(&boot_cpu_data);
 #ifndef CONFIG_SMP
 	printk("CPU: ");
 	print_cpu_info(&boot_cpu_data);
===================================================================
--- a/arch/x86_64/kernel/bugs.c
+++ b/arch/x86_64/kernel/bugs.c
@@ -3,19 +3,12 @@
  *
  *  Copyright (C) 1994  Linus Torvalds
  *  Copyright (C) 2000  SuSE
- *
- * This is included by init/main.c to check for architecture-dependent bugs.
- *
- * Needs:
- *	void check_bugs(void);
  */
 
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <asm/alternative.h>
 #include <asm/processor.h>
-#include <asm/i387.h>
-#include <asm/msr.h>
-#include <asm/pda.h>
 
 void __init check_bugs(void)
 {
===================================================================
--- a/include/asm-i386/bugs.h
+++ b/include/asm-i386/bugs.h
@@ -7,6 +7,6 @@
 #ifndef _ASM_I386_BUG_H
 #define _ASM_I386_BUG_H
 
-extern void __init check_bugs(void);
+void check_bugs(void);
 
 #endif	/* _ASM_I386_BUG_H */

-- 
