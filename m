From: yamahata@valinux.co.jp
Subject: [PATCH 08/28] RFC: ia64/xen: xen hand written assembly code
	paravirtualization.
Date: Thu, 21 Feb 2008 18:17:39 +0900
Message-ID: <20080221091901.195905000__10327.581203501$1203633926$gmane$org@ls.local.valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GI17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
Content-Disposition: inline;
	filename=0008-ia64-xen-xen-hand-written-assembly-code-paravirtual.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/entry.S      |   41 +-
 arch/ia64/xen/xenentry.S      |  798 +++++++++++++++
 arch/ia64/xen/xenivt.S        | 2204 +++++++++++++++++++++++++++++++++++++++++
 arch/ia64/xen/xenminstate.h   |  320 ++++++
 include/asm-ia64/privop.h     |   26 +
 include/asm-ia64/xen/privop.h |   22 +
 6 files changed, 3399 insertions(+), 12 deletions(-)
 create mode 100644 arch/ia64/xen/xenentry.S
 create mode 100644 arch/ia64/xen/xenivt.S
 create mode 100644 arch/ia64/xen/xenminstate.h
 create mode 100644 include/asm-ia64/privop.h

diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index 3c331c4..39bb7d5 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -180,7 +180,7 @@ END(sys_clone)
  *	called.  The code starting at .map relies on this.  The rest of the code
  *	doesn't care about the interrupt masking status.
  */
-GLOBAL_ENTRY(ia64_switch_to)
+GLOBAL_ENTRY(__ia64_switch_to)
 	.prologue
 	alloc r16=ar.pfs,1,0,0,0
 	DO_SAVE_SWITCH_STACK
@@ -234,7 +234,7 @@ GLOBAL_ENTRY(ia64_switch_to)
 	;;
 	srlz.d
 	br.cond.sptk .done
-END(ia64_switch_to)
+END(__ia64_switch_to)
 
 /*
  * Note that interrupts are enabled during save_switch_stack and load_switch_stack.  This
@@ -375,7 +375,7 @@ END(save_switch_stack)
  *	- b7 holds address to return to
  *	- must not touch r8-r11
  */
-ENTRY(load_switch_stack)
+GLOBAL_ENTRY(load_switch_stack)
 	.prologue
 	.altrp b7
 
@@ -635,8 +635,16 @@ GLOBAL_ENTRY(ia64_ret_from_syscall)
 	adds r2=PT(R8)+16,sp			// r2 = &pt_regs.r8
 	mov r10=r0				// clear error indication in r10
 (p7)	br.cond.spnt handle_syscall_error	// handle potential syscall failure
+#ifdef CONFIG_PARAVIRT_GUEST
+	;;
+	// don't fall through, ia64_leave_syscall may be #define'd
+	br.cond.sptk.few ia64_leave_syscall
+	;;
+#endif
 END(ia64_ret_from_syscall)
+#ifndef CONFIG_PARAVIRT_GUEST
 	// fall through
+#endif
 /*
  * ia64_leave_syscall(): Same as ia64_leave_kernel, except that it doesn't
  *	need to switch to bank 0 and doesn't restore the scratch registers.
@@ -681,7 +689,7 @@ END(ia64_ret_from_syscall)
  *	      ar.csd: cleared
  *	      ar.ssd: cleared
  */
-ENTRY(ia64_leave_syscall)
+GLOBAL_ENTRY(__ia64_leave_syscall)
 	PT_REGS_UNWIND_INFO(0)
 	/*
 	 * work.need_resched etc. mustn't get changed by this CPU before it returns to
@@ -691,7 +699,7 @@ ENTRY(ia64_leave_syscall)
 	 * extra work.  We always check for extra work when returning to user-level.
 	 * With CONFIG_PREEMPT, we also check for extra work when the preempt_count
 	 * is 0.  After extra work processing has been completed, execution
-	 * resumes at .work_processed_syscall with p6 set to 1 if the extra-work-check
+	 * resumes at ia64_work_processed_syscall with p6 set to 1 if the extra-work-check
 	 * needs to be redone.
 	 */
 #ifdef CONFIG_PREEMPT
@@ -709,7 +717,8 @@ ENTRY(ia64_leave_syscall)
 	cmp.eq pLvSys,p0=r0,r0		// pLvSys=1: leave from syscall
 (pUStk)	cmp.eq.unc p6,p0=r0,r0		// p6 <- pUStk
 #endif
-.work_processed_syscall:
+.global __ia64_work_processed_syscall;
+__ia64_work_processed_syscall:
 	adds r2=PT(LOADRS)+16,r12
 	adds r3=PT(AR_BSPSTORE)+16,r12
 	adds r18=TI_FLAGS+IA64_TASK_SIZE,r13
@@ -788,7 +797,7 @@ ENTRY(ia64_leave_syscall)
 	mov.m ar.ssd=r0			// M2   clear ar.ssd
 	mov f11=f0			// F    clear f11
 	br.cond.sptk.many rbs_switch	// B
-END(ia64_leave_syscall)
+END(__ia64_leave_syscall)
 
 #ifdef CONFIG_IA32_SUPPORT
 GLOBAL_ENTRY(ia64_ret_from_ia32_execve)
@@ -800,10 +809,18 @@ GLOBAL_ENTRY(ia64_ret_from_ia32_execve)
 	st8.spill [r2]=r8	// store return value in slot for r8 and set unat bit
 	.mem.offset 8,0
 	st8.spill [r3]=r0	// clear error indication in slot for r10 and set unat bit
+#ifdef CONFIG_PARAVIRT_GUEST
+	;;
+	// don't fall through, ia64_leave_kernel may be #define'd
+	br.cond.sptk.few ia64_leave_kernel
+	;;
+#endif
 END(ia64_ret_from_ia32_execve)
+#ifndef CONFIG_PARAVIRT_GUEST
 	// fall through
+#endif
 #endif /* CONFIG_IA32_SUPPORT */
-GLOBAL_ENTRY(ia64_leave_kernel)
+GLOBAL_ENTRY(__ia64_leave_kernel)
 	PT_REGS_UNWIND_INFO(0)
 	/*
 	 * work.need_resched etc. mustn't get changed by this CPU before it returns to
@@ -1130,9 +1147,9 @@ skip_rbs_switch:
 	;;
 	ld8 r8=[r2]
 	ld8 r10=[r3]
-	br.cond.sptk.many .work_processed_syscall	// re-check
+	br.cond.sptk.many ia64_work_processed_syscall	// re-check
 
-END(ia64_leave_kernel)
+END(__ia64_leave_kernel)
 
 ENTRY(handle_syscall_error)
 	/*
@@ -1172,7 +1189,7 @@ END(ia64_invoke_schedule_tail)
 	 * be set up by the caller.  We declare 8 input registers so the system call
 	 * args get preserved, in case we need to restart a system call.
 	 */
-ENTRY(notify_resume_user)
+GLOBAL_ENTRY(notify_resume_user)
 	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(8)
 	alloc loc1=ar.pfs,8,2,3,0 // preserve all eight input regs in case of syscall restart!
 	mov r9=ar.unat
@@ -1234,7 +1251,7 @@ ENTRY(sys_rt_sigreturn)
 	adds sp=16,sp
 	;;
 	ld8 r9=[sp]				// load new ar.unat
-	mov.sptk b7=r8,ia64_leave_kernel
+	mov.sptk b7=r8,__ia64_leave_kernel
 	;;
 	mov ar.unat=r9
 	br.many b7
