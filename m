From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 04/13] x86/paravirt: Convert DEF_NATIVE macro to GCC extended
	asm syntax
Date: Wed,  4 Oct 2017 10:58:25 -0500
Message-ID: <fc26aa39d00294fce9f669ea4757135ac02eae0a.1507128293.git.jpoimboe__45528.55510633$1509079605$gmane$org@redhat.com>
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

In a future patch, the NATIVE_* instruction string macros will be used
in GCC extended inline asm, which requires registers to have two '%'
instead of one in the asm template string.  Convert the DEF_NATIVE macro
to the GCC extended asm syntax so the NATIVE_* macros can be shared more
broadly.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/paravirt_types.h | 10 +++++++---
 arch/x86/include/asm/special_insns.h  | 14 +++++++-------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index e99e5ac3e036..ab7aabe6b668 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -359,11 +359,15 @@ extern struct pv_lock_ops pv_lock_ops;
 	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
 
 /* Simple instruction patching code. */
-#define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
+#define NATIVE_LABEL(a,x,b) "\n" a #x "_" #b ":\n\t"
 
 #define DEF_NATIVE(ops, name, code)					\
-	__visible extern const char start_##ops##_##name[], end_##ops##_##name[];	\
-	asm(NATIVE_LABEL("start_", ops, name) code NATIVE_LABEL("end_", ops, name))
+static inline void __used __native_ ## name ## _insns(void) {		\
+	asm volatile(NATIVE_LABEL("start_", ops, name)			\
+		     code						\
+		     NATIVE_LABEL("end_", ops, name) : );		\
+} \
+__visible extern const char start_##ops##_##name[], end_##ops##_##name[];
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 0549c5f2c1b3..4b89668f2862 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -7,14 +7,14 @@
 #include <asm/nops.h>
 
 #ifdef CONFIG_X86_64
-# define _REG_ARG1			"%rdi"
-# define NATIVE_IDENTITY_32		"mov %edi, %eax"
+# define _REG_ARG1			"%%rdi"
+# define NATIVE_IDENTITY_32		"mov %%edi, %%eax"
 # define NATIVE_USERGS_SYSRET64		"swapgs; sysretq"
 #else
-# define _REG_ARG1			"%eax"
+# define _REG_ARG1			"%%eax"
 #endif
 
-#define _REG_RET			"%" _ASM_AX
+#define _REG_RET			"%%" _ASM_AX
 
 #define NATIVE_ZERO			"xor " _REG_ARG1 ", " _REG_ARG1
 #define NATIVE_IDENTITY			"mov " _REG_ARG1 ", " _REG_RET
@@ -22,9 +22,9 @@
 #define NATIVE_RESTORE_FL		"push " _REG_ARG1 "; popf"
 #define NATIVE_IRQ_DISABLE		"cli"
 #define NATIVE_IRQ_ENABLE		"sti"
-#define NATIVE_READ_CR2			"mov %cr2, " _REG_RET
-#define NATIVE_READ_CR3			"mov %cr3, " _REG_RET
-#define NATIVE_WRITE_CR3		"mov " _REG_ARG1 ", %cr3"
+#define NATIVE_READ_CR2			"mov %%cr2, " _REG_RET
+#define NATIVE_READ_CR3			"mov %%cr3, " _REG_RET
+#define NATIVE_WRITE_CR3		"mov " _REG_ARG1 ", %%cr3"
 #define NATIVE_FLUSH_TLB_SINGLE		"invlpg (" _REG_ARG1 ")"
 #define NATIVE_SWAPGS			"swapgs"
 #define NATIVE_IRET			"iret"
-- 
2.13.6
