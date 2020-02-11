From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 36/62] x86/sev-es: Add Runtime #VC Exception Handler
Date: Tue, 11 Feb 2020 14:52:30 +0100
Message-ID: <20200211135256.24617-37-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Add the handler for #VC exceptions invoked at runtime.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_64.S    |  4 ++
 arch/x86/include/asm/traps.h |  7 ++++
 arch/x86/kernel/idt.c        |  4 +-
 arch/x86/kernel/sev-es.c     | 77 +++++++++++++++++++++++++++++++++++-
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f2bb91e87877..729876d368c5 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1210,6 +1210,10 @@ idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
 idtentry machine_check		do_mce			has_error_code=0	paranoid=1
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+idtentry vmm_communication     do_vmm_communication    has_error_code=1
+#endif
+
 /*
  * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 2aa786484bb1..1be25c065698 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -35,6 +35,9 @@ asmlinkage void alignment_check(void);
 #ifdef CONFIG_X86_MCE
 asmlinkage void machine_check(void);
 #endif /* CONFIG_X86_MCE */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+asmlinkage void vmm_communication(void);
+#endif
 asmlinkage void simd_coprocessor_error(void);
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_XEN_PV)
@@ -93,6 +96,10 @@ dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
 dotraplinkage void do_machine_check(struct pt_regs *regs, long error_code);
 #endif
 dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+dotraplinkage void do_vmm_communication_error(struct pt_regs *regs,
+					      long error_code);
+#endif
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
 #endif
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 1bfee6981e9b..94f6a5705e1d 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -95,8 +95,10 @@ static const __initconst struct idt_data def_idts[] = {
 #ifdef CONFIG_X86_MCE
 	INTG(X86_TRAP_MC,		&machine_check),
 #endif
-
 	SYSG(X86_TRAP_OF,		overflow),
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	INTG(X86_TRAP_VC,               vmm_communication),
+#endif
 #if defined(CONFIG_IA32_EMULATION)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_compat),
 #elif defined(CONFIG_X86_32)
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 9a5530857db7..1fb7128ff386 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -19,7 +19,7 @@
 #include <asm/sev-es.h>
 #include <asm/fpu/internal.h>
 #include <asm/processor.h>
-#include <asm/trap_defs.h>
+#include <asm/traps.h>
 #include <asm/svm.h>
 
 /* For early boot hypervisor communication in SEV-ES enabled guests */
@@ -184,6 +184,81 @@ static enum es_result handle_vc_exception(struct es_em_ctxt *ctxt,
 	return result;
 }
 
+static void forward_exception(struct es_em_ctxt *ctxt)
+{
+	long error_code = ctxt->fi.error_code;
+	int trapnr = ctxt->fi.vector;
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+
+	switch (trapnr) {
+	case X86_TRAP_GP:
+		do_general_protection(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_UD:
+		do_invalid_op(ctxt->regs, 0);
+		break;
+	default:
+		BUG();
+	}
+}
+
+dotraplinkage void do_vmm_communication(struct pt_regs *regs, unsigned long exit_code)
+{
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+	struct ghcb *ghcb;
+
+	/*
+	 * This is invoked through an interrupt gate, so IRQs are disabled. The
+	 * code below might walk page-tables for user or kernel addresses, so
+	 * keep the IRQs disabled to protect us against concurrent TLB flushes.
+	 */
+
+	ghcb = this_cpu_ptr(&ghcb_page);
+
+	ghcb_invalidate(ghcb);
+	result = init_em_ctxt(&ctxt, regs, exit_code);
+
+	if (result == ES_OK)
+		result = handle_vc_exception(&ctxt, ghcb, exit_code);
+
+	/* Done - now check the result */
+	switch (result) {
+	case ES_OK:
+		finish_insn(&ctxt);
+		break;
+	case ES_UNSUPPORTED:
+		pr_emerg("Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+			 exit_code, regs->ip);
+		goto fail;
+	case ES_VMM_ERROR:
+		pr_emerg("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+			 exit_code, regs->ip);
+		goto fail;
+	case ES_DECODE_FAILED:
+		pr_emerg("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+			 exit_code, regs->ip);
+		goto fail;
+	case ES_EXCEPTION:
+		forward_exception(&ctxt);
+		break;
+	case ES_RETRY:
+		/* Nothing to do */
+		break;
+	default:
+		BUG();
+	}
+
+	return;
+
+fail:
+	show_regs(regs);
+
+	while (true)
+		halt();
+}
+
 int __init boot_vc_exception(struct pt_regs *regs)
 {
 	unsigned long exit_code = regs->orig_ax;
-- 
2.17.1
