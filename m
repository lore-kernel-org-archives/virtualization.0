From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 1/5] KVM paravirt_ops core infrastructure
Date: Sun, 17 Jun 2007 21:58:11 -0500
Message-ID: <4675F4C3.6050700@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000707070802090600040407"
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4675F462.1010708-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------000707070802090600040407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------000707070802090600040407
Content-Type: text/x-patch;
 name="kvm-paravirt-core.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-paravirt-core.diff"

Subject: [PATCH] KVM paravirt_ops core infrastructure
Author: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

This patch implements paravirt_ops support for KVM and updates the current
paravirtualization support in KVM to match.  Some changes to the previous
paravirtualization support in KVM:

  1) Theoritical support for SMP guests
  2) Use CPUID to discover paravirtualization
  3) Use feature bitmap instead of versioning

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8770a5d..97ad1e1 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -231,6 +231,13 @@ config VMI
 	  at the moment), by linking the kernel to a GPL-ed ROM module
 	  provided by the hypervisor.
 
+config KVM_GUEST
+	bool "KVM paravirt-ops support"
+	depends on PARAVIRT
+	help
+	  This option enables various optimizations for running under the KVM
+          hypervisor.
+
 config ACPI_SRAT
 	bool
 	default y
diff --git a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
index 06da59f..12a4201 100644
--- a/arch/i386/kernel/Makefile
+++ b/arch/i386/kernel/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
 obj-$(CONFIG_K8_NB)		+= k8.o
 
 obj-$(CONFIG_VMI)		+= vmi.o vmiclock.o
+obj-$(CONFIG_KVM_GUEST)		+= kvm.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 obj-y				+= pcspeaker.o
 
