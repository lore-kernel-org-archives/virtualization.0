From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 01/26] x86/paravirt: Specify subsection in PVOP macros
Date: Tue,  7 Apr 2020 22:02:58 -0700
Message-ID: <20200408050323.4237-2-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Allow PVOP macros to specify a subsection such that _paravirt_alt() can
optionally put sites in .parainstructions.*.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/paravirt_types.h | 158 +++++++++++++++++---------
 1 file changed, 102 insertions(+), 56 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 732f62e04ddb..37e8f27a3b9d 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -337,6 +337,9 @@ struct paravirt_patch_template {
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
 
+/* Sub-section for .parainstructions */
+#define PV_SUFFIX ""
+
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
@@ -350,9 +353,9 @@ extern struct paravirt_patch_template pv_ops;
  * Generate some code, and mark it as patchable by the
  * apply_paravirt() alternate instruction patcher.
  */
-#define _paravirt_alt(insn_string, type, clobber)	\
+#define _paravirt_alt(sec, insn_string, type, clobber)	\
 	"771:\n\t" insn_string "\n" "772:\n"		\
-	".pushsection .parainstructions,\"a\"\n"	\
+	".pushsection .parainstructions" sec ",\"a\"\n"	\
 	_ASM_ALIGN "\n"					\
 	_ASM_PTR " 771b\n"				\
 	"  .byte " type "\n"				\
@@ -361,8 +364,9 @@ extern struct paravirt_patch_template pv_ops;
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */
-#define paravirt_alt(insn_string)					\
-	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
+#define paravirt_alt(sec, insn_string)					\
+	_paravirt_alt(sec, insn_string, "%c[paravirt_typenum]",		\
+		      "%c[paravirt_clobber]")
 
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
@@ -414,7 +418,7 @@ int paravirt_disable_iospace(void);
  * unfortunately, are quite a bit (r8 - r11)
  *
  * The call instruction itself is marked by placing its start address
- * and size into the .parainstructions section, so that
+ * and size into the .parainstructions* sections, so that
  * apply_paravirt() in arch/i386/kernel/alternative.c can do the
  * appropriate patching under the control of the backend pv_init_ops
  * implementation.
@@ -512,7 +516,7 @@ int paravirt_disable_iospace(void);
 	})
 
 
