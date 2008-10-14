From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 21/32] ia64/pv_ops/xen: paravirtualize DO_SAVE_MIN for xen.
Date: Tue, 14 Oct 2008 14:51:36 +0900
Message-ID: <1223963507-28056-22-git-send-email-yamahata__1387.51742565564$1223968664$gmane$org@valinux.co.jp>
References: <1223963507-28056-1-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1223963507-28056-1-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

paravirtualize DO_SAVE_MIN in minstate.h for xen.

Signed-off-by: Yaozu (Eddie) Dong <eddie.dong@intel.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/include/asm/xen/inst.h     |    2 +
 arch/ia64/include/asm/xen/minstate.h |  134 ++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 0 deletions(-)
 create mode 100644 arch/ia64/include/asm/xen/minstate.h

diff --git a/arch/ia64/include/asm/xen/inst.h b/arch/ia64/include/asm/xen/inst.h
index 03895e9..1e92ed0 100644
--- a/arch/ia64/include/asm/xen/inst.h
+++ b/arch/ia64/include/asm/xen/inst.h
@@ -22,6 +22,8 @@
 
 #include <asm/xen/privop.h>
 
+#define DO_SAVE_MIN				XEN_DO_SAVE_MIN
+
 #define MOV_FROM_IFA(reg)	\
 	movl reg = XSI_IFA;	\
 	;;			\
diff --git a/arch/ia64/include/asm/xen/minstate.h b/arch/ia64/include/asm/xen/minstate.h
new file mode 100644
index 0000000..4d92d9b
--- /dev/null
+++ b/arch/ia64/include/asm/xen/minstate.h
@@ -0,0 +1,134 @@
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
+#define XEN_DO_SAVE_MIN(__COVER,SAVE_IFS,EXTRA,WORKAROUND)					\
+	mov r16=IA64_KR(CURRENT);	/* M */							\
+	mov r27=ar.rsc;			/* M */							\
+	mov r20=r1;			/* A */							\
+	mov r25=ar.unat;		/* M */							\
+	MOV_FROM_IPSR(p0,r29);		/* M */							\
+	MOV_FROM_IIP(r28);		/* M */							\
+	mov r21=ar.fpsr;		/* M */							\
+	mov r26=ar.pfs;			/* I */							\
+	__COVER;			/* B;; (or nothing) */					\
+	adds r16=IA64_TASK_THREAD_ON_USTACK_OFFSET,r16;						\
+	;;											\
+	ld1 r17=[r16];				/* load current->thread.on_ustack flag */	\
+	st1 [r16]=r0;				/* clear current->thread.on_ustack flag */	\
+	adds r1=-IA64_TASK_THREAD_ON_USTACK_OFFSET,r16						\
+	/* switch from user to kernel RBS: */							\
+	;;											\
+	invala;				/* M */							\
+	/* SAVE_IFS;*/ /* see xen special handling below */					\
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
+	WORKAROUND;										\
+	adds r16=PT(R8),r1;	/* initialize first base pointer */				\
+	adds r17=PT(R9),r1;	/* initialize second base pointer */				\
+(pKStk)	mov r18=r0;		/* make sure r18 isn't NaT */					\
+	;;											\
+.mem.offset 0,0; st8.spill [r16]=r8,16;								\
+.mem.offset 8,0; st8.spill [r17]=r9,16;								\
+        ;;											\
+.mem.offset 0,0; st8.spill [r16]=r10,24;							\
+	movl r8=XSI_PRECOVER_IFS;								\
+.mem.offset 8,0; st8.spill [r17]=r11,24;							\
+        ;;											\
+	/* xen special handling for possibly lazy cover */					\
+	/* SAVE_MIN case in dispatch_ia32_handler: mov r30=r0 */				\
+	ld8 r30=[r8];										\
+(pUStk)	sub r18=r18,r22;	/* r18=RSE.ndirty*8 */						\
+	st8 [r16]=r28,16;	/* save cr.iip */						\
+	;;											\
+	st8 [r17]=r30,16;	/* save cr.ifs */						\
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
+	ACCOUNT_GET_STAMP									\
+	adds r2=IA64_PT_REGS_R16_OFFSET,r1;							\
+	;;											\
+	EXTRA;											\
+	movl r1=__gp;		/* establish kernel global pointer */				\
+	;;											\
+	ACCOUNT_SYS_ENTER									\
+	BSW_1(r3,r14);	/* switch back to bank 1 (must be last in insn group) */		\
+	;;
-- 
1.6.0.2
