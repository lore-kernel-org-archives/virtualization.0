From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 16/19] arm64: alternatives: Split up alternative.h
Date: Fri, 10 Jul 2020 17:52:00 +0100
Message-ID: <20200710165203.31284-17-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>, Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alan Stern <stern@rowland.harvard.edu>, Sami Tolvanen <samitolvanen@google.com>, Matt Turner <mattst88@gmail.com>, kernel-team@android.com, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-alpha@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

asm/alternative.h contains both the macros needed to use alternatives,
as well the type definitions and function prototypes for applying them.

Split the header in two, so that alternatives can be used from core
header files such as linux/compiler.h without the risk of circular
includes

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/alternative-macros.h | 276 ++++++++++++++++++++
 arch/arm64/include/asm/alternative.h        | 267 +------------------
 arch/arm64/include/asm/insn.h               |   3 +-
 3 files changed, 279 insertions(+), 267 deletions(-)
 create mode 100644 arch/arm64/include/asm/alternative-macros.h

diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
new file mode 100644
index 000000000000..8f4e4b60e72a
--- /dev/null
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -0,0 +1,276 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ALTERNATIVE_MACROS_H
+#define __ASM_ALTERNATIVE_MACROS_H
+
+#include <asm/cpucaps.h>
+
+#define ARM64_CB_PATCH ARM64_NCAPS
+
+/* A64 instructions are always 32 bits. */
+#define	AARCH64_INSN_SIZE		4
+
+#ifndef __ASSEMBLY__
+
+#include <linux/stringify.h>
+
+#define ALTINSTR_ENTRY(feature)					              \
+	" .word 661b - .\n"				/* label           */ \
+	" .word 663f - .\n"				/* new instruction */ \
+	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
+	" .byte 662b-661b\n"				/* source len      */ \
+	" .byte 664f-663f\n"				/* replacement len */
+
+#define ALTINSTR_ENTRY_CB(feature, cb)					      \
+	" .word 661b - .\n"				/* label           */ \
+	" .word " __stringify(cb) "- .\n"		/* callback */	      \
+	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
+	" .byte 662b-661b\n"				/* source len      */ \
+	" .byte 664f-663f\n"				/* replacement len */
+
+/*
+ * alternative assembly primitive:
+ *
+ * If any of these .org directive fail, it means that insn1 and insn2
+ * don't have the same length. This used to be written as
+ *
+ * .if ((664b-663b) != (662b-661b))
+ * 	.error "Alternatives instruction length mismatch"
+ * .endif
+ *
+ * but most assemblers die if insn1 or insn2 have a .inst. This should
+ * be fixed in a binutils release posterior to 2.25.51.0.2 (anything
+ * containing commit 4e4d08cf7399b606 or c1baaddf8861).
+ *
+ * Alternatives with callbacks do not generate replacement instructions.
+ */
+#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
+	".if "__stringify(cfg_enabled)" == 1\n"				\
+	"661:\n\t"							\
+	oldinstr "\n"							\
+	"662:\n"							\
+	".pushsection .altinstructions,\"a\"\n"				\
+	ALTINSTR_ENTRY(feature)						\
+	".popsection\n"							\
+	".subsection 1\n"						\
+	"663:\n\t"							\
+	newinstr "\n"							\
+	"664:\n\t"							\
+	".previous\n\t"							\
+	".org	. - (664b-663b) + (662b-661b)\n\t"			\
+	".org	. - (662b-661b) + (664b-663b)\n"			\
+	".endif\n"
+
+#define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\
+	".if "__stringify(cfg_enabled)" == 1\n"				\
+	"661:\n\t"							\
+	oldinstr "\n"							\
+	"662:\n"							\
+	".pushsection .altinstructions,\"a\"\n"				\
+	ALTINSTR_ENTRY_CB(feature, cb)					\
+	".popsection\n"							\
+	"663:\n\t"							\
+	"664:\n\t"							\
+	".endif\n"
+
+#define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
+	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
+
+#define ALTERNATIVE_CB(oldinstr, cb) \
+	__ALTERNATIVE_CFG_CB(oldinstr, ARM64_CB_PATCH, 1, cb)
+#else
+
+#include <asm/assembler.h>
+
+.macro altinstruction_entry orig_offset alt_offset feature orig_len alt_len
+	.word \orig_offset - .
+	.word \alt_offset - .
+	.hword \feature
+	.byte \orig_len
+	.byte \alt_len
+.endm
+
+.macro alternative_insn insn1, insn2, cap, enable = 1
+	.if \enable
+661:	\insn1
+662:	.pushsection .altinstructions, "a"
+	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
+	.popsection
+	.subsection 1
+663:	\insn2
+664:	.previous
+	.org	. - (664b-663b) + (662b-661b)
+	.org	. - (662b-661b) + (664b-663b)
+	.endif
+.endm
+
+/*
+ * Alternative sequences
+ *
+ * The code for the case where the capability is not present will be
+ * assembled and linked as normal. There are no restrictions on this
+ * code.
+ *
+ * The code for the case where the capability is present will be
+ * assembled into a special section to be used for dynamic patching.
+ * Code for that case must:
+ *
+ * 1. Be exactly the same length (in bytes) as the default code
+ *    sequence.
+ *
+ * 2. Not contain a branch target that is used outside of the
+ *    alternative sequence it is defined in (branches into an
+ *    alternative sequence are not fixed up).
+ */
+
+/*
+ * Begin an alternative code sequence.
+ */
+.macro alternative_if_not cap
+	.set .Lasm_alt_mode, 0
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
+	.popsection
+661:
+.endm
+
+.macro alternative_if cap
+	.set .Lasm_alt_mode, 1
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 663f, 661f, \cap, 664f-663f, 662f-661f
+	.popsection
+	.subsection 1
+	.align 2	/* So GAS knows label 661 is suitably aligned */
+661:
+.endm
+
+.macro alternative_cb cb
+	.set .Lasm_alt_mode, 0
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 661f, \cb, ARM64_CB_PATCH, 662f-661f, 0
+	.popsection
+661:
+.endm
+
+/*
+ * Provide the other half of the alternative code sequence.
+ */
+.macro alternative_else
+662:
+	.if .Lasm_alt_mode==0
+	.subsection 1
+	.else
+	.previous
+	.endif
+663:
+.endm
+
+/*
+ * Complete an alternative code sequence.
+ */
+.macro alternative_endif
+664:
+	.if .Lasm_alt_mode==0
+	.previous
+	.endif
+	.org	. - (664b-663b) + (662b-661b)
+	.org	. - (662b-661b) + (664b-663b)
+.endm
+
+/*
+ * Callback-based alternative epilogue
+ */
+.macro alternative_cb_end
+662:
+.endm
+
+/*
+ * Provides a trivial alternative or default sequence consisting solely
+ * of NOPs. The number of NOPs is chosen automatically to match the
+ * previous case.
+ */
+.macro alternative_else_nop_endif
+alternative_else
+	nops	(662b-661b) / AARCH64_INSN_SIZE
+alternative_endif
+.endm
+
+#define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)	\
+	alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
+
+.macro user_alt, label, oldinstr, newinstr, cond
+9999:	alternative_insn "\oldinstr", "\newinstr", \cond
+	_asm_extable 9999b, \label
+.endm
+
+/*
+ * Generate the assembly for UAO alternatives with exception table entries.
+ * This is complicated as there is no post-increment or pair versions of the
+ * unprivileged instructions, and USER() only works for single instructions.
+ */
+#ifdef CONFIG_ARM64_UAO
+	.macro uao_ldp l, reg1, reg2, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			ldp	\reg1, \reg2, [\addr], \post_inc;
+8889:			nop;
+			nop;
+		alternative_else
+			ldtr	\reg1, [\addr];
+			ldtr	\reg2, [\addr, #8];
+			add	\addr, \addr, \post_inc;
+		alternative_endif
+
+		_asm_extable	8888b,\l;
+		_asm_extable	8889b,\l;
+	.endm
+
+	.macro uao_stp l, reg1, reg2, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			stp	\reg1, \reg2, [\addr], \post_inc;
+8889:			nop;
+			nop;
+		alternative_else
+			sttr	\reg1, [\addr];
+			sttr	\reg2, [\addr, #8];
+			add	\addr, \addr, \post_inc;
+		alternative_endif
+
+		_asm_extable	8888b,\l;
+		_asm_extable	8889b,\l;
+	.endm
+
+	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			\inst	\reg, [\addr], \post_inc;
+			nop;
+		alternative_else
+			\alt_inst	\reg, [\addr];
+			add		\addr, \addr, \post_inc;
+		alternative_endif
+
+		_asm_extable	8888b,\l;
+	.endm
+#else
+	.macro uao_ldp l, reg1, reg2, addr, post_inc
+		USER(\l, ldp \reg1, \reg2, [\addr], \post_inc)
+	.endm
+	.macro uao_stp l, reg1, reg2, addr, post_inc
+		USER(\l, stp \reg1, \reg2, [\addr], \post_inc)
+	.endm
+	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
+		USER(\l, \inst \reg, [\addr], \post_inc)
+	.endm
+#endif
+
+#endif  /*  __ASSEMBLY__  */
+
+/*
+ * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature));
+ *
+ * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature, CONFIG_FOO));
+ * N.B. If CONFIG_FOO is specified, but not selected, the whole block
+ *      will be omitted, including oldinstr.
+ */
+#define ALTERNATIVE(oldinstr, newinstr, ...)   \
+	_ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
+
+#endif /* __ASM_ALTERNATIVE_MACROS_H */
diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 12f0eb56a1cc..a38b92e11811 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -2,17 +2,13 @@
 #ifndef __ASM_ALTERNATIVE_H
 #define __ASM_ALTERNATIVE_H
 
-#include <asm/cpucaps.h>
-#include <asm/insn.h>
-
-#define ARM64_CB_PATCH ARM64_NCAPS
+#include <asm/alternative-macros.h>
 
 #ifndef __ASSEMBLY__
 
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
-#include <linux/stringify.h>
 
 struct alt_instr {
 	s32 orig_offset;	/* offset to original instruction */
@@ -35,264 +31,5 @@ void apply_alternatives_module(void *start, size_t length);
 static inline void apply_alternatives_module(void *start, size_t length) { }
 #endif
 
-#define ALTINSTR_ENTRY(feature)					              \
-	" .word 661b - .\n"				/* label           */ \
-	" .word 663f - .\n"				/* new instruction */ \
-	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
-	" .byte 662b-661b\n"				/* source len      */ \
-	" .byte 664f-663f\n"				/* replacement len */
-
-#define ALTINSTR_ENTRY_CB(feature, cb)					      \
-	" .word 661b - .\n"				/* label           */ \
-	" .word " __stringify(cb) "- .\n"		/* callback */	      \
-	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
-	" .byte 662b-661b\n"				/* source len      */ \
-	" .byte 664f-663f\n"				/* replacement len */
-
-/*
- * alternative assembly primitive:
- *
- * If any of these .org directive fail, it means that insn1 and insn2
- * don't have the same length. This used to be written as
- *
- * .if ((664b-663b) != (662b-661b))
- * 	.error "Alternatives instruction length mismatch"
- * .endif
- *
- * but most assemblers die if insn1 or insn2 have a .inst. This should
- * be fixed in a binutils release posterior to 2.25.51.0.2 (anything
- * containing commit 4e4d08cf7399b606 or c1baaddf8861).
- *
- * Alternatives with callbacks do not generate replacement instructions.
- */
-#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
-	".if "__stringify(cfg_enabled)" == 1\n"				\
-	"661:\n\t"							\
-	oldinstr "\n"							\
-	"662:\n"							\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature)						\
-	".popsection\n"							\
-	".subsection 1\n"						\
-	"663:\n\t"							\
-	newinstr "\n"							\
-	"664:\n\t"							\
-	".previous\n\t"							\
-	".org	. - (664b-663b) + (662b-661b)\n\t"			\
-	".org	. - (662b-661b) + (664b-663b)\n"			\
-	".endif\n"
-
-#define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\
-	".if "__stringify(cfg_enabled)" == 1\n"				\
-	"661:\n\t"							\
-	oldinstr "\n"							\
-	"662:\n"							\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY_CB(feature, cb)					\
-	".popsection\n"							\
-	"663:\n\t"							\
-	"664:\n\t"							\
-	".endif\n"
-
-#define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
-	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
-
-#define ALTERNATIVE_CB(oldinstr, cb) \
-	__ALTERNATIVE_CFG_CB(oldinstr, ARM64_CB_PATCH, 1, cb)
-#else
-
-#include <asm/assembler.h>
-
-.macro altinstruction_entry orig_offset alt_offset feature orig_len alt_len
-	.word \orig_offset - .
-	.word \alt_offset - .
-	.hword \feature
-	.byte \orig_len
-	.byte \alt_len
-.endm
-
-.macro alternative_insn insn1, insn2, cap, enable = 1
-	.if \enable
-661:	\insn1
-662:	.pushsection .altinstructions, "a"
-	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
-	.popsection
-	.subsection 1
-663:	\insn2
-664:	.previous
-	.org	. - (664b-663b) + (662b-661b)
-	.org	. - (662b-661b) + (664b-663b)
-	.endif
-.endm
-
-/*
- * Alternative sequences
- *
- * The code for the case where the capability is not present will be
- * assembled and linked as normal. There are no restrictions on this
- * code.
- *
- * The code for the case where the capability is present will be
- * assembled into a special section to be used for dynamic patching.
- * Code for that case must:
- *
- * 1. Be exactly the same length (in bytes) as the default code
- *    sequence.
- *
- * 2. Not contain a branch target that is used outside of the
- *    alternative sequence it is defined in (branches into an
- *    alternative sequence are not fixed up).
- */
-
-/*
- * Begin an alternative code sequence.
- */
-.macro alternative_if_not cap
-	.set .Lasm_alt_mode, 0
-	.pushsection .altinstructions, "a"
-	altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
-	.popsection
-661:
-.endm
-
-.macro alternative_if cap
-	.set .Lasm_alt_mode, 1
-	.pushsection .altinstructions, "a"
-	altinstruction_entry 663f, 661f, \cap, 664f-663f, 662f-661f
-	.popsection
-	.subsection 1
-	.align 2	/* So GAS knows label 661 is suitably aligned */
-661:
-.endm
-
-.macro alternative_cb cb
-	.set .Lasm_alt_mode, 0
-	.pushsection .altinstructions, "a"
-	altinstruction_entry 661f, \cb, ARM64_CB_PATCH, 662f-661f, 0
-	.popsection
-661:
-.endm
-
-/*
- * Provide the other half of the alternative code sequence.
- */
-.macro alternative_else
-662:
-	.if .Lasm_alt_mode==0
-	.subsection 1
-	.else
-	.previous
-	.endif
-663:
-.endm
-
-/*
- * Complete an alternative code sequence.
- */
-.macro alternative_endif
-664:
-	.if .Lasm_alt_mode==0
-	.previous
-	.endif
-	.org	. - (664b-663b) + (662b-661b)
-	.org	. - (662b-661b) + (664b-663b)
-.endm
-
-/*
- * Callback-based alternative epilogue
- */
-.macro alternative_cb_end
-662:
-.endm
-
-/*
- * Provides a trivial alternative or default sequence consisting solely
- * of NOPs. The number of NOPs is chosen automatically to match the
- * previous case.
- */
-.macro alternative_else_nop_endif
-alternative_else
-	nops	(662b-661b) / AARCH64_INSN_SIZE
-alternative_endif
-.endm
-
-#define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)	\
-	alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
-
-.macro user_alt, label, oldinstr, newinstr, cond
-9999:	alternative_insn "\oldinstr", "\newinstr", \cond
-	_asm_extable 9999b, \label
-.endm
-
-/*
- * Generate the assembly for UAO alternatives with exception table entries.
- * This is complicated as there is no post-increment or pair versions of the
- * unprivileged instructions, and USER() only works for single instructions.
- */
-#ifdef CONFIG_ARM64_UAO
-	.macro uao_ldp l, reg1, reg2, addr, post_inc
-		alternative_if_not ARM64_HAS_UAO
-8888:			ldp	\reg1, \reg2, [\addr], \post_inc;
-8889:			nop;
-			nop;
-		alternative_else
-			ldtr	\reg1, [\addr];
-			ldtr	\reg2, [\addr, #8];
-			add	\addr, \addr, \post_inc;
-		alternative_endif
-
-		_asm_extable	8888b,\l;
-		_asm_extable	8889b,\l;
-	.endm
-
-	.macro uao_stp l, reg1, reg2, addr, post_inc
-		alternative_if_not ARM64_HAS_UAO
-8888:			stp	\reg1, \reg2, [\addr], \post_inc;
-8889:			nop;
-			nop;
-		alternative_else
-			sttr	\reg1, [\addr];
-			sttr	\reg2, [\addr, #8];
-			add	\addr, \addr, \post_inc;
-		alternative_endif
-
-		_asm_extable	8888b,\l;
-		_asm_extable	8889b,\l;
-	.endm
-
-	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
-		alternative_if_not ARM64_HAS_UAO
-8888:			\inst	\reg, [\addr], \post_inc;
-			nop;
-		alternative_else
-			\alt_inst	\reg, [\addr];
-			add		\addr, \addr, \post_inc;
-		alternative_endif
-
-		_asm_extable	8888b,\l;
-	.endm
-#else
-	.macro uao_ldp l, reg1, reg2, addr, post_inc
-		USER(\l, ldp \reg1, \reg2, [\addr], \post_inc)
-	.endm
-	.macro uao_stp l, reg1, reg2, addr, post_inc
-		USER(\l, stp \reg1, \reg2, [\addr], \post_inc)
-	.endm
-	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
-		USER(\l, \inst \reg, [\addr], \post_inc)
-	.endm
-#endif
-
-#endif  /*  __ASSEMBLY__  */
-
-/*
- * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature));
- *
- * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature, CONFIG_FOO));
- * N.B. If CONFIG_FOO is specified, but not selected, the whole block
- *      will be omitted, including oldinstr.
- */
-#define ALTERNATIVE(oldinstr, newinstr, ...)   \
-	_ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
-
+#endif /* __ASSEMBLY__ */
 #endif /* __ASM_ALTERNATIVE_H */
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 0bc46149e491..01da70ba2fb9 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -10,8 +10,7 @@
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
-/* A64 instructions are always 32 bits. */
-#define	AARCH64_INSN_SIZE		4
+#include <asm/alternative.h>
 
 #ifndef __ASSEMBLY__
 /*
-- 
2.27.0.383.g050319c2ae-goog
