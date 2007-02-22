From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: rough sketch of revised patching infrastructure
Date: Thu, 22 Feb 2007 02:22:47 -0800
Message-ID: <45DD6EF7.9060808@goop.org>
References: <45DCFB6E.2010806@goop.org>
	<1172115803.13378.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000901070706000208040105"
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1172115803.13378.63.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------000901070706000208040105
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Rusty Russell wrote:
> On Wed, 2007-02-21 at 18:09 -0800, Jeremy Fitzhardinge wrote:
>   
>> Here's the new patching patch.  It compiles, but it doesn't, you know,
>> boot, as such.
>>     
>
> OK, there are several separate things here.
> (1) Get rid of the PARAVIRT_IRQ_DISABLE etc constants in favour of
> offsetof within the structure.
> (2) Change (almost) all the paravirt hooks to be patchable.
> (3) Genericise the infrastructure to table-driven.
>
> These should probably become separate patches, in fact.
>   

OK, here's something which is more presentable, and it even boots (at
least under Xen; haven't tried native).

paravirt-patch-rename-paravirt_patch.patch
paravirt-use-offset-site-ids.patch
paravirt-fix-clobbers.patch
 - misc cleanups
paravirt-patchable-call-wrappers.patch
 - wrap a large number of the paravirt calls with the magic to make the
callsites patchable.  More are possible; this is just a good first step.
paravirt-patch-machinery.patch
 - the actual patching machinery, which is function-pointer driven
rather than table driven now.

    J

--------------000901070706000208040105
Content-Type: text/x-patch; name="paravirt-patch-rename-paravirt_patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="paravirt-patch-rename-paravirt_patch.patch"

Rename struct paravirt_patch to paravirt_patch_site, so that it
clearly refers to a callsite, and no the patch which may be applied to
the callsite.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

===================================================================
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -350,9 +350,9 @@ void alternatives_smp_switch(int smp)
 #endif
 
 #ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
-{
-	struct paravirt_patch *p;
+void apply_paravirt(struct paravirt_patch_site *start, struct paravirt_patch_site *end)
+{
+	struct paravirt_patch_site *p;
 
 	for (p = start; p < end; p++) {
 		unsigned int used;
@@ -379,8 +379,6 @@ void apply_paravirt(struct paravirt_patc
 	/* Sync to be conservative, in case we patched following instructions */
 	sync_core();
 }
-extern struct paravirt_patch __start_parainstructions[],
-	__stop_parainstructions[];
 #endif	/* CONFIG_PARAVIRT */
 
 void __init alternative_instructions(void)
===================================================================
--- a/arch/i386/kernel/vmi.c
+++ b/arch/i386/kernel/vmi.c
@@ -70,10 +70,6 @@ struct {
 	void (*set_initial_ap_state)(int, int);
 	void (*halt)(void);
 } vmi_ops;
-
-/* XXX move this to alternative.h */
-extern struct paravirt_patch __start_parainstructions[],
-	__stop_parainstructions[];
 
 /*
  * VMI patching routines.
===================================================================
--- a/include/asm-i386/alternative.h
+++ b/include/asm-i386/alternative.h
@@ -118,12 +118,12 @@ static inline void alternatives_smp_swit
 #define LOCK_PREFIX ""
 #endif
 
-struct paravirt_patch;
+struct paravirt_patch_site;
 #ifdef CONFIG_PARAVIRT
-void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end);
+void apply_paravirt(struct paravirt_patch_site *start, struct paravirt_patch_site *end);
 #else
 static inline void
-apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
+apply_paravirt(struct paravirt_patch_site *start, struct paravirt_patch_site *end)
 {}
 #define __start_parainstructions NULL
 #define __stop_parainstructions NULL
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -561,12 +561,15 @@ static inline void pmd_clear(pmd_t *pmdp
 #define arch_leave_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
 
 /* These all sit in the .parainstructions section to tell us what to patch. */
-struct paravirt_patch {
+struct paravirt_patch_site {
 	u8 *instr; 		/* original instructions */
 	u8 instrtype;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
 	u16 clobbers;		/* what registers you may clobber */
 };
+
+extern struct paravirt_patch_site __start_parainstructions[],
+	__stop_parainstructions[];
 
 #define paravirt_alt(insn_string, typenum, clobber)	\
 	"771:\n\t" insn_string "\n" "772:\n"		\

--------------000901070706000208040105
Content-Type: text/x-patch;
 name="paravirt-use-offset-site-ids.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="paravirt-use-offset-site-ids.patch"

Use patch type identifiers derived from the offset of the operation in
the paravirt_ops structure.  This avoids having to maintain a separate
enum for patch types.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

===================================================================
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -110,5 +110,11 @@ void foo(void)
 	OFFSET(PARAVIRT_irq_enable_sysexit, paravirt_ops, irq_enable_sysexit);
 	OFFSET(PARAVIRT_iret, paravirt_ops, iret);
 	OFFSET(PARAVIRT_read_cr0, paravirt_ops, read_cr0);
+
+	DEFINE(PARAVIRT_IRQ_DISABLE, PARAVIRT_IRQ_DISABLE);
+	DEFINE(PARAVIRT_IRQ_ENABLE, PARAVIRT_IRQ_ENABLE);
+	DEFINE(PARAVIRT_STI_SYSEXIT, PARAVIRT_STI_SYSEXIT);
+	DEFINE(PARAVIRT_IRQ_DISABLE, PARAVIRT_IRQ_DISABLE);
+	DEFINE(PARAVIRT_INTERRUPT_RETURN, PARAVIRT_INTERRUPT_RETURN);
 #endif
 }
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -7,15 +7,6 @@
 #include <asm/page.h>
 
 #ifdef CONFIG_PARAVIRT
-/* These are the most performance critical ops, so we want to be able to patch
- * callers */
-#define PARAVIRT_IRQ_DISABLE 0
-#define PARAVIRT_IRQ_ENABLE 1
-#define PARAVIRT_RESTORE_FLAGS 2
-#define PARAVIRT_SAVE_FLAGS 3
-#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE 4
-#define PARAVIRT_INTERRUPT_RETURN 5
-#define PARAVIRT_STI_SYSEXIT 6
 
 /* Bitmask of what can be clobbered: usually at least eax. */
 #define CLBR_NONE 0x0
@@ -26,6 +17,32 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+
+#define paravirt_type(type)		[paravirt_typenum] "i" (type)
+#define paravirt_clobber(clobber)	[paravirt_clobber] "i" (clobber)
+
+#define PARAVIRT_PATCH(x)	(offsetof(struct paravirt_ops, x) / sizeof(void *))
+#define PARAVIRT_PATCH_SPECIAL(x)	(0x80+x)
+
+#define PARAVIRT_IRQ_DISABLE		PARAVIRT_PATCH(irq_disable)
+#define PARAVIRT_IRQ_ENABLE		PARAVIRT_PATCH(irq_enable)
+#define PARAVIRT_RESTORE_FLAGS		PARAVIRT_PATCH(restore_fl)
+#define PARAVIRT_SAVE_FLAGS		PARAVIRT_PATCH(save_fl)
+#define PARAVIRT_SAVE_FLAGS_IRQ_DISABLE	PARAVIRT_PATCH_SPECIAL(0)
+#define PARAVIRT_INTERRUPT_RETURN	PARAVIRT_PATCH(iret)
+#define PARAVIRT_STI_SYSEXIT		PARAVIRT_PATCH(irq_enable_sysexit)
+
+#define _paravirt_alt(insn_string, type, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	"  .long 771b\n"				\
+	"  .byte " type "\n"				\
+	"  .byte 772b-771b\n"				\
+	"  .short " clobber "\n"			\
+	".popsection"
+
+#define paravirt_alt(insn_string)				\
+	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
 
 struct thread_struct;
 struct Xgt_desc_struct;
@@ -571,24 +588,16 @@ extern struct paravirt_patch_site __star
 extern struct paravirt_patch_site __start_parainstructions[],
 	__stop_parainstructions[];
 
-#define paravirt_alt(insn_string, typenum, clobber)	\
-	"771:\n\t" insn_string "\n" "772:\n"		\
-	".pushsection .parainstructions,\"a\"\n"	\
-	"  .long 771b\n"				\
-	"  .byte " __stringify(typenum) "\n"		\
-	"  .byte 772b-771b\n"				\
-	"  .short " __stringify(clobber) "\n"		\
-	".popsection"
-
 static inline unsigned long __raw_local_save_flags(void)
 {
 	unsigned long f;
 
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%1;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_SAVE_FLAGS, CLBR_NONE)
-			     : "=a"(f): "m"(paravirt_ops.save_fl)
+					   "popl %%edx; popl %%ecx")
+			     : "=a"(f): "m"(paravirt_ops.save_fl),
+			       paravirt_type(PARAVIRT_SAVE_FLAGS),
+			       paravirt_clobber(CLBR_NONE)
 			     : "memory", "cc");
 	return f;
 }
