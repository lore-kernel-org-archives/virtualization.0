From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 04/12] Revert "x86/paravirt: Work around GCC inlining bugs
	when compiling paravirt ops"
Date: Tue, 18 Dec 2018 01:03:19 +0900
Message-ID: <1545062607-8599-5-git-send-email-yamada.masahiro__16691.579440567$1545062949$gmane$org@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>, Richard Biener <rguenther@suse.de>, Kees Cook <keescook@chromium.org>, Segher Boessenkool <segher@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit 494b5168f2de009eb80f198f668da374295098dd.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/include/asm/paravirt_types.h | 56 ++++++++++++++++++-----------------
 arch/x86/kernel/macros.S              |  1 -
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 26942ad..488c596 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -348,11 +348,23 @@ extern struct paravirt_patch_template pv_ops;
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
+/*
+ * Generate some code, and mark it as patchable by the
+ * apply_paravirt() alternate instruction patcher.
+ */
+#define _paravirt_alt(insn_string, type, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	_ASM_ALIGN "\n"					\
+	_ASM_PTR " 771b\n"				\
+	"  .byte " type "\n"				\
+	"  .byte 772b-771b\n"				\
+	"  .short " clobber "\n"			\
+	".popsection\n"
+
 /* Generate patchable code, with the default asm parameters. */
-#define paravirt_call							\
-	"PARAVIRT_CALL type=\"%c[paravirt_typenum]\""			\
-	" clobber=\"%c[paravirt_clobber]\""				\
-	" pv_opptr=\"%c[paravirt_opptr]\";"
+#define paravirt_alt(insn_string)					\
+	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
 
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
@@ -373,6 +385,16 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len);
 int paravirt_disable_iospace(void);
 
 /*
+ * This generates an indirect call based on the operation type number.
+ * The type number, computed in PARAVIRT_PATCH, is derived from the
+ * offset into the paravirt_patch_template structure, and can therefore be
+ * freely converted back into a structure offset.
+ */
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr];"
+
+/*
  * These macros are intended to wrap calls through one of the paravirt
  * ops structs, so that they can be later identified and patched at
  * runtime.
@@ -509,7 +531,7 @@ int paravirt_disable_iospace(void);
 		/* since this condition will never hold */		\
 		if (sizeof(rettype) > sizeof(unsigned long)) {		\
 			asm volatile(pre				\
-				     paravirt_call			\
+				     paravirt_alt(PARAVIRT_CALL)	\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -519,7 +541,7 @@ int paravirt_disable_iospace(void);
 			__ret = (rettype)((((u64)__edx) << 32) | __eax); \
 		} else {						\
 			asm volatile(pre				\
-				     paravirt_call			\
+				     paravirt_alt(PARAVIRT_CALL)	\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -546,7 +568,7 @@ int paravirt_disable_iospace(void);
 		PVOP_VCALL_ARGS;					\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(pre					\
-			     paravirt_call				\
+			     paravirt_alt(PARAVIRT_CALL)		\
 			     post					\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
@@ -664,26 +686,6 @@ struct paravirt_patch_site {
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
-#else	/* __ASSEMBLY__ */
-
-/*
- * This generates an indirect call based on the operation type number.
- * The type number, computed in PARAVIRT_PATCH, is derived from the
- * offset into the paravirt_patch_template structure, and can therefore be
- * freely converted back into a structure offset.
- */
-.macro PARAVIRT_CALL type:req clobber:req pv_opptr:req
-771:	ANNOTATE_RETPOLINE_SAFE
-	call *\pv_opptr
-772:	.pushsection .parainstructions,"a"
-	_ASM_ALIGN
-	_ASM_PTR 771b
-	.byte \type
-	.byte 772b-771b
-	.short \clobber
-	.popsection
-.endm
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index 71d8b71..66ccb8e 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -10,4 +10,3 @@
 #include <asm/refcount.h>
 #include <asm/alternative-asm.h>
 #include <asm/bug.h>
-#include <asm/paravirt.h>
-- 
2.7.4
