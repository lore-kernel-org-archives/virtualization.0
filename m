From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1 of 7]  lguest: Move mce_disabled to asm/mce.h so lguest
	can use it.
Date: Sat, 10 Feb 2007 02:03:03 +1100
Message-ID: <1171033383.2718.163.camel@localhost.localdomain>
References: <1171033146.2718.157.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946504AbXBIPDt@vger.kernel.org>
In-Reply-To: <1171033146.2718.157.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

===================================================================
--- a/arch/i386/kernel/cpu/mcheck/mce.h
+++ b/arch/i386/kernel/cpu/mcheck/mce.h
@@ -1,4 +1,5 @@
 #include <linux/init.h>
+#include <asm/mce.h>
 
 void amd_mcheck_init(struct cpuinfo_x86 *c);
 void intel_p4_mcheck_init(struct cpuinfo_x86 *c);
@@ -9,6 +10,5 @@ void winchip_mcheck_init(struct cpuinfo_
 /* Call the installed machine check handler for this CPU setup. */
 extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
 
-extern int mce_disabled;
 extern int nr_mce_banks;
 
===================================================================
--- a/include/asm-i386/mce.h
+++ b/include/asm-i386/mce.h
@@ -3,3 +3,5 @@ extern void mcheck_init(struct cpuinfo_x
 #else
 #define mcheck_init(c) do {} while(0)
 #endif
+
+extern int mce_disabled;