@@ -597,9 +606,10 @@ static inline void raw_local_irq_restore
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%1;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_RESTORE_FLAGS, CLBR_EAX)
-			     : "=a"(f) : "m" (paravirt_ops.restore_fl), "0"(f)
+					   "popl %%edx; popl %%ecx")
+			     : "=a"(f) : "m" (paravirt_ops.restore_fl), "0"(f),
+			       paravirt_type(PARAVIRT_RESTORE_FLAGS),
+			       paravirt_clobber(CLBR_EAX)
 			     : "memory", "cc");
 }
 
@@ -607,9 +617,10 @@ static inline void raw_local_irq_disable
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%0;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_IRQ_DISABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_disable)
+					   "popl %%edx; popl %%ecx")
+			     : : "m" (paravirt_ops.irq_disable),
+			       paravirt_type(PARAVIRT_IRQ_DISABLE),
+			       paravirt_clobber(CLBR_EAX)
 			     : "memory", "eax", "cc");
 }
 
@@ -617,9 +628,10 @@ static inline void raw_local_irq_enable(
 {
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%0;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_IRQ_ENABLE, CLBR_EAX)
-			     : : "m" (paravirt_ops.irq_enable)
+					   "popl %%edx; popl %%ecx")
+			     : : "m" (paravirt_ops.irq_enable),
+			       paravirt_type(PARAVIRT_IRQ_ENABLE),
+			       paravirt_clobber(CLBR_EAX)
 			     : "memory", "eax", "cc");
 }
 
@@ -630,30 +642,35 @@ static inline unsigned long __raw_local_
 	__asm__ __volatile__(paravirt_alt( "pushl %%ecx; pushl %%edx;"
 					   "call *%1; pushl %%eax;"
 					   "call *%2; popl %%eax;"
-					   "popl %%edx; popl %%ecx",
-					  PARAVIRT_SAVE_FLAGS_IRQ_DISABLE,
-					  CLBR_NONE)
+					   "popl %%edx; popl %%ecx")
 			     : "=a"(f)
 			     : "m" (paravirt_ops.save_fl),
-			       "m" (paravirt_ops.irq_disable)
+			       "m" (paravirt_ops.irq_disable),
+			       paravirt_type(PARAVIRT_SAVE_FLAGS_IRQ_DISABLE),
+			       paravirt_clobber(CLBR_NONE)
 			     : "memory", "cc");
 	return f;
 }
 