-#define ____PVOP_CALL(rettype, op, clbr, call_clbr, extra_clbr,		\
+#define ____PVOP_CALL(sec, rettype, op, clbr, call_clbr, extra_clbr,	\
 		      pre, post, ...)					\
 	({								\
 		rettype __ret;						\
@@ -522,7 +526,7 @@ int paravirt_disable_iospace(void);
 		/* since this condition will never hold */		\
 		if (sizeof(rettype) > sizeof(unsigned long)) {		\
 			asm volatile(pre				\
-				     paravirt_alt(PARAVIRT_CALL)	\
+				     paravirt_alt(sec, PARAVIRT_CALL)	\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -532,7 +536,7 @@ int paravirt_disable_iospace(void);
 			__ret = (rettype)((((u64)__edx) << 32) | __eax); \
 		} else {						\
 			asm volatile(pre				\
-				     paravirt_alt(PARAVIRT_CALL)	\
+				     paravirt_alt(sec, PARAVIRT_CALL)	\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -544,22 +548,22 @@ int paravirt_disable_iospace(void);
 		__ret;							\
 	})
 
-#define __PVOP_CALL(rettype, op, pre, post, ...)			\
-	____PVOP_CALL(rettype, op, CLBR_ANY, PVOP_CALL_CLOBBERS,	\
+#define __PVOP_CALL(sec, rettype, op, pre, post, ...)			\
+	____PVOP_CALL(sec, rettype, op, CLBR_ANY, PVOP_CALL_CLOBBERS,	\
 		      EXTRA_CLOBBERS, pre, post, ##__VA_ARGS__)
 
-#define __PVOP_CALLEESAVE(rettype, op, pre, post, ...)			\
-	____PVOP_CALL(rettype, op.func, CLBR_RET_REG,			\
+#define __PVOP_CALLEESAVE(sec, rettype, op, pre, post, ...)		\
+	____PVOP_CALL(sec, rettype, op.func, CLBR_RET_REG,		\
 		      PVOP_CALLEE_CLOBBERS, ,				\
 		      pre, post, ##__VA_ARGS__)
 
 
-#define ____PVOP_VCALL(op, clbr, call_clbr, extra_clbr, pre, post, ...)	\
+#define ____PVOP_VCALL(sec, op, clbr, call_clbr, extra_clbr, pre, post, ...)	\
 	({								\
 		PVOP_VCALL_ARGS;					\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(pre					\
-			     paravirt_alt(PARAVIRT_CALL)		\
+			     paravirt_alt(sec, PARAVIRT_CALL)		\
 			     post					\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
@@ -568,85 +572,127 @@ int paravirt_disable_iospace(void);
 			     : "memory", "cc" extra_clbr);		\
 	})
 
-#define __PVOP_VCALL(op, pre, post, ...)				\
-	____PVOP_VCALL(op, CLBR_ANY, PVOP_VCALL_CLOBBERS,		\
+#define __PVOP_VCALL(sec, op, pre, post, ...)				\
+	____PVOP_VCALL(sec, op, CLBR_ANY, PVOP_VCALL_CLOBBERS,		\
 		       VEXTRA_CLOBBERS,					\
 		       pre, post, ##__VA_ARGS__)
 
-#define __PVOP_VCALLEESAVE(op, pre, post, ...)				\
-	____PVOP_VCALL(op.func, CLBR_RET_REG,				\
+#define __PVOP_VCALLEESAVE(sec, op, pre, post, ...)			\
+	____PVOP_VCALL(sec, op.func, CLBR_RET_REG,			\
 		      PVOP_VCALLEE_CLOBBERS, ,				\
 		      pre, post, ##__VA_ARGS__)
 
 
 
-#define PVOP_CALL0(rettype, op)						\
-	__PVOP_CALL(rettype, op, "", "")
-#define PVOP_VCALL0(op)							\
-	__PVOP_VCALL(op, "", "")
+#define _PVOP_CALL0(sec, rettype, op)					\
+	__PVOP_CALL(sec, rettype, op, "", "")
+#define _PVOP_VCALL0(sec, op)						\
+	__PVOP_VCALL(sec, op, "", "")
 
-#define PVOP_CALLEE0(rettype, op)					\
-	__PVOP_CALLEESAVE(rettype, op, "", "")
-#define PVOP_VCALLEE0(op)						\
-	__PVOP_VCALLEESAVE(op, "", "")
+#define _PVOP_CALLEE0(sec, rettype, op)					\
+	__PVOP_CALLEESAVE(sec, rettype, op, "", "")
+#define _PVOP_VCALLEE0(sec, op)						\
+	__PVOP_VCALLEESAVE(sec, op, "", "")
 
 
-#define PVOP_CALL1(rettype, op, arg1)					\
-	__PVOP_CALL(rettype, op, "", "", PVOP_CALL_ARG1(arg1))
-#define PVOP_VCALL1(op, arg1)						\
-	__PVOP_VCALL(op, "", "", PVOP_CALL_ARG1(arg1))
+#define _PVOP_CALL1(sec, rettype, op, arg1)				\
+	__PVOP_CALL(sec, rettype, op, "", "", PVOP_CALL_ARG1(arg1))
+#define _PVOP_VCALL1(sec, op, arg1)					\
+	__PVOP_VCALL(sec, op, "", "", PVOP_CALL_ARG1(arg1))
 
-#define PVOP_CALLEE1(rettype, op, arg1)					\
-	__PVOP_CALLEESAVE(rettype, op, "", "", PVOP_CALL_ARG1(arg1))
-#define PVOP_VCALLEE1(op, arg1)						\
-	__PVOP_VCALLEESAVE(op, "", "", PVOP_CALL_ARG1(arg1))
+#define _PVOP_CALLEE1(sec, rettype, op, arg1)				\
+	__PVOP_CALLEESAVE(sec, rettype, op, "", "", PVOP_CALL_ARG1(arg1))
+#define _PVOP_VCALLEE1(sec, op, arg1)					\
+	__PVOP_VCALLEESAVE(sec, op, "", "", PVOP_CALL_ARG1(arg1))
 
-
-#define PVOP_CALL2(rettype, op, arg1, arg2)				\
-	__PVOP_CALL(rettype, op, "", "", PVOP_CALL_ARG1(arg1),		\
+#define _PVOP_CALL2(sec, rettype, op, arg1, arg2)			\
+	__PVOP_CALL(sec, rettype, op, "", "", PVOP_CALL_ARG1(arg1),	\
 		    PVOP_CALL_ARG2(arg2))
-#define PVOP_VCALL2(op, arg1, arg2)					\
-	__PVOP_VCALL(op, "", "", PVOP_CALL_ARG1(arg1),			\
+#define _PVOP_VCALL2(sec, op, arg1, arg2)				\
+	__PVOP_VCALL(sec, op, "", "", PVOP_CALL_ARG1(arg1),		\
 		     PVOP_CALL_ARG2(arg2))
 
-#define PVOP_CALLEE2(rettype, op, arg1, arg2)				\
-	__PVOP_CALLEESAVE(rettype, op, "", "", PVOP_CALL_ARG1(arg1),	\
+#define _PVOP_CALLEE2(sec, rettype, op, arg1, arg2)			\
+	__PVOP_CALLEESAVE(sec, rettype, op, "", "", PVOP_CALL_ARG1(arg1), \
 			  PVOP_CALL_ARG2(arg2))
-#define PVOP_VCALLEE2(op, arg1, arg2)					\
-	__PVOP_VCALLEESAVE(op, "", "", PVOP_CALL_ARG1(arg1),		\
+#define _PVOP_VCALLEE2(sec, op, arg1, arg2)				\
+	__PVOP_VCALLEESAVE(sec, op, "", "", PVOP_CALL_ARG1(arg1),	\
 			   PVOP_CALL_ARG2(arg2))
 
 
-#define PVOP_CALL3(rettype, op, arg1, arg2, arg3)			\
-	__PVOP_CALL(rettype, op, "", "", PVOP_CALL_ARG1(arg1),		\
+#define _PVOP_CALL3(sec, rettype, op, arg1, arg2, arg3)			\
+	__PVOP_CALL(sec, rettype, op, "", "", PVOP_CALL_ARG1(arg1),	\
 		    PVOP_CALL_ARG2(arg2), PVOP_CALL_ARG3(arg3))
-#define PVOP_VCALL3(op, arg1, arg2, arg3)				\
-	__PVOP_VCALL(op, "", "", PVOP_CALL_ARG1(arg1),			\
+#define _PVOP_VCALL3(sec, op, arg1, arg2, arg3)				\
+	__PVOP_VCALL(sec, op, "", "", PVOP_CALL_ARG1(arg1),		\
 		     PVOP_CALL_ARG2(arg2), PVOP_CALL_ARG3(arg3))
 
 /* This is the only difference in x86_64. We can make it much simpler */
 #ifdef CONFIG_X86_32
-#define PVOP_CALL4(rettype, op, arg1, arg2, arg3, arg4)			\
-	__PVOP_CALL(rettype, op,					\
+#define _PVOP_CALL4(sec, rettype, op, arg1, arg2, arg3, arg4)		\
+	__PVOP_CALL(sec, rettype, op,					\
 		    "push %[_arg4];", "lea 4(%%esp),%%esp;",		\
 		    PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),		\
 		    PVOP_CALL_ARG3(arg3), [_arg4] "mr" ((u32)(arg4)))
-#define PVOP_VCALL4(op, arg1, arg2, arg3, arg4)				\
-	__PVOP_VCALL(op,						\
+#define _PVOP_VCALL4(sec, op, arg1, arg2, arg3, arg4)			\
+	__PVOP_VCALL(sec, op,						\
 		    "push %[_arg4];", "lea 4(%%esp),%%esp;",		\
 		    "0" ((u32)(arg1)), "1" ((u32)(arg2)),		\
 		    "2" ((u32)(arg3)), [_arg4] "mr" ((u32)(arg4)))
 #else
-#define PVOP_CALL4(rettype, op, arg1, arg2, arg3, arg4)			\
-	__PVOP_CALL(rettype, op, "", "",				\
+#define _PVOP_CALL4(sec, rettype, op, arg1, arg2, arg3, arg4)		\
+	__PVOP_CALL(sec, rettype, op, "", "",				\
 		    PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),		\
 		    PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
-#define PVOP_VCALL4(op, arg1, arg2, arg3, arg4)				\
-	__PVOP_VCALL(op, "", "",					\
+#define _PVOP_VCALL4(sec, op, arg1, arg2, arg3, arg4)			\
+	__PVOP_VCALL(sec, op, "", "",					\
 		     PVOP_CALL_ARG1(arg1), PVOP_CALL_ARG2(arg2),	\
 		     PVOP_CALL_ARG3(arg3), PVOP_CALL_ARG4(arg4))
 #endif
 
+/*
+ * PVOP macros for .parainstructions
+ */
+#define PVOP_CALL0(rettype, op)						\
+	_PVOP_CALL0(PV_SUFFIX, rettype, op)
+#define PVOP_VCALL0(op)							\
+	_PVOP_VCALL0(PV_SUFFIX, op)
+
+#define PVOP_CALLEE0(rettype, op)					\
+	_PVOP_CALLEE0(PV_SUFFIX, rettype, op)
+#define PVOP_VCALLEE0(op)						\
+	_PVOP_VCALLEE0(PV_SUFFIX, op)
+
+#define PVOP_CALL1(rettype, op, arg1)					\
+	_PVOP_CALL1(PV_SUFFIX, rettype, op, arg1)
+#define PVOP_VCALL1(op, arg1)						\
+	_PVOP_VCALL1(PV_SUFFIX, op, arg1)
+
+#define PVOP_CALLEE1(rettype, op, arg1)					\
+	_PVOP_CALLEE1(PV_SUFFIX, rettype, op, arg1)
+#define PVOP_VCALLEE1(op, arg1)						\
+	_PVOP_VCALLEE1(PV_SUFFIX, op, arg1)
+
+#define PVOP_CALL2(rettype, op, arg1, arg2)				\
+	_PVOP_CALL2(PV_SUFFIX, rettype, op, arg1, arg2)
+#define PVOP_VCALL2(op, arg1, arg2)					\
+	_PVOP_VCALL2(PV_SUFFIX, op, arg1, arg2)
+
+#define PVOP_CALLEE2(rettype, op, arg1, arg2)				\
+	_PVOP_CALLEE2(PV_SUFFIX, rettype, op, arg1, arg2)
+#define PVOP_VCALLEE2(op, arg1, arg2)					\
+	_PVOP_VCALLEE2(PV_SUFFIX, op, arg1, arg2)
+
+#define PVOP_CALL3(rettype, op, arg1, arg2, arg3)			\
+	_PVOP_CALL3(PV_SUFFIX, rettype, op, arg1, arg2, arg3)
+#define PVOP_VCALL3(op, arg1, arg2, arg3)				\
+	_PVOP_VCALL3(PV_SUFFIX, op, arg1, arg2, arg3)
+
+#define PVOP_CALL4(rettype, op, arg1, arg2, arg3, arg4)			\
+	_PVOP_CALL4(PV_SUFFIX, rettype, op, arg1, arg2, arg3, arg4)
+#define PVOP_VCALL4(op, arg1, arg2, arg3, arg4)				\
+	_PVOP_VCALL4(PV_SUFFIX, op, arg1, arg2, arg3, arg4)
+
 /* Lazy mode for batching updates / context switch */
 enum paravirt_lazy_mode {
 	PARAVIRT_LAZY_NONE,
@@ -667,7 +713,7 @@ u64 _paravirt_ident_64(u64);
 
 #define paravirt_nop	((void *)_paravirt_nop)
 
-/* These all sit in the .parainstructions section to tell us what to patch. */
+/* These all sit in .parainstructions* sections to tell us what to patch. */
 struct paravirt_patch_site {
 	u8 *instr;		/* original instructions */
 	u8 type;		/* type of this instruction */
-- 
2.20.1
