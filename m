Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98581C2D0A7
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:27:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3C3215A4
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3C3215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 161C586108;
	Mon,  7 Sep 2020 13:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AibEs-YKaCaH; Mon,  7 Sep 2020 13:27:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D34398610F;
	Mon,  7 Sep 2020 13:27:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B45E5C0893;
	Mon,  7 Sep 2020 13:27:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD73DC0891
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B3288867B7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tIOoeWlqMYEu
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 755D48679D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:27:47 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 2AE761021;
 Mon,  7 Sep 2020 15:17:05 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 45/72] x86/entry/64: Add entry code for #VC handler
Date: Mon,  7 Sep 2020 15:15:46 +0200
Message-Id: <20200907131613.12703-46-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907131613.12703-1-joro@8bytes.org>
References: <20200907131613.12703-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

The #VC handler needs special entry code because:

	1. It runs on an IST stack

	2. It needs to be able to handle nested #VC exceptions

To make this work the entry code is implemented to pretend it doesn't
use an IST stack. When entered from user-mode or early SYSCALL entry
path it switches to the task stack, if entered from kernel-mode it
tries to switch back to the previous stack in the IRET frame.

The stack found in the IRET frame is validated first, and if it is not
safe to use it for the #VC handler, the code will switch to a
fall-back stack (the #VC2 IST stack). From there it can cause nested
exceptions again.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_64.S       | 80 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h | 44 ++++++++++++++++++
 arch/x86/include/asm/proto.h    |  1 +
 arch/x86/include/asm/traps.h    |  1 +
 arch/x86/kernel/traps.c         | 45 +++++++++++++++++++
 5 files changed, 171 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5c5d234d968d..f446e9048d07 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -101,6 +101,8 @@ SYM_CODE_START(entry_SYSCALL_64)
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
+SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
+
 	/* Construct struct pt_regs on stack */
 	pushq	$__USER_DS				/* pt_regs->ss */
 	pushq	PER_CPU_VAR(cpu_tss_rw + TSS_sp2)	/* pt_regs->sp */
@@ -446,6 +448,84 @@ _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
 .endm
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/**
+ * idtentry_vc - Macro to generate entry stub for #VC
+ * @vector:		Vector number
+ * @asmsym:		ASM symbol for the entry point
+ * @cfunc:		C function to be called
+ *
+ * The macro emits code to set up the kernel context for #VC. The #VC handler
+ * runs on an IST stack and needs to be able to cause nested #VC exceptions.
+ *
+ * To make this work the #VC entry code tries its best to pretend it doesn't use
+ * an IST stack by switching to the task stack if coming from user-space (which
+ * includes early SYSCALL entry path) or back to the stack in the IRET frame if
+ * entered from kernel-mode.
+ *
+ * If entered from kernel-mode the return stack is validated first, and if it is
+ * not safe to use (e.g. because it points to the entry stack) the #VC handler
+ * will switch to a fall-back stack (VC2) and call a special handler function.
+ *
+ * The macro is only used for one vector, but it is planned to be extended in
+ * the future for the #HV exception.
+ */
+.macro idtentry_vc vector asmsym cfunc
+SYM_CODE_START(\asmsym)
+	UNWIND_HINT_IRET_REGS
+	ASM_CLAC
+
+	/*
+	 * If the entry is from userspace, switch stacks and treat it as
+	 * a normal entry.
+	 */
+	testb	$3, CS-ORIG_RAX(%rsp)
+	jnz	.Lfrom_usermode_switch_stack_\@
+
+	/*
+	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
+	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
+	 */
+	call	paranoid_entry
+
+	UNWIND_HINT_REGS
+
+	/*
+	 * Switch off the IST stack to make it free for nested exceptions. The
+	 * vc_switch_off_ist() function will switch back to the interrupted
+	 * stack if it is safe to do so. If not it switches to the VC fall-back
+	 * stack.
+	 */
+	movq	%rsp, %rdi		/* pt_regs pointer */
+	call	vc_switch_off_ist
+	movq	%rax, %rsp		/* Switch to new stack */
+
+	UNWIND_HINT_REGS
+
+	/* Update pt_regs */
+	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
+	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
+
+	movq	%rsp, %rdi		/* pt_regs pointer */
+
+	call	\cfunc
+
+	/*
+	 * No need to switch back to the IST stack. The current stack is either
+	 * identical to the stack in the IRET frame or the VC fall-back stack,
+	 * so it is definitly mapped even with PTI enabled.
+	 */
+	jmp	paranoid_exit
+
+	/* Switch to the regular task stack */
+.Lfrom_usermode_switch_stack_\@:
+	idtentry_body safe_stack_\cfunc, has_error_code=1
+
+_ASM_NOKPROBE(\asmsym)
+SYM_CODE_END(\asmsym)
+.endm
+#endif
+
 /*
  * Double fault entry. Straight paranoid. No checks from which context
  * this comes because for the espfix induced #DF this would do the wrong
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 337dcfd45472..5ce67113a761 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -308,6 +308,18 @@ static __always_inline void __##func(struct pt_regs *regs)
 	DECLARE_IDTENTRY_RAW(vector, func);				\
 	__visible void noist_##func(struct pt_regs *regs)
 
+/**
+ * DECLARE_IDTENTRY_VC - Declare functions for the VC entry point
+ * @vector:	Vector number (ignored for C)
+ * @func:	Function name of the entry point
+ *
+ * Maps to DECLARE_IDTENTRY_RAW_ERRORCODE, but declares also the
+ * safe_stack C handler.
+ */
+#define DECLARE_IDTENTRY_VC(vector, func)				\
+	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func);			\
+	__visible noinstr void safe_stack_##func(struct pt_regs *regs, unsigned long error_code)
+
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
  * @func:	Function name of the entry point