-#define CLI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-		     "call *paravirt_ops+%c[irq_disable];"		\
-		     "popl %%edx; popl %%ecx",				\
-		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)
-
-#define STI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-		     "call *paravirt_ops+%c[irq_enable];"		\
-		     "popl %%edx; popl %%ecx",				\
-		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
+#define CLI_STRING _paravirt_alt("pushl %%ecx; pushl %%edx;"		\
+				 "call *paravirt_ops+%c[irq_disable];"	\
+				 "popl %%edx; popl %%ecx",		\
+				 "%c[paravirt_cli_type]", "%c[paravirt_clobber]")
+
+#define STI_STRING _paravirt_alt("pushl %%ecx; pushl %%edx;"		\
+				"call *paravirt_ops+%c[irq_enable];"	\
+				 "popl %%edx; popl %%ecx",		\
+				 "%c[paravirt_cli_type]", "%c[paravirt_clobber]")
+
+
 #define CLI_STI_CLOBBERS , "%eax"
-#define CLI_STI_INPUT_ARGS \
+#define CLI_STI_INPUT_ARGS						\
 	,								\
-	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
-	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
+		[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
+		[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable)), \
+		[paravirt_cli_type] "i" (PARAVIRT_IRQ_DISABLE),		\
+		[paravirt_sti_type] "i" (PARAVIRT_IRQ_DISABLE),		\
+		paravirt_clobber(CLBR_NONE)
 
 #else  /* __ASSEMBLY__ */
 

--------------000901070706000208040105
Content-Type: text/x-patch;
 name="paravirt-fix-clobbers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="paravirt-fix-clobbers.patch"

Fix a few clobbers to include the return register.  The clobbers set
is the set of all registers modified (or may be modified) by the code
snippet, regardless of whether it was deliberate or accidental.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -597,7 +597,7 @@ static inline unsigned long __raw_local_
 					   "popl %%edx; popl %%ecx")
 			     : "=a"(f): "m"(paravirt_ops.save_fl),
 			       paravirt_type(PARAVIRT_SAVE_FLAGS),
-			       paravirt_clobber(CLBR_NONE)
+			       paravirt_clobber(CLBR_EAX)
 			     : "memory", "cc");
 	return f;
 }
@@ -647,7 +647,7 @@ static inline unsigned long __raw_local_
 			     : "m" (paravirt_ops.save_fl),
 			       "m" (paravirt_ops.irq_disable),
 			       paravirt_type(PARAVIRT_SAVE_FLAGS_IRQ_DISABLE),
-			       paravirt_clobber(CLBR_NONE)
+			       paravirt_clobber(CLBR_EAX)
 			     : "memory", "cc");
 	return f;
 }
@@ -658,7 +658,7 @@ static inline unsigned long __raw_local_
 				 "%c[paravirt_cli_type]", "%c[paravirt_clobber]")
 
 #define STI_STRING _paravirt_alt("pushl %%ecx; pushl %%edx;"		\
-				"call *paravirt_ops+%c[irq_enable];"	\
+				 "call *paravirt_ops+%c[irq_enable];"	\
 				 "popl %%edx; popl %%ecx",		\
 				 "%c[paravirt_cli_type]", "%c[paravirt_clobber]")
 

--------------000901070706000208040105
Content-Type: text/x-patch;
 name="paravirt-patchable-call-wrappers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="paravirt-patchable-call-wrappers.patch"

Wrap a set of interesting paravirt_ops calls in a wrapper which makes
the callsites available for patching.  Unfortunately this is pretty
ugly because there's no way to get gcc to generate a function call,
but also wrap just the callsite itself with the necessary labels.

This patch supports functions with 0-4 arguments, and either void or
returning a value.  64-bit arguments must be split into a pair of
32-bit arguments (lower word first).  Functions which return
structures do so via the stack, with the first hidden argument being
the pointer to the returned structure; this is explicitly visible in
the wrapped calls.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -43,6 +43,222 @@
 
 #define paravirt_alt(insn_string)				\
 	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
