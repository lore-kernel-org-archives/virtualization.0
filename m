From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 2/4] ia64/xen: paravirtualize minstate.h, DO_SAVE_MIN.
Date: Mon, 25 Feb 2008 12:16:44 +0900
Message-ID: <12039094063108-git-send-email-yamahata__39825.8350593553$1203909853$gmane$org@valinux.co.jp>
References: <12039094061834-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12039094061834-git-send-email-yamahata@valinux.co.jp>
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
 arch/ia64/xen/xenminstate.h |  320 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 320 insertions(+), 0 deletions(-)
 create mode 100644 arch/ia64/xen/xenminstate.h

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
-- 
1.5.3
