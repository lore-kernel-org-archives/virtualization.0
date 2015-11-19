From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v2 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Thu, 19 Nov 2015 16:55:45 -0500
Message-ID: <1447970147-1733-2-git-send-email-boris.ostrovsky@oracle.com>
References: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
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
 arch/x86/entry/entry_32.S         |  5 +++--
 arch/x86/entry/entry_64_compat.S  | 10 ++++++----
 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/xen/enlighten.c          |  4 +++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 3eb572e..0870825 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -308,8 +308,9 @@ sysenter_past_esp:
 
 	movl	%esp, %eax
 	call	do_fast_syscall_32
-	testl	%eax, %eax
-	jz	.Lsyscall_32_done
+	/* XEN PV guests always use IRET path */
+	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
+		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
 
 /* Opportunistic SYSEXIT */
 	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index c320183..402e34a 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -121,8 +121,9 @@ sysenter_flags_fixed:
 
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
-	testl	%eax, %eax
-	jz	.Lsyscall_32_done
+	/* XEN PV guests always use IRET path */
+	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
+		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
 	jmp	sysret32_from_system_call
 
 sysenter_fix_flags:
@@ -200,8 +201,9 @@ ENTRY(entry_SYSCALL_compat)
 
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
-	testl	%eax, %eax
-	jz	.Lsyscall_32_done
+	/* XEN PV guests always use IRET path */
+	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
+		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
 
 	/* Opportunistic SYSRET */
 sysret32_from_system_call:
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index e4f8010..f7ba9fb 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -216,6 +216,7 @@
 #define X86_FEATURE_PAUSEFILTER ( 8*32+13) /* AMD filtered pause intercept */
 #define X86_FEATURE_PFTHRESHOLD ( 8*32+14) /* AMD pause filter threshold */
 #define X86_FEATURE_VMMCALL     ( 8*32+15) /* Prefer vmmcall to vmcall */
+#define X86_FEATURE_XENPV       ( 8*32+16) /* "" Xen paravirtual guest */
 
 
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