+
+#define PVOP_CALL0(__rettype, __op)					\
+	({								\
+		__rettype __ret;					\
+		if (sizeof(__rettype) > sizeof(unsigned long)) {	\
+			unsigned long long __tmp;			\
+			unsigned long __ecx;				\
+			asm volatile(paravirt_alt("call *%[op]")	\
+				     : "=A" (__tmp), "=c" (__ecx)	\
+				     : [op] "m" (paravirt_ops.__op),	\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		} else {						\
+			unsigned long __tmp, __edx, __ecx;	\
+			asm volatile(paravirt_alt("call *%[op]")	\
+				     : "=a" (__tmp), "=d" (__edx), "=c" (__ecx) \
+				     : [op] "m" (paravirt_ops.__op),	\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		}							\
+		__ret;							\
+	})
+#define PVOP_VCALL0(__op)						\
+	({								\
+		unsigned long __eax, __edx, __ecx;			\
+		asm volatile(paravirt_alt("call *%[op]")		\
+			     : "=a" (__eax), "=d" (__edx), "=c" (__ecx) \
+			     : [op] "m" (paravirt_ops.__op),		\
+			       paravirt_type(PARAVIRT_PATCH(__op)),	\
+			       paravirt_clobber(CLBR_ANY)		\
+			     : "memory");				\
+	})
+
+#define PVOP_CALL1(__rettype, __op, arg1)				\
+	({								\
+		__rettype __ret;					\
+		if (sizeof(__rettype) > sizeof(unsigned long)) {	\
+			unsigned long long __tmp;			\
+			unsigned long __ecx;				\
+			asm volatile(paravirt_alt("call *%[op]")	\
+				     : "=A" (__tmp), "=c" (__ecx)	\
+				     : [op] "m" (paravirt_ops.__op),	\
+				       "a" ((u32)(arg1)),		\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		} else {						\
+			unsigned long __tmp, __edx, __ecx;	\
+			asm volatile(paravirt_alt("call *%[op]")	\
+				     : "=a" (__tmp), "=d" (__edx), "=c" (__ecx) \
+				     : [op] "m" (paravirt_ops.__op),	\
+				       "0" ((u32)(arg1)),		\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		}							\
+		__ret;							\
+	})
+#define PVOP_VCALL1(__op, arg1)						\
+	({								\
+		unsigned long __eax, __edx, __ecx;			\
+		asm volatile(paravirt_alt("call *%[op]")		\
+			     : "=a" (__eax), "=d" (__edx), "=c" (__ecx) \
+			     : [op] "m" (paravirt_ops.__op),		\
+			       "0" ((u32)(arg1)),			\
+			       paravirt_type(PARAVIRT_PATCH(__op)),	\
+			       paravirt_clobber(CLBR_ANY)		\
+			     : "memory");				\
+	})
+
+#define PVOP_CALL2(__rettype, __op, arg1, arg2)				\
+	({								\
+		__rettype __ret;					\
+		if (sizeof(__rettype) > sizeof(unsigned long)) {	\
+			unsigned long long __tmp;			\
+			unsigned long __ecx;				\
+			asm volatile(paravirt_alt("call *%[op]")	\
+				     : "=A" (__tmp), "=c" (__ecx)	\
+				     : [op] "m" (paravirt_ops.__op),	\
+				       "a" ((u32)(arg1)),		\
+				       "d" ((u32)(arg2)),		\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		} else {						\
+			unsigned long __tmp, __edx, __ecx;	\
+			asm volatile(paravirt_alt("call *%[op]")	\
+				     : "=a" (__tmp), "=d" (__edx), "=c" (__ecx) \
+				     : [op] "m" (paravirt_ops.__op),	\
+				       "0" ((u32)(arg1)),		\
+				       "1" ((u32)(arg2)),		\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		}							\
+		__ret;							\
+	})
+#define PVOP_VCALL2(__op, arg1, arg2)					\
+	({								\
+		unsigned long __eax, __edx, __ecx;			\
+		asm volatile(paravirt_alt("call *%[op]")		\
+			     : "=a" (__eax), "=d" (__edx), "=c" (__ecx) \
+			     : [op] "m" (paravirt_ops.__op),		\
+			       "0" ((u32)(arg1)),			\
+			       "1" ((u32)(arg2)),			\
+			       paravirt_type(PARAVIRT_PATCH(__op)),	\
+			       paravirt_clobber(CLBR_ANY)		\
+			     : "memory");				\
+	})
+
+#define PVOP_CALL3(__rettype, __op, arg1, arg2, arg3)			\
+	({								\
+		__rettype __ret;					\
+		if (sizeof(__rettype) > sizeof(unsigned long)) {	\
+			unsigned long long __tmp;			\
+			unsigned long __ecx;				\
+			asm volatile(paravirt_alt("call *%[op]")	\
+				     : "=A" (__tmp), "=c" (__ecx)	\
+				     : [op] "m" (paravirt_ops.__op),	\
+				       "a" ((u32)(arg1)),		\
+				       "d" ((u32)(arg2)),		\
+				       "1" ((u32)(arg3)),		\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		} else {						\
+			unsigned long __tmp, __edx, __ecx;	\
+			asm volatile(paravirt_alt("call *%[op]")	\
+				     : "=a" (__tmp), "=d" (__edx), "=c" (__ecx) \
+				     : [op] "m" (paravirt_ops.__op),	\
+				       "0" ((u32)(arg1)),		\
+				       "1" ((u32)(arg2)),		\
+				       "2" ((u32)(arg3)),		\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		}							\
+		__ret;							\
+	})
+#define PVOP_VCALL3(__op, arg1, arg2, arg3)				\
+	({								\
+		unsigned long __eax, __edx, __ecx;			\
+		asm volatile(paravirt_alt("call *%[op]")		\
+			     : "=a" (__eax), "=d" (__edx), "=c" (__ecx) \
+			     : [op] "m" (paravirt_ops.__op),		\
+			       "0" ((u32)(arg1)),			\
+			       "1" ((u32)(arg2)),			\
+			       "2" ((u32)(arg3)),			\
+			       paravirt_type(PARAVIRT_PATCH(__op)),	\
+			       paravirt_clobber(CLBR_ANY)		\
+			     : "memory");				\
+	})
+
+#define PVOP_CALL4(__rettype, __op, arg1, arg2, arg3, arg4)		\
+	({								\
+		__rettype __ret;					\
+		if (sizeof(__rettype) > sizeof(unsigned long)) {	\
+			unsigned long long __tmp;			\
+			unsigned long __ecx;				\
+			asm volatile(paravirt_alt("push %[_arg4]; "	\
+						  "call *%[op]; "	\
+						  "add $4,%%esp")	\
+				     : "=A" (__tmp), "=c" (__ecx)	\
+				     : [op] "m" (paravirt_ops.__op),	\
+				       "a" ((u32)(arg1)),		\
+				       "d" ((u32)(arg2)),		\
+				       "1" ((u32)(arg3)),		\
+				       [_arg4] "mr" ((u32)(arg4)),	\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		} else {						\
+			unsigned long __tmp, __edx, __ecx;			\
+			asm volatile(paravirt_alt("push %[_arg4]; "	\
+						  "call *%[op]; "	\
+						  "add $4,%%esp")	\
+				     : "=a" (__tmp), "=d" (__edx), "=c" (__ecx) \
+				     : [op] "m" (paravirt_ops.__op),	\
+				       "0" ((u32)(arg1)),		\
+				       "1" ((u32)(arg2)),		\
+				       "2" ((u32)(arg3)),		\
+				       [_arg4]"mr" ((u32)(arg4)),	\
+				       paravirt_type(PARAVIRT_PATCH(__op)), \
+				       paravirt_clobber(CLBR_ANY)	\
+				     : "memory");			\
+			__ret = (__rettype)__tmp;			\
+		}							\
+		__ret;							\
+	})
+#define PVOP_VCALL4(__op, arg1, arg2, arg3, arg4)			\
+	({								\
+		unsigned long __eax, __edx, __ecx;			\
+		asm volatile(paravirt_alt("push %[_arg4]; "		\
+					  "call *%[op]; "		\
+					  "add $4,%%esp")		\
+			     : "=a" (__eax), "=d" (__edx), "=c" (__ecx) \
+			     : [op] "m" (paravirt_ops.__op),		\
+			       "0" ((u32)(arg1)),			\
+			       "1" ((u32)(arg2)),			\
+			       "2" ((u32)(arg3)),			\
+			       [_arg4]"mr" ((u32)(arg4)),		\
+			       paravirt_type(PARAVIRT_PATCH(__op)),	\
+			       paravirt_clobber(CLBR_ANY)		\
+			     : "memory");				\
+	})
 
 struct thread_struct;
 struct Xgt_desc_struct;
@@ -258,18 +474,18 @@ static inline void load_esp0(struct tss_
 static inline void load_esp0(struct tss_struct *tss,
 			     struct thread_struct *thread)
 {
-	paravirt_ops.load_esp0(tss, thread);
+	PVOP_VCALL2(load_esp0, tss, thread);
 }
 
 #define ARCH_SETUP			paravirt_ops.arch_setup();
 static inline unsigned long get_wallclock(void)
 {
-	return paravirt_ops.get_wallclock();
+	return PVOP_CALL0(unsigned long, get_wallclock);
 }
 
 static inline int set_wallclock(unsigned long nowtime)
 {
-	return paravirt_ops.set_wallclock(nowtime);
+	return PVOP_CALL1(int, set_wallclock, nowtime);
 }
 
 static inline void do_time_init(void)
@@ -287,36 +503,41 @@ static inline void __cpuid(unsigned int 
 /*
  * These special macros can be used to get or set a debugging register
  */
-#define get_debugreg(var, reg) var = paravirt_ops.get_debugreg(reg)
-#define set_debugreg(val, reg) paravirt_ops.set_debugreg(reg, val)
-
-#define clts() paravirt_ops.clts()
-
-#define read_cr0() paravirt_ops.read_cr0()
-#define write_cr0(x) paravirt_ops.write_cr0(x)
-
-#define read_cr2() paravirt_ops.read_cr2()
-#define write_cr2(x) paravirt_ops.write_cr2(x)
-
-#define read_cr3() paravirt_ops.read_cr3()
-#define write_cr3(x) paravirt_ops.write_cr3(x)
-
-#define read_cr4() paravirt_ops.read_cr4()
-#define read_cr4_safe(x) paravirt_ops.read_cr4_safe()
-#define write_cr4(x) paravirt_ops.write_cr4(x)
-
-#define raw_ptep_get_and_clear(xp)	(paravirt_ops.ptep_get_and_clear(xp))
+#define get_debugreg(var, reg) var = PVOP_CALL1(unsigned long, get_debugreg, reg)
+#define set_debugreg(val, reg) PVOP_VCALL2(set_debugreg, reg, val)
+
+#define clts()		PVOP_VCALL0(clts)
+
+#define read_cr0()	PVOP_CALL0(unsigned long, read_cr0)
+#define write_cr0(x)	PVOP_VCALL1(write_cr0, x)
+
+#define read_cr2()	PVOP_CALL0(unsigned long, read_cr2)
+#define write_cr2(x)	PVOP_VCALL1(write_cr2, x)
+
+#define read_cr3()	PVOP_CALL0(unsigned long, read_cr3)
+#define write_cr3(x)	PVOP_VCALL1(write_cr3, x)
+
+#define read_cr4()	PVOP_CALL0(unsigned long, read_cr4)
+#define read_cr4_safe(x) PVOP_CALL0(unsigned long, read_cr4_safe)
+#define write_cr4(x)	PVOP_VCALL1(write_cr4, x)
+
+static inline pte_t raw_ptep_get_and_clear(pte_t *p)
+{
+	pte_t ret;
+	PVOP_VCALL2(ptep_get_and_clear, &ret, p);
+	return ret;
+}
 
 static inline void raw_safe_halt(void)
 {
-	paravirt_ops.safe_halt();
+	PVOP_VCALL0(safe_halt);
 }
 
 static inline void halt(void)
 {
-	paravirt_ops.safe_halt();
-}
-#define wbinvd() paravirt_ops.wbinvd()
+	PVOP_VCALL0(safe_halt);
+}
+#define wbinvd()	PVOP_VCALL0(wbinvd)
 
 #define get_kernel_rpl()  (paravirt_ops.kernel_rpl)
 
@@ -352,22 +573,22 @@ static inline void halt(void)
 	_err; })
 
 #define rdtsc(low,high) do {					\
-	u64 _l = paravirt_ops.read_tsc();			\
+	u64 _l = PVOP_CALL0(u64, read_tsc);			\
 	low = (u32)_l;						\
 	high = _l >> 32;					\
 } while(0)
 
 #define rdtscl(low) do {					\
-	u64 _l = paravirt_ops.read_tsc();			\
+	u64 _l = PVOP_CALL0(u64, read_tsc);			\
 	low = (int)_l;						\
 } while(0)
 
-#define rdtscll(val) (val = paravirt_ops.read_tsc())
+#define rdtscll(val) (val = PVOP_CALL0(u64, read_tsc))
 
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
 #define rdpmc(counter,low,high) do {				\
-	u64 _l = paravirt_ops.read_pmc();			\
+	u64 _l = PVOP_CALL0(u64, read_pmc);			\
 	low = (u32)_l;						\
 	high = _l >> 32;					\
 } while(0)
@@ -388,15 +609,66 @@ static inline void halt(void)
 	(paravirt_ops.write_idt_entry((dt), (entry), (low), (high)))
 #define set_iopl_mask(mask) (paravirt_ops.set_iopl_mask(mask))
 
-#define __pte(x)	paravirt_ops.make_pte(x)
-#define __pgd(x)	paravirt_ops.make_pgd(x)
-
-#define pte_val(x)	paravirt_ops.pte_val(x)
-#define pgd_val(x)	paravirt_ops.pgd_val(x)
-
 #ifdef CONFIG_X86_PAE
-#define __pmd(x)	paravirt_ops.make_pmd(x)
-#define pmd_val(x)	paravirt_ops.pmd_val(x)
+static inline pte_t __pte(unsigned long long val)
+{
+	pte_t ret;
+	PVOP_VCALL3(make_pte, &ret, val, val >> 32);
+	return ret;
+}
+
+static inline pmd_t __pmd(unsigned long long val)
+{
+	pmd_t ret;
+	PVOP_VCALL3(make_pmd, &ret, val, val >> 32);
+	return ret;
+}
+
+static inline pgd_t __pgd(unsigned long long val)
+{
+	pgd_t ret;
+	PVOP_VCALL3(make_pgd, &ret, val, val >> 32);
+	return ret;
+}
+
+static inline unsigned long long pte_val(pte_t x)
+{
+	return PVOP_CALL2(unsigned long long, pte_val, x.pte_low, x.pte_high);
+}
+
+static inline unsigned long long pmd_val(pmd_t x)
+{
+	return PVOP_CALL2(unsigned long long, pmd_val, x.pmd, x.pmd >> 32);
+}
+
+static inline unsigned long long pgd_val(pgd_t x)
+{
+	return PVOP_CALL2(unsigned long long, pgd_val, x.pgd, x.pgd >> 32);
+}
+#else
+static inline pte_t __pte(unsigned long val)
+{
+	pte_t ret;
+	PVOP_VCALL2(make_pte, &ret, val);
+	return ret;
+}
+
+static inline pgd_t __pte(unsigned long val)
+{
+	pgd_t ret;
+	PVOP_VCALL2(make_pgd, &ret, val);
+	return ret;
+}
+
+static inline unsigned long pte_val(pte_t x)
+{
+	PVOP_CALL1(unsigned long, pte_val, x.pte_low);
+}
+
+static inline unsigned long pgd_val(pgd_t x)
+{
+	PVOP_CALL2(unsigned long, pgd_val, x.pgd);
+}
 #endif
 
 /* The paravirtualized I/O functions */
@@ -473,18 +745,18 @@ static inline void paravirt_activate_mm(
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
-	paravirt_ops.activate_mm(prev, next);
+	PVOP_VCALL2(activate_mm, prev, next);
 }
 
 static inline void arch_dup_mmap(struct mm_struct *oldmm,
 				 struct mm_struct *mm)
 {
-	paravirt_ops.dup_mmap(oldmm, mm);
+	PVOP_VCALL2(dup_mmap, oldmm, mm);
 }
 
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
-	paravirt_ops.exit_mmap(mm);
+	PVOP_VCALL1(exit_mmap, mm);
 }
 
 static inline void paravirt_init_pda(struct i386_pda *pda, int cpu)
@@ -514,33 +786,41 @@ unsigned long native_store_tr(void);
 
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
-	paravirt_ops.set_pte(ptep, pteval);
+#ifdef CONFIG_X86_PAE
+	PVOP_VCALL3(set_pte, ptep, pteval.pte_low, pteval.pte_high);
+#else
+	PVOP_VCALL2(set_pte, ptep, pteval.pte_low);
+#endif
 }
 
 static inline void set_pte_at(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pteval)
 {
+#ifdef CONFIG_X86_PAE
 	paravirt_ops.set_pte_at(mm, addr, ptep, pteval);
+#else
+	PVOP_VCALL4(set_pte_at, mm, addr, ptep, pteval.pte_low);
+#endif
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmdval)
 {
-	paravirt_ops.set_pmd(pmdp, pmdval);
+	PVOP_VCALL3(set_pmd, pmdp, pmdval.pmd, pmdval.pmd >> 32);
 }
 
 static inline void pte_update(struct mm_struct *mm, u32 addr, pte_t *ptep)
 {
-	paravirt_ops.pte_update(mm, addr, ptep);
+	PVOP_VCALL3(pte_update, mm, addr, ptep);
 }
 
 static inline void pte_update_defer(struct mm_struct *mm, u32 addr, pte_t *ptep)
 {
-	paravirt_ops.pte_update_defer(mm, addr, ptep);
+	PVOP_VCALL3(pte_update_defer, mm, addr, ptep);
 }
 
 #ifdef CONFIG_X86_PAE
 static inline void set_pte_atomic(pte_t *ptep, pte_t pteval)
 {
-	paravirt_ops.set_pte_atomic(ptep, pteval);
+	PVOP_VCALL3(set_pte_atomic, ptep, pteval.pte_low, pteval.pte_high);
 }
 
 static inline void set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
@@ -550,17 +830,17 @@ static inline void set_pte_present(struc
 
 static inline void set_pud(pud_t *pudp, pud_t pudval)
 {
-	paravirt_ops.set_pud(pudp, pudval);
+	PVOP_VCALL3(set_pud, pudp, pudval.pgd.pgd, pudval.pgd.pgd >> 32);
 }
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	paravirt_ops.pte_clear(mm, addr, ptep);
+	PVOP_VCALL3(pte_clear, mm, addr, ptep);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
 {
-	paravirt_ops.pmd_clear(pmdp);
+	PVOP_VCALL1(pmd_clear, pmdp);
 }
 #endif
 
@@ -570,12 +850,12 @@ static inline void pmd_clear(pmd_t *pmdp
 #define PARAVIRT_LAZY_CPU  2
 
 #define  __HAVE_ARCH_ENTER_LAZY_CPU_MODE
-#define arch_enter_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_CPU)
-#define arch_leave_lazy_cpu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
+#define arch_enter_lazy_cpu_mode() PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_CPU)
+#define arch_leave_lazy_cpu_mode() PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_NONE)
 
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
-#define arch_enter_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_MMU)
-#define arch_leave_lazy_mmu_mode() paravirt_ops.set_lazy_mode(PARAVIRT_LAZY_NONE)
+#define arch_enter_lazy_mmu_mode() PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_MMU)
+#define arch_leave_lazy_mmu_mode() PVOP_VCALL1(set_lazy_mode, PARAVIRT_LAZY_NONE)
 
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch_site {

--------------000901070706000208040105
Content-Type: text/x-patch;
 name="paravirt-patch-machinery.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="paravirt-patch-machinery.patch"

Implement the actual patching machinery.  paravirt_patcher() contains the logic to automatically patch a callsite based on a few simple rules:
 - if the paravirt_op function is either NULL or native_nop, then patch nops
 - if the paravirt_op function is a jmp target, then jmp to it
 - if the paravirt_op function is callable and doesn't clobber too much
    for the callsite, call it directly

These rules will remove most of the expensive indirect calls in favour
of either a direct call or a pile of nops.

Paravirt backends can also pass in other patcher functions for
specific operations if they want to insert literal machine code, or do
more complex things.  The function paravirt_patch_insns() is available
to help with this.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -53,43 +53,144 @@ char *memory_setup(void)
 #define DEF_NATIVE(name, code)					\
 	extern const char start_##name[], end_##name[];		\
 	asm("start_" #name ": " code "; end_" #name ":")
+
 DEF_NATIVE(cli, "cli");
+static unsigned native_patch_irq_disable(void *opfunc, u16 clobbers,
+					 void *site, unsigned len)
+{
+	return paravirt_patch_insns(site, len, start_cli, end_cli);
+}
+
 DEF_NATIVE(sti, "sti");
+static unsigned native_patch_irq_enable(void *opfunc, u16 clobbers,
+					void *site, unsigned len)
+{
+	return paravirt_patch_insns(site, len, start_sti, end_sti);
+}
+
 DEF_NATIVE(popf, "push %eax; popf");
+static unsigned native_patch_restore_flags(void *opfunc, u16 clobbers,
+					   void *site, unsigned len)
+{
+	return paravirt_patch_insns(site, len, start_popf, end_popf);
+}
+
 DEF_NATIVE(pushf, "pushf; pop %eax");
+static unsigned native_patch_save_flags(void *opfunc, u16 clobbers,
+					void *site, unsigned len)
+{
+	return paravirt_patch_insns(site, len, start_pushf, end_pushf);
+}
+
 DEF_NATIVE(pushf_cli, "pushf; pop %eax; cli");
+static unsigned native_patch_save_flags_irq_disable(void *opfunc, u16 clobbers,
+						    void *site, unsigned len)
+{
+	return paravirt_patch_insns(site, len, start_pushf_cli, end_pushf_cli);
+}
+
 DEF_NATIVE(iret, "iret");
+static unsigned native_patch_interrupt_return(void *opfunc, u16 clobbers,
+					      void *site, unsigned len)
+{
+	return paravirt_patch_insns(site, len, start_iret, end_iret);
+}
+
 DEF_NATIVE(sti_sysexit, "sti; sysexit");
-
-static const struct native_insns
-{
-	const char *start, *end;
-} native_insns[] = {
-	[PARAVIRT_IRQ_DISABLE] = { start_cli, end_cli },
-	[PARAVIRT_IRQ_ENABLE] = { start_sti, end_sti },
-	[PARAVIRT_RESTORE_FLAGS] = { start_popf, end_popf },
-	[PARAVIRT_SAVE_FLAGS] = { start_pushf, end_pushf },
-	[PARAVIRT_SAVE_FLAGS_IRQ_DISABLE] = { start_pushf_cli, end_pushf_cli },
-	[PARAVIRT_INTERRUPT_RETURN] = { start_iret, end_iret },
-	[PARAVIRT_STI_SYSEXIT] = { start_sti_sysexit, end_sti_sysexit },
-};
+static unsigned native_patch_sti_sysexit(void *opfunc, u16 clobbers,
+					 void *site, unsigned len)
+{
+	return paravirt_patch_insns(site, len, start_sti_sysexit, end_sti_sysexit);
+}
 
 static unsigned native_patch(u8 type, u16 clobbers, void *insns, unsigned len)
 {
-	unsigned int insn_len;
-
-	/* Don't touch it if we don't have a replacement */
-	if (type >= ARRAY_SIZE(native_insns) || !native_insns[type].start)
-		return len;
-
-	insn_len = native_insns[type].end - native_insns[type].start;
-
-	/* Similarly if we can't fit replacement. */
-	if (len < insn_len)
-		return len;
-
-	memcpy(insns, native_insns[type].start, insn_len);
+	patcher_t patcher = NULL;
+
+	switch(type) {
+	case PARAVIRT_IRQ_DISABLE:	patcher = native_patch_irq_disable; break;
+	case PARAVIRT_IRQ_ENABLE:	patcher = native_patch_irq_enable; break;
+	case PARAVIRT_RESTORE_FLAGS:	patcher = native_patch_restore_flags; break;
+	case PARAVIRT_SAVE_FLAGS:	patcher = native_patch_save_flags; break;
+	case PARAVIRT_SAVE_FLAGS_IRQ_DISABLE:
+		patcher = native_patch_save_flags_irq_disable; break;
+	case PARAVIRT_INTERRUPT_RETURN:	patcher = native_patch_interrupt_return; break;
+	case PARAVIRT_STI_SYSEXIT:	patcher = native_patch_sti_sysexit; break;
+	}
+
+	return paravirt_patcher(type, clobbers, insns, len, patcher);
+}
+
+unsigned paravirt_patch_nop(void *opfunc, u16 clobbers, void *site, unsigned len)
+{
+	return 0;
+}
+
+unsigned paravirt_patch_ignore(void *opfunc, u16 clobbers, void *site, unsigned len)
+{
+	return len;
+}
+
+unsigned paravirt_patch_call(void *target, u16 clobbers, void *site, unsigned len)
+{
+	unsigned char *call = site;
+	unsigned long delta = (unsigned long)target - (unsigned long)(call+5);
+
+	if (clobbers != (CLBR_EAX|CLBR_EDX|CLBR_ECX))
+		return len;	/* calling C would clobber too much */
+	if (len < 5)
+		return len;	/* call too long for patch site */
+
+	*call++ = 0xe8;		/* call */
+	*(unsigned long *)call = delta;
+
+	return 5;
+}
+
+unsigned paravirt_patch_jmp(void *target, u16 clobbers, void *site, unsigned len)
+{
+	unsigned char *jmp = site;
+	unsigned long delta = (unsigned long)target - (unsigned long)(jmp+5);
+
+	if (len < 5)
+		return len;	/* call too long for patch site */
+
+	*jmp++ = 0xe9;		/* jmp */
+	*(unsigned long *)jmp = delta;
+
+	return 5;
+}
+
+unsigned paravirt_patch_insns(void *site, unsigned len,
+			      const char *start, const char *end)
+{
+	unsigned insn_len = end - start;
+
+	if (insn_len > len || start == NULL)
+		insn_len = len;
+	else
+		memcpy(site, start, insn_len);
+
 	return insn_len;
+}
+
+unsigned paravirt_patcher(u8 type, u16 clobbers, void *site, unsigned len,
+			  patcher_t patch)
+{
+	void *opfunc = *((void **)&paravirt_ops + type);
+
+	if (patch == NULL) {
+		/* work out how to handle this site automatically */
+		if (opfunc == (void *)native_nop || opfunc == NULL)
+			patch = paravirt_patch_nop;
+		else if (type == PARAVIRT_PATCH(iret) ||
+			 type == PARAVIRT_PATCH(irq_enable_sysexit))
+			patch = paravirt_patch_jmp;
+		else
+			patch = paravirt_patch_call;
+	}
+
+	return (*patch)(opfunc, clobbers, site, len);
 }
 
 static unsigned long native_get_debugreg(int regno)
===================================================================
--- a/arch/i386/xen/enlighten.c
+++ b/arch/i386/xen/enlighten.c
@@ -37,11 +37,10 @@ struct start_info *xen_start_info;
 struct start_info *xen_start_info;
 EXPORT_SYMBOL_GPL(xen_start_info);
 
-static unsigned xen_patch(u8 type, u16 clobber, void *firstinsn, unsigned len)
-{
-	/* Xen will require relocations to patch calls and jmps, and
-	   perhaps chunks of inline code */
-	return len;
+static unsigned xen_patch(u8 type, u16 clobber, void *insn, unsigned len)
+{
+	/* Use the default patcher's default options */
+	return paravirt_patcher(type, clobber, insn, len, NULL);
 }
 
 static void __init xen_banner(void)
===================================================================
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -865,6 +865,19 @@ struct paravirt_patch_site {
 	u16 clobbers;		/* what registers you may clobber */
 };
 
+typedef unsigned (*patcher_t)(void *opfunc, u16 clobbers, void *site, unsigned len);
+
+unsigned paravirt_patcher(u8 type, u16 clobbers, void *insns, unsigned len,
+			  patcher_t patch);
+
+unsigned paravirt_patch_nop(void *opfunc, u16 clobbers, void *site, unsigned len);
+unsigned paravirt_patch_ignore(void *opfunc, u16 clobbers, void *site, unsigned len);
+unsigned paravirt_patch_call(void *opfunc, u16 clobbers, void *site, unsigned len);
+unsigned paravirt_patch_jmp(void *opfunc, u16 clobbers, void *site, unsigned len);
+
+unsigned paravirt_patch_insns(void *site, unsigned len,
+			      const char *start, const char *end);
+
 extern struct paravirt_patch_site __start_parainstructions[],
 	__stop_parainstructions[];
 

--------------000901070706000208040105
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/virtualization

--------------000901070706000208040105--
