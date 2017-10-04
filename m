From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 03/13] x86/paravirt: Convert native patch assembly code
	strings to macros
Date: Wed,  4 Oct 2017 10:58:24 -0500
Message-ID: <e4cea2b8aa8ca23122d9c807784ca62ee6cbbff8.1507128293.git.jpoimboe__23470.9307006144$1509079595$gmane$org@redhat.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1507128293.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Convert the hard-coded native patch assembly code strings to macros to
facilitate sharing common code between 32-bit and 64-bit.

These macros will also be used by a future patch which requires the GCC
extended asm syntax of two '%' characters instead of one when specifying
a register name.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/special_insns.h | 24 ++++++++++++++++++++++++
 arch/x86/kernel/paravirt_patch_32.c  | 21 +++++++++++----------
 arch/x86/kernel/paravirt_patch_64.c  | 29 +++++++++++++++--------------
 3 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index ac402c6fc24b..0549c5f2c1b3 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -6,6 +6,30 @@
 
 #include <asm/nops.h>
 
+#ifdef CONFIG_X86_64
+# define _REG_ARG1			"%rdi"
+# define NATIVE_IDENTITY_32		"mov %edi, %eax"
+# define NATIVE_USERGS_SYSRET64		"swapgs; sysretq"
+#else
+# define _REG_ARG1			"%eax"
+#endif
+
+#define _REG_RET			"%" _ASM_AX
+
+#define NATIVE_ZERO			"xor " _REG_ARG1 ", " _REG_ARG1
+#define NATIVE_IDENTITY			"mov " _REG_ARG1 ", " _REG_RET
+#define NATIVE_SAVE_FL			"pushf; pop " _REG_RET
+#define NATIVE_RESTORE_FL		"push " _REG_ARG1 "; popf"
+#define NATIVE_IRQ_DISABLE		"cli"
+#define NATIVE_IRQ_ENABLE		"sti"
+#define NATIVE_READ_CR2			"mov %cr2, " _REG_RET
+#define NATIVE_READ_CR3			"mov %cr3, " _REG_RET
+#define NATIVE_WRITE_CR3		"mov " _REG_ARG1 ", %cr3"
+#define NATIVE_FLUSH_TLB_SINGLE		"invlpg (" _REG_ARG1 ")"
+#define NATIVE_SWAPGS			"swapgs"
+#define NATIVE_IRET			"iret"
+#define NATIVE_QUEUED_SPIN_UNLOCK	"movb $0, (" _REG_ARG1 ")"
+
 /*
  * Volatile isn't enough to prevent the compiler from reordering the
  * read/write functions for the control registers and messing everything up.
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index 553acbbb4d32..c9c6106ae714 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -1,17 +1,18 @@
 #include <asm/paravirt.h>
+#include <asm/special_insns.h>
 
-DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
-DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
-DEF_NATIVE(pv_irq_ops, restore_fl, "push %eax; popf");
-DEF_NATIVE(pv_irq_ops, save_fl, "pushf; pop %eax");
-DEF_NATIVE(pv_cpu_ops, iret, "iret");
-DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
-DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
-DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
+DEF_NATIVE(pv_irq_ops,	save_fl,		NATIVE_SAVE_FL);
+DEF_NATIVE(pv_irq_ops,	restore_fl,		NATIVE_RESTORE_FL);
+DEF_NATIVE(pv_irq_ops,	irq_disable,		NATIVE_IRQ_DISABLE);
+DEF_NATIVE(pv_irq_ops,	irq_enable,		NATIVE_IRQ_ENABLE);
+DEF_NATIVE(pv_cpu_ops,	iret,			NATIVE_IRET);
+DEF_NATIVE(pv_mmu_ops,	read_cr2,		NATIVE_READ_CR2);
+DEF_NATIVE(pv_mmu_ops,	read_cr3,		NATIVE_READ_CR3);
+DEF_NATIVE(pv_mmu_ops,	write_cr3,		NATIVE_WRITE_CR3);
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
-DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %eax, %eax");
+DEF_NATIVE(pv_lock_ops,	queued_spin_unlock,	NATIVE_QUEUED_SPIN_UNLOCK);
+DEF_NATIVE(pv_lock_ops,	vcpu_is_preempted,	NATIVE_ZERO);
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 0a1ba3f80cbf..0aa232edd670 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -1,25 +1,26 @@
 #include <asm/paravirt.h>
 #include <asm/asm-offsets.h>
+#include <asm/special_insns.h>
 #include <linux/stringify.h>
 
-DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
-DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
-DEF_NATIVE(pv_irq_ops, restore_fl, "pushq %rdi; popfq");
-DEF_NATIVE(pv_irq_ops, save_fl, "pushfq; popq %rax");
-DEF_NATIVE(pv_mmu_ops, read_cr2, "movq %cr2, %rax");
-DEF_NATIVE(pv_mmu_ops, read_cr3, "movq %cr3, %rax");
-DEF_NATIVE(pv_mmu_ops, write_cr3, "movq %rdi, %cr3");
-DEF_NATIVE(pv_mmu_ops, flush_tlb_single, "invlpg (%rdi)");
+DEF_NATIVE(pv_irq_ops,	save_fl,		NATIVE_SAVE_FL);
+DEF_NATIVE(pv_irq_ops,	restore_fl,		NATIVE_RESTORE_FL);
+DEF_NATIVE(pv_irq_ops,	irq_disable,		NATIVE_IRQ_DISABLE);
+DEF_NATIVE(pv_irq_ops,	irq_enable,		NATIVE_IRQ_ENABLE);
+DEF_NATIVE(pv_mmu_ops,	read_cr2,		NATIVE_READ_CR2);
+DEF_NATIVE(pv_mmu_ops,	read_cr3,		NATIVE_READ_CR3);
+DEF_NATIVE(pv_mmu_ops,	write_cr3,		NATIVE_WRITE_CR3);
+DEF_NATIVE(pv_mmu_ops,	flush_tlb_single,	NATIVE_FLUSH_TLB_SINGLE);
 
-DEF_NATIVE(pv_cpu_ops, usergs_sysret64, "swapgs; sysretq");
-DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
+DEF_NATIVE(pv_cpu_ops,	usergs_sysret64,	NATIVE_USERGS_SYSRET64);
+DEF_NATIVE(pv_cpu_ops,	swapgs,			NATIVE_SWAPGS);
 
-DEF_NATIVE(, mov32, "mov %edi, %eax");
-DEF_NATIVE(, mov64, "mov %rdi, %rax");
+DEF_NATIVE(,		mov32,			NATIVE_IDENTITY_32);
+DEF_NATIVE(,		mov64,			NATIVE_IDENTITY);
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
-DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %rax, %rax");
+DEF_NATIVE(pv_lock_ops,	queued_spin_unlock,	NATIVE_QUEUED_SPIN_UNLOCK);
+DEF_NATIVE(pv_lock_ops,	vcpu_is_preempted,	NATIVE_ZERO);
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
-- 
2.13.6
