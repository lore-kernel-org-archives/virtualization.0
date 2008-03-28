From: Akio Takebe <takebe_akio@jp.fujitsu.com>
Subject: Re: [08/17][PATCH] kvm/ia64: Add interruption vector table for vmm.
Date: Fri, 28 Mar 2008 22:02:19 +0900
Message-ID: <88C890D3F4B4D9takebe_akio__1109.77791850946$1206709568$gmane$org@jp.fujitsu.com>
References: <42DFA526FC41B1429CE7279EF83C6BDCFF7EF8@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDCFF7EF8@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>, Avi Kivity <avi@qumranet.com>, "Luck, Tony" <tony.luck@intel.com>, "Xu, Anthony" <anthony.xu@intel.com>, Jes Sorensen <jes>
List-Id: virtualization@lists.linuxfoundation.org

Hi, Xiantao

a comments is below.


>+// 0x3000 Entry 12 (size 64 bundles) External Interrupt (4)
>+ENTRY(kvm_interrupt)
>+    mov r31=pr		// prepare to save predicates
>+    mov r19=12
>+    mov r29=cr.ipsr
>+    ;;
>+    tbit.z p6,p7=r29,IA64_PSR_VM_BIT
>+    tbit.z p0,p15=r29,IA64_PSR_I_BIT
>+    ;;
>+(p7) br.sptk kvm_dispatch_interrupt
>+    ;;
>+    mov r27=ar.rsc		/* M */
>+    mov r20=r1			/* A */
>+    mov r25=ar.unat		/* M */
>+    mov r26=ar.pfs		/* I */
>+    mov r28=cr.iip		/* M */
>+    cover			/* B (or nothing) */
>+    ;;
>+    mov r1=sp
>+    ;;
>+    invala			/* M */
>+    mov r30=cr.ifs
>+    ;;
>+    addl r1=-VMM_PT_REGS_SIZE,r1
>+    ;;
>+    adds r17=2*L1_CACHE_BYTES,r1	/* really: biggest cache-line
>size */
>+    adds r16=PT(CR_IPSR),r1
>+    ;;
>+    lfetch.fault.excl.nt1 [r17],L1_CACHE_BYTES
>+    st8 [r16]=r29			/* save cr.ipsr */
>+    ;;
>+    lfetch.fault.excl.nt1 [r17]
>+    mov r29=b0
>+    ;;
>+    adds r16=PT(R8),r1  	/* initialize first base pointer */
>+    adds r17=PT(R9),r1  	/* initialize second base pointer */
>+    mov r18=r0      		/* make sure r18 isn't NaT */
>+    ;;
>+.mem.offset 0,0; st8.spill [r16]=r8,16
>+.mem.offset 8,0; st8.spill [r17]=r9,16
>+        ;;
>+.mem.offset 0,0; st8.spill [r16]=r10,24
>+.mem.offset 8,0; st8.spill [r17]=r11,24
>+        ;;
>+    st8 [r16]=r28,16		/* save cr.iip */
>+    st8 [r17]=r30,16		/* save cr.ifs */
>+    mov r8=ar.fpsr		/* M */
>+    mov r9=ar.csd
>+    mov r10=ar.ssd
>+    movl r11=FPSR_DEFAULT	/* L-unit */
>+    ;;
>+    st8 [r16]=r25,16		/* save ar.unat */
>+    st8 [r17]=r26,16		/* save ar.pfs */
>+    shl r18=r18,16		/* compute ar.rsc to be used for
>"loadrs" */
>+    ;;
>+    st8 [r16]=r27,16		/* save ar.rsc */
>+    adds r17=16,r17		/* skip over ar_rnat field */
>+    ;;
>+    st8 [r17]=r31,16		/* save predicates */
>+    adds r16=16,r16		/* skip over ar_bspstore field */
>+    ;;
>+    st8 [r16]=r29,16		/* save b0 */
>+    st8 [r17]=r18,16		/* save ar.rsc value for "loadrs" */
>+    ;;
>+.mem.offset 0,0; st8.spill [r16]=r20,16    /* save original r1 */
>+.mem.offset 8,0; st8.spill [r17]=r12,16
>+    adds r12=-16,r1
>+    /* switch to kernel memory stack (with 16 bytes of scratch) */
>+    ;;
>+.mem.offset 0,0; st8.spill [r16]=r13,16
>+.mem.offset 8,0; st8.spill [r17]=r8,16 /* save ar.fpsr */
>+    ;;
>+.mem.offset 0,0; st8.spill [r16]=r15,16
>+.mem.offset 8,0; st8.spill [r17]=r14,16
>+    dep r14=-1,r0,60,4
>+    ;;
>+.mem.offset 0,0; st8.spill [r16]=r2,16
>+.mem.offset 8,0; st8.spill [r17]=r3,16
>+    adds r2=VMM_PT_REGS_R16_OFFSET,r1
>+    adds r14 = VMM_VCPU_GP_OFFSET,r13
>+    ;;
>+    mov r8=ar.ccv
>+    ld8 r14 = [r14]
>+    ;;
>+    mov r1=r14       /* establish kernel global pointer */
>+    ;;                                          \
>+    bsw.1
>+    ;;
>+    alloc r14=ar.pfs,0,0,1,0	// must be first in an insn group
>+    mov out0=r13
>+    ;;
>+    ssm psr.ic
>+    ;;
>+    srlz.i
>+    ;;
>+    //(p15) ssm psr.i
Why do you comments out some ssm psr.i?
>+    adds r3=8,r2		// set up second base pointer for
>SAVE_REST
>+    srlz.i			// ensure everybody knows psr.ic is back
>on
Hmm, if the above ssm is not necessary, this srlz.i is also necessary.

Best Regards,

Akio Takebe