diff --git a/arch/i386/kernel/kvm.c b/arch/i386/kernel/kvm.c
new file mode 100644
index 0000000..22ea647
--- /dev/null
+++ b/arch/i386/kernel/kvm.c
@@ -0,0 +1,219 @@
+/*
+ * KVM paravirt_ops implementation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) 2007, Red Hat, Inc., Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
+ * Copyright IBM Corporation, 2007
+ *   Authors: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+#include <linux/cpu.h>
+#include <linux/mm.h>
+
+struct kvm_paravirt_state
+{
+	struct kvm_vmca *vmca;
+	struct kvm_hypercall_entry *queue;
+	void (*hypercall)(void);
+
+	u64 vmca_gpa;
+};
+
+static DEFINE_PER_CPU(struct kvm_paravirt_state *, paravirt_state);
+
+static int do_nop_io_delay;
+static u64 msr_set_vmca;
+
+static long kvm_hypercall(unsigned int nr, unsigned long p1,
+			  unsigned long p2, unsigned long p3,
+			  unsigned long p4)
+{
+	struct kvm_paravirt_state *state
+		= per_cpu(paravirt_state, smp_processor_id());
+	long ret;
+
+	asm volatile("call *(%6) \n\t"
+		     : "=a"(ret)
+		     : "a" (nr),
+		     "b" (p1),
+		     "c" (p2),
+		     "d" (p3),
+		     "S" (p4),
+		     "r" (&state->hypercall)
+		     : "memory", "cc"
+		     );
+
+	return ret;
+}
+
+/*
+ * No need for any "IO delay" on KVM
+ */
+static void kvm_io_delay(void)
+{
+}
+
+static void paravirt_ops_setup(void)
+{
+	paravirt_ops.name = "KVM";
+
+	if (do_nop_io_delay)
+		paravirt_ops.io_delay = kvm_io_delay;
+
+	paravirt_ops.paravirt_enabled = 1;
+
+	apply_paravirt(__parainstructions, __parainstructions_end);
+}
+
+static void paravirt_activate(void *unused)
+{
+	struct kvm_paravirt_state *state
+		= per_cpu(paravirt_state, raw_smp_processor_id());
+	wrmsrl(msr_set_vmca, state->vmca_gpa);
+}
+
+static int paravirt_initialize(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	char signature[13];
+
+	/* verify that we're running on KVM */
+	cpuid(CPUID_HYPE_IDENT, &eax, &ebx, &ecx, &edx);
+	memcpy(signature, &ebx, 4);
+	memcpy(signature + 4, &ecx, 4);
+	memcpy(signature + 8, &edx, 4);
+	signature[12] = 0;
+
+	if (strcmp(signature, "KVMKVMKVMKVM"))
+		return -EINVAL;
+
+	/* check what features are supported */
+	cpuid(CPUID_HYPE_KVM_FEATURES, &eax, &ebx, &ecx, &edx);
+	msr_set_vmca = eax;
+
+	/* no paravirtualization is supported */
+	if (!(edx & KVM_FEATURE_VMCA))
+		return -ENOSYS;
+
+	if ((edx & KVM_FEATURE_NOP_IO_DELAY))
+		do_nop_io_delay = 1;
+
+	on_each_cpu(paravirt_activate, NULL, 0, 1);
+
+	return 0;
+}
+
+static __init void paravirt_free_state(struct kvm_paravirt_state *state)
+{
+	if (!state)
+		return;
+
+	if (state->hypercall)
+		__free_page(pfn_to_page(__pa(state->hypercall) >> PAGE_SHIFT));
+
+	if (state->vmca)
+		__free_page(pfn_to_page(__pa(state->vmca) >> PAGE_SHIFT));
+
+	__free_page(pfn_to_page(__pa(state) >> PAGE_SHIFT));
+}
+
+static __init struct kvm_paravirt_state *paravirt_alloc_state(void)
+{
+	struct kvm_paravirt_state *state;
+
+	state = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!state)
+		goto err;
+
+	state->vmca = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!state->vmca)
+		goto err;
+
+	/* FIXME: what do I need for this to be executable on 64 bit? */
+	state->hypercall = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!state->hypercall)
+		goto err;
+
+	state->vmca_gpa = __pa(state->vmca);
+	state->vmca->hypercall_gpa = __pa(state->hypercall);
+
+	return state;
+
+ err:
+	paravirt_free_state(state);
+	return NULL;
+}
+
+/* FIXME: hotplug hooks whenever KVM supports CPU hotplug */
+
+static __init void paravirt_free_area(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		struct kvm_paravirt_state *state;
+		state = per_cpu(paravirt_state, cpu);
+		paravirt_free_state(state);
+	}
+}
+
+static __init int paravirt_alloc_area(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		struct kvm_paravirt_state *state;
+
+		state = paravirt_alloc_state();
+		if (!state)
+			goto err;
+
+		per_cpu(paravirt_state, cpu) = state;
+	}
+
+	return 0;
+
+ err:
+	paravirt_free_area();
+	return -ENOMEM;
+}
+
+static int __init kvm_guest_init(void)
+{
+	int rc;
+
+	rc = paravirt_alloc_area();
+	if (rc)
+		return rc;
+
+	rc = paravirt_initialize();
+	if (rc)
+		goto err;
+
+	paravirt_ops_setup();
+
+	return rc;
+
+ err:
+	paravirt_free_area();
+	return rc;
+}
+
+/* FIXME: need a better solution! */
+core_initcall(kvm_guest_init);
diff --git a/drivers/kvm/kvm_main.c b/drivers/kvm/kvm_main.c
index 633c2ed..f7a0e6e 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -43,6 +43,7 @@
 #include <linux/sched.h>
 #include <linux/cpumask.h>
 #include <linux/smp.h>
+#include <linux/kvm_para.h>
 
 #include "x86_emulate.h"
 #include "segment_descriptor.h"
@@ -91,6 +92,11 @@ struct vfsmount *kvmfs_mnt;
 #define CR8_RESEVED_BITS (~0x0fULL)
 #define EFER_RESERVED_BITS 0xfffffffffffff2fe
 
+#define KVM_PARAVIRT_FEATURES \
+	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY)
+
+#define KVM_MSR_SET_VMCA	0x87655678
+
 #ifdef CONFIG_X86_64
 // LDT or TSS descriptor in the GDT. 16 bytes.
 struct segment_descriptor_64 {
@@ -1340,12 +1346,19 @@ int kvm_emulate_halt(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_halt);
 
+static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
+			      unsigned long p1, unsigned long p2,
+			      unsigned long p3, unsigned long p4)
+{
+	return -ENOSYS;
+}
+
 int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	unsigned long nr, a0, a1, a2, a3, a4, a5, ret;
 
 	kvm_arch_ops->cache_regs(vcpu);
