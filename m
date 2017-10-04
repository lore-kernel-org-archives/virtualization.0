From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 09/13] x86/asm: Convert ALTERNATIVE*() assembler macros to
	preprocessor macros
Date: Wed,  4 Oct 2017 10:58:30 -0500
Message-ID: <9e97ee7a68cab00993c7afa8e429fd8fe5a7015f.1507128293.git.jpoimboe__41859.3493443497$1509079660$gmane$org@redhat.com>
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

The ALTERNATIVE() and ALTERNATIVE_2() macros are GNU assembler macros,
which makes them quite inflexible for future changes.  Convert them to
preprocessor macros.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/entry_32.S                | 12 +++---
 arch/x86/entry/entry_64.S                | 10 ++---
 arch/x86/entry/entry_64_compat.S         |  8 ++--
 arch/x86/entry/vdso/vdso32/system_call.S | 10 ++---
 arch/x86/include/asm/alternative-asm.h   | 68 +++++++++++++++-----------------
 arch/x86/include/asm/smap.h              |  4 +-
 arch/x86/lib/copy_page_64.S              |  2 +-
 arch/x86/lib/memcpy_64.S                 |  4 +-
 arch/x86/lib/memmove_64.S                |  3 +-
 arch/x86/lib/memset_64.S                 |  4 +-
 10 files changed, 59 insertions(+), 66 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 21d1197779a4..338dc838a9a8 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -443,8 +443,8 @@ ENTRY(entry_SYSENTER_32)
 	movl	%esp, %eax
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+	#define JMP_IF_IRET testl %eax, %eax; jz .Lsyscall_32_done
+	ALTERNATIVE(JMP_IF_IRET, jmp .Lsyscall_32_done, X86_FEATURE_XENPV)
 
 /* Opportunistic SYSEXIT */
 	TRACE_IRQS_ON			/* User mode traces as IRQs on. */
@@ -536,7 +536,7 @@ restore_all:
 	TRACE_IRQS_IRET
 .Lrestore_all_notrace:
 #ifdef CONFIG_X86_ESPFIX32
-	ALTERNATIVE	"jmp .Lrestore_nocheck", "", X86_BUG_ESPFIX
+	ALTERNATIVE(jmp .Lrestore_nocheck, , X86_BUG_ESPFIX)
 
 	movl	PT_EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
 	/*
@@ -692,9 +692,9 @@ ENTRY(simd_coprocessor_error)
 	pushl	$0
 #ifdef CONFIG_X86_INVD_BUG
 	/* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
-	ALTERNATIVE "pushl	$do_general_protection",	\
-		    "pushl	$do_simd_coprocessor_error",	\
-		    X86_FEATURE_XMM
+	ALTERNATIVE(pushl	$do_general_protection,
+		    pushl	$do_simd_coprocessor_error,
+		    X86_FEATURE_XMM)
 #else
 	pushl	$do_simd_coprocessor_error
 #endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c7c85724d7e0..49733c72619a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -925,7 +925,7 @@ ENTRY(native_load_gs_index)
 	SWAPGS
 .Lgs_change:
 	movl	%edi, %gs
-2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
+2:	ALTERNATIVE(, mfence, X86_BUG_SWAPGS_FENCE)
 	SWAPGS
 	popfq
 	FRAME_END
@@ -938,12 +938,8 @@ EXPORT_SYMBOL(native_load_gs_index)
 	/* running with kernelgs */
 bad_gs:
 	SWAPGS					/* switch back to user gs */
-.macro ZAP_GS
-	/* This can't be a string because the preprocessor needs to see it. */
-	movl $__USER_DS, %eax
-	movl %eax, %gs
-.endm
-	ALTERNATIVE "", "ZAP_GS", X86_BUG_NULL_SEG
+	#define ZAP_GS movl $__USER_DS, %eax; movl %eax, %gs
+	ALTERNATIVE(, ZAP_GS, X86_BUG_NULL_SEG)
 	xorl	%eax, %eax
 	movl	%eax, %gs
 	jmp	2b
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4d9385529c39..16e82b5103b5 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -124,8 +124,8 @@ ENTRY(entry_SYSENTER_compat)
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+	#define JMP_IF_IRET testl %eax, %eax; jz .Lsyscall_32_done
+	ALTERNATIVE(JMP_IF_IRET, jmp .Lsyscall_32_done, X86_FEATURE_XENPV)
 	jmp	sysret32_from_system_call
 
 .Lsysenter_fix_flags:
@@ -224,8 +224,8 @@ GLOBAL(entry_SYSCALL_compat_after_hwframe)
 	movq	%rsp, %rdi
 	call	do_fast_syscall_32
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz .Lsyscall_32_done", \
-		    "jmp .Lsyscall_32_done", X86_FEATURE_XENPV
+	ALTERNATIVE(JMP_IF_IRET,
+		    jmp .Lsyscall_32_done, X86_FEATURE_XENPV)
 
 	/* Opportunistic SYSRET */
 sysret32_from_system_call:
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index ed4bc9731cbb..a0c5f9e8226c 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -48,15 +48,15 @@ __kernel_vsyscall:
 	CFI_ADJUST_CFA_OFFSET	4
 	CFI_REL_OFFSET		ebp, 0
 
-	#define SYSENTER_SEQUENCE	"movl %esp, %ebp; sysenter"
-	#define SYSCALL_SEQUENCE	"movl %ecx, %ebp; syscall"
+	#define SYSENTER_SEQUENCE	movl %esp, %ebp; sysenter
+	#define SYSCALL_SEQUENCE	movl %ecx, %ebp; syscall
 
 #ifdef CONFIG_X86_64
 	/* If SYSENTER (Intel) or SYSCALL32 (AMD) is available, use it. */
