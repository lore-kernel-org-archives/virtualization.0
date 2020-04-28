From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 50/75] x86/sev-es: Do not crash on #VC exceptions from user-space
Date: Tue, 28 Apr 2020 17:17:00 +0200
Message-ID: <20200428151725.31091-51-joro@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200428151725.31091-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Send SIGBUS to the user-space process that caused the #VC exception
instead of killing the machine. Also ratelimit the error messages so
that user-space can't flood the kernel log and add a prefix the the
messages printed for SEV-ES.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/sev-es.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index c2223c2a28c2..f4ce3b475464 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -7,6 +7,8 @@
  * Author: Joerg Roedel <jroedel@suse.de>
  */
 
+#define pr_fmt(fmt)	"SEV-ES: " fmt
+
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
 #include <linux/mem_encrypt.h>
@@ -468,7 +470,7 @@ static void vc_forward_exception(struct es_em_ctxt *ctxt)
 		do_invalid_op(ctxt->regs, 0);
 		break;
 	default:
-		pr_emerg("ERROR: Unsupported exception in #VC instruction emulation - can't continue\n");
+		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
 		BUG();
 	}
 }
@@ -516,16 +518,16 @@ dotraplinkage void do_vmm_communication(struct pt_regs *regs,
 		vc_finish_insn(&ctxt);
 		break;
 	case ES_UNSUPPORTED:
-		pr_emerg("PANIC: Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
-			 exit_code, regs->ip);
+		pr_err_ratelimited("Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+				   exit_code, regs->ip);
 		goto fail;
 	case ES_VMM_ERROR:
-		pr_emerg("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
-			 exit_code, regs->ip);
+		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				   exit_code, regs->ip);
 		goto fail;
 	case ES_DECODE_FAILED:
-		pr_emerg("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
-			 exit_code, regs->ip);
+		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				   exit_code, regs->ip);
 		goto fail;
 	case ES_EXCEPTION:
 		vc_forward_exception(&ctxt);
@@ -534,7 +536,7 @@ dotraplinkage void do_vmm_communication(struct pt_regs *regs,
 		/* Nothing to do */
 		break;
 	default:
-		pr_emerg("PANIC: Unknown result in %s():%d\n", __func__, result);
+		pr_emerg("Unknown result in %s():%d\n", __func__, result);
 		/*
 		 * Emulating the instruction which caused the #VC exception
 		 * failed - can't continue so print debug information
@@ -545,10 +547,26 @@ dotraplinkage void do_vmm_communication(struct pt_regs *regs,
 	return;
 
 fail:
-	show_regs(regs);
+	if (user_mode(regs)) {
+		/*
+		 * Do not kill the machine if user-space triggered the
+		 * exception. Send SIGBUS instead and let user-space deal with
+		 * it.
+		 */
+		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
+	} else {
+		pr_emerg("PANIC: Unhandled #VC exception in kernel space (result=%d)\n",
+			 result);
 
-	while (true)
-		halt();
+		/* Show some debug info */
+		show_regs(regs);
+
+		/* Ask hypervisor to sev_es_terminate */
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+
+		/* If that fails and we get here - just panic */
+		panic("Returned from Terminate-Request to Hypervisor\n");
+	}
 }
 
 bool __init vc_boot_ghcb(struct pt_regs *regs)
-- 
2.17.1