@@ -347,6 +359,35 @@ static __always_inline void __##func(struct pt_regs *regs)
 #define DEFINE_IDTENTRY_DF(func)					\
 	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
 
+/**
+ * DEFINE_IDTENTRY_VC_SAFE_STACK - Emit code for VMM communication handler
+				   which runs on a safe stack.
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ */
+#define DEFINE_IDTENTRY_VC_SAFE_STACK(func)				\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(safe_stack_##func)
+
+/**
+ * DEFINE_IDTENTRY_VC_IST - Emit code for VMM communication handler
+			    which runs on the VC fall-back stack
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ */
+#define DEFINE_IDTENTRY_VC_IST(func)				\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(ist_##func)
+
+/**
+ * DEFINE_IDTENTRY_VC - Emit code for VMM communication handler
+ * @func:	Function name of the entry point
+ *
+ * Maps to DEFINE_IDTENTRY_RAW_ERRORCODE
+ */
+#define DEFINE_IDTENTRY_VC(func)					\
+	DEFINE_IDTENTRY_RAW_ERRORCODE(func)
+
 #else	/* CONFIG_X86_64 */
 
 /**
@@ -433,6 +474,9 @@ __visible noinstr void func(struct pt_regs *regs,			\
 # define DECLARE_IDTENTRY_XENCB(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
+# define DECLARE_IDTENTRY_VC(vector, func)				\
+	idtentry_vc vector asm_##func func
+
 #else
 # define DECLARE_IDTENTRY_MCE(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 28996fe19301..2c35f1c01a2d 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -10,6 +10,7 @@ void syscall_init(void);
 
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
+void entry_SYSCALL_64_safe_stack(void);
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 6a308355ea29..1b86bb3abc56 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -15,6 +15,7 @@ asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
 void __init trap_init(void);
+asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
 #ifdef CONFIG_X86_F00F_BUG
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e121e7c5f831..e2c6fd4dde8e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -43,6 +43,7 @@
 #include <asm/stacktrace.h>
 #include <asm/processor.h>
 #include <asm/debugreg.h>
+#include <asm/realmode.h>
 #include <asm/text-patching.h>
 #include <asm/ftrace.h>
 #include <asm/traps.h>
@@ -673,6 +674,50 @@ asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 	return regs;
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *regs)
+{
+	unsigned long sp, *stack;
+	struct stack_info info;
+	struct pt_regs *regs_ret;
+
+	/*
+	 * In the SYSCALL entry path the RSP value comes from user-space - don't
+	 * trust it and switch to the current kernel stack
+	 */
+	if (regs->ip >= (unsigned long)entry_SYSCALL_64 &&
+	    regs->ip <  (unsigned long)entry_SYSCALL_64_safe_stack) {
+		sp = this_cpu_read(cpu_current_top_of_stack);
+		goto sync;
+	}
+
+	/*
+	 * From here on the RSP value is trusted. Now check whether entry
+	 * happened from a safe stack. Not safe are the entry or unknown stacks,
+	 * use the fall-back stack instead in this case.
+	 */
+	sp    = regs->sp;
+	stack = (unsigned long *)sp;
+
+	if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
+	    info.type >= STACK_TYPE_EXCEPTION_LAST)
+		sp = __this_cpu_ist_top_va(VC2);
+
+sync:
+	/*
+	 * Found a safe stack - switch to it as if the entry didn't happen via
+	 * IST stack. The code below only copies pt_regs, the real switch happens
+	 * in assembly code.
+	 */
+	sp = ALIGN_DOWN(sp, 8) - sizeof(*regs_ret);
+
+	regs_ret = (struct pt_regs *)sp;
+	*regs_ret = *regs;
+
+	return regs_ret;
+}
+#endif
+
 struct bad_iret_stack {
 	void *error_entry_ret;
 	struct pt_regs regs;
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