-	ret = -KVM_EINVAL;
+	ret = -EINVAL;
 #ifdef CONFIG_X86_64
 	if (is_long_mode(vcpu)) {
 		nr = vcpu->regs[VCPU_REGS_RAX];
@@ -1358,16 +1371,17 @@ int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	} else
 #endif
 	{
-		nr = vcpu->regs[VCPU_REGS_RBX] & -1u;
-		a0 = vcpu->regs[VCPU_REGS_RAX] & -1u;
+		nr = vcpu->regs[VCPU_REGS_RAX] & -1u;
+		a0 = vcpu->regs[VCPU_REGS_RBX] & -1u;
 		a1 = vcpu->regs[VCPU_REGS_RCX] & -1u;
 		a2 = vcpu->regs[VCPU_REGS_RDX] & -1u;
 		a3 = vcpu->regs[VCPU_REGS_RSI] & -1u;
 		a4 = vcpu->regs[VCPU_REGS_RDI] & -1u;
 		a5 = vcpu->regs[VCPU_REGS_RBP] & -1u;
 	}
-	switch (nr) {
-	default:
+
+	ret = dispatch_hypercall(vcpu, nr, a0, a1, a2, a3);
+	if (ret == -ENOSYS) {
 		run->hypercall.args[0] = a0;
 		run->hypercall.args[1] = a1;
 		run->hypercall.args[2] = a2;
@@ -1456,7 +1470,7 @@ void realmode_set_cr(struct kvm_vcpu *vcpu, int cr, unsigned long val,
  */
 static int vcpu_register_para(struct kvm_vcpu *vcpu, gpa_t para_state_gpa)
 {
-	struct kvm_vcpu_para_state *para_state;
+	struct kvm_vmca *para_state;
 	hpa_t para_state_hpa, hypercall_hpa;
 	struct page *para_state_page;
 	unsigned char *hypercall;
@@ -1476,30 +1490,14 @@ static int vcpu_register_para(struct kvm_vcpu *vcpu, gpa_t para_state_gpa)
 	if (is_error_hpa(para_state_hpa))
 		goto err_gp;
 
-	mark_page_dirty(vcpu->kvm, para_state_gpa >> PAGE_SHIFT);
 	para_state_page = pfn_to_page(para_state_hpa >> PAGE_SHIFT);
 	para_state = kmap_atomic(para_state_page, KM_USER0);
 
-	printk(KERN_DEBUG "....  guest version: %d\n", para_state->guest_version);
-	printk(KERN_DEBUG "....           size: %d\n", para_state->size);
-
-	para_state->host_version = KVM_PARA_API_VERSION;
-	/*
-	 * We cannot support guests that try to register themselves
-	 * with a newer API version than the host supports:
-	 */
-	if (para_state->guest_version > KVM_PARA_API_VERSION) {
-		para_state->ret = -KVM_EINVAL;
-		goto err_kunmap_skip;
-	}
-
 	hypercall_gpa = para_state->hypercall_gpa;
 	hypercall_hpa = gpa_to_hpa(vcpu, hypercall_gpa);
 	printk(KERN_DEBUG ".... hypercall_hpa: %08Lx\n", hypercall_hpa);
-	if (is_error_hpa(hypercall_hpa)) {
-		para_state->ret = -KVM_EINVAL;
+	if (is_error_hpa(hypercall_hpa))
 		goto err_kunmap_skip;
-	}
 
 	printk(KERN_DEBUG "kvm: para guest successfully registered.\n");
 	vcpu->para_state_page = para_state_page;
@@ -1512,7 +1510,6 @@ static int vcpu_register_para(struct kvm_vcpu *vcpu, gpa_t para_state_gpa)
 	kvm_arch_ops->patch_hypercall(vcpu, hypercall);
 	kunmap_atomic(hypercall, KM_USER1);
 
-	para_state->ret = 0;
 err_kunmap_skip:
 	kunmap_atomic(para_state, KM_USER0);
 	return 0;
@@ -1633,12 +1630,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 	case MSR_IA32_MISC_ENABLE:
 		vcpu->ia32_misc_enable_msr = data;
 		break;
-	/*
-	 * This is the 'probe whether the host is KVM' logic:
-	 */
-	case MSR_KVM_API_MAGIC:
-		return vcpu_register_para(vcpu, data);
-
+	case KVM_MSR_SET_VMCA:
+		vcpu_register_para(vcpu, data);
+		break;
 	default:
 		printk(KERN_ERR "kvm: unhandled wrmsr: 0x%x\n", msr);
 		return 1;
@@ -1693,6 +1687,20 @@ void kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 
 	kvm_arch_ops->cache_regs(vcpu);
 	function = vcpu->regs[VCPU_REGS_RAX];
+
+	if (function == CPUID_HYPE_IDENT) {
+		vcpu->regs[VCPU_REGS_RAX] = 0;
+		/* KVMKVMKVMKVM */
+		vcpu->regs[VCPU_REGS_RBX] = 0x4b4d564b;
+		vcpu->regs[VCPU_REGS_RCX] = 0x564b4d56;
+		vcpu->regs[VCPU_REGS_RDX] = 0x4d564b4d;
+		goto out;
+	} else if (function == CPUID_HYPE_KVM_FEATURES) {
+		vcpu->regs[VCPU_REGS_RAX] = KVM_MSR_SET_VMCA;
+		vcpu->regs[VCPU_REGS_RDX] = KVM_PARAVIRT_FEATURES;
+		goto out;
+	}
+
 	vcpu->regs[VCPU_REGS_RAX] = 0;
 	vcpu->regs[VCPU_REGS_RBX] = 0;
 	vcpu->regs[VCPU_REGS_RCX] = 0;
@@ -1717,6 +1725,7 @@ void kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 		vcpu->regs[VCPU_REGS_RCX] = best->ecx;
 		vcpu->regs[VCPU_REGS_RDX] = best->edx;
 	}
+ out:
 	kvm_arch_ops->decache_regs(vcpu);
 	kvm_arch_ops->skip_emulated_instruction(vcpu);
 }
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 3b29256..cf51d4a 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -8,66 +8,26 @@
  *       as we make progress.
  */
 
-/*
- * Per-VCPU descriptor area shared between guest and host. Writable to
- * both guest and host. Registered with the host by the guest when
- * a guest acknowledges paravirtual mode.
- *
- * NOTE: all addresses are guest-physical addresses (gpa), to make it
- * easier for the hypervisor to map between the various addresses.
- */
-struct kvm_vcpu_para_state {
-	/*
-	 * API version information for compatibility. If there's any support
-	 * mismatch (too old host trying to execute too new guest) then
-	 * the host will deny entry into paravirtual mode. Any other
-	 * combination (new host + old guest and new host + new guest)
-	 * is supposed to work - new host versions will support all old
-	 * guest API versions.
-	 */
-	u32 guest_version;
-	u32 host_version;
-	u32 size;
-	u32 ret;
-
-	/*
-	 * The address of the vm exit instruction (VMCALL or VMMCALL),
-	 * which the host will patch according to the CPU model the
-	 * VM runs on:
-	 */
-	u64 hypercall_gpa;
-
-} __attribute__ ((aligned(PAGE_SIZE)));
+#define CPUID_HYPE_IDENT		0x40000000
+#define CPUID_HYPE_KVM_FEATURES		0x40000001
 
-#define KVM_PARA_API_VERSION 1
+#define KVM_FEATURE_VMCA		(1UL << 0)
+#define KVM_FEATURE_NOP_IO_DELAY	(1UL << 1)
 
-/*
- * This is used for an RDMSR's ECX parameter to probe for a KVM host.
- * Hopefully no CPU vendor will use up this number. This is placed well
- * out of way of the typical space occupied by CPU vendors' MSR indices,
- * and we think (or at least hope) it wont be occupied in the future
- * either.
- */
-#define MSR_KVM_API_MAGIC 0x87655678
-
-#define KVM_EINVAL 1
+struct kvm_vmca
+{
+	u64 hypercall_gpa;
+};
 
 /*
  * Hypercall calling convention:
  *
- * Each hypercall may have 0-6 parameters.
- *
- * 64-bit hypercall index is in RAX, goes from 0 to __NR_hypercalls-1
- *
- * 64-bit parameters 1-6 are in the standard gcc x86_64 calling convention
- * order: RDI, RSI, RDX, RCX, R8, R9.
+ * Each hypercall may have 0-4 parameters.
  *
- * 32-bit index is EBX, parameters are: EAX, ECX, EDX, ESI, EDI, EBP.
- * (the first 3 are according to the gcc regparm calling convention)
+ * 32-bit index is EAX, parameters are: EBX, ECX, EDX, ESI.
  *
  * No registers are clobbered by the hypercall, except that the
  * return value is in RAX.
  */
-#define __NR_hypercalls			0
 
 #endif

--------------000707070802090600040407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------000707070802090600040407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------000707070802090600040407--
