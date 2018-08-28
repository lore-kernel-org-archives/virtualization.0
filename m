From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 01/15] xen: move pv irq related functions under
	CONFIG_XEN_PV umbrella
Date: Tue, 28 Aug 2018 09:40:12 +0200
Message-ID: <20180828074026.820-2-jgross__12091.0853533589$1535441946$gmane$org@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

All functions in arch/x86/xen/irq.c and arch/x86/xen/xen-asm*.S are
specific to PV guests. Include them in the kernel with
CONFIG_XEN_PV only.

Make the PV specific code in arch/x86/entry/entry_*.S dependent on
CONFIG_XEN_PV instead of CONFIG_XEN.

The HVM specific code should depend on CONFIG_XEN_PVHVM.

While at it reformat the Makefile to make it more readable.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S |  8 +++++---
 arch/x86/entry/entry_64.S |  8 +++++---
 arch/x86/xen/Makefile     | 41 +++++++++++++++++++++++++++++++----------
 include/xen/events.h      |  2 ++
 4 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2767c625a52c..9cc4c3064ce0 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -782,7 +782,7 @@ GLOBAL(__begin_SYSENTER_singlestep_region)
  * will ignore all of the single-step traps generated in this range.
  */
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 /*
  * Xen doesn't set %esp to be precisely what the normal SYSENTER
  * entry point expects, so fix it up before using the normal path.
@@ -1240,7 +1240,7 @@ ENTRY(spurious_interrupt_bug)
 	jmp	common_exception
 END(spurious_interrupt_bug)
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 ENTRY(xen_hypervisor_callback)
 	pushl	$-1				/* orig_ax = -1 => not a system call */
 	SAVE_ALL
@@ -1321,11 +1321,13 @@ ENTRY(xen_failsafe_callback)
 	_ASM_EXTABLE(3b, 8b)
 	_ASM_EXTABLE(4b, 9b)
 ENDPROC(xen_failsafe_callback)
+#endif /* CONFIG_XEN_PV */
 
+#ifdef CONFIG_XEN_PVHVM
 BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
 		 xen_evtchn_do_upcall)
+#endif
 
-#endif /* CONFIG_XEN */
 
 #if IS_ENABLED(CONFIG_HYPERV)
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 957dfb693ecc..a9ec5d3c6e67 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1050,7 +1050,7 @@ ENTRY(do_softirq_own_stack)
 	ret
 ENDPROC(do_softirq_own_stack)
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 idtentry hypervisor_callback xen_do_hypervisor_callback has_error_code=0
 
 /*
@@ -1130,11 +1130,13 @@ ENTRY(xen_failsafe_callback)
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
+#endif /* CONFIG_XEN_PV */
 
+#ifdef CONFIG_XEN_PVHVM
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 	xen_hvm_callback_vector xen_evtchn_do_upcall
+#endif
 
-#endif /* CONFIG_XEN */
 
 #if IS_ENABLED(CONFIG_HYPERV)
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
@@ -1151,7 +1153,7 @@ idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
 idtentry int3			do_int3			has_error_code=0
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 idtentry xennmi			do_nmi			has_error_code=0
 idtentry xendebug		do_debug		has_error_code=0
 idtentry xenint3		do_int3			has_error_code=0
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index d83cb5478f54..f723b5aa8f74 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -12,25 +12,46 @@ endif
 # Make sure early boot has no stackprotector
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_enlighten_pv.o		:= $(nostackp)
-CFLAGS_mmu_pv.o		:= $(nostackp)
+CFLAGS_mmu_pv.o			:= $(nostackp)
 
-obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
-			time.o xen-asm.o xen-asm_$(BITS).o \
-			grant-table.o suspend.o platform-pci-unplug.o
+obj-y				+= enlighten.o
+obj-y				+= multicalls.o
+obj-y				+= mmu.o
+obj-y				+= time.o
+obj-y				+= grant-table.o
+obj-y				+= suspend.o
+obj-y				+= platform-pci-unplug.o
 
-obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
-obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
-						p2m.o enlighten_pv.o mmu_pv.o
-obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
+obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o
+obj-$(CONFIG_XEN_PVHVM)		+= mmu_hvm.o
+obj-$(CONFIG_XEN_PVHVM)		+= suspend_hvm.o
 
-obj-$(CONFIG_EVENT_TRACING) += trace.o
+obj-$(CONFIG_XEN_PV)		+= setup.o
+obj-$(CONFIG_XEN_PV)		+= apic.o
+obj-$(CONFIG_XEN_PV)		+= pmu.o
+obj-$(CONFIG_XEN_PV)		+= suspend_pv.o
+obj-$(CONFIG_XEN_PV)		+= p2m.o
+obj-$(CONFIG_XEN_PV)		+= enlighten_pv.o
+obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
+obj-$(CONFIG_XEN_PV)		+= irq.o
+obj-$(CONFIG_XEN_PV)		+= xen-asm.o
+obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
+
+obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
+obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
+
+obj-$(CONFIG_EVENT_TRACING)	+= trace.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_XEN_PV_SMP)  	+= smp_pv.o
 obj-$(CONFIG_XEN_PVHVM_SMP)  	+= smp_hvm.o
+
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+= spinlock.o
+
 obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
+
 obj-$(CONFIG_XEN_DOM0)		+= vga.o
+
 obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
+
 obj-$(CONFIG_XEN_EFI)		+= efi.o
-obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
diff --git a/include/xen/events.h b/include/xen/events.h
index c3e6bc643a7b..a48897199975 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -89,11 +89,13 @@ unsigned irq_from_evtchn(unsigned int evtchn);
 int irq_from_virq(unsigned int cpu, unsigned int virq);
 unsigned int evtchn_from_irq(unsigned irq);
 
+#ifdef CONFIG_XEN_PVHVM
 /* Xen HVM evtchn vector callback */
 void xen_hvm_callback_vector(void);
 #ifdef CONFIG_TRACING
 #define trace_xen_hvm_callback_vector xen_hvm_callback_vector
 #endif
+#endif
 int xen_set_callback_via(uint64_t via);
 void xen_evtchn_do_upcall(struct pt_regs *regs);
 void xen_hvm_evtchn_do_upcall(void);
-- 
2.16.4
