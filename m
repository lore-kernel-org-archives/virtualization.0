From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Wed, 18 Nov 2015 15:06:17 -0500
Message-ID: <1447877179-2775-2-git-send-email-boris.ostrovsky__290.921252644871$1447877460$gmane$org@oracle.com>
References: <1447877179-2775-1-git-send-email-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447877179-2775-1-git-send-email-boris.ostrovsky@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, david.vrabel@citrix.com, konrad.wilk@oracle.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, luto@kernel.org, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, bp@suse.de
List-Id: virtualization@lists.linuxfoundation.org

After 32-bit syscall rewrite, and specifically after commit 5f310f739b4c
("x86/entry/32: Re-implement SYSENTER using the new C path"), the stack
frame that is passed to xen_sysexit is no longer a "standard" one (i.e.
it's not pt_regs).

Since we end up calling xen_iret from xen_sysexit we don't need to fix
up the stack and instead follow entry_SYSENTER_32's IRET path directly
to xen_iret.

We can do the same thing for compat mode even though stack does not need
to be fixed. This will allow us to drop usergs_sysret32 paravirt op (in
the subsequent patch)

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Suggested-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/entry/entry_32.S         | 3 ++-
 arch/x86/entry/entry_64_compat.S  | 6 ++++--
 arch/x86/include/asm/cpufeature.h | 1 +
 arch/x86/xen/enlighten.c          | 4 +++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 3eb572e..901f186 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -308,7 +308,8 @@ sysenter_past_esp:
 
 	movl	%esp, %eax
 	call	do_fast_syscall_32
-	testl	%eax, %eax
+	/* XEN PV guests always use IRET path */
+	ALTERNATIVE "testl %eax, %eax", "xor %eax, %eax", X86_FEATURE_XENPV
 	jz	.Lsyscall_32_done
 
 /* Opportunistic SYSEXIT */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index c320183..98893d9 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -121,7 +121,8 @@ sysenter_flags_fixed:
 
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
-	testl	%eax, %eax
+	/* XEN PV guests always use IRET path */
+	ALTERNATIVE "testl %eax, %eax", "xor %eax, %eax", X86_FEATURE_XENPV
 	jz	.Lsyscall_32_done
 	jmp	sysret32_from_system_call
 
@@ -200,7 +201,8 @@ ENTRY(entry_SYSCALL_compat)
 
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
-	testl	%eax, %eax
+	/* XEN PV guests always use IRET path */
+	ALTERNATIVE "testl %eax, %eax", "xor %eax, %eax", X86_FEATURE_XENPV
 	jz	.Lsyscall_32_done
 
 	/* Opportunistic SYSRET */
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index e4f8010..0e4fe5b 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -216,6 +216,7 @@
 #define X86_FEATURE_PAUSEFILTER ( 8*32+13) /* AMD filtered pause intercept */
 #define X86_FEATURE_PFTHRESHOLD ( 8*32+14) /* AMD pause filter threshold */
 #define X86_FEATURE_VMMCALL     ( 8*32+15) /* Prefer vmmcall to vmcall */
+#define X86_FEATURE_XENPV       ( 8*32+16) /* Xen paravirtual guest */
 
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ebx), word 9 */
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 5774800..d315151 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1886,8 +1886,10 @@ EXPORT_SYMBOL_GPL(xen_hvm_need_lapic);
 
 static void xen_set_cpu_features(struct cpuinfo_x86 *c)
 {
-	if (xen_pv_domain())
+	if (xen_pv_domain()) {
 		clear_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+		set_cpu_cap(c, X86_FEATURE_XENPV);
+	}
 }
 
 const struct hypervisor_x86 x86_hyper_xen = {
-- 
1.8.1.4
