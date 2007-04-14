From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 17/28] x86: cleanup arch/i386/kernel/cpu/mcheck/p4.c
Date: Sat, 14 Apr 2007 13:42:11 -0700
Message-ID: <20070414204924.649790791@goop.org>
References: <20070414204154.871250608@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=i386-mcheck-p4-grotesque-and-needless-warning-fix.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

No, just no.  You do not use goto to skip a code block.  You do not
return an obvious variable from a singly-inlined function and give
the function a return value.  You don't put unexplained comments
about kmalloc in code which doesn't do dynamic allocation.  And
you don't leave stray warnings around for no good reason.

Also, when possible, it is better to use block scoped variables
because gcc can sometime generate better code.

From: Zachary Amsden <zach@vmware.com>
Signed-off-by: Zachary Amsden <zach@vmware.com>

---
 arch/i386/kernel/cpu/mcheck/p4.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/cpu/mcheck/p4.c
+++ b/arch/i386/kernel/cpu/mcheck/p4.c
@@ -124,12 +124,9 @@ static void intel_init_thermal(struct cp
 =

 =

 /* P4/Xeon Extended MCE MSR retrieval, return 0 if unsupported */
-static inline int intel_get_extended_msrs(struct intel_mce_extended_msrs *=
r)
+static inline void intel_get_extended_msrs(struct intel_mce_extended_msrs =
*r)
 {
 	u32 h;
-
-	if (mce_num_extended_msrs =3D=3D 0)
-		goto done;
 =

 	rdmsr (MSR_IA32_MCG_EAX, r->eax, h);
 	rdmsr (MSR_IA32_MCG_EBX, r->ebx, h);
@@ -141,12 +138,6 @@ static inline int intel_get_extended_msr
 	rdmsr (MSR_IA32_MCG_ESP, r->esp, h);
 	rdmsr (MSR_IA32_MCG_EFLAGS, r->eflags, h);
 	rdmsr (MSR_IA32_MCG_EIP, r->eip, h);
-
-	/* can we rely on kmalloc to do a dynamic
-	 * allocation for the reserved registers?
-	 */
-done:
-	return mce_num_extended_msrs;
 }
 =

 static fastcall void intel_machine_check(struct pt_regs * regs, long error=
_code)
@@ -155,7 +146,6 @@ static fastcall void intel_machine_check
 	u32 alow, ahigh, high, low;
 	u32 mcgstl, mcgsth;
 	int i;
-	struct intel_mce_extended_msrs dbg;
 =

 	rdmsr (MSR_IA32_MCG_STATUS, mcgstl, mcgsth);
 	if (mcgstl & (1<<0))	/* Recoverable ? */
@@ -164,7 +154,9 @@ static fastcall void intel_machine_check
 	printk (KERN_EMERG "CPU %d: Machine Check Exception: %08x%08x\n",
 		smp_processor_id(), mcgsth, mcgstl);
 =

-	if (intel_get_extended_msrs(&dbg)) {
+	if (mce_num_extended_msrs > 0) {
+		struct intel_mce_extended_msrs dbg;
+		intel_get_extended_msrs(&dbg);
 		printk (KERN_DEBUG "CPU %d: EIP: %08x EFLAGS: %08x\n",
 			smp_processor_id(), dbg.eip, dbg.eflags);
 		printk (KERN_DEBUG "\teax: %08x ebx: %08x ecx: %08x edx: %08x\n",

-- =