diff --git a/arch/ia64/xen/xenentry.S b/arch/ia64/xen/xenentry.S
new file mode 100644
index 0000000..38a509d
--- /dev/null
+++ b/arch/ia64/xen/xenentry.S
@@ -0,0 +1,798 @@
+/*
+ * ia64/xen/entry.S
+ *
+ * Alternate kernel routines for Xen.  Heavily leveraged from
+ *   ia64/kernel/entry.S
+ *
+ * Copyright (C) 2005 Hewlett-Packard Co
+ *	Dan Magenheimer <dan.magenheimer@.hp.com>
+ */
+
+#include <asm/asmmacro.h>
+#include <asm/cache.h>
+#include <asm/errno.h>
+#include <asm/kregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/pgtable.h>
+#include <asm/percpu.h>
+#include <asm/processor.h>
+#include <asm/thread_info.h>
+#include <asm/unistd.h>
+
+#ifdef CONFIG_XEN
+#include "xenminstate.h"
+#include <asm/paravirt_nop.h>
+#else
+#include "minstate.h"
+#endif
+
+/*
+ * prev_task <- ia64_switch_to(struct task_struct *next)
+ *	With Ingo's new scheduler, interrupts are disabled when this routine gets
+ *	called.  The code starting at .map relies on this.  The rest of the code
+ *	doesn't care about the interrupt masking status.
+ */
+#ifdef CONFIG_XEN
+GLOBAL_ENTRY(xen_switch_to)
+	BR_IF_NATIVE(__ia64_switch_to, r22, p7)
+#else
+GLOBAL_ENTRY(ia64_switch_to)
+#endif
+	.prologue
+	alloc r16=ar.pfs,1,0,0,0
+	DO_SAVE_SWITCH_STACK
+	.body
+
+	adds r22=IA64_TASK_THREAD_KSP_OFFSET,r13
+	movl r25=init_task
+	mov r27=IA64_KR(CURRENT_STACK)
+	adds r21=IA64_TASK_THREAD_KSP_OFFSET,in0
+	dep r20=0,in0,61,3		// physical address of "next"
+	;;
+	st8 [r22]=sp			// save kernel stack pointer of old task
+	shr.u r26=r20,IA64_GRANULE_SHIFT
+	cmp.eq p7,p6=r25,in0
+	;;
+	/*
+	 * If we've already mapped this task's page, we can skip doing it again.
+	 */
+(p6)	cmp.eq p7,p6=r26,r27
+(p6)	br.cond.dpnt .map
+	;;
+.done:
+	ld8 sp=[r21]			// load kernel stack pointer of new task
+#ifdef CONFIG_XEN
+	// update "current" application register
+	mov r8=IA64_KR_CURRENT
+	mov r9=in0;;
+	XEN_HYPER_SET_KR
+#else
+	mov IA64_KR(CURRENT)=in0	// update "current" application register
+#endif
+	mov r8=r13			// return pointer to previously running task
+	mov r13=in0			// set "current" pointer
+	;;
+	DO_LOAD_SWITCH_STACK
+
+#ifdef CONFIG_SMP
+	sync.i				// ensure "fc"s done by this CPU are visible on other CPUs
+#endif
+	br.ret.sptk.many rp		// boogie on out in new context
+
+.map:
+#ifdef CONFIG_XEN
+	movl r25=XSI_PSR_IC			// clear psr.ic
+	;;
+	st4 [r25]=r0
+	;;
+#else
+	rsm psr.ic			// interrupts (psr.i) are already disabled here
+#endif
+	movl r25=PAGE_KERNEL
+	;;
+	srlz.d
+	or r23=r25,r20			// construct PA | page properties
+	mov r25=IA64_GRANULE_SHIFT<<2
+	;;
+#ifdef CONFIG_XEN
+	movl r8=XSI_ITIR
+	;;
+	st8 [r8]=r25
+	;;
+	movl r8=XSI_IFA
+	;;
+	st8 [r8]=in0			 // VA of next task...
+	;;
+	mov r25=IA64_TR_CURRENT_STACK
+	// remember last page we mapped...
+	mov r8=IA64_KR_CURRENT_STACK
+	mov r9=r26;;
+	XEN_HYPER_SET_KR;;
+#else
+	mov cr.itir=r25
+	mov cr.ifa=in0			// VA of next task...
+	;;
+	mov r25=IA64_TR_CURRENT_STACK
+	mov IA64_KR(CURRENT_STACK)=r26	// remember last page we mapped...
+#endif
+	;;
+	itr.d dtr[r25]=r23		// wire in new mapping...
+#ifdef CONFIG_XEN
+	;;
+	srlz.d
+	mov r9=1
+	movl r8=XSI_PSR_IC
+	;;
+	st4 [r8]=r9
+	;;
+#else
+	ssm psr.ic			// reenable the psr.ic bit
+	;;
+	srlz.d
+#endif
+	br.cond.sptk .done
+#ifdef CONFIG_XEN
+END(xen_switch_to)
+#else
+END(ia64_switch_to)
+#endif
+
+#ifdef CONFIG_XEN
+GLOBAL_ENTRY(xen_work_processed_syscall_with_check)
+	BR_IF_NATIVE(__ia64_work_processed_syscall, r2, p7)
+	br.cond.sptk xen_work_processed_syscall
+END(xen_work_processed_syscall_with_check)
+#endif
+
+/*
+ * ia64_leave_syscall(): Same as ia64_leave_kernel, except that it doesn't
+ *	need to switch to bank 0 and doesn't restore the scratch registers.
+ *	To avoid leaking kernel bits, the scratch registers are set to
+ *	the following known-to-be-safe values:
+ *
+ *		  r1: restored (global pointer)
+ *		  r2: cleared
+ *		  r3: 1 (when returning to user-level)
+ *	      r8-r11: restored (syscall return value(s))
+ *		 r12: restored (user-level stack pointer)
+ *		 r13: restored (user-level thread pointer)
+ *		 r14: set to __kernel_syscall_via_epc
+ *		 r15: restored (syscall #)
+ *	     r16-r17: cleared
+ *		 r18: user-level b6
+ *		 r19: cleared
+ *		 r20: user-level ar.fpsr
+ *		 r21: user-level b0
+ *		 r22: cleared
+ *		 r23: user-level ar.bspstore
+ *		 r24: user-level ar.rnat
+ *		 r25: user-level ar.unat
+ *		 r26: user-level ar.pfs
+ *		 r27: user-level ar.rsc
+ *		 r28: user-level ip
+ *		 r29: user-level psr
+ *		 r30: user-level cfm
+ *		 r31: user-level pr
+ *	      f6-f11: cleared
+ *		  pr: restored (user-level pr)
+ *		  b0: restored (user-level rp)
+ *	          b6: restored
+ *		  b7: set to __kernel_syscall_via_epc
+ *	     ar.unat: restored (user-level ar.unat)
+ *	      ar.pfs: restored (user-level ar.pfs)
+ *	      ar.rsc: restored (user-level ar.rsc)
+ *	     ar.rnat: restored (user-level ar.rnat)
+ *	 ar.bspstore: restored (user-level ar.bspstore)
+ *	     ar.fpsr: restored (user-level ar.fpsr)
+ *	      ar.ccv: cleared
+ *	      ar.csd: cleared
+ *	      ar.ssd: cleared
+ */
+#ifdef CONFIG_XEN
+GLOBAL_ENTRY(xen_leave_syscall)
+	BR_IF_NATIVE(__ia64_leave_syscall, r22, p7)
+#else
+ENTRY(ia64_leave_syscall)
+#endif
+	PT_REGS_UNWIND_INFO(0)
+	/*
+	 * work.need_resched etc. mustn't get changed by this CPU before it returns to
+	 * user- or fsys-mode, hence we disable interrupts early on.
+	 *
+	 * p6 controls whether current_thread_info()->flags needs to be check for
+	 * extra work.  We always check for extra work when returning to user-level.
+	 * With CONFIG_PREEMPT, we also check for extra work when the preempt_count
+	 * is 0.  After extra work processing has been completed, execution
+	 * resumes at .work_processed_syscall with p6 set to 1 if the extra-work-check
+	 * needs to be redone.
+	 */
+#ifdef CONFIG_PREEMPT
+	rsm psr.i				// disable interrupts
+	cmp.eq pLvSys,p0=r0,r0			// pLvSys=1: leave from syscall
+(pKStk) adds r20=TI_PRE_COUNT+IA64_TASK_SIZE,r13
+	;;
+	.pred.rel.mutex pUStk,pKStk
+(pKStk) ld4 r21=[r20]			// r21 <- preempt_count
+(pUStk)	mov r21=0			// r21 <- 0
+	;;
+	cmp.eq p6,p0=r21,r0		// p6 <- pUStk || (preempt_count == 0)
+#else /* !CONFIG_PREEMPT */
+#ifdef CONFIG_XEN
+	movl r2=XSI_PSR_I_ADDR
+	mov r18=1
+	;;
+	ld8 r2=[r2]
+	;;
+(pUStk)	st1 [r2]=r18
+#else
+(pUStk)	rsm psr.i
+#endif
+	cmp.eq pLvSys,p0=r0,r0		// pLvSys=1: leave from syscall
+(pUStk)	cmp.eq.unc p6,p0=r0,r0		// p6 <- pUStk
+#endif
+#ifdef CONFIG_XEN
+.global xen_work_processed_syscall;
+xen_work_processed_syscall:
+#else
+.work_processed_syscall:
+#endif
+	adds r2=PT(LOADRS)+16,r12
+	adds r3=PT(AR_BSPSTORE)+16,r12
+	adds r18=TI_FLAGS+IA64_TASK_SIZE,r13
+	;;
+(p6)	ld4 r31=[r18]				// load current_thread_info()->flags
+	ld8 r19=[r2],PT(B6)-PT(LOADRS)		// load ar.rsc value for "loadrs"
+	nop.i 0
+	;;
+	mov r16=ar.bsp				// M2  get existing backing store pointer
+	ld8 r18=[r2],PT(R9)-PT(B6)		// load b6
+(p6)	and r15=TIF_WORK_MASK,r31		// any work other than TIF_SYSCALL_TRACE?
+	;;
+	ld8 r23=[r3],PT(R11)-PT(AR_BSPSTORE)	// load ar.bspstore (may be garbage)
+(p6)	cmp4.ne.unc p6,p0=r15, r0		// any special work pending?
+(p6)	br.cond.spnt .work_pending_syscall
+	;;
+	// start restoring the state saved on the kernel stack (struct pt_regs):
+	ld8 r9=[r2],PT(CR_IPSR)-PT(R9)
+	ld8 r11=[r3],PT(CR_IIP)-PT(R11)
+(pNonSys) break 0		//      bug check: we shouldn't be here if pNonSys is TRUE!
+	;;
+	invala			// M0|1 invalidate ALAT
+#ifdef CONFIG_XEN
+	movl r28=XSI_PSR_I_ADDR
+	movl r29=XSI_PSR_IC
+	;;
+	ld8 r28=[r28]
+	mov r30=1
+	;;
+	st1	[r28]=r30
+	st4	[r29]=r0	// note: clears both vpsr.i and vpsr.ic!
+	;;
+#else
+	rsm psr.i | psr.ic	// M2   turn off interrupts and interruption collection
+#endif
+	cmp.eq p9,p0=r0,r0	// A    set p9 to indicate that we should restore cr.ifs
+
+	ld8 r29=[r2],16		// M0|1 load cr.ipsr
+	ld8 r28=[r3],16		// M0|1 load cr.iip
+	mov r22=r0		// A    clear r22
+	;;
+	ld8 r30=[r2],16		// M0|1 load cr.ifs
+	ld8 r25=[r3],16		// M0|1 load ar.unat
+(pUStk) add r14=IA64_TASK_THREAD_ON_USTACK_OFFSET,r13
+	;;
+	ld8 r26=[r2],PT(B0)-PT(AR_PFS)	// M0|1 load ar.pfs
+#ifdef CONFIG_XEN
+(pKStk)	mov r21=r8
+(pKStk)	XEN_HYPER_GET_PSR
+	;;
+(pKStk)	mov r22=r8
+(pKStk)	mov r8=r21
+	;;
+#else
+(pKStk)	mov r22=psr			// M2   read PSR now that interrupts are disabled
+#endif
+	nop 0
+	;;
+	ld8 r21=[r2],PT(AR_RNAT)-PT(B0) // M0|1 load b0
+	ld8 r27=[r3],PT(PR)-PT(AR_RSC)	// M0|1 load ar.rsc
+	mov f6=f0			// F    clear f6
+	;;
+	ld8 r24=[r2],PT(AR_FPSR)-PT(AR_RNAT)	// M0|1 load ar.rnat (may be garbage)
+	ld8 r31=[r3],PT(R1)-PT(PR)		// M0|1 load predicates
+	mov f7=f0				// F    clear f7
+	;;
+	ld8 r20=[r2],PT(R12)-PT(AR_FPSR)	// M0|1 load ar.fpsr
+	ld8.fill r1=[r3],16			// M0|1 load r1
+(pUStk) mov r17=1				// A
+	;;
+(pUStk) st1 [r14]=r17				// M2|3
+	ld8.fill r13=[r3],16			// M0|1
+	mov f8=f0				// F    clear f8
+	;;
+	ld8.fill r12=[r2]			// M0|1 restore r12 (sp)
+	ld8.fill r15=[r3]			// M0|1 restore r15
+	mov b6=r18				// I0   restore b6
+
+	LOAD_PHYS_STACK_REG_SIZE(r17)
+	mov f9=f0					// F    clear f9
+(pKStk) br.cond.dpnt.many skip_rbs_switch		// B
+
+	srlz.d				// M0   ensure interruption collection is off (for cover)
+	shr.u r18=r19,16		// I0|1 get byte size of existing "dirty" partition
+#ifdef CONFIG_XEN
+	XEN_HYPER_COVER;
+#else
+	cover				// B    add current frame into dirty partition & set cr.ifs
+#endif
+	;;
+	mov r19=ar.bsp			// M2   get new backing store pointer
+	mov f10=f0			// F    clear f10
+
+	nop.m 0
+	movl r14=__kernel_syscall_via_epc // X
+	;;
+	mov.m ar.csd=r0			// M2   clear ar.csd
+	mov.m ar.ccv=r0			// M2   clear ar.ccv
+	mov b7=r14			// I0   clear b7 (hint with __kernel_syscall_via_epc)
+
+	mov.m ar.ssd=r0			// M2   clear ar.ssd
+	mov f11=f0			// F    clear f11
+	br.cond.sptk.many rbs_switch	// B
+#ifdef CONFIG_XEN
+END(xen_leave_syscall)
+#else
+END(ia64_leave_syscall)
+#endif
+
+#ifdef CONFIG_XEN
+GLOBAL_ENTRY(xen_leave_kernel)
+	BR_IF_NATIVE(__ia64_leave_kernel, r22, p7)
+#else
+GLOBAL_ENTRY(ia64_leave_kernel)
+#endif
+	PT_REGS_UNWIND_INFO(0)
+	/*
+	 * work.need_resched etc. mustn't get changed by this CPU before it returns to
+	 * user- or fsys-mode, hence we disable interrupts early on.
+	 *
+	 * p6 controls whether current_thread_info()->flags needs to be check for
+	 * extra work.  We always check for extra work when returning to user-level.
+	 * With CONFIG_PREEMPT, we also check for extra work when the preempt_count
+	 * is 0.  After extra work processing has been completed, execution
+	 * resumes at .work_processed_syscall with p6 set to 1 if the extra-work-check
+	 * needs to be redone.
+	 */
+#ifdef CONFIG_PREEMPT
+	rsm psr.i				// disable interrupts
+	cmp.eq p0,pLvSys=r0,r0			// pLvSys=0: leave from kernel
+(pKStk)	adds r20=TI_PRE_COUNT+IA64_TASK_SIZE,r13
+	;;
+	.pred.rel.mutex pUStk,pKStk
+(pKStk)	ld4 r21=[r20]			// r21 <- preempt_count
+(pUStk)	mov r21=0			// r21 <- 0
+	;;
+	cmp.eq p6,p0=r21,r0		// p6 <- pUStk || (preempt_count == 0)
+#else
+#ifdef CONFIG_XEN
+(pUStk)	movl r17=XSI_PSR_I_ADDR
+(pUStk)	mov r31=1
+		;;
+(pUStk) 	ld8 r17=[r17]
+		;;
+(pUStk)	st1 [r17]=r31
+	;;
+#else
+(pUStk)	rsm psr.i
+#endif
+	cmp.eq p0,pLvSys=r0,r0		// pLvSys=0: leave from kernel
+(pUStk)	cmp.eq.unc p6,p0=r0,r0		// p6 <- pUStk
+#endif
+.work_processed_kernel:
+	adds r17=TI_FLAGS+IA64_TASK_SIZE,r13
+	;;
+(p6)	ld4 r31=[r17]				// load current_thread_info()->flags
+	adds r21=PT(PR)+16,r12
+	;;
+
+	lfetch [r21],PT(CR_IPSR)-PT(PR)
+	adds r2=PT(B6)+16,r12
+	adds r3=PT(R16)+16,r12
+	;;
+	lfetch [r21]
+	ld8 r28=[r2],8		// load b6
+	adds r29=PT(R24)+16,r12
+
+	ld8.fill r16=[r3],PT(AR_CSD)-PT(R16)
+	adds r30=PT(AR_CCV)+16,r12
+(p6)	and r19=TIF_WORK_MASK,r31		// any work other than TIF_SYSCALL_TRACE?
+	;;
+	ld8.fill r24=[r29]
+	ld8 r15=[r30]		// load ar.ccv
+(p6)	cmp4.ne.unc p6,p0=r19, r0		// any special work pending?
+	;;
+	ld8 r29=[r2],16		// load b7
+	ld8 r30=[r3],16		// load ar.csd
+(p6)	br.cond.spnt .work_pending
+	;;
+	ld8 r31=[r2],16		// load ar.ssd
+	ld8.fill r8=[r3],16
+	;;
+	ld8.fill r9=[r2],16
+	ld8.fill r10=[r3],PT(R17)-PT(R10)
+	;;
+	ld8.fill r11=[r2],PT(R18)-PT(R11)
+	ld8.fill r17=[r3],16
+	;;
+	ld8.fill r18=[r2],16
+	ld8.fill r19=[r3],16
+	;;
+	ld8.fill r20=[r2],16
+	ld8.fill r21=[r3],16
+	mov ar.csd=r30
+	mov ar.ssd=r31
+	;;
+#ifdef CONFIG_XEN
+	movl r23=XSI_PSR_I_ADDR
+	movl r22=XSI_PSR_IC
+	;;
+	ld8 r23=[r23]
+	mov r25=1
+	;;
+	st1 [r23]=r25
+	st4 [r22]=r0		// note: clears both vpsr.i and vpsr.ic!
+	;;
+#else
+	rsm psr.i | psr.ic	// initiate turning off of interrupt and interruption collection
+#endif
+	invala			// invalidate ALAT
+	;;
+	ld8.fill r22=[r2],24
+	ld8.fill r23=[r3],24
+	mov b6=r28
+	;;
+	ld8.fill r25=[r2],16
+	ld8.fill r26=[r3],16
+	mov b7=r29
+	;;
+	ld8.fill r27=[r2],16
+	ld8.fill r28=[r3],16
+	;;
+	ld8.fill r29=[r2],16
+	ld8.fill r30=[r3],24
+	;;
+	ld8.fill r31=[r2],PT(F9)-PT(R31)
+	adds r3=PT(F10)-PT(F6),r3
+	;;
+	ldf.fill f9=[r2],PT(F6)-PT(F9)
+	ldf.fill f10=[r3],PT(F8)-PT(F10)
+	;;
+	ldf.fill f6=[r2],PT(F7)-PT(F6)
+	;;
+	ldf.fill f7=[r2],PT(F11)-PT(F7)
+	ldf.fill f8=[r3],32
+	;;
+	srlz.d	// ensure that inter. collection is off (VHPT is don't care, since text is pinned)
+	mov ar.ccv=r15
+	;;
+	ldf.fill f11=[r2]
+#ifdef CONFIG_XEN
+	;;
+	// r16-r31 all now hold bank1 values
+	mov r15=ar.unat
+	movl r2=XSI_BANK1_R16
+	movl r3=XSI_BANK1_R16+8
+	;;
+.mem.offset 0,0; st8.spill [r2]=r16,16
+.mem.offset 8,0; st8.spill [r3]=r17,16
+	;;
+.mem.offset 0,0; st8.spill [r2]=r18,16
+.mem.offset 8,0; st8.spill [r3]=r19,16
+	;;
+.mem.offset 0,0; st8.spill [r2]=r20,16
+.mem.offset 8,0; st8.spill [r3]=r21,16
+	;;
+.mem.offset 0,0; st8.spill [r2]=r22,16
+.mem.offset 8,0; st8.spill [r3]=r23,16
+	;;
+.mem.offset 0,0; st8.spill [r2]=r24,16
+.mem.offset 8,0; st8.spill [r3]=r25,16
+	;;
+.mem.offset 0,0; st8.spill [r2]=r26,16
+.mem.offset 8,0; st8.spill [r3]=r27,16
+	;;
+.mem.offset 0,0; st8.spill [r2]=r28,16
+.mem.offset 8,0; st8.spill [r3]=r29,16
+	;;
+.mem.offset 0,0; st8.spill [r2]=r30,16
+.mem.offset 8,0; st8.spill [r3]=r31,16
+	;;
+	mov r3=ar.unat
+	movl r2=XSI_B1NAT
+	;;
+	st8 [r2]=r3
+	mov ar.unat=r15
+	movl r2=XSI_BANKNUM;;
+	st4 [r2]=r0;
+#else
+	bsw.0			// switch back to bank 0 (no stop bit required beforehand...)
+#endif
+	;;
+(pUStk)	mov r18=IA64_KR(CURRENT)// M2 (12 cycle read latency)
+	adds r16=PT(CR_IPSR)+16,r12
+	adds r17=PT(CR_IIP)+16,r12
+
+#ifdef CONFIG_XEN
+(pKStk)	mov r29=r8
+(pKStk)	XEN_HYPER_GET_PSR
+	;;
+(pKStk)	mov r22=r8
+(pKStk)	mov r8=r29
+	;;
+#else
+(pKStk)	mov r22=psr		// M2 read PSR now that interrupts are disabled
+#endif
+	nop.i 0
+	nop.i 0
+	;;
+	ld8 r29=[r16],16	// load cr.ipsr
+	ld8 r28=[r17],16	// load cr.iip
+	;;
+	ld8 r30=[r16],16	// load cr.ifs
+	ld8 r25=[r17],16	// load ar.unat
+	;;
+	ld8 r26=[r16],16	// load ar.pfs
+	ld8 r27=[r17],16	// load ar.rsc
+	cmp.eq p9,p0=r0,r0	// set p9 to indicate that we should restore cr.ifs
+	;;
+	ld8 r24=[r16],16	// load ar.rnat (may be garbage)
+	ld8 r23=[r17],16	// load ar.bspstore (may be garbage)
+	;;
+	ld8 r31=[r16],16	// load predicates
+	ld8 r21=[r17],16	// load b0
+	;;
+	ld8 r19=[r16],16	// load ar.rsc value for "loadrs"
+	ld8.fill r1=[r17],16	// load r1
+	;;
+	ld8.fill r12=[r16],16
+	ld8.fill r13=[r17],16
+(pUStk)	adds r18=IA64_TASK_THREAD_ON_USTACK_OFFSET,r18
+	;;
+	ld8 r20=[r16],16	// ar.fpsr
+	ld8.fill r15=[r17],16
+	;;
+	ld8.fill r14=[r16],16
+	ld8.fill r2=[r17]
+(pUStk)	mov r17=1
+	;;
+	ld8.fill r3=[r16]
+(pUStk)	st1 [r18]=r17		// restore current->thread.on_ustack
+	shr.u r18=r19,16	// get byte size of existing "dirty" partition
+	;;
+	mov r16=ar.bsp		// get existing backing store pointer
+	LOAD_PHYS_STACK_REG_SIZE(r17)
+(pKStk)	br.cond.dpnt skip_rbs_switch
+
+	/*
+	 * Restore user backing store.
+	 *
+	 * NOTE: alloc, loadrs, and cover can't be predicated.
+	 */
+(pNonSys) br.cond.dpnt dont_preserve_current_frame
+
+#ifdef CONFIG_XEN
+	XEN_HYPER_COVER;
+#else
+	cover				// add current frame into dirty partition and set cr.ifs
+#endif
+	;;
+	mov r19=ar.bsp			// get new backing store pointer
+rbs_switch:
+	sub r16=r16,r18			// krbs = old bsp - size of dirty partition
+	cmp.ne p9,p0=r0,r0		// clear p9 to skip restore of cr.ifs
+	;;
+	sub r19=r19,r16			// calculate total byte size of dirty partition
+	add r18=64,r18			// don't force in0-in7 into memory...
+	;;
+	shl r19=r19,16			// shift size of dirty partition into loadrs position
+	;;
+dont_preserve_current_frame:
+	/*
+	 * To prevent leaking bits between the kernel and user-space,
+	 * we must clear the stacked registers in the "invalid" partition here.
+	 * Not pretty, but at least it's fast (3.34 registers/cycle on Itanium,
+	 * 5 registers/cycle on McKinley).
+	 */
+#	define pRecurse	p6
+#	define pReturn	p7
+#ifdef CONFIG_ITANIUM
+#	define Nregs	10
+#else
+#	define Nregs	14
+#endif
+	alloc loc0=ar.pfs,2,Nregs-2,2,0
+	shr.u loc1=r18,9		// RNaTslots <= floor(dirtySize / (64*8))
+	sub r17=r17,r18			// r17 = (physStackedSize + 8) - dirtySize
+	;;
+	mov ar.rsc=r19			// load ar.rsc to be used for "loadrs"
+	shladd in0=loc1,3,r17
+	mov in1=0
+	;;
+	TEXT_ALIGN(32)
+rse_clear_invalid:
+#ifdef CONFIG_ITANIUM
+	// cycle 0
+ { .mii
+	alloc loc0=ar.pfs,2,Nregs-2,2,0
+	cmp.lt pRecurse,p0=Nregs*8,in0	// if more than Nregs regs left to clear, (re)curse
+	add out0=-Nregs*8,in0
+}{ .mfb
+	add out1=1,in1			// increment recursion count
+	nop.f 0
+	nop.b 0				// can't do br.call here because of alloc (WAW on CFM)
+	;;
+}{ .mfi	// cycle 1
+	mov loc1=0
+	nop.f 0
+	mov loc2=0
+}{ .mib
+	mov loc3=0
+	mov loc4=0
+(pRecurse) br.call.sptk.many b0=rse_clear_invalid
+
+}{ .mfi	// cycle 2
+	mov loc5=0
+	nop.f 0
+	cmp.ne pReturn,p0=r0,in1	// if recursion count != 0, we need to do a br.ret
+}{ .mib
+	mov loc6=0
+	mov loc7=0
+(pReturn) br.ret.sptk.many b0
+}
+#else /* !CONFIG_ITANIUM */
+	alloc loc0=ar.pfs,2,Nregs-2,2,0
+	cmp.lt pRecurse,p0=Nregs*8,in0	// if more than Nregs regs left to clear, (re)curse
+	add out0=-Nregs*8,in0
+	add out1=1,in1			// increment recursion count
+	mov loc1=0
+	mov loc2=0
+	;;
+	mov loc3=0
+	mov loc4=0
+	mov loc5=0
+	mov loc6=0
+	mov loc7=0
+(pRecurse) br.call.dptk.few b0=rse_clear_invalid
+	;;
+	mov loc8=0
+	mov loc9=0
+	cmp.ne pReturn,p0=r0,in1	// if recursion count != 0, we need to do a br.ret
+	mov loc10=0
+	mov loc11=0
+(pReturn) br.ret.dptk.many b0
+#endif /* !CONFIG_ITANIUM */
+#	undef pRecurse
+#	undef pReturn
+	;;
+	alloc r17=ar.pfs,0,0,0,0	// drop current register frame
+	;;
+	loadrs
+	;;
+skip_rbs_switch:
+	mov ar.unat=r25		// M2
+(pKStk)	extr.u r22=r22,21,1	// I0 extract current value of psr.pp from r22
+(pLvSys)mov r19=r0		// A  clear r19 for leave_syscall, no-op otherwise
+	;;
+(pUStk)	mov ar.bspstore=r23	// M2
+(pKStk)	dep r29=r22,r29,21,1	// I0 update ipsr.pp with psr.pp
+(pLvSys)mov r16=r0		// A  clear r16 for leave_syscall, no-op otherwise
+	;;
+#ifdef CONFIG_XEN
+	movl r25=XSI_IPSR
+	;;
+	st8[r25]=r29,XSI_IFS_OFS-XSI_IPSR_OFS
+	;;
+#else
+	mov cr.ipsr=r29		// M2
+#endif
+	mov ar.pfs=r26		// I0
+(pLvSys)mov r17=r0		// A  clear r17 for leave_syscall, no-op otherwise
+
+#ifdef CONFIG_XEN
+(p9)	st8 [r25]=r30
+	;;
+	adds r25=XSI_IIP_OFS-XSI_IFS_OFS,r25
+	;;
+#else
+(p9)	mov cr.ifs=r30		// M2
+#endif
+	mov b0=r21		// I0
+(pLvSys)mov r18=r0		// A  clear r18 for leave_syscall, no-op otherwise
+
+	mov ar.fpsr=r20		// M2
+#ifdef CONFIG_XEN
+	st8	[r25]=r28
+#else
+	mov cr.iip=r28		// M2
+#endif
+	nop 0
+	;;
+(pUStk)	mov ar.rnat=r24		// M2 must happen with RSE in lazy mode
+	nop 0
+(pLvSys)mov r2=r0
+
+	mov ar.rsc=r27		// M2
+	mov pr=r31,-1		// I0
+#ifdef CONFIG_XEN
+	;;
+	XEN_HYPER_RFI;
+#else
+	rfi			// B
+#endif
+
+	/*
+	 * On entry:
+	 *	r20 = &current->thread_info->pre_count (if CONFIG_PREEMPT)
+	 *	r31 = current->thread_info->flags
+	 * On exit:
+	 *	p6 = TRUE if work-pending-check needs to be redone
+	 */
+.work_pending_syscall:
+	add r2=-8,r2
+	add r3=-8,r3
+	;;
+	st8 [r2]=r8
+	st8 [r3]=r10
+.work_pending:
+	tbit.z p6,p0=r31,TIF_NEED_RESCHED		// current_thread_info()->need_resched==0?
+(p6)	br.cond.sptk.few .notify
+#ifdef CONFIG_PREEMPT
+(pKStk) dep r21=-1,r0,PREEMPT_ACTIVE_BIT,1
+	;;
+(pKStk) st4 [r20]=r21
+	ssm psr.i		// enable interrupts
+#endif
+	br.call.spnt.many rp=schedule
+.ret9:	cmp.eq p6,p0=r0,r0				// p6 <- 1
+#ifdef CONFIG_XEN
+	movl r2=XSI_PSR_I_ADDR
+	mov r20=1
+	;;
+	ld8 r2=[r2]
+	;;
+	st1 [r2]=r20
+#else
+	rsm psr.i		// disable interrupts
+#endif
+	;;
+#ifdef CONFIG_PREEMPT
+(pKStk)	adds r20=TI_PRE_COUNT+IA64_TASK_SIZE,r13
+	;;
+(pKStk)	st4 [r20]=r0		// preempt_count() <- 0
+#endif
+(pLvSys)br.cond.sptk.few  .work_pending_syscall_end
+	br.cond.sptk.many .work_processed_kernel	// re-check
+
+.notify:
+(pUStk)	br.call.spnt.many rp=notify_resume_user
+.ret10:	cmp.ne p6,p0=r0,r0				// p6 <- 0
+(pLvSys)br.cond.sptk.few  .work_pending_syscall_end
+	br.cond.sptk.many .work_processed_kernel	// don't re-check
+
+.work_pending_syscall_end:
+	adds r2=PT(R8)+16,r12
+	adds r3=PT(R10)+16,r12
+	;;
+	ld8 r8=[r2]
+	ld8 r10=[r3]
+#ifdef CONFIG_XEN
+	br.cond.sptk.many xen_work_processed_syscall	// re-check
+#else
+	br.cond.sptk.many .work_processed_syscall	// re-check
+#endif
+
+#ifdef CONFIG_XEN
+END(xen_leave_kernel)
+#else
+END(ia64_leave_kernel)
+#endif
diff --git a/arch/ia64/xen/xenivt.S b/arch/ia64/xen/xenivt.S
new file mode 100644
index 0000000..f2eaa1f
--- /dev/null
+++ b/arch/ia64/xen/xenivt.S
@@ -0,0 +1,2204 @@
+/*
+ * arch/ia64/xen/ivt.S
+ *
+ * Copyright (C) 2005 Hewlett-Packard Co
+ *	Dan Magenheimer <dan.magenheimer@hp.com>
+ */
+/*
+ * This file defines the interruption vector table used by the CPU.
+ * It does not include one entry per possible cause of interruption.
+ *
+ * The first 20 entries of the table contain 64 bundles each while the
+ * remaining 48 entries contain only 16 bundles each.
+ *
+ * The 64 bundles are used to allow inlining the whole handler for critical
+ * interruptions like TLB misses.
+ *
+ *  For each entry, the comment is as follows:
+ *
+ *		// 0x1c00 Entry 7 (size 64 bundles) Data Key Miss (12,51)
+ *  entry offset ----/     /         /                  /          /
+ *  entry number ---------/         /                  /          /
+ *  size of the entry -------------/                  /          /
+ *  vector name -------------------------------------/          /
+ *  interruptions triggering this vector ----------------------/
+ *
+ * The table is 32KB in size and must be aligned on 32KB boundary.
+ * (The CPU ignores the 15 lower bits of the address)
+ *
+ * Table is based upon EAS2.6 (Oct 1999)
+ */
+
+
+#include <asm/asmmacro.h>
+#include <asm/break.h>
+#include <asm/ia32.h>
+#include <asm/kregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/thread_info.h>
+#include <asm/unistd.h>
+#include <asm/errno.h>
+
+#ifdef CONFIG_XEN
+#define ia64_ivt xen_ivt
+#endif
+
+#if 1
+# define PSR_DEFAULT_BITS	psr.ac
+#else
+# define PSR_DEFAULT_BITS	0
+#endif
+
+#if 0
+  /*
+   * This lets you track the last eight faults that occurred on the CPU.  Make sure ar.k2 isn't
+   * needed for something else before enabling this...
+   */
+# define DBG_FAULT(i)	mov r16=ar.k2;;	shl r16=r16,8;;	add r16=(i),r16;;mov ar.k2=r16
+#else
+# define DBG_FAULT(i)
+#endif
+
+#ifdef CONFIG_XEN
+#include "xenminstate.h"
+#else
+#include "minstate.h"
+#endif
+
+#define FAULT(n)									\
+	mov r31=pr;									\
+	mov r19=n;;			/* prepare to save predicates */		\
+	br.sptk.many dispatch_to_fault_handler
+
+	.section .text.ivt,"ax"
+
+	.align 32768	// align on 32KB boundary
+	.global ia64_ivt
+ia64_ivt:
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x0000 Entry 0 (size 64 bundles) VHPT Translation (8,20,47)
+ENTRY(vhpt_miss)
+	DBG_FAULT(0)
+	/*
+	 * The VHPT vector is invoked when the TLB entry for the virtual page table
+	 * is missing.  This happens only as a result of a previous
+	 * (the "original") TLB miss, which may either be caused by an instruction
+	 * fetch or a data access (or non-access).
+	 *
+	 * What we do here is normal TLB miss handing for the _original_ miss,
+	 * followed by inserting the TLB entry for the virtual page table page
+	 * that the VHPT walker was attempting to access.  The latter gets
+	 * inserted as long as page table entry above pte level have valid
+	 * mappings for the faulting address.  The TLB entry for the original
+	 * miss gets inserted only if the pte entry indicates that the page is
+	 * present.
+	 *
+	 * do_page_fault gets invoked in the following cases:
+	 *	- the faulting virtual address uses unimplemented address bits
+	 *	- the faulting virtual address has no valid page table mapping
+	 */
+#ifdef CONFIG_XEN
+	movl r16=XSI_IFA
+	;;
+	ld8 r16=[r16]
+#ifdef CONFIG_HUGETLB_PAGE
+	movl r18=PAGE_SHIFT
+	movl r25=XSI_ITIR
+	;;
+	ld8 r25=[r25]
+#endif
+#else
+	mov r16=cr.ifa				// get address that caused the TLB miss
+#ifdef CONFIG_HUGETLB_PAGE
+	movl r18=PAGE_SHIFT
+	mov r25=cr.itir
+#endif
+#endif
+	;;
+#ifdef CONFIG_XEN
+	XEN_HYPER_RSM_PSR_DT;
+#else
+	rsm psr.dt				// use physical addressing for data
+#endif
+	mov r31=pr				// save the predicate registers
+	mov r19=IA64_KR(PT_BASE)		// get page table base address
+	shl r21=r16,3				// shift bit 60 into sign bit
+	shr.u r17=r16,61			// get the region number into r17
+	;;
+	shr.u r22=r21,3
+#ifdef CONFIG_HUGETLB_PAGE
+	extr.u r26=r25,2,6
+	;;
+	cmp.ne p8,p0=r18,r26
+	sub r27=r26,r18
+	;;
+(p8)	dep r25=r18,r25,2,6
+(p8)	shr r22=r22,r27
+#endif
+	;;
+	cmp.eq p6,p7=5,r17			// is IFA pointing into to region 5?
+	shr.u r18=r22,PGDIR_SHIFT		// get bottom portion of pgd index bit
+	;;
+(p7)	dep r17=r17,r19,(PAGE_SHIFT-3),3	// put region number bits in place
+
+	srlz.d
+	LOAD_PHYSICAL(p6, r19, swapper_pg_dir)	// region 5 is rooted at swapper_pg_dir
+
+	.pred.rel "mutex", p6, p7
+(p6)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT
+(p7)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT-3
+	;;
+(p6)	dep r17=r18,r19,3,(PAGE_SHIFT-3)	// r17=pgd_offset for region 5
+(p7)	dep r17=r18,r17,3,(PAGE_SHIFT-6)	// r17=pgd_offset for region[0-4]
+	cmp.eq p7,p6=0,r21			// unused address bits all zeroes?
+#ifdef CONFIG_PGTABLE_4
+	shr.u r28=r22,PUD_SHIFT			// shift pud index into position
+#else
+	shr.u r18=r22,PMD_SHIFT			// shift pmd index into position
+#endif
+	;;
+	ld8 r17=[r17]				// get *pgd (may be 0)
+	;;
+(p7)	cmp.eq p6,p7=r17,r0			// was pgd_present(*pgd) == NULL?
+#ifdef CONFIG_PGTABLE_4
+	dep r28=r28,r17,3,(PAGE_SHIFT-3)	// r28=pud_offset(pgd,addr)
+	;;
+	shr.u r18=r22,PMD_SHIFT			// shift pmd index into position
+(p7)	ld8 r29=[r28]				// get *pud (may be 0)
+	;;
+(p7)	cmp.eq.or.andcm p6,p7=r29,r0		// was pud_present(*pud) == NULL?
+	dep r17=r18,r29,3,(PAGE_SHIFT-3)	// r17=pmd_offset(pud,addr)
+#else
+	dep r17=r18,r17,3,(PAGE_SHIFT-3)	// r17=pmd_offset(pgd,addr)
+#endif
+	;;
+(p7)	ld8 r20=[r17]				// get *pmd (may be 0)
+	shr.u r19=r22,PAGE_SHIFT		// shift pte index into position
+	;;
+(p7)	cmp.eq.or.andcm p6,p7=r20,r0		// was pmd_present(*pmd) == NULL?
+	dep r21=r19,r20,3,(PAGE_SHIFT-3)	// r21=pte_offset(pmd,addr)
+	;;
+(p7)	ld8 r18=[r21]				// read *pte
+#ifdef CONFIG_XEN
+	movl r19=XSI_ISR
+	;;
+	ld8 r19=[r19]
+#else
+	mov r19=cr.isr				// cr.isr bit 32 tells us if this is an insn miss
+#endif
+	;;
+(p7)	tbit.z p6,p7=r18,_PAGE_P_BIT		// page present bit cleared?
+#ifdef CONFIG_XEN
+	movl r22=XSI_IHA
+	;;
+	ld8 r22=[r22]
+#else
+	mov r22=cr.iha				// get the VHPT address that caused the TLB miss
+#endif
+	;;					// avoid RAW on p7
+(p7)	tbit.nz.unc p10,p11=r19,32		// is it an instruction TLB miss?
+	dep r23=0,r20,0,PAGE_SHIFT		// clear low bits to get page address
+	;;
+#ifdef CONFIG_XEN
+	mov r24=r8
+	mov r8=r18
+	;;
+(p10)	XEN_HYPER_ITC_I
+	;;
+(p11)	XEN_HYPER_ITC_D
+	;;
+	mov r8=r24
+	;;
+#else
+(p10)	itc.i r18				// insert the instruction TLB entry
+(p11)	itc.d r18				// insert the data TLB entry
+#endif
+(p6)	br.cond.spnt.many page_fault		// handle bad address/page not present (page fault)
+#ifdef CONFIG_XEN
+	movl r24=XSI_IFA
+	;;
+	st8 [r24]=r22
+	;;
+#ifdef CONFIG_HUGETLB_PAGE
+(p8)	movl r24=XSI_ITIR
+	;;
+(p8)	st8 [r24]=r25
+#endif
+#else
+	mov cr.ifa=r22
+
+#ifdef CONFIG_HUGETLB_PAGE
+(p8)	mov cr.itir=r25				// change to default page-size for VHPT
+#endif
+#endif
+
+	/*
+	 * Now compute and insert the TLB entry for the virtual page table.  We never
+	 * execute in a page table page so there is no need to set the exception deferral
+	 * bit.
+	 */
+	adds r24=__DIRTY_BITS_NO_ED|_PAGE_PL_0|_PAGE_AR_RW,r23
+	;;
+#ifdef CONFIG_XEN
+(p7)	mov r25=r8
+(p7)	mov r8=r24
+	;;
+(p7)	XEN_HYPER_ITC_D
+	;;
+(p7)	mov r8=r25
+	;;
+#else
+(p7)	itc.d r24
+#endif
+	;;
+#ifdef CONFIG_SMP
+	/*
+	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
+	 * cannot possibly affect the following loads:
+	 */
+	dv_serialize_data
+
+	/*
+	 * Re-check pagetable entry.  If they changed, we may have received a ptc.g
+	 * between reading the pagetable and the "itc".  If so, flush the entry we
+	 * inserted and retry.  At this point, we have:
+	 *
+	 * r28 = equivalent of pud_offset(pgd, ifa)
+	 * r17 = equivalent of pmd_offset(pud, ifa)
+	 * r21 = equivalent of pte_offset(pmd, ifa)
+	 *
+	 * r29 = *pud
+	 * r20 = *pmd
+	 * r18 = *pte
+	 */
+	ld8 r25=[r21]				// read *pte again
+	ld8 r26=[r17]				// read *pmd again
+#ifdef CONFIG_PGTABLE_4
+	ld8 r19=[r28]				// read *pud again
+#endif
+	cmp.ne p6,p7=r0,r0
+	;;
+	cmp.ne.or.andcm p6,p7=r26,r20		// did *pmd change
+#ifdef CONFIG_PGTABLE_4
+	cmp.ne.or.andcm p6,p7=r19,r29		// did *pud change
+#endif
+	mov r27=PAGE_SHIFT<<2
+	;;
+(p6)	ptc.l r22,r27				// purge PTE page translation
+(p7)	cmp.ne.or.andcm p6,p7=r25,r18		// did *pte change
+	;;
+(p6)	ptc.l r16,r27				// purge translation
+#endif
+
+	mov pr=r31,-1				// restore predicate registers
+#ifdef CONFIG_XEN
+	XEN_HYPER_RFI
+	dv_serialize_data
+#else
+	rfi
+#endif
+END(vhpt_miss)
+
+	.org ia64_ivt+0x400
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x0400 Entry 1 (size 64 bundles) ITLB (21)
+ENTRY(itlb_miss)
+	DBG_FAULT(1)
+	/*
+	 * The ITLB handler accesses the PTE via the virtually mapped linear
+	 * page table.  If a nested TLB miss occurs, we switch into physical
+	 * mode, walk the page table, and then re-execute the PTE read and
+	 * go on normally after that.
+	 */
+#ifdef CONFIG_XEN
+	movl r16=XSI_IFA
+	;;
+	ld8 r16=[r16]
+#else
+	mov r16=cr.ifa				// get virtual address
+#endif
+	mov r29=b0				// save b0
+	mov r31=pr				// save predicates
+.itlb_fault:
+#ifdef CONFIG_XEN
+	movl r17=XSI_IHA
+	;;
+	ld8 r17=[r17]				// get virtual address of L3 PTE
+#else
+	mov r17=cr.iha				// get virtual address of PTE
+#endif
+	movl r30=1f				// load nested fault continuation point
+	;;
+1:	ld8 r18=[r17]				// read *pte
+	;;
+	mov b0=r29
+	tbit.z p6,p0=r18,_PAGE_P_BIT		// page present bit cleared?
+(p6)	br.cond.spnt page_fault
+	;;
+#ifdef CONFIG_XEN
+	mov r19=r8
+	mov r8=r18
+	;;
+	XEN_HYPER_ITC_I
+	;;
+	mov r8=r19
+#else
+	itc.i r18
+#endif
+	;;
+#ifdef CONFIG_SMP
+	/*
+	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
+	 * cannot possibly affect the following loads:
+	 */
+	dv_serialize_data
+
+	ld8 r19=[r17]				// read *pte again and see if same
+	mov r20=PAGE_SHIFT<<2			// setup page size for purge
+	;;
+	cmp.ne p7,p0=r18,r19
+	;;
+(p7)	ptc.l r16,r20
+#endif
+	mov pr=r31,-1
+#ifdef CONFIG_XEN
+	XEN_HYPER_RFI
+	dv_serialize_data
+#else
+	rfi
+#endif
+END(itlb_miss)
+
+	.org ia64_ivt+0x0800
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x0800 Entry 2 (size 64 bundles) DTLB (9,48)
+ENTRY(dtlb_miss)
+	DBG_FAULT(2)
+	/*
+	 * The DTLB handler accesses the PTE via the virtually mapped linear
+	 * page table.  If a nested TLB miss occurs, we switch into physical
+	 * mode, walk the page table, and then re-execute the PTE read and
+	 * go on normally after that.
+	 */
+#ifdef CONFIG_XEN
+	movl r16=XSI_IFA
+	;;
+	ld8 r16=[r16]
+#else
+	mov r16=cr.ifa				// get virtual address
+#endif
+	mov r29=b0				// save b0
+	mov r31=pr				// save predicates
+dtlb_fault:
+#ifdef CONFIG_XEN
+	movl r17=XSI_IHA
+	;;
+	ld8 r17=[r17]				// get virtual address of L3 PTE
+#else
+	mov r17=cr.iha				// get virtual address of PTE
+#endif
+	movl r30=1f				// load nested fault continuation point
+	;;
+1:	ld8 r18=[r17]				// read *pte
+	;;
+	mov b0=r29
+	tbit.z p6,p0=r18,_PAGE_P_BIT		// page present bit cleared?
+(p6)	br.cond.spnt page_fault
+	;;
+#ifdef CONFIG_XEN
+	mov r19=r8
+	mov r8=r18
+	;;
+	XEN_HYPER_ITC_D
+	;;
+	mov r8=r19
+	;;
+#else
+	itc.d r18
+#endif
+	;;
+#ifdef CONFIG_SMP
+	/*
+	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
+	 * cannot possibly affect the following loads:
+	 */
+	dv_serialize_data
+
+	ld8 r19=[r17]				// read *pte again and see if same
+	mov r20=PAGE_SHIFT<<2			// setup page size for purge
+	;;
+	cmp.ne p7,p0=r18,r19
+	;;
+(p7)	ptc.l r16,r20
+#endif
+	mov pr=r31,-1
+#ifdef CONFIG_XEN
+	XEN_HYPER_RFI
+	dv_serialize_data
+#else
+	rfi
+#endif
+END(dtlb_miss)
+
+	.org ia64_ivt+0x0c00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x0c00 Entry 3 (size 64 bundles) Alt ITLB (19)
+ENTRY(alt_itlb_miss)
+	DBG_FAULT(3)
+#ifdef CONFIG_XEN
+	movl r31=XSI_IPSR
+	;;
+	ld8 r21=[r31],XSI_IFA_OFS-XSI_IPSR_OFS	// get ipsr, point to ifa
+	movl r17=PAGE_KERNEL
+	;;
+	ld8 r16=[r31]		// get ifa
+#else
+	mov r16=cr.ifa		// get address that caused the TLB miss
+	movl r17=PAGE_KERNEL
+	mov r21=cr.ipsr
+#endif
+	movl r19=(((1 << IA64_MAX_PHYS_BITS) - 1) & ~0xfff)
+	mov r31=pr
+	;;
+#ifdef CONFIG_DISABLE_VHPT
+	shr.u r22=r16,61			// get the region number into r21
+	;;
+	cmp.gt p8,p0=6,r22			// user mode
+	;;
+#ifdef CONFIG_XEN
+	//XXX notyet
+#else
+(p8)	thash r17=r16
+	;;
+(p8)	mov cr.iha=r17
+#endif
+(p8)	mov r29=b0				// save b0
+(p8)	br.cond.dptk .itlb_fault
+#endif
+	extr.u r23=r21,IA64_PSR_CPL0_BIT,2	// extract psr.cpl
+	and r19=r19,r16		// clear ed, reserved bits, and PTE control bits
+	shr.u r18=r16,57	// move address bit 61 to bit 4
+	;;
+	andcm r18=0x10,r18	// bit 4=~address-bit(61)
+	cmp.ne p8,p0=r0,r23	// psr.cpl != 0?
+	or r19=r17,r19		// insert PTE control bits into r19
+	;;
+	or r19=r19,r18		// set bit 4 (uncached) if the access was to region 6
+(p8)	br.cond.spnt page_fault
+	;;
+#ifdef CONFIG_XEN
+	mov r18=r8
+	mov r8=r19
+	;;
+	XEN_HYPER_ITC_I
+	;;
+	mov r8=r18
+	;;
+	mov pr=r31,-1
+	;;
+	XEN_HYPER_RFI;
+#else
+	itc.i r19		// insert the TLB entry
+	mov pr=r31,-1
+	rfi
+#endif
+END(alt_itlb_miss)
+
+	.org ia64_ivt+0x1000
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x1000 Entry 4 (size 64 bundles) Alt DTLB (7,46)
+ENTRY(alt_dtlb_miss)
+	DBG_FAULT(4)
+#ifdef CONFIG_XEN
+	movl r31=XSI_IPSR
+	;;
+	ld8 r21=[r31],XSI_ISR_OFS-XSI_IPSR_OFS	// get ipsr, point to isr
+	movl r17=PAGE_KERNEL
+	;;
+	ld8 r20=[r31],XSI_IFA_OFS-XSI_ISR_OFS	// get isr, point to ifa
+	movl r19=(((1 << IA64_MAX_PHYS_BITS) - 1) & ~0xfff)
+	;;
+	ld8 r16=[r31]		// get ifa
+#else
+	mov r16=cr.ifa		// get address that caused the TLB miss
+	movl r17=PAGE_KERNEL
+	mov r20=cr.isr
+	movl r19=(((1 << IA64_MAX_PHYS_BITS) - 1) & ~0xfff)
+	mov r21=cr.ipsr
+#endif
+	mov r31=pr
+	mov r24=PERCPU_ADDR
+	;;
+#ifdef CONFIG_DISABLE_VHPT
+	shr.u r22=r16,61			// get the region number into r21
+	;;
+	cmp.gt p8,p0=6,r22			// access to region 0-5
+	;;
+#ifdef CONFIG_XEN
+	//XXX notyet
+#else
+(p8)	thash r17=r16
+	;;
+(p8)	mov cr.iha=r17
+#endif
+(p8)	mov r29=b0				// save b0
+(p8)	br.cond.dptk dtlb_fault
+#endif
+	cmp.ge p10,p11=r16,r24			// access to per_cpu_data?
+	tbit.z p12,p0=r16,61			// access to region 6?
+	mov r25=PERCPU_PAGE_SHIFT << 2
+	mov r26=PERCPU_PAGE_SIZE
+	nop.m 0
+	nop.b 0
+	;;
+(p10)	mov r19=IA64_KR(PER_CPU_DATA)
+(p11)	and r19=r19,r16				// clear non-ppn fields
+	extr.u r23=r21,IA64_PSR_CPL0_BIT,2	// extract psr.cpl
+	and r22=IA64_ISR_CODE_MASK,r20		// get the isr.code field
+	tbit.nz p6,p7=r20,IA64_ISR_SP_BIT	// is speculation bit on?
+	tbit.nz p9,p0=r20,IA64_ISR_NA_BIT	// is non-access bit on?
+	;;
+(p10)	sub r19=r19,r26
+#ifdef CONFIG_XEN
+(p10)	movl r24=XSI_ITIR
+	;;
+(p10)	st8 [r24]=r25
+#else
+(p10)	mov cr.itir=r25
+#endif
+	cmp.ne p8,p0=r0,r23
+(p9)	cmp.eq.or.andcm p6,p7=IA64_ISR_CODE_LFETCH,r22	// check isr.code field
+(p12)	dep r17=-1,r17,4,1			// set ma=UC for region 6 addr
+(p8)	br.cond.spnt page_fault
+
+	dep r21=-1,r21,IA64_PSR_ED_BIT,1
+	;;
+	or r19=r19,r17		// insert PTE control bits into r19
+(p6)	mov cr.ipsr=r21
+	;;
+#ifdef CONFIG_XEN
+(p7)	mov r18=r8
+(p7)	mov r8=r19
+	;;
+(p7)	XEN_HYPER_ITC_D
+	;;
+(p7)	mov r8=r18
+	;;
+	mov pr=r31,-1
+	;;
+	XEN_HYPER_RFI;
+#else
+(p7)	itc.d r19		// insert the TLB entry
+	mov pr=r31,-1
+	rfi
+#endif
+END(alt_dtlb_miss)
+
+	.org ia64_ivt+0x1400
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x1400 Entry 5 (size 64 bundles) Data nested TLB (6,45)
+ENTRY(nested_dtlb_miss)
+	/*
+	 * In the absence of kernel bugs, we get here when the virtually mapped linear
+	 * page table is accessed non-speculatively (e.g., in the Dirty-bit, Instruction
+	 * Access-bit, or Data Access-bit faults).  If the DTLB entry for the virtual page
+	 * table is missing, a nested TLB miss fault is triggered and control is
+	 * transferred to this point.  When this happens, we lookup the pte for the
+	 * faulting address by walking the page table in physical mode and return to the
+	 * continuation point passed in register r30 (or call page_fault if the address is
+	 * not mapped).
+	 *
+	 * Input:	r16:	faulting address
+	 *		r29:	saved b0
+	 *		r30:	continuation address
+	 *		r31:	saved pr
+	 *
+	 * Output:	r17:	physical address of PTE of faulting address
+	 *		r29:	saved b0
+	 *		r30:	continuation address
+	 *		r31:	saved pr
+	 *
+	 * Clobbered:	b0, r18, r19, r21, r22, psr.dt (cleared)
+	 */
+#ifdef CONFIG_XEN
+	XEN_HYPER_RSM_PSR_DT;
+#else
+	rsm psr.dt				// switch to using physical data addressing
+#endif
+	mov r19=IA64_KR(PT_BASE)		// get the page table base address
+	shl r21=r16,3				// shift bit 60 into sign bit
+#ifdef CONFIG_XEN
+	movl r18=XSI_ITIR
+	;;
+	ld8 r18=[r18]
+#else
+	mov r18=cr.itir
+#endif
+	;;
+	shr.u r17=r16,61			// get the region number into r17
+	extr.u r18=r18,2,6			// get the faulting page size
+	;;
+	cmp.eq p6,p7=5,r17			// is faulting address in region 5?
+	add r22=-PAGE_SHIFT,r18			// adjustment for hugetlb address
+	add r18=PGDIR_SHIFT-PAGE_SHIFT,r18
+	;;
+	shr.u r22=r16,r22
+	shr.u r18=r16,r18
+(p7)	dep r17=r17,r19,(PAGE_SHIFT-3),3	// put region number bits in place
+
+	srlz.d
+	LOAD_PHYSICAL(p6, r19, swapper_pg_dir)	// region 5 is rooted at swapper_pg_dir
+
+	.pred.rel "mutex", p6, p7
+(p6)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT
+(p7)	shr.u r21=r21,PGDIR_SHIFT+PAGE_SHIFT-3
+	;;
+(p6)	dep r17=r18,r19,3,(PAGE_SHIFT-3)	// r17=pgd_offset for region 5
+(p7)	dep r17=r18,r17,3,(PAGE_SHIFT-6)	// r17=pgd_offset for region[0-4]
+	cmp.eq p7,p6=0,r21			// unused address bits all zeroes?
+#ifdef CONFIG_PGTABLE_4
+	shr.u r18=r22,PUD_SHIFT			// shift pud index into position
+#else
+	shr.u r18=r22,PMD_SHIFT			// shift pmd index into position
+#endif
+	;;
+	ld8 r17=[r17]				// get *pgd (may be 0)
+	;;
+(p7)	cmp.eq p6,p7=r17,r0			// was pgd_present(*pgd) == NULL?
+	dep r17=r18,r17,3,(PAGE_SHIFT-3)	// r17=p[u|m]d_offset(pgd,addr)
+	;;
+#ifdef CONFIG_PGTABLE_4
+(p7)	ld8 r17=[r17]				// get *pud (may be 0)
+	shr.u r18=r22,PMD_SHIFT			// shift pmd index into position
+	;;
+(p7)	cmp.eq.or.andcm p6,p7=r17,r0		// was pud_present(*pud) == NULL?
+	dep r17=r18,r17,3,(PAGE_SHIFT-3)	// r17=pmd_offset(pud,addr)
+	;;
+#endif
+(p7)	ld8 r17=[r17]				// get *pmd (may be 0)
+	shr.u r19=r22,PAGE_SHIFT		// shift pte index into position
+	;;
+(p7)	cmp.eq.or.andcm p6,p7=r17,r0		// was pmd_present(*pmd) == NULL?
+	dep r17=r19,r17,3,(PAGE_SHIFT-3)	// r17=pte_offset(pmd,addr);
+(p6)	br.cond.spnt page_fault
+	mov b0=r30
+	br.sptk.many b0				// return to continuation point
+END(nested_dtlb_miss)
+
+	.org ia64_ivt+0x1800
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x1800 Entry 6 (size 64 bundles) Instruction Key Miss (24)
+ENTRY(ikey_miss)
+	DBG_FAULT(6)
+	FAULT(6)
+END(ikey_miss)
+
+	//-----------------------------------------------------------------------------------
+	// call do_page_fault (predicates are in r31, psr.dt may be off, r16 is faulting address)
+ENTRY(page_fault)
+#ifdef CONFIG_XEN
+	XEN_HYPER_SSM_PSR_DT
+#else
+	ssm psr.dt
+	;;
+	srlz.i
+#endif
+	;;
+	SAVE_MIN_WITH_COVER
+	alloc r15=ar.pfs,0,0,3,0
+#ifdef CONFIG_XEN
+	movl r3=XSI_ISR
+	;;
+	ld8 out1=[r3],XSI_IFA_OFS-XSI_ISR_OFS	// get vcr.isr, point to ifa
+	;;
+	ld8 out0=[r3]				// get vcr.ifa
+	mov r14=1
+	;;
+	add r3=XSI_PSR_IC_OFS-XSI_IFA_OFS, r3	// point to vpsr.ic
+	;;
+	st4 [r3]=r14				// vpsr.ic = 1
+	adds r3=8,r2				// set up second base pointer
+	;;
+#else
+	mov out0=cr.ifa
+	mov out1=cr.isr
+	adds r3=8,r2				// set up second base pointer
+	;;
+	ssm psr.ic | PSR_DEFAULT_BITS
+	;;
+	srlz.i					// guarantee that interruption collectin is on
+	;;
+#endif
+#ifdef CONFIG_XEN
+
+#define MASK_TO_PEND_OFS    (-1)
+
+(p15)	movl r14=XSI_PSR_I_ADDR
+	;;
+(p15)	ld8 r14=[r14]
+	;;
+(p15)	st1 [r14]=r0,MASK_TO_PEND_OFS		// if (p15) vpsr.i = 1
+	;;		// if (p15) (vcpu->vcpu_info->evtchn_upcall_mask)=0
+(p15)	ld1 r14=[r14]	// if (vcpu->vcpu_info->evtchn_upcall_pending)
+	;;
+(p15)	cmp.ne	p15,p0=r14,r0
+	;;
+(p15)	XEN_HYPER_SSM_I
+#else
+(p15)	ssm psr.i				// restore psr.i
+#endif
+	movl r14=ia64_leave_kernel
+	;;
+	SAVE_REST
+	mov rp=r14
+	;;
+	adds out2=16,r12			// out2 = pointer to pt_regs
+	br.call.sptk.many b6=ia64_do_page_fault	// ignore return address
+END(page_fault)
+
+	.org ia64_ivt+0x1c00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x1c00 Entry 7 (size 64 bundles) Data Key Miss (12,51)
+ENTRY(dkey_miss)
+	DBG_FAULT(7)
+	FAULT(7)
+END(dkey_miss)
+
+	.org ia64_ivt+0x2000
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x2000 Entry 8 (size 64 bundles) Dirty-bit (54)
+ENTRY(dirty_bit)
+	DBG_FAULT(8)
+	/*
+	 * What we do here is to simply turn on the dirty bit in the PTE.  We need to
+	 * update both the page-table and the TLB entry.  To efficiently access the PTE,
+	 * we address it through the virtual page table.  Most likely, the TLB entry for
+	 * the relevant virtual page table page is still present in the TLB so we can
+	 * normally do this without additional TLB misses.  In case the necessary virtual
+	 * page table TLB entry isn't present, we take a nested TLB miss hit where we look
+	 * up the physical address of the L3 PTE and then continue at label 1 below.
+	 */
+#ifdef CONFIG_XEN
+	movl r16=XSI_IFA
+	;;
+	ld8 r16=[r16]
+	;;
+#else
+	mov r16=cr.ifa				// get the address that caused the fault
+#endif
+	movl r30=1f				// load continuation point in case of nested fault
+	;;
+#ifdef CONFIG_XEN
+	mov r18=r8;
+	mov r8=r16;
+	XEN_HYPER_THASH;;
+	mov r17=r8;
+	mov r8=r18;;
+#else
+	thash r17=r16				// compute virtual address of L3 PTE
+#endif
+	mov r29=b0				// save b0 in case of nested fault
+	mov r31=pr				// save pr
+#ifdef CONFIG_SMP
+	mov r28=ar.ccv				// save ar.ccv
+	;;
+1:	ld8 r18=[r17]
+	;;					// avoid RAW on r18
+	mov ar.ccv=r18				// set compare value for cmpxchg
+	or r25=_PAGE_D|_PAGE_A,r18		// set the dirty and accessed bits
+	tbit.z p7,p6 = r18,_PAGE_P_BIT		// Check present bit
+	;;
+(p6)	cmpxchg8.acq r26=[r17],r25,ar.ccv	// Only update if page is present
+	mov r24=PAGE_SHIFT<<2
+	;;
+(p6)	cmp.eq p6,p7=r26,r18			// Only compare if page is present
+	;;
+#ifdef CONFIG_XEN
+(p6)	mov r18=r8
+(p6)	mov r8=r25
+	;;
+(p6)	XEN_HYPER_ITC_D
+	;;
+(p6)	mov r8=r18
+#else
+(p6)	itc.d r25				// install updated PTE
+#endif
+	;;
+	/*
+	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
+	 * cannot possibly affect the following loads:
+	 */
+	dv_serialize_data
+
+	ld8 r18=[r17]				// read PTE again
+	;;
+	cmp.eq p6,p7=r18,r25			// is it same as the newly installed
+	;;
+(p7)	ptc.l r16,r24
+	mov b0=r29				// restore b0
+	mov ar.ccv=r28
+#else
+	;;
+1:	ld8 r18=[r17]
+	;;					// avoid RAW on r18
+	or r18=_PAGE_D|_PAGE_A,r18		// set the dirty and accessed bits
+	mov b0=r29				// restore b0
+	;;
+	st8 [r17]=r18				// store back updated PTE
+	itc.d r18				// install updated PTE
+#endif
+	mov pr=r31,-1				// restore pr
+#ifdef CONFIG_XEN
+	XEN_HYPER_RFI
+	dv_serialize_data
+#else
+	rfi
+#endif
+END(dirty_bit)
+
+	.org ia64_ivt+0x2400
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x2400 Entry 9 (size 64 bundles) Instruction Access-bit (27)
+ENTRY(iaccess_bit)
+	DBG_FAULT(9)
+	// Like Entry 8, except for instruction access
+#ifdef CONFIG_XEN
+	movl r16=XSI_IFA
+	;;
+	ld8 r16=[r16]
+	;;
+#else
+	mov r16=cr.ifa				// get the address that caused the fault
+#endif
+	movl r30=1f				// load continuation point in case of nested fault
+	mov r31=pr				// save predicates
+#ifdef CONFIG_ITANIUM
+	/*
+	 * Erratum 10 (IFA may contain incorrect address) has "NoFix" status.
+	 */
+	mov r17=cr.ipsr
+	;;
+	mov r18=cr.iip
+	tbit.z p6,p0=r17,IA64_PSR_IS_BIT	// IA64 instruction set?
+	;;
+(p6)	mov r16=r18				// if so, use cr.iip instead of cr.ifa
+#endif /* CONFIG_ITANIUM */
+	;;
+#ifdef CONFIG_XEN
+	mov r18=r8;
+	mov r8=r16;
+	XEN_HYPER_THASH;;
+	mov r17=r8;
+	mov r8=r18;;
+#else
+	thash r17=r16				// compute virtual address of L3 PTE
+#endif
+	mov r29=b0				// save b0 in case of nested fault)
+#ifdef CONFIG_SMP
+	mov r28=ar.ccv				// save ar.ccv
+	;;
+1:	ld8 r18=[r17]
+	;;
+	mov ar.ccv=r18				// set compare value for cmpxchg
+	or r25=_PAGE_A,r18			// set the accessed bit
+	tbit.z p7,p6 = r18,_PAGE_P_BIT	 	// Check present bit
+	;;
+(p6)	cmpxchg8.acq r26=[r17],r25,ar.ccv	// Only if page present
+	mov r24=PAGE_SHIFT<<2
+	;;
+(p6)	cmp.eq p6,p7=r26,r18			// Only if page present
+	;;
+#ifdef CONFIG_XEN
+	mov r26=r8
+	mov r8=r25
+	;;
+(p6)	XEN_HYPER_ITC_I
+	;;
+	mov r8=r26
+	;;
+#else
+(p6)	itc.i r25				// install updated PTE
+#endif
+	;;
+	/*
+	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
+	 * cannot possibly affect the following loads:
+	 */
+	dv_serialize_data
+
+	ld8 r18=[r17]				// read PTE again
+	;;
+	cmp.eq p6,p7=r18,r25			// is it same as the newly installed
+	;;
+(p7)	ptc.l r16,r24
+	mov b0=r29				// restore b0
+	mov ar.ccv=r28
+#else /* !CONFIG_SMP */
+	;;
+1:	ld8 r18=[r17]
+	;;
+	or r18=_PAGE_A,r18			// set the accessed bit
+	mov b0=r29				// restore b0
+	;;
+	st8 [r17]=r18				// store back updated PTE
+	itc.i r18				// install updated PTE
+#endif /* !CONFIG_SMP */
+	mov pr=r31,-1
+#ifdef CONFIG_XEN
+	XEN_HYPER_RFI
+	dv_serialize_data
+#else
+	rfi
+#endif
+END(iaccess_bit)
+
+	.org ia64_ivt+0x2800
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x2800 Entry 10 (size 64 bundles) Data Access-bit (15,55)
+ENTRY(daccess_bit)
+	DBG_FAULT(10)
+	// Like Entry 8, except for data access
+#ifdef CONFIG_XEN
+	movl r16=XSI_IFA
+	;;
+	ld8 r16=[r16]
+	;;
+#else
+	mov r16=cr.ifa				// get the address that caused the fault
+#endif
+	movl r30=1f				// load continuation point in case of nested fault
+	;;
+#ifdef CONFIG_XEN
+	mov r18=r8
+	mov r8=r16
+	XEN_HYPER_THASH
+	;;
+	mov r17=r8
+	mov r8=r18
+	;;
+#else
+	thash r17=r16				// compute virtual address of L3 PTE
+#endif
+	mov r31=pr
+	mov r29=b0				// save b0 in case of nested fault)
+#ifdef CONFIG_SMP
+	mov r28=ar.ccv				// save ar.ccv
+	;;
+1:	ld8 r18=[r17]
+	;;					// avoid RAW on r18
+	mov ar.ccv=r18				// set compare value for cmpxchg
+	or r25=_PAGE_A,r18			// set the dirty bit
+	tbit.z p7,p6 = r18,_PAGE_P_BIT		// Check present bit
+	;;
+(p6)	cmpxchg8.acq r26=[r17],r25,ar.ccv	// Only if page is present
+	mov r24=PAGE_SHIFT<<2
+	;;
+(p6)	cmp.eq p6,p7=r26,r18			// Only if page is present
+	;;
+#ifdef CONFIG_XEN
+	mov r26=r8
+	mov r8=r25
+	;;
+(p6)	XEN_HYPER_ITC_D
+	;;
+	mov r8=r26
+	;;
+#else
+(p6)	itc.d r25				// install updated PTE
+#endif
+	/*
+	 * Tell the assemblers dependency-violation checker that the above "itc" instructions
+	 * cannot possibly affect the following loads:
+	 */
+	dv_serialize_data
+	;;
+	ld8 r18=[r17]				// read PTE again
+	;;
+	cmp.eq p6,p7=r18,r25			// is it same as the newly installed
+	;;
+(p7)	ptc.l r16,r24
+	mov ar.ccv=r28
+#else
+	;;
+1:	ld8 r18=[r17]
+	;;					// avoid RAW on r18
+	or r18=_PAGE_A,r18			// set the accessed bit
+	;;
+	st8 [r17]=r18				// store back updated PTE
+	itc.d r18				// install updated PTE
+#endif
+	mov b0=r29				// restore b0
+	mov pr=r31,-1
+#ifdef CONFIG_XEN
+	XEN_HYPER_RFI
+	dv_serialize_data
+#else
+	rfi
+#endif
+END(daccess_bit)
+
+	.org ia64_ivt+0x2c00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x2c00 Entry 11 (size 64 bundles) Break instruction (33)
+ENTRY(break_fault)
+	/*
+	 * The streamlined system call entry/exit paths only save/restore the initial part
+	 * of pt_regs.  This implies that the callers of system-calls must adhere to the
+	 * normal procedure calling conventions.
+	 *
+	 *   Registers to be saved & restored:
+	 *	CR registers: cr.ipsr, cr.iip, cr.ifs
+	 *	AR registers: ar.unat, ar.pfs, ar.rsc, ar.rnat, ar.bspstore, ar.fpsr
+	 * 	others: pr, b0, b6, loadrs, r1, r11, r12, r13, r15
+	 *   Registers to be restored only:
+	 * 	r8-r11: output value from the system call.
+	 *
+	 * During system call exit, scratch registers (including r15) are modified/cleared
+	 * to prevent leaking bits from kernel to user level.
+	 */
+	DBG_FAULT(11)
+	mov.m r16=IA64_KR(CURRENT)		// M2 r16 <- current task (12 cyc)
+#ifdef CONFIG_XEN
+	movl r22=XSI_IPSR
+	;;
+	ld8 r29=[r22],XSI_IIM_OFS-XSI_IPSR_OFS	// get ipsr, point to iip
+#else
+	mov r29=cr.ipsr				// M2 (12 cyc)
+#endif
+	mov r31=pr				// I0 (2 cyc)
+
+#ifdef CONFIG_XEN
+	;;
+	ld8 r17=[r22],XSI_IIP_OFS-XSI_IIM_OFS
+#else
+	mov r17=cr.iim				// M2 (2 cyc)
+#endif
+	mov.m r27=ar.rsc			// M2 (12 cyc)
+	mov r18=__IA64_BREAK_SYSCALL		// A
+
+	mov.m ar.rsc=0				// M2
+	mov.m r21=ar.fpsr			// M2 (12 cyc)
+	mov r19=b6				// I0 (2 cyc)
+	;;
+	mov.m r23=ar.bspstore			// M2 (12 cyc)
+	mov.m r24=ar.rnat			// M2 (5 cyc)
+	mov.i r26=ar.pfs			// I0 (2 cyc)
+
+	invala					// M0|1
+	nop.m 0					// M
+	mov r20=r1				// A			save r1
+
+	nop.m 0
+	movl r30=sys_call_table			// X
+
+#ifdef CONFIG_XEN
+	ld8 r28=[r22]
+#else
+	mov r28=cr.iip				// M2 (2 cyc)
+#endif
+	cmp.eq p0,p7=r18,r17			// I0 is this a system call?
+(p7)	br.cond.spnt non_syscall		// B  no ->
+	//
+	// From this point on, we are definitely on the syscall-path
+	// and we can use (non-banked) scratch registers.
+	//
+///////////////////////////////////////////////////////////////////////
+	mov r1=r16				// A    move task-pointer to "addl"-addressable reg
+	mov r2=r16				// A    setup r2 for ia64_syscall_setup
+	add r9=TI_FLAGS+IA64_TASK_SIZE,r16	// A	r9 = &current_thread_info()->flags
+
+	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r16
+	adds r15=-1024,r15			// A    subtract 1024 from syscall number
+	mov r3=NR_syscalls - 1
+	;;
+	ld1.bias r17=[r16]			// M0|1 r17 = current->thread.on_ustack flag
+	ld4 r9=[r9]				// M0|1 r9 = current_thread_info()->flags
+	extr.u r8=r29,41,2			// I0   extract ei field from cr.ipsr
+
+	shladd r30=r15,3,r30			// A    r30 = sys_call_table + 8*(syscall-1024)
+	addl r22=IA64_RBS_OFFSET,r1		// A    compute base of RBS
+	cmp.leu p6,p7=r15,r3			// A    syscall number in range?
+	;;
+
+	lfetch.fault.excl.nt1 [r22]		// M0|1 prefetch RBS
+(p6)	ld8 r30=[r30]				// M0|1 load address of syscall entry point
+	tnat.nz.or p7,p0=r15			// I0	is syscall nr a NaT?
+
+	mov.m ar.bspstore=r22			// M2   switch to kernel RBS
+	cmp.eq p8,p9=2,r8			// A    isr.ei==2?
+	;;
+
+(p8)	mov r8=0				// A    clear ei to 0
+(p7)	movl r30=sys_ni_syscall			// X
+
+(p8)	adds r28=16,r28				// A    switch cr.iip to next bundle
+(p9)	adds r8=1,r8				// A    increment ei to next slot
+	nop.i 0
+	;;
+
+	mov.m r25=ar.unat			// M2 (5 cyc)
+	dep r29=r8,r29,41,2			// I0   insert new ei into cr.ipsr
+	adds r15=1024,r15			// A    restore original syscall number
+	//
+	// If any of the above loads miss in L1D, we'll stall here until
+	// the data arrives.
+	//
+///////////////////////////////////////////////////////////////////////
+	st1 [r16]=r0				// M2|3 clear current->thread.on_ustack flag
+	mov b6=r30				// I0   setup syscall handler branch reg early
+	cmp.eq pKStk,pUStk=r0,r17		// A    were we on kernel stacks already?
+
+	and r9=_TIF_SYSCALL_TRACEAUDIT,r9	// A    mask trace or audit
+	mov r18=ar.bsp				// M2 (12 cyc)
+(pKStk)	br.cond.spnt .break_fixup		// B	we're already in kernel-mode -- fix up RBS
+	;;
+.back_from_break_fixup:
+(pUStk)	addl r1=IA64_STK_OFFSET-IA64_PT_REGS_SIZE,r1 // A    compute base of memory stack
+	cmp.eq p14,p0=r9,r0			// A    are syscalls being traced/audited?
+	br.call.sptk.many b7=ia64_syscall_setup	// B
+1:
+	mov ar.rsc=0x3				// M2   set eager mode, pl 0, LE, loadrs=0
+	nop 0
+#ifdef CONFIG_XEN
+	mov r2=b0; br.call.sptk b0=xen_bsw1;; mov b0=r2;;
+#else
+	bsw.1					// B (6 cyc) regs are saved, switch to bank 1
+#endif
+	;;
+
+#ifdef CONFIG_XEN
+	movl r16=XSI_PSR_IC
+	mov r3=1
+	;;
+	st4 [r16]=r3,XSI_PSR_I_ADDR_OFS-XSI_PSR_IC_OFS	// vpsr.ic = 1
+#else
+	ssm psr.ic | PSR_DEFAULT_BITS		// M2	now it's safe to re-enable intr.-collection
+#endif
+	movl r3=ia64_ret_from_syscall		// X
+	;;
+
+	srlz.i					// M0   ensure interruption collection is on
+	mov rp=r3				// I0   set the real return addr
+(p10)	br.cond.spnt.many ia64_ret_from_syscall	// B    return if bad call-frame or r15 is a NaT
+
+#ifdef CONFIG_XEN
+(p15)	ld8 r16=[r16]				// vpsr.i
+	;;
+(p15)	st1 [r16]=r0,MASK_TO_PEND_OFS		// if (p15) vpsr.i = 1
+	;;		// if (p15) (vcpu->vcpu_info->evtchn_upcall_mask)=0
+(p15)	ld1 r2=[r16]	// if (vcpu->vcpu_info->evtchn_upcall_pending)
+	;;
+(p15)	cmp.ne.unc p6,p0=r2,r0
+	;;
+(p6)	XEN_HYPER_SSM_I				//   do a real ssm psr.i
+#else
+(p15)	ssm psr.i				// M2   restore psr.i
+#endif
+(p14)	br.call.sptk.many b6=b6			// B    invoke syscall-handker (ignore return addr)
+	br.cond.spnt.many ia64_trace_syscall	// B	do syscall-tracing thingamagic
+	// NOT REACHED
+///////////////////////////////////////////////////////////////////////
+	// On entry, we optimistically assumed that we're coming from user-space.
+	// For the rare cases where a system-call is done from within the kernel,
+	// we fix things up at this point:
+.break_fixup:
+	add r1=-IA64_PT_REGS_SIZE,sp		// A    allocate space for pt_regs structure
+	mov ar.rnat=r24				// M2	restore kernel's AR.RNAT
+	;;
+	mov ar.bspstore=r23			// M2	restore kernel's AR.BSPSTORE
+	br.cond.sptk .back_from_break_fixup
+END(break_fault)
+
+	.org ia64_ivt+0x3000
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x3000 Entry 12 (size 64 bundles) External Interrupt (4)
+ENTRY(interrupt)
+	DBG_FAULT(12)
+	mov r31=pr		// prepare to save predicates
+	;;
+	SAVE_MIN_WITH_COVER	// uses r31; defines r2 and r3
+#ifdef CONFIG_XEN
+	movl r3=XSI_PSR_IC
+	mov r14=1
+	;;
+	st4 [r3]=r14
+#else
+	ssm psr.ic | PSR_DEFAULT_BITS
+#endif
+	;;
+	adds r3=8,r2		// set up second base pointer for SAVE_REST
+	srlz.i			// ensure everybody knows psr.ic is back on
+	;;
+	SAVE_REST
+	;;
+	MCA_RECOVER_RANGE(interrupt)
+	alloc r14=ar.pfs,0,0,2,0 // must be first in an insn group
+#ifdef CONFIG_XEN
+	;;
+	XEN_HYPER_GET_IVR
+	;;
+	mov out0=r8		// pass cr.ivr as first arg
+#else
+	mov out0=cr.ivr		// pass cr.ivr as first arg
+#endif
+	add out1=16,sp		// pass pointer to pt_regs as second arg
+	;;
+	srlz.d			// make sure we see the effect of cr.ivr
+	movl r14=ia64_leave_kernel
+	;;
+	mov rp=r14
+	br.call.sptk.many b6=ia64_handle_irq
+END(interrupt)
+
+	.org ia64_ivt+0x3400
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x3400 Entry 13 (size 64 bundles) Reserved
+	DBG_FAULT(13)
+	FAULT(13)
+
+	.org ia64_ivt+0x3800
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x3800 Entry 14 (size 64 bundles) Reserved
+	DBG_FAULT(14)
+	FAULT(14)
+
+	/*
+	 * There is no particular reason for this code to be here, other than that
+	 * there happens to be space here that would go unused otherwise.  If this
+	 * fault ever gets "unreserved", simply moved the following code to a more
+	 * suitable spot...
+	 *
+	 * ia64_syscall_setup() is a separate subroutine so that it can
+	 *	allocate stacked registers so it can safely demine any
+	 *	potential NaT values from the input registers.
+	 *
+	 * On entry:
+	 *	- executing on bank 0 or bank 1 register set (doesn't matter)
+	 *	-  r1: stack pointer
+	 *	-  r2: current task pointer
+	 *	-  r3: preserved
+	 *	- r11: original contents (saved ar.pfs to be saved)
+	 *	- r12: original contents (sp to be saved)
+	 *	- r13: original contents (tp to be saved)
+	 *	- r15: original contents (syscall # to be saved)
+	 *	- r18: saved bsp (after switching to kernel stack)
+	 *	- r19: saved b6
+	 *	- r20: saved r1 (gp)
+	 *	- r21: saved ar.fpsr
+	 *	- r22: kernel's register backing store base (krbs_base)
+	 *	- r23: saved ar.bspstore
+	 *	- r24: saved ar.rnat
+	 *	- r25: saved ar.unat
+	 *	- r26: saved ar.pfs
+	 *	- r27: saved ar.rsc
+	 *	- r28: saved cr.iip
+	 *	- r29: saved cr.ipsr
+	 *	- r31: saved pr
+	 *	-  b0: original contents (to be saved)
+	 * On exit:
+	 *	-  p10: TRUE if syscall is invoked with more than 8 out
+	 *		registers or r15's Nat is true
+	 *	-  r1: kernel's gp
+	 *	-  r3: preserved (same as on entry)
+	 *	-  r8: -EINVAL if p10 is true
+	 *	- r12: points to kernel stack
+	 *	- r13: points to current task
+	 *	- r14: preserved (same as on entry)
+	 *	- p13: preserved
+	 *	- p15: TRUE if interrupts need to be re-enabled
+	 *	- ar.fpsr: set to kernel settings
+	 *	-  b6: preserved (same as on entry)
+	 */
+#ifndef CONFIG_XEN
+GLOBAL_ENTRY(ia64_syscall_setup)
+#if PT(B6) != 0
+# error This code assumes that b6 is the first field in pt_regs.
+#endif
+	st8 [r1]=r19				// save b6
+	add r16=PT(CR_IPSR),r1			// initialize first base pointer
+	add r17=PT(R11),r1			// initialize second base pointer
+	;;
+	alloc r19=ar.pfs,8,0,0,0		// ensure in0-in7 are writable
+	st8 [r16]=r29,PT(AR_PFS)-PT(CR_IPSR)	// save cr.ipsr
+	tnat.nz p8,p0=in0
+
+	st8.spill [r17]=r11,PT(CR_IIP)-PT(R11)	// save r11
+	tnat.nz p9,p0=in1
+(pKStk)	mov r18=r0				// make sure r18 isn't NaT
+	;;
+
+	st8 [r16]=r26,PT(CR_IFS)-PT(AR_PFS)	// save ar.pfs
+	st8 [r17]=r28,PT(AR_UNAT)-PT(CR_IIP)	// save cr.iip
+	mov r28=b0				// save b0 (2 cyc)
+	;;
+
+	st8 [r17]=r25,PT(AR_RSC)-PT(AR_UNAT)	// save ar.unat
+	dep r19=0,r19,38,26			// clear all bits but 0..37 [I0]
+(p8)	mov in0=-1
+	;;
+
+	st8 [r16]=r19,PT(AR_RNAT)-PT(CR_IFS)	// store ar.pfs.pfm in cr.ifs
+	extr.u r11=r19,7,7	// I0		// get sol of ar.pfs
+	and r8=0x7f,r19		// A		// get sof of ar.pfs
+
+	st8 [r17]=r27,PT(AR_BSPSTORE)-PT(AR_RSC)// save ar.rsc
+	tbit.nz p15,p0=r29,IA64_PSR_I_BIT // I0
+(p9)	mov in1=-1
+	;;
+
+(pUStk) sub r18=r18,r22				// r18=RSE.ndirty*8
+	tnat.nz p10,p0=in2
+	add r11=8,r11
+	;;
+(pKStk) adds r16=PT(PR)-PT(AR_RNAT),r16		// skip over ar_rnat field
+(pKStk) adds r17=PT(B0)-PT(AR_BSPSTORE),r17	// skip over ar_bspstore field
+	tnat.nz p11,p0=in3
+	;;
+(p10)	mov in2=-1
+	tnat.nz p12,p0=in4				// [I0]
+(p11)	mov in3=-1
+	;;
+(pUStk) st8 [r16]=r24,PT(PR)-PT(AR_RNAT)	// save ar.rnat
+(pUStk) st8 [r17]=r23,PT(B0)-PT(AR_BSPSTORE)	// save ar.bspstore
+	shl r18=r18,16				// compute ar.rsc to be used for "loadrs"
+	;;
+	st8 [r16]=r31,PT(LOADRS)-PT(PR)		// save predicates
+	st8 [r17]=r28,PT(R1)-PT(B0)		// save b0
+	tnat.nz p13,p0=in5				// [I0]
+	;;
+	st8 [r16]=r18,PT(R12)-PT(LOADRS)	// save ar.rsc value for "loadrs"
+	st8.spill [r17]=r20,PT(R13)-PT(R1)	// save original r1
+(p12)	mov in4=-1
+	;;
+
+.mem.offset 0,0; st8.spill [r16]=r12,PT(AR_FPSR)-PT(R12)	// save r12
+.mem.offset 8,0; st8.spill [r17]=r13,PT(R15)-PT(R13)		// save r13
+(p13)	mov in5=-1
+	;;
+	st8 [r16]=r21,PT(R8)-PT(AR_FPSR)	// save ar.fpsr
+	tnat.nz p13,p0=in6
+	cmp.lt p10,p9=r11,r8	// frame size can't be more than local+8
+	;;
+	mov r8=1
+(p9)	tnat.nz p10,p0=r15
+	adds r12=-16,r1		// switch to kernel memory stack (with 16 bytes of scratch)
+
+	st8.spill [r17]=r15			// save r15
+	tnat.nz p8,p0=in7
+	nop.i 0
+
+	mov r13=r2				// establish `current'
+	movl r1=__gp				// establish kernel global pointer
+	;;
+	st8 [r16]=r8		// ensure pt_regs.r8 != 0 (see handle_syscall_error)
+(p13)	mov in6=-1
+(p8)	mov in7=-1
+
+	cmp.eq pSys,pNonSys=r0,r0		// set pSys=1, pNonSys=0
+	movl r17=FPSR_DEFAULT
+	;;
+	mov.m ar.fpsr=r17			// set ar.fpsr to kernel default value
+(p10)	mov r8=-EINVAL
+	br.ret.sptk.many b7
+END(ia64_syscall_setup)
+#endif
+
+	.org ia64_ivt+0x3c00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x3c00 Entry 15 (size 64 bundles) Reserved
+	DBG_FAULT(15)
+	FAULT(15)
+
+	/*
+	 * Squatting in this space ...
+	 *
+	 * This special case dispatcher for illegal operation faults allows preserved
+	 * registers to be modified through a callback function (asm only) that is handed
+	 * back from the fault handler in r8. Up to three arguments can be passed to the
+	 * callback function by returning an aggregate with the callback as its first
+	 * element, followed by the arguments.
+	 */
+ENTRY(dispatch_illegal_op_fault)
+	.prologue
+	.body
+	SAVE_MIN_WITH_COVER
+	ssm psr.ic | PSR_DEFAULT_BITS
+	;;
+	srlz.i		// guarantee that interruption collection is on
+	;;
+(p15)	ssm psr.i	// restore psr.i
+	adds r3=8,r2	// set up second base pointer for SAVE_REST
+	;;
+	alloc r14=ar.pfs,0,0,1,0	// must be first in insn group
+	mov out0=ar.ec
+	;;
+	SAVE_REST
+	PT_REGS_UNWIND_INFO(0)
+	;;
+	br.call.sptk.many rp=ia64_illegal_op_fault
+.ret0:	;;
+	alloc r14=ar.pfs,0,0,3,0	// must be first in insn group
+	mov out0=r9
+	mov out1=r10
+	mov out2=r11
+	movl r15=ia64_leave_kernel
+	;;
+	mov rp=r15
+	mov b6=r8
+	;;
+	cmp.ne p6,p0=0,r8
+(p6)	br.call.dpnt.many b6=b6		// call returns to ia64_leave_kernel
+	br.sptk.many ia64_leave_kernel
+END(dispatch_illegal_op_fault)
+
+	.org ia64_ivt+0x4000
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x4000 Entry 16 (size 64 bundles) Reserved
+	DBG_FAULT(16)
+	FAULT(16)
+
+	.org ia64_ivt+0x4400
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x4400 Entry 17 (size 64 bundles) Reserved
+	DBG_FAULT(17)
+	FAULT(17)
+
+ENTRY(non_syscall)
+	mov ar.rsc=r27			// restore ar.rsc before SAVE_MIN_WITH_COVER
+	;;
+	SAVE_MIN_WITH_COVER
+
+	// There is no particular reason for this code to be here, other than that
+	// there happens to be space here that would go unused otherwise.  If this
+	// fault ever gets "unreserved", simply moved the following code to a more
+	// suitable spot...
+
+	alloc r14=ar.pfs,0,0,2,0
+	mov out0=cr.iim
+	add out1=16,sp
+	adds r3=8,r2			// set up second base pointer for SAVE_REST
+
+	ssm psr.ic | PSR_DEFAULT_BITS
+	;;
+	srlz.i				// guarantee that interruption collection is on
+	;;
+(p15)	ssm psr.i			// restore psr.i
+	movl r15=ia64_leave_kernel
+	;;
+	SAVE_REST
+	mov rp=r15
+	;;
+	br.call.sptk.many b6=ia64_bad_break	// avoid WAW on CFM and ignore return addr
+END(non_syscall)
+
+	.org ia64_ivt+0x4800
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x4800 Entry 18 (size 64 bundles) Reserved
+	DBG_FAULT(18)
+	FAULT(18)
+
+	/*
+	 * There is no particular reason for this code to be here, other than that
+	 * there happens to be space here that would go unused otherwise.  If this
+	 * fault ever gets "unreserved", simply moved the following code to a more
+	 * suitable spot...
+	 */
+
+ENTRY(dispatch_unaligned_handler)
+	SAVE_MIN_WITH_COVER
+	;;
+	alloc r14=ar.pfs,0,0,2,0		// now it's safe (must be first in insn group!)
+	mov out0=cr.ifa
+	adds out1=16,sp
+
+	ssm psr.ic | PSR_DEFAULT_BITS
+	;;
+	srlz.i					// guarantee that interruption collection is on
+	;;
+(p15)	ssm psr.i				// restore psr.i
+	adds r3=8,r2				// set up second base pointer
+	;;
+	SAVE_REST
+	movl r14=ia64_leave_kernel
+	;;
+	mov rp=r14
+	br.sptk.many ia64_prepare_handle_unaligned
+END(dispatch_unaligned_handler)
+
+	.org ia64_ivt+0x4c00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x4c00 Entry 19 (size 64 bundles) Reserved
+	DBG_FAULT(19)
+	FAULT(19)
+
+	/*
+	 * There is no particular reason for this code to be here, other than that
+	 * there happens to be space here that would go unused otherwise.  If this
+	 * fault ever gets "unreserved", simply moved the following code to a more
+	 * suitable spot...
+	 */
+
+ENTRY(dispatch_to_fault_handler)
+	/*
+	 * Input:
+	 *	psr.ic:	off
+	 *	r19:	fault vector number (e.g., 24 for General Exception)
+	 *	r31:	contains saved predicates (pr)
+	 */
+	SAVE_MIN_WITH_COVER_R19
+	alloc r14=ar.pfs,0,0,5,0
+	mov out0=r15
+#ifdef CONFIG_XEN
+	movl out1=XSI_ISR
+	;;
+	adds out2=XSI_IFA-XSI_ISR,out1
+	adds out3=XSI_IIM-XSI_ISR,out1
+	adds out4=XSI_ITIR-XSI_ISR,out1
+	;;
+	ld8 out1=[out1]
+	ld8 out2=[out2]
+	ld8 out3=[out4]
+	ld8 out4=[out4]
+	;;
+#else
+	mov out1=cr.isr
+	mov out2=cr.ifa
+	mov out3=cr.iim
+	mov out4=cr.itir
+	;;
+#endif
+	ssm psr.ic | PSR_DEFAULT_BITS
+	;;
+	srlz.i					// guarantee that interruption collection is on
+	;;
+(p15)	ssm psr.i				// restore psr.i
+	adds r3=8,r2				// set up second base pointer for SAVE_REST
+	;;
+	SAVE_REST
+	movl r14=ia64_leave_kernel
+	;;
+	mov rp=r14
+	br.call.sptk.many b6=ia64_fault
+END(dispatch_to_fault_handler)
+
+//
+// --- End of long entries, Beginning of short entries
+//
+
+	.org ia64_ivt+0x5000
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5000 Entry 20 (size 16 bundles) Page Not Present (10,22,49)
+ENTRY(page_not_present)
+	DBG_FAULT(20)
+	mov r16=cr.ifa
+	rsm psr.dt
+	/*
+	 * The Linux page fault handler doesn't expect non-present pages to be in
+	 * the TLB.  Flush the existing entry now, so we meet that expectation.
+	 */
+	mov r17=PAGE_SHIFT<<2
+	;;
+	ptc.l r16,r17
+	;;
+	mov r31=pr
+	srlz.d
+	br.sptk.many page_fault
+END(page_not_present)
+
+	.org ia64_ivt+0x5100
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5100 Entry 21 (size 16 bundles) Key Permission (13,25,52)
+ENTRY(key_permission)
+	DBG_FAULT(21)
+	mov r16=cr.ifa
+	rsm psr.dt
+	mov r31=pr
+	;;
+	srlz.d
+	br.sptk.many page_fault
+END(key_permission)
+
+	.org ia64_ivt+0x5200
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5200 Entry 22 (size 16 bundles) Instruction Access Rights (26)
+ENTRY(iaccess_rights)
+	DBG_FAULT(22)
+	mov r16=cr.ifa
+	rsm psr.dt
+	mov r31=pr
+	;;
+	srlz.d
+	br.sptk.many page_fault
+END(iaccess_rights)
+
+	.org ia64_ivt+0x5300
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5300 Entry 23 (size 16 bundles) Data Access Rights (14,53)
+ENTRY(daccess_rights)
+	DBG_FAULT(23)
+#ifdef CONFIG_XEN
+	movl r16=XSI_IFA
+	;;
+	ld8 r16=[r16]
+	;;
+	XEN_HYPER_RSM_PSR_DT
+#else
+	mov r16=cr.ifa
+	rsm psr.dt
+#endif
+	mov r31=pr
+	;;
+	srlz.d
+	br.sptk.many page_fault
+END(daccess_rights)
+
+	.org ia64_ivt+0x5400
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5400 Entry 24 (size 16 bundles) General Exception (5,32,34,36,38,39)
+ENTRY(general_exception)
+	DBG_FAULT(24)
+	mov r16=cr.isr
+	mov r31=pr
+	;;
+	cmp4.eq p6,p0=0,r16
+(p6)	br.sptk.many dispatch_illegal_op_fault
+	;;
+	mov r19=24		// fault number
+	br.sptk.many dispatch_to_fault_handler
+END(general_exception)
+
+	.org ia64_ivt+0x5500
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5500 Entry 25 (size 16 bundles) Disabled FP-Register (35)
+ENTRY(disabled_fp_reg)
+	DBG_FAULT(25)
+	rsm psr.dfh		// ensure we can access fph
+	;;
+	srlz.d
+	mov r31=pr
+	mov r19=25
+	br.sptk.many dispatch_to_fault_handler
+END(disabled_fp_reg)
+
+	.org ia64_ivt+0x5600
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5600 Entry 26 (size 16 bundles) Nat Consumption (11,23,37,50)
+ENTRY(nat_consumption)
+	DBG_FAULT(26)
+
+	mov r16=cr.ipsr
+	mov r17=cr.isr
+	mov r31=pr				// save PR
+	;;
+	and r18=0xf,r17				// r18 = cr.ipsr.code{3:0}
+	tbit.z p6,p0=r17,IA64_ISR_NA_BIT
+	;;
+	cmp.ne.or p6,p0=IA64_ISR_CODE_LFETCH,r18
+	dep r16=-1,r16,IA64_PSR_ED_BIT,1
+(p6)	br.cond.spnt 1f		// branch if (cr.ispr.na == 0 || cr.ipsr.code{3:0} != LFETCH)
+	;;
+	mov cr.ipsr=r16		// set cr.ipsr.na
+	mov pr=r31,-1
+	;;
+	rfi
+
+1:	mov pr=r31,-1
+	;;
+	FAULT(26)
+END(nat_consumption)
+
+	.org ia64_ivt+0x5700
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5700 Entry 27 (size 16 bundles) Speculation (40)
+ENTRY(speculation_vector)
+	DBG_FAULT(27)
+	/*
+	 * A [f]chk.[as] instruction needs to take the branch to the recovery code but
+	 * this part of the architecture is not implemented in hardware on some CPUs, such
+	 * as Itanium.  Thus, in general we need to emulate the behavior.  IIM contains
+	 * the relative target (not yet sign extended).  So after sign extending it we
+	 * simply add it to IIP.  We also need to reset the EI field of the IPSR to zero,
+	 * i.e., the slot to restart into.
+	 *
+	 * cr.imm contains zero_ext(imm21)
+	 */
+	mov r18=cr.iim
+	;;
+	mov r17=cr.iip
+	shl r18=r18,43			// put sign bit in position (43=64-21)
+	;;
+
+	mov r16=cr.ipsr
+	shr r18=r18,39			// sign extend (39=43-4)
+	;;
+
+	add r17=r17,r18			// now add the offset
+	;;
+	mov cr.iip=r17
+	dep r16=0,r16,41,2		// clear EI
+	;;
+
+	mov cr.ipsr=r16
+	;;
+
+#ifdef CONFIG_XEN
+	XEN_HYPER_RFI;
+#else
+	rfi				// and go back
+#endif
+END(speculation_vector)
+
+	.org ia64_ivt+0x5800
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5800 Entry 28 (size 16 bundles) Reserved
+	DBG_FAULT(28)
+	FAULT(28)
+
+	.org ia64_ivt+0x5900
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5900 Entry 29 (size 16 bundles) Debug (16,28,56)
+ENTRY(debug_vector)
+	DBG_FAULT(29)
+	FAULT(29)
+END(debug_vector)
+
+	.org ia64_ivt+0x5a00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5a00 Entry 30 (size 16 bundles) Unaligned Reference (57)
+ENTRY(unaligned_access)
+	DBG_FAULT(30)
+	mov r31=pr		// prepare to save predicates
+	;;
+	br.sptk.many dispatch_unaligned_handler
+END(unaligned_access)
+
+	.org ia64_ivt+0x5b00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5b00 Entry 31 (size 16 bundles) Unsupported Data Reference (57)
+ENTRY(unsupported_data_reference)
+	DBG_FAULT(31)
+	FAULT(31)
+END(unsupported_data_reference)
+
+	.org ia64_ivt+0x5c00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5c00 Entry 32 (size 16 bundles) Floating-Point Fault (64)
+ENTRY(floating_point_fault)
+	DBG_FAULT(32)
+	FAULT(32)
+END(floating_point_fault)
+
+	.org ia64_ivt+0x5d00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5d00 Entry 33 (size 16 bundles) Floating Point Trap (66)
+ENTRY(floating_point_trap)
+	DBG_FAULT(33)
+	FAULT(33)
+END(floating_point_trap)
+
+	.org ia64_ivt+0x5e00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5e00 Entry 34 (size 16 bundles) Lower Privilege Transfer Trap (66)
+ENTRY(lower_privilege_trap)
+	DBG_FAULT(34)
+	FAULT(34)
+END(lower_privilege_trap)
+
+	.org ia64_ivt+0x5f00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x5f00 Entry 35 (size 16 bundles) Taken Branch Trap (68)
+ENTRY(taken_branch_trap)
+	DBG_FAULT(35)
+	FAULT(35)
+END(taken_branch_trap)
+
+	.org ia64_ivt+0x6000
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6000 Entry 36 (size 16 bundles) Single Step Trap (69)
+ENTRY(single_step_trap)
+	DBG_FAULT(36)
+	FAULT(36)
+END(single_step_trap)
+
+	.org ia64_ivt+0x6100
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6100 Entry 37 (size 16 bundles) Reserved
+	DBG_FAULT(37)
+	FAULT(37)
+
+	.org ia64_ivt+0x6200
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6200 Entry 38 (size 16 bundles) Reserved
+	DBG_FAULT(38)
+	FAULT(38)
+
+	.org ia64_ivt+0x6300
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6300 Entry 39 (size 16 bundles) Reserved
+	DBG_FAULT(39)
+	FAULT(39)
+
+	.org ia64_ivt+0x6400
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6400 Entry 40 (size 16 bundles) Reserved
+	DBG_FAULT(40)
+	FAULT(40)
+
+	.org ia64_ivt+0x6500
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6500 Entry 41 (size 16 bundles) Reserved
+	DBG_FAULT(41)
+	FAULT(41)
+
+	.org ia64_ivt+0x6600
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6600 Entry 42 (size 16 bundles) Reserved
+	DBG_FAULT(42)
+	FAULT(42)
+
+	.org ia64_ivt+0x6700
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6700 Entry 43 (size 16 bundles) Reserved
+	DBG_FAULT(43)
+	FAULT(43)
+
+	.org ia64_ivt+0x6800
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6800 Entry 44 (size 16 bundles) Reserved
+	DBG_FAULT(44)
+	FAULT(44)
+
+	.org ia64_ivt+0x6900
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6900 Entry 45 (size 16 bundles) IA-32 Exeception (17,18,29,41,42,43,44,58,60,61,62,72,73,75,76,77)
+ENTRY(ia32_exception)
+	DBG_FAULT(45)
+	FAULT(45)
+END(ia32_exception)
+
+	.org ia64_ivt+0x6a00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6a00 Entry 46 (size 16 bundles) IA-32 Intercept  (30,31,59,70,71)
+ENTRY(ia32_intercept)
+	DBG_FAULT(46)
+#ifdef	CONFIG_IA32_SUPPORT
+	mov r31=pr
+	mov r16=cr.isr
+	;;
+	extr.u r17=r16,16,8	// get ISR.code
+	mov r18=ar.eflag
+	mov r19=cr.iim		// old eflag value
+	;;
+	cmp.ne p6,p0=2,r17
+(p6)	br.cond.spnt 1f		// not a system flag fault
+	xor r16=r18,r19
+	;;
+	extr.u r17=r16,18,1	// get the eflags.ac bit
+	;;
+	cmp.eq p6,p0=0,r17
+(p6)	br.cond.spnt 1f		// eflags.ac bit didn't change
+	;;
+	mov pr=r31,-1		// restore predicate registers
+#ifdef CONFIG_XEN
+	XEN_HYPER_RFI;
+#else
+	rfi
+#endif
+
+1:
+#endif	// CONFIG_IA32_SUPPORT
+	FAULT(46)
+END(ia32_intercept)
+
+	.org ia64_ivt+0x6b00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6b00 Entry 47 (size 16 bundles) IA-32 Interrupt  (74)
+ENTRY(ia32_interrupt)
+	DBG_FAULT(47)
+#ifdef CONFIG_IA32_SUPPORT
+	mov r31=pr
+	br.sptk.many dispatch_to_ia32_handler
+#else
+	FAULT(47)
+#endif
+END(ia32_interrupt)
+
+	.org ia64_ivt+0x6c00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6c00 Entry 48 (size 16 bundles) Reserved
+	DBG_FAULT(48)
+	FAULT(48)
+
+	.org ia64_ivt+0x6d00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6d00 Entry 49 (size 16 bundles) Reserved
+	DBG_FAULT(49)
+	FAULT(49)
+
+	.org ia64_ivt+0x6e00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6e00 Entry 50 (size 16 bundles) Reserved
+	DBG_FAULT(50)
+	FAULT(50)
+
+	.org ia64_ivt+0x6f00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x6f00 Entry 51 (size 16 bundles) Reserved
+	DBG_FAULT(51)
+	FAULT(51)
+
+	.org ia64_ivt+0x7000
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7000 Entry 52 (size 16 bundles) Reserved
+	DBG_FAULT(52)
+	FAULT(52)
+
+	.org ia64_ivt+0x7100
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7100 Entry 53 (size 16 bundles) Reserved
+	DBG_FAULT(53)
+	FAULT(53)
+
+	.org ia64_ivt+0x7200
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7200 Entry 54 (size 16 bundles) Reserved
+	DBG_FAULT(54)
+	FAULT(54)
+
+	.org ia64_ivt+0x7300
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7300 Entry 55 (size 16 bundles) Reserved
+	DBG_FAULT(55)
+	FAULT(55)
+
+	.org ia64_ivt+0x7400
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7400 Entry 56 (size 16 bundles) Reserved
+	DBG_FAULT(56)
+	FAULT(56)
+
+	.org ia64_ivt+0x7500
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7500 Entry 57 (size 16 bundles) Reserved
+	DBG_FAULT(57)
+	FAULT(57)
+
+	.org ia64_ivt+0x7600
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7600 Entry 58 (size 16 bundles) Reserved
+	DBG_FAULT(58)
+	FAULT(58)
+
+	.org ia64_ivt+0x7700
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7700 Entry 59 (size 16 bundles) Reserved
+	DBG_FAULT(59)
+	FAULT(59)
+
+	.org ia64_ivt+0x7800
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7800 Entry 60 (size 16 bundles) Reserved
+	DBG_FAULT(60)
+	FAULT(60)
+
+	.org ia64_ivt+0x7900
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7900 Entry 61 (size 16 bundles) Reserved
+	DBG_FAULT(61)
+	FAULT(61)
+
+	.org ia64_ivt+0x7a00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7a00 Entry 62 (size 16 bundles) Reserved
+	DBG_FAULT(62)
+	FAULT(62)
+
+	.org ia64_ivt+0x7b00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7b00 Entry 63 (size 16 bundles) Reserved
+	DBG_FAULT(63)
+	FAULT(63)
+
+	.org ia64_ivt+0x7c00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7c00 Entry 64 (size 16 bundles) Reserved
+	DBG_FAULT(64)
+	FAULT(64)
+
+	.org ia64_ivt+0x7d00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7d00 Entry 65 (size 16 bundles) Reserved
+	DBG_FAULT(65)
+	FAULT(65)
+
+	.org ia64_ivt+0x7e00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7e00 Entry 66 (size 16 bundles) Reserved
+	DBG_FAULT(66)
+	FAULT(66)
+
+	.org ia64_ivt+0x7f00
+/////////////////////////////////////////////////////////////////////////////////////////
+// 0x7f00 Entry 67 (size 16 bundles) Reserved
+	DBG_FAULT(67)
+	FAULT(67)
+
+#ifdef CONFIG_IA32_SUPPORT
+
+	/*
+	 * There is no particular reason for this code to be here, other than that
+	 * there happens to be space here that would go unused otherwise.  If this
+	 * fault ever gets "unreserved", simply moved the following code to a more
+	 * suitable spot...
+	 */
+
+	// IA32 interrupt entry point
+
+ENTRY(dispatch_to_ia32_handler)
+	SAVE_MIN
+	;;
+	mov r14=cr.isr
+	ssm psr.ic | PSR_DEFAULT_BITS
+	;;
+	srlz.i					// guarantee that interruption collection is on
+	;;
+(p15)	ssm psr.i
+	adds r3=8,r2		// Base pointer for SAVE_REST
+	;;
+	SAVE_REST
+	;;
+	mov r15=0x80
+	shr r14=r14,16		// Get interrupt number
+	;;
+	cmp.ne p6,p0=r14,r15
+(p6)	br.call.dpnt.many b6=non_ia32_syscall
+
+	adds r14=IA64_PT_REGS_R8_OFFSET + 16,sp	// 16 byte hole per SW conventions
+	adds r15=IA64_PT_REGS_R1_OFFSET + 16,sp
+	;;
+	cmp.eq pSys,pNonSys=r0,r0 // set pSys=1, pNonSys=0
+	ld8 r8=[r14]		// get r8
+	;;
+	st8 [r15]=r8		// save original EAX in r1 (IA32 procs don't use the GP)
+	;;
+	alloc r15=ar.pfs,0,0,6,0	// must first in an insn group
+	;;
+	ld4 r8=[r14],8		// r8 == eax (syscall number)
+	mov r15=IA32_NR_syscalls
+	;;
+	cmp.ltu.unc p6,p7=r8,r15
+	ld4 out1=[r14],8	// r9 == ecx
+	;;
+	ld4 out2=[r14],8	// r10 == edx
+	;;
+	ld4 out0=[r14]		// r11 == ebx
+	adds r14=(IA64_PT_REGS_R13_OFFSET) + 16,sp
+	;;
+	ld4 out5=[r14],PT(R14)-PT(R13)	// r13 == ebp
+	;;
+	ld4 out3=[r14],PT(R15)-PT(R14)	// r14 == esi
+	adds r2=TI_FLAGS+IA64_TASK_SIZE,r13
+	;;
+	ld4 out4=[r14]		// r15 == edi
+	movl r16=ia32_syscall_table
+	;;
+(p6)	shladd r16=r8,3,r16	// force ni_syscall if not valid syscall number
+	ld4 r2=[r2]		// r2 = current_thread_info()->flags
+	;;
+	ld8 r16=[r16]
+	and r2=_TIF_SYSCALL_TRACEAUDIT,r2	// mask trace or audit
+	;;
+	mov b6=r16
+	movl r15=ia32_ret_from_syscall
+	cmp.eq p8,p0=r2,r0
+	;;
+	mov rp=r15
+(p8)	br.call.sptk.many b6=b6
+	br.cond.sptk ia32_trace_syscall
+
+non_ia32_syscall:
+	alloc r15=ar.pfs,0,0,2,0
+	mov out0=r14				// interrupt #
+	add out1=16,sp				// pointer to pt_regs
+	;;			// avoid WAW on CFM
+	br.call.sptk.many rp=ia32_bad_interrupt
+.ret1:	movl r15=ia64_leave_kernel
+	;;
+	mov rp=r15
+	br.ret.sptk.many rp
+END(dispatch_to_ia32_handler)
+#endif /* CONFIG_IA32_SUPPORT */
+
+#ifdef CONFIG_XEN
+	.section .text,"ax"
+GLOBAL_ENTRY(xen_event_callback)
+	mov r31=pr		// prepare to save predicates
+	;;
+	SAVE_MIN_WITH_COVER	// uses r31; defines r2 and r3
+	;;
+	movl r3=XSI_PSR_IC
+	mov r14=1
+	;;
+	st4 [r3]=r14
+	;;
+	adds r3=8,r2		// set up second base pointer for SAVE_REST
+	srlz.i			// ensure everybody knows psr.ic is back on
+	;;
+	SAVE_REST
+	;;
+1:
+	alloc r14=ar.pfs,0,0,1,0 // must be first in an insn group
+	add out0=16,sp		// pass pointer to pt_regs as first arg
+	;;
+	br.call.sptk.many b0=xen_evtchn_do_upcall
+	;;
+	movl r20=XSI_PSR_I_ADDR
+	;;
+	ld8 r20=[r20]
+	;;
+	adds r20=-1,r20		// vcpu_info->evtchn_upcall_pending
+	;;
+	ld1 r20=[r20]
+	;;
+	cmp.ne p6,p0=r20,r0	// if there are pending events,
+	(p6) br.spnt.few 1b	// call evtchn_do_upcall again.
+	br.sptk.many ia64_leave_kernel
+END(xen_event_callback)
+
+
+	/*
+	 * There is no particular reason for this code to be here, other than that
+	 * there happens to be space here that would go unused otherwise.  If this
+	 * fault ever gets "unreserved", simply moved the following code to a more
+	 * suitable spot...
+	 */
+
+GLOBAL_ENTRY(xen_bsw1)
+	/* FIXME: THIS CODE IS NOT NaT SAFE! */
+	mov r14=ar.unat
+	movl r30=XSI_B1NAT
+	;;
+	ld8 r30=[r30];;
+	mov ar.unat=r30
+	movl r30=XSI_BANKNUM;
+	mov r31=1;;
+	st4 [r30]=r31;
+	movl r30=XSI_BANK1_R16;
+	movl r31=XSI_BANK1_R16+8;;
+	ld8.fill r16=[r30],16; ld8.fill r17=[r31],16;;
+	ld8.fill r18=[r30],16; ld8.fill r19=[r31],16;;
+	ld8.fill r20=[r30],16; ld8.fill r21=[r31],16;;
+	ld8.fill r22=[r30],16; ld8.fill r23=[r31],16;;
+	ld8.fill r24=[r30],16; ld8.fill r25=[r31],16;;
+	ld8.fill r26=[r30],16; ld8.fill r27=[r31],16;;
+	ld8.fill r28=[r30],16; ld8.fill r29=[r31],16;;
+	ld8.fill r30=[r30]; ld8.fill r31=[r31];;
+	mov ar.unat=r14
+	br.ret.sptk.many b0
+END(xen_bsw1)
+
+#endif
diff --git a/arch/ia64/xen/xenminstate.h b/arch/ia64/xen/xenminstate.h
new file mode 100644
index 0000000..eb199db
--- /dev/null
+++ b/arch/ia64/xen/xenminstate.h
@@ -0,0 +1,320 @@
+#include <asm/cache.h>
+
+#ifdef CONFIG_XEN
+#include "../kernel/entry.h"
+#else
+#include "entry.h"
+#endif
+
+/*
+ * DO_SAVE_MIN switches to the kernel stacks (if necessary) and saves
+ * the minimum state necessary that allows us to turn psr.ic back
+ * on.
+ *
+ * Assumed state upon entry:
+ *	psr.ic: off
+ *	r31:	contains saved predicates (pr)
+ *
+ * Upon exit, the state is as follows:
+ *	psr.ic: off
+ *	 r2 = points to &pt_regs.r16
+ *	 r8 = contents of ar.ccv
+ *	 r9 = contents of ar.csd
+ *	r10 = contents of ar.ssd
+ *	r11 = FPSR_DEFAULT
+ *	r12 = kernel sp (kernel virtual address)
+ *	r13 = points to current task_struct (kernel virtual address)
+ *	p15 = TRUE if psr.i is set in cr.ipsr
+ *	predicate registers (other than p2, p3, and p15), b6, r3, r14, r15:
+ *		preserved
+ * CONFIG_XEN note: p6/p7 are not preserved
+ *
+ * Note that psr.ic is NOT turned on by this macro.  This is so that
+ * we can pass interruption state as arguments to a handler.
+ */
+#ifdef CONFIG_XEN
+#define DO_SAVE_MIN(COVER,SAVE_IFS,EXTRA)							\
+	mov r16=IA64_KR(CURRENT);	/* M */							\
+	mov r27=ar.rsc;			/* M */							\
+	mov r20=r1;			/* A */							\
+	mov r25=ar.unat;		/* M */							\
+	/* mov r29=cr.ipsr;		/* M */							\
+	movl r29=XSI_IPSR;;									\
+	ld8 r29=[r29];;										\
+	mov r26=ar.pfs;			/* I */							\
+	/* mov r28=cr.iip;		/* M */							\
+	movl r28=XSI_IIP;;									\
+	ld8 r28=[r28];;										\
+	mov r21=ar.fpsr;		/* M */							\
+	COVER;				/* B;; (or nothing) */					\
+	;;											\
+	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r16;						\
+	;;											\
+	ld1 r17=[r16];				/* load current->thread.on_ustack flag */	\
+	st1 [r16]=r0;				/* clear current->thread.on_ustack flag */	\
+	adds r1=-IA64_TASK_THREAD_ON_USTACK_OFFSET,r16						\
+	/* switch from user to kernel RBS: */							\
+	;;											\
+	invala;				/* M */							\
+	/* SAVE_IFS; /* see xen special handling below */						\
+	cmp.eq pKStk,pUStk=r0,r17;		/* are we in kernel mode already? */		\
+	;;											\
+(pUStk)	mov ar.rsc=0;		/* set enforced lazy mode, pl 0, little-endian, loadrs=0 */	\
+	;;											\
+(pUStk)	mov.m r24=ar.rnat;									\
+(pUStk)	addl r22=IA64_RBS_OFFSET,r1;			/* compute base of RBS */		\
+(pKStk) mov r1=sp;					/* get sp  */				\
+	;;											\
+(pUStk) lfetch.fault.excl.nt1 [r22];								\
+(pUStk)	addl r1=IA64_STK_OFFSET-IA64_PT_REGS_SIZE,r1;	/* compute base of memory stack */	\
+(pUStk)	mov r23=ar.bspstore;				/* save ar.bspstore */			\
+	;;											\
+(pUStk)	mov ar.bspstore=r22;				/* switch to kernel RBS */		\
+(pKStk) addl r1=-IA64_PT_REGS_SIZE,r1;			/* if in kernel mode, use sp (r12) */	\
+	;;											\
+(pUStk)	mov r18=ar.bsp;										\
+(pUStk)	mov ar.rsc=0x3;		/* set eager mode, pl 0, little-endian, loadrs=0 */		\
+	adds r17=2*L1_CACHE_BYTES,r1;		/* really: biggest cache-line size */		\
+	adds r16=PT(CR_IPSR),r1;								\
+	;;											\
+	lfetch.fault.excl.nt1 [r17],L1_CACHE_BYTES;						\
+	st8 [r16]=r29;		/* save cr.ipsr */						\
+	;;											\
+	lfetch.fault.excl.nt1 [r17];								\
+	tbit.nz p15,p0=r29,IA64_PSR_I_BIT;							\
+	mov r29=b0										\
+	;;											\
+	adds r16=PT(R8),r1;	/* initialize first base pointer */				\
+	adds r17=PT(R9),r1;	/* initialize second base pointer */				\
+(pKStk)	mov r18=r0;		/* make sure r18 isn't NaT */					\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r8,16;								\
+.mem.offset 8,0; st8.spill [r17]=r9,16;								\
+        ;;											\
+.mem.offset 0,0; st8.spill [r16]=r10,24;							\
+.mem.offset 8,0; st8.spill [r17]=r11,24;							\
+        ;;											\
+	/* xen special handling for possibly lazy cover */					\
+	movl r8=XSI_PRECOVER_IFS;								\
+	;;											\
+	ld8 r30=[r8];										\
+	;;											\
+	st8 [r16]=r28,16;	/* save cr.iip */						\
+	st8 [r17]=r30,16;	/* save cr.ifs */						\
+(pUStk)	sub r18=r18,r22;	/* r18=RSE.ndirty*8 */						\
+	mov r8=ar.ccv;										\
+	mov r9=ar.csd;										\
+	mov r10=ar.ssd;										\
+	movl r11=FPSR_DEFAULT;   /* L-unit */							\
+	;;											\
+	st8 [r16]=r25,16;	/* save ar.unat */						\
+	st8 [r17]=r26,16;	/* save ar.pfs */						\
+	shl r18=r18,16;		/* compute ar.rsc to be used for "loadrs" */			\
+	;;											\
+	st8 [r16]=r27,16;	/* save ar.rsc */						\
+(pUStk)	st8 [r17]=r24,16;	/* save ar.rnat */						\
+(pKStk)	adds r17=16,r17;	/* skip over ar_rnat field */					\
+	;;			/* avoid RAW on r16 & r17 */					\
+(pUStk)	st8 [r16]=r23,16;	/* save ar.bspstore */						\
+	st8 [r17]=r31,16;	/* save predicates */						\
+(pKStk)	adds r16=16,r16;	/* skip over ar_bspstore field */				\
+	;;											\
+	st8 [r16]=r29,16;	/* save b0 */							\
+	st8 [r17]=r18,16;	/* save ar.rsc value for "loadrs" */				\
+	cmp.eq pNonSys,pSys=r0,r0	/* initialize pSys=0, pNonSys=1 */			\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r20,16;	/* save original r1 */				\
+.mem.offset 8,0; st8.spill [r17]=r12,16;							\
+	adds r12=-16,r1;	/* switch to kernel memory stack (with 16 bytes of scratch) */	\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r13,16;							\
+.mem.offset 8,0; st8.spill [r17]=r21,16;	/* save ar.fpsr */				\
+	mov r13=IA64_KR(CURRENT);	/* establish `current' */				\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r15,16;							\
+.mem.offset 8,0; st8.spill [r17]=r14,16;							\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r2,16;								\
+.mem.offset 8,0; st8.spill [r17]=r3,16;								\
+	;;											\
+	EXTRA;											\
+	mov r2=b0; br.call.sptk b0=xen_bsw1;; mov b0=r2;					\
+	adds r2=IA64_PT_REGS_R16_OFFSET,r1;							\
+	;;											\
+	movl r1=__gp;		/* establish kernel global pointer */				\
+	;;											\
+	/*bsw.1;*/		/* switch back to bank 1 (must be last in insn group) */	\
+	;;
+#else
+#define DO_SAVE_MIN(COVER,SAVE_IFS,EXTRA)							\
+	mov r16=IA64_KR(CURRENT);	/* M */							\
+	mov r27=ar.rsc;			/* M */							\
+	mov r20=r1;			/* A */							\
+	mov r25=ar.unat;		/* M */							\
+	mov r29=cr.ipsr;		/* M */							\
+	mov r26=ar.pfs;			/* I */							\
+	mov r28=cr.iip;			/* M */							\
+	mov r21=ar.fpsr;		/* M */							\
+	COVER;				/* B;; (or nothing) */					\
+	;;											\
+	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r16;						\
+	;;											\
+	ld1 r17=[r16];				/* load current->thread.on_ustack flag */	\
+	st1 [r16]=r0;				/* clear current->thread.on_ustack flag */	\
+	adds r1=-IA64_TASK_THREAD_ON_USTACK_OFFSET,r16						\
+	/* switch from user to kernel RBS: */							\
+	;;											\
+	invala;				/* M */							\
+	SAVE_IFS;										\
+	cmp.eq pKStk,pUStk=r0,r17;		/* are we in kernel mode already? */		\
+	;;											\
+(pUStk)	mov ar.rsc=0;		/* set enforced lazy mode, pl 0, little-endian, loadrs=0 */	\
+	;;											\
+(pUStk)	mov.m r24=ar.rnat;									\
+(pUStk)	addl r22=IA64_RBS_OFFSET,r1;			/* compute base of RBS */		\
+(pKStk) mov r1=sp;					/* get sp  */				\
+	;;											\
+(pUStk) lfetch.fault.excl.nt1 [r22];								\
+(pUStk)	addl r1=IA64_STK_OFFSET-IA64_PT_REGS_SIZE,r1;	/* compute base of memory stack */	\
+(pUStk)	mov r23=ar.bspstore;				/* save ar.bspstore */			\
+	;;											\
+(pUStk)	mov ar.bspstore=r22;				/* switch to kernel RBS */		\
+(pKStk) addl r1=-IA64_PT_REGS_SIZE,r1;			/* if in kernel mode, use sp (r12) */	\
+	;;											\
+(pUStk)	mov r18=ar.bsp;										\
+(pUStk)	mov ar.rsc=0x3;		/* set eager mode, pl 0, little-endian, loadrs=0 */		\
+	adds r17=2*L1_CACHE_BYTES,r1;		/* really: biggest cache-line size */		\
+	adds r16=PT(CR_IPSR),r1;								\
+	;;											\
+	lfetch.fault.excl.nt1 [r17],L1_CACHE_BYTES;						\
+	st8 [r16]=r29;		/* save cr.ipsr */						\
+	;;											\
+	lfetch.fault.excl.nt1 [r17];								\
+	tbit.nz p15,p0=r29,IA64_PSR_I_BIT;							\
+	mov r29=b0										\
+	;;											\
+	adds r16=PT(R8),r1;	/* initialize first base pointer */				\
+	adds r17=PT(R9),r1;	/* initialize second base pointer */				\
+(pKStk)	mov r18=r0;		/* make sure r18 isn't NaT */					\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r8,16;								\
+.mem.offset 8,0; st8.spill [r17]=r9,16;								\
+        ;;											\
+.mem.offset 0,0; st8.spill [r16]=r10,24;							\
+.mem.offset 8,0; st8.spill [r17]=r11,24;							\
+        ;;											\
+	st8 [r16]=r28,16;	/* save cr.iip */						\
+	st8 [r17]=r30,16;	/* save cr.ifs */						\
+(pUStk)	sub r18=r18,r22;	/* r18=RSE.ndirty*8 */						\
+	mov r8=ar.ccv;										\
+	mov r9=ar.csd;										\
+	mov r10=ar.ssd;										\
+	movl r11=FPSR_DEFAULT;   /* L-unit */							\
+	;;											\
+	st8 [r16]=r25,16;	/* save ar.unat */						\
+	st8 [r17]=r26,16;	/* save ar.pfs */						\
+	shl r18=r18,16;		/* compute ar.rsc to be used for "loadrs" */			\
+	;;											\
+	st8 [r16]=r27,16;	/* save ar.rsc */						\
+(pUStk)	st8 [r17]=r24,16;	/* save ar.rnat */						\
+(pKStk)	adds r17=16,r17;	/* skip over ar_rnat field */					\
+	;;			/* avoid RAW on r16 & r17 */					\
+(pUStk)	st8 [r16]=r23,16;	/* save ar.bspstore */						\
+	st8 [r17]=r31,16;	/* save predicates */						\
+(pKStk)	adds r16=16,r16;	/* skip over ar_bspstore field */				\
+	;;											\
+	st8 [r16]=r29,16;	/* save b0 */							\
+	st8 [r17]=r18,16;	/* save ar.rsc value for "loadrs" */				\
+	cmp.eq pNonSys,pSys=r0,r0	/* initialize pSys=0, pNonSys=1 */			\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r20,16;	/* save original r1 */				\
+.mem.offset 8,0; st8.spill [r17]=r12,16;							\
+	adds r12=-16,r1;	/* switch to kernel memory stack (with 16 bytes of scratch) */	\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r13,16;							\
+.mem.offset 8,0; st8.spill [r17]=r21,16;	/* save ar.fpsr */				\
+	mov r13=IA64_KR(CURRENT);	/* establish `current' */				\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r15,16;							\
+.mem.offset 8,0; st8.spill [r17]=r14,16;							\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r2,16;								\
+.mem.offset 8,0; st8.spill [r17]=r3,16;								\
+	adds r2=IA64_PT_REGS_R16_OFFSET,r1;							\
+	;;											\
+	EXTRA;											\
+	movl r1=__gp;		/* establish kernel global pointer */				\
+	;;											\
+	bsw.1;			/* switch back to bank 1 (must be last in insn group) */	\
+	;;
+#endif
+
+/*
+ * SAVE_REST saves the remainder of pt_regs (with psr.ic on).
+ *
+ * Assumed state upon entry:
+ *	psr.ic: on
+ *	r2:	points to &pt_regs.r16
+ *	r3:	points to &pt_regs.r17
+ *	r8:	contents of ar.ccv
+ *	r9:	contents of ar.csd
+ *	r10:	contents of ar.ssd
+ *	r11:	FPSR_DEFAULT
+ *
+ * Registers r14 and r15 are guaranteed not to be touched by SAVE_REST.
+ */
+#define SAVE_REST				\
+.mem.offset 0,0; st8.spill [r2]=r16,16;		\
+.mem.offset 8,0; st8.spill [r3]=r17,16;		\
+	;;					\
+.mem.offset 0,0; st8.spill [r2]=r18,16;		\
+.mem.offset 8,0; st8.spill [r3]=r19,16;		\
+	;;					\
+.mem.offset 0,0; st8.spill [r2]=r20,16;		\
+.mem.offset 8,0; st8.spill [r3]=r21,16;		\
+	mov r18=b6;				\
+	;;					\
+.mem.offset 0,0; st8.spill [r2]=r22,16;		\
+.mem.offset 8,0; st8.spill [r3]=r23,16;		\
+	mov r19=b7;				\
+	;;					\
+.mem.offset 0,0; st8.spill [r2]=r24,16;		\
+.mem.offset 8,0; st8.spill [r3]=r25,16;		\
+	;;					\
+.mem.offset 0,0; st8.spill [r2]=r26,16;		\
+.mem.offset 8,0; st8.spill [r3]=r27,16;		\
+	;;					\
+.mem.offset 0,0; st8.spill [r2]=r28,16;		\
+.mem.offset 8,0; st8.spill [r3]=r29,16;		\
+	;;					\
+.mem.offset 0,0; st8.spill [r2]=r30,16;		\
+.mem.offset 8,0; st8.spill [r3]=r31,32;		\
+	;;					\
+	mov ar.fpsr=r11;	/* M-unit */	\
+	st8 [r2]=r8,8;		/* ar.ccv */	\
+	adds r24=PT(B6)-PT(F7),r3;		\
+	;;					\
+	stf.spill [r2]=f6,32;			\
+	stf.spill [r3]=f7,32;			\
+	;;					\
+	stf.spill [r2]=f8,32;			\
+	stf.spill [r3]=f9,32;			\
+	;;					\
+	stf.spill [r2]=f10;			\
+	stf.spill [r3]=f11;			\
+	adds r25=PT(B7)-PT(F11),r3;		\
+	;;					\
+	st8 [r24]=r18,16;       /* b6 */	\
+	st8 [r25]=r19,16;       /* b7 */	\
+	;;					\
+	st8 [r24]=r9;        	/* ar.csd */	\
+	st8 [r25]=r10;      	/* ar.ssd */	\
+	;;
+
+#define SAVE_MIN_WITH_COVER	DO_SAVE_MIN(cover, mov r30=cr.ifs,)
+#define SAVE_MIN_WITH_COVER_R19	DO_SAVE_MIN(cover, mov r30=cr.ifs, mov r15=r19)
+#ifdef CONFIG_XEN
+#define SAVE_MIN		break 0;; /* FIXME: non-cover version only for ia32 support? */
+#else
+#define SAVE_MIN		DO_SAVE_MIN(     , mov r30=r0, )
+#endif
diff --git a/include/asm-ia64/privop.h b/include/asm-ia64/privop.h
new file mode 100644
index 0000000..b8dce79
--- /dev/null
+++ b/include/asm-ia64/privop.h
@@ -0,0 +1,26 @@
+#ifndef _ASM_IA64_PRIVOP_H
+#define _ASM_IA64_PRIVOP_H
+
+#ifndef _ASM_IA64_INTRINSICS_H
+#error "don't include privop.h directly. instead include intrinsics.h"
+#endif
+/*
+ * Copyright (C) 2005 Hewlett-Packard Co
+ *	Dan Magenheimer <dan.magenheimer@hp.com>
+ *
+ */
+
+#ifdef CONFIG_XEN
+#include <asm/xen/privop.h>
+#endif
+
+/* fallback for native case */
+
+#ifndef IA64_PARAVIRTUALIZED_ENTRY
+#define ia64_switch_to			__ia64_switch_to
+#define ia64_leave_syscall		__ia64_leave_syscall
+#define ia64_work_processed_syscall	__ia64_work_processed_syscall
+#define ia64_leave_kernel		__ia64_leave_kernel
+#endif /* !IA64_PARAVIRTUALIZED_ENTRY */
+
+#endif /* _ASM_IA64_PRIVOP_H */
diff --git a/include/asm-ia64/xen/privop.h b/include/asm-ia64/xen/privop.h
index dd3e5ec..c8a5a0d 100644
--- a/include/asm-ia64/xen/privop.h
+++ b/include/asm-ia64/xen/privop.h
@@ -70,4 +70,26 @@
 #define XSI_IHA				(XSI_BASE + XSI_IHA_OFS)
 #endif
 
+/* these routines utilize privilege-sensitive or performance-sensitive
+ * privileged instructions so the code must be replaced with
+ * paravirtualized versions */
+#ifndef CONFIG_PARAVIRT_ENTRY
+#define IA64_PARAVIRTUALIZED_ENTRY
+#define ia64_switch_to			xen_switch_to
+#define ia64_leave_syscall		xen_leave_syscall
+#define ia64_work_processed_syscall	xen_work_processed_syscall_with_check
+#define ia64_leave_kernel		xen_leave_kernel
+#endif /* !CONFIG_PARAVIRT_ENTRY */
+
+#ifdef CONFIG_XEN
+#ifdef __ASSEMBLY__
+#define BR_IF_NATIVE(target, reg, pred)		\
+	.body ;					\
+	movl reg=running_on_xen;; ;		\
+	ld4 reg=[reg];; ;			\
+	cmp.eq pred,p0=reg,r0 ;			\
+	(pred)	br.cond.sptk.many target;;
+#endif /* __ASSEMBLY__ */
+#endif
+
 #endif /* _ASM_IA64_XEN_PRIVOP_H */
-- 
1.5.3

-- 
yamahata
