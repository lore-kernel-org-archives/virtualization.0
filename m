From: Chris Wright <chrisw@sous-sol.org>
Subject: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt kernels
Date: Sat, 28 Oct 2006 00:00:04 -0700
Message-ID: <20061029024606.496399000@sous-sol.org>
References: <20061029024504.760769000@sous-sol.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964948AbWJ2Cpn@vger.kernel.org>
Content-Disposition: inline; filename=015-disable-bug-checking.patch
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@osdl.org, ak@muc.de
Cc: Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Allow selected bug checks to be skipped by paravirt kernels.  The two most
important are the F00F workaround (which is either done by the hypervisor,
or not required), and the 'hlt' instruction check, which can break under
some hypervisors.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>

---
 arch/i386/kernel/cpu/intel.c |    2 +-
 include/asm-i386/bugs.h      |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6-pv.orig/arch/i386/kernel/cpu/intel.c
+++ linux-2.6-pv/arch/i386/kernel/cpu/intel.c
@@ -107,7 +107,7 @@ static void __cpuinit init_intel(struct 
 	 * Note that the workaround only should be initialized once...
 	 */
 	c->f00f_bug = 0;
-	if ( c->x86 == 5 ) {
+	if (!paravirt_enabled() && c->x86 == 5) {
 		static int f00f_workaround_enabled = 0;
 
 		c->f00f_bug = 1;
--- linux-2.6-pv.orig/include/asm-i386/bugs.h
+++ linux-2.6-pv/include/asm-i386/bugs.h
@@ -21,6 +21,7 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/msr.h>
+#include <asm/paravirt.h>
 
 static int __init no_halt(char *s)
 {
@@ -91,6 +92,9 @@ static void __init check_fpu(void)
 
 static void __init check_hlt(void)
 {
+	if (paravirt_enabled())
+		return;
+
 	printk(KERN_INFO "Checking 'hlt' instruction... ");
 	if (!boot_cpu_data.hlt_works_ok) {
 		printk("disabled\n");

--
