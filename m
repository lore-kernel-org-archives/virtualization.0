From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/7] cleanup: Move mce_disabled to asm/mce.h
Date: Mon, 12 Feb 2007 14:35:35 +1100
Message-ID: <1171251335.10409.10.camel@localhost.localdomain>
References: <1171251120.10409.2.camel@localhost.localdomain>
	 <1171251185.10409.4.camel@localhost.localdomain>
	 <1171251258.10409.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932947AbXBLDgZ@vger.kernel.org>
In-Reply-To: <1171251258.10409.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.osdl.org>, Paul Mackerras <paulus@samba.org>
List-Id: virtualization@lists.linuxfoundation.org

Allows external actors to disable mce.

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
