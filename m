From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 03/10] xen: move interrupt handling for pv guests under
	CONFIG_XEN_PV umbrella
Date: Fri, 19 May 2017 17:47:39 +0200
Message-ID: <20170519154746.29389-4-jgross@suse.com>
References: <20170519154746.29389-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170519154746.29389-1-jgross@suse.com>
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
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

There is no need to include pv-guest only object files in a kernel not
configured to support those. Move Xen's irq.o, xen-asm*.o and pv parts
of entry_*.o into CONFIG_XEN_PV sections.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/entry/entry_32.S | 4 +++-
 arch/x86/entry/entry_64.S | 6 ++++--
 arch/x86/xen/Makefile     | 8 ++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 50bc26949e9e..37ae4a7809d9 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -789,7 +789,7 @@ ENTRY(spurious_interrupt_bug)
 	jmp	common_exception
 END(spurious_interrupt_bug)
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 ENTRY(xen_hypervisor_callback)
 	pushl	$-1				/* orig_ax = -1 => not a system call */
 	SAVE_ALL
@@ -870,7 +870,9 @@ ENTRY(xen_failsafe_callback)
 	_ASM_EXTABLE(3b, 8b)
 	_ASM_EXTABLE(4b, 9b)
 ENDPROC(xen_failsafe_callback)
+#endif /* CONFIG_XEN_PV */
 
+#ifdef CONFIG_XEN
 BUILD_INTERRUPT3(xen_hvm_callback_vector, HYPERVISOR_CALLBACK_VECTOR,
 		xen_evtchn_do_upcall)
 
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 607d72c4a485..cd47214ff402 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -902,7 +902,7 @@ ENTRY(do_softirq_own_stack)
 	ret
 END(do_softirq_own_stack)
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 idtentry xen_hypervisor_callback xen_do_hypervisor_callback has_error_code=0
 
 /*
@@ -983,7 +983,9 @@ ENTRY(xen_failsafe_callback)
 	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
+#endif /* CONFIG_XEN_PV */
 
+#ifdef CONFIG_XEN
 apicinterrupt3 HYPERVISOR_CALLBACK_VECTOR \
 	xen_hvm_callback_vector xen_evtchn_do_upcall
 
@@ -998,7 +1000,7 @@ idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
 idtentry int3			do_int3			has_error_code=0	paranoid=1 shift_ist=DEBUG_STACK
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
-#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
 idtentry xen_debug		do_debug		has_error_code=0
 idtentry xen_int3		do_int3			has_error_code=0
 idtentry xen_stack_segment	do_stack_segment	has_error_code=1
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index fffb0a16f9e3..5fc463eaafff 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -10,13 +10,13 @@ nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_enlighten_pv.o		:= $(nostackp)
 CFLAGS_mmu_pv.o		:= $(nostackp)
 
-obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
-			time.o xen-asm.o xen-asm_$(BITS).o \
+obj-y		:= enlighten.o multicalls.o mmu.o time.o \
 			grant-table.o suspend.o platform-pci-unplug.o
 
 obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
-obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
-						p2m.o enlighten_pv.o mmu_pv.o
+obj-$(CONFIG_XEN_PV)		+= setup.o apic.o pmu.o suspend_pv.o irq.o \
+					p2m.o enlighten_pv.o mmu_pv.o \
+					xen-asm.o xen-asm_$(BITS).o
 obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
 
 obj-$(CONFIG_EVENT_TRACING) += trace.o
-- 
2.12.0