-	ALTERNATIVE_2 "", SYSENTER_SEQUENCE, X86_FEATURE_SYSENTER32, \
-	                  SYSCALL_SEQUENCE,  X86_FEATURE_SYSCALL32
+	ALTERNATIVE_2(, SYSENTER_SEQUENCE, X86_FEATURE_SYSENTER32,
+			SYSCALL_SEQUENCE,  X86_FEATURE_SYSCALL32)
 #else
-	ALTERNATIVE "", SYSENTER_SEQUENCE, X86_FEATURE_SEP
+	ALTERNATIVE(, SYSENTER_SEQUENCE, X86_FEATURE_SEP)
 #endif
 
 	/* Enter using int $0x80 */
diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index e7636bac7372..60073947350d 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -39,23 +39,21 @@
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-.macro ALTERNATIVE oldinstr, newinstr, feature
-140:
-	\oldinstr
-141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature,142b-140b,144f-143f,142b-141b
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr
-144:
+#define ALTERNATIVE(oldinstr, newinstr, feature)			\
+140:;									\
+	oldinstr;							\
+141:;									\
+	.skip -(((144f-143f)-(141b-140b)) > 0) *			\
+		((144f-143f)-(141b-140b)),0x90;				\
+142:;									\
+	.pushsection .altinstructions, "a";				\
+	altinstruction_entry 140b,143f,feature,142b-140b,144f-143f,142b-141b;\
+	.popsection;							\
+	.pushsection .altinstr_replacement, "ax";			\
+143:;									\
+	newinstr;							\
+144:;									\
 	.popsection
-.endm
 
 #define old_len			141b-140b
 #define new_len1		144f-143f
@@ -73,27 +71,25 @@
  * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
  * @feature2, it replaces @oldinstr with @feature2.
  */
-.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_short(new_len1, new_len2) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstruction_entry 140b,143f,\feature1,142b-140b,144f-143f,142b-141b
-	altinstruction_entry 140b,144f,\feature2,142b-140b,145f-144f,142b-141b
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
+#define ALTERNATIVE_2(oldinstr, newinstr1, feature1,			\
+		      newinstr2, feature2)				\
+140:;									\
+	oldinstr;							\
+141:;									\
+	.skip -((alt_max_short(new_len1, new_len2) - (old_len)) > 0) *	\
+		(alt_max_short(new_len1, new_len2) - (old_len)),0x90;	\
+142:;									\
+	.pushsection .altinstructions, "a";				\
+	altinstruction_entry 140b,143f,feature1,142b-140b,144f-143f,142b-141b; \
+	altinstruction_entry 140b,144f,feature2,142b-140b,145f-144f,142b-141b; \
+	.popsection;							\
+	.pushsection .altinstr_replacement, "ax";			\
+143:;									\
+	newinstr1;							\
+144:;									\
+	newinstr2;							\
+145:;									\
 	.popsection
-.endm
 
 #endif  /*  __ASSEMBLY__  */
 
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index db333300bd4b..b1264cff8906 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -28,10 +28,10 @@
 #ifdef CONFIG_X86_SMAP
 
 #define ASM_CLAC \
-	ALTERNATIVE "", __stringify(__ASM_CLAC), X86_FEATURE_SMAP
+	ALTERNATIVE(, __ASM_CLAC, X86_FEATURE_SMAP)
 
 #define ASM_STAC \
-	ALTERNATIVE "", __stringify(__ASM_STAC), X86_FEATURE_SMAP
+	ALTERNATIVE(, __ASM_STAC, X86_FEATURE_SMAP)
 
 #else /* CONFIG_X86_SMAP */
 
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index e8508156c99d..0611dee51760 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -13,7 +13,7 @@
  */
 	ALIGN
 ENTRY(copy_page)
-	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
+	ALTERNATIVE(jmp copy_page_regs, , X86_FEATURE_REP_GOOD)
 	movl	$4096/8, %ecx
 	rep	movsq
 	ret
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 9a53a06e5a3e..7ada0513864b 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -28,8 +28,8 @@
  */
 ENTRY(__memcpy)
 ENTRY(memcpy)
-	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
-		      "jmp memcpy_erms", X86_FEATURE_ERMS
+	ALTERNATIVE_2(jmp memcpy_orig, , X86_FEATURE_REP_GOOD,
+		      jmp memcpy_erms, X86_FEATURE_ERMS)
 
 	movq %rdi, %rax
 	movq %rdx, %rcx
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 15de86cd15b0..ca6c39effa2f 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -42,7 +42,8 @@ ENTRY(__memmove)
 	jg 2f
 
 .Lmemmove_begin_forward:
-	ALTERNATIVE "", "movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
+	#define ERMS_MOVSB_RET movq %rdx, %rcx; rep movsb; retq
+	ALTERNATIVE(, ERMS_MOVSB_RET, X86_FEATURE_ERMS)
 
 	/*
 	 * movsq instruction have many startup latency
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 55b95db30a61..d86825a11724 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -26,8 +26,8 @@ ENTRY(__memset)
 	 *
 	 * Otherwise, use original memset function.
 	 */
-	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
-		      "jmp memset_erms", X86_FEATURE_ERMS
+	ALTERNATIVE_2(jmp memset_orig, , X86_FEATURE_REP_GOOD,
+		      jmp memset_erms, X86_FEATURE_ERMS)
 
 	movq %rdi,%r9
 	movq %rdx,%rcx
-- 
2.13.6
