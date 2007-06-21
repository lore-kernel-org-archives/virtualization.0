From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 5/5] KVM: Add hypercall queue for paravirt_ops
	implementation
Date: Wed, 20 Jun 2007 22:09:39 -0500
Message-ID: <4679EBF3.8090302@codemonkey.ws>
References: <4679EAAF.2060103@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030304040703020109030302"
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4679EAAF.2060103-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
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
--------------030304040703020109030302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori


--------------030304040703020109030302
Content-Type: text/x-patch;
 name="kvm-hypercall-queue.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-hypercall-queue.diff"

Subject: [PATCH] KVM: Add hypercall queue for paravirt_ops implementation
Author: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

Implemented a hypercall queue that can be used when paravirt_ops lazy mode
is enabled.  This patch enables queueing of MMU write operations and CR
updates.  This results in about a 50% bump in kernbench performance.

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff --git a/arch/i386/kernel/kvm.c b/arch/i386/kernel/kvm.c
index 21133e4..52eb50d 100644
--- a/arch/i386/kernel/kvm.c
+++ b/arch/i386/kernel/kvm.c
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/dmi.h>
 #include <linux/acpi_pmtmr.h>
+#include <linux/hardirq.h>
 
 #include "mach_timer.h"
 
@@ -46,8 +47,12 @@ struct kvm_paravirt_state
 	unsigned long cached_cr[5];
 	int cr_valid[5];
 
-	struct kvm_vmca *vmca;
+	enum paravirt_lazy_mode mode;
 	struct kvm_hypercall_entry *queue;
+	int queue_index;
+	int max_queue_index;
+
+	struct kvm_vmca *vmca;
 	void (*hypercall)(void);
 
 	u64 vmca_gpa;
@@ -55,18 +60,18 @@ struct kvm_paravirt_state
 
 static DEFINE_PER_CPU(struct kvm_paravirt_state *, paravirt_state);
 
+static int do_hypercall_batching;
 static int do_mmu_write;
 static int do_cr_read_caching;
 static int do_nop_io_delay;
 static int do_paravirt_clock;
 static u64 msr_set_vmca;
 
-static long kvm_hypercall(unsigned int nr, unsigned long p1,
-			  unsigned long p2, unsigned long p3,
-			  unsigned long p4)
+static long _kvm_hypercall(struct kvm_paravirt_state *state,
+			   unsigned int nr, unsigned long p1,
+			   unsigned long p2, unsigned long p3,
+			   unsigned long p4)
 {
-	struct kvm_paravirt_state *state
-		= per_cpu(paravirt_state, smp_processor_id());
 	long ret;
 
 	asm volatile("call *(%6) \n\t"
@@ -83,6 +88,69 @@ static long kvm_hypercall(unsigned int nr, unsigned long p1,
 	return ret;
 }
 
+static int can_defer_hypercall(struct kvm_paravirt_state *state,
+			       unsigned int nr)
+{
+	if (state->mode == PARAVIRT_LAZY_MMU) {
+		switch (nr) {
+		case KVM_HYPERCALL_MMU_WRITE:
+		case KVM_HYPERCALL_FLUSH_TLB:
+		case KVM_HYPERCALL_FLUSH_TLB_SINGLE:
+			return 1;
+		}
+	} else if (state->mode == PARAVIRT_LAZY_CPU) {
+		if (nr == KVM_HYPERCALL_SET_CR)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void hypercall_queue_flush(struct kvm_paravirt_state *state)
+{
+	if (state->queue_index) {
+		_kvm_hypercall(state, KVM_HYPERCALL_FLUSH, __pa(state->queue),
+			       state->queue_index, 0, 0);
+		state->queue_index = 0;
+	}
+}
+
+static void _kvm_hypercall_defer(struct kvm_paravirt_state *state,
+				 unsigned int nr,
+				 unsigned long p1, unsigned long p2,
+				 unsigned long p3, unsigned long p4)
+{
+	struct kvm_hypercall_entry *entry;
+
+	BUG_ON(preemptible());
+
+	if (state->queue_index == state->max_queue_index)
+		hypercall_queue_flush(state);
+
+	entry = &state->queue[state->queue_index++];
+	entry->nr = nr;
+	entry->p1 = p1;
+	entry->p2 = p2;
+	entry->p3 = p3;
+	entry->p4 = p4;
+}
+
+static long kvm_hypercall(unsigned int nr, unsigned long p1,
+			  unsigned long p2, unsigned long p3,
+			  unsigned long p4)
+{
+	struct kvm_paravirt_state *state = get_cpu_var(paravirt_state);
+	long ret = 0;
+
+	if (can_defer_hypercall(state, nr))
+		_kvm_hypercall_defer(state, nr, p1, p2, p3, p4);
+	else
+		ret = _kvm_hypercall(state, nr, p1, p2, p3, p4);
+
+	put_cpu_var(paravirt_state);
+	return ret;
+}
+
 static cycle_t kvm_clocksource_read(void)
 {
 	struct kvm_paravirt_state *state = get_cpu_var(paravirt_state);
@@ -146,18 +214,22 @@ static __always_inline void kvm_write_cr(int reg, unsigned long value)
 	state->cr_valid[reg] = 1;
 	state->cached_cr[reg] = value;
 
-	switch (reg) {
-	case 0:
-		native_write_cr0(value);
-		break;
-	case 3:
-		native_write_cr3(value);
-		break;
-	case 4:
-		native_write_cr4(value);
-		break;
-	default:
-		BUG();
+	if (state->mode == PARAVIRT_LAZY_CPU)
+		kvm_hypercall(KVM_HYPERCALL_SET_CR, reg, value, 0, 0);
+	else {
+		switch (reg) {
+		case 0:
+			native_write_cr0(value);
+			break;
+		case 3:
+			native_write_cr3(value);
+			break;
+		case 4:
+			native_write_cr4(value);
+			break;
+		default:
+			BUG();
+		}
 	}
 }
 
@@ -269,7 +341,24 @@ static void kvm_flush_tlb(void)
 
 static void kvm_flush_tlb_single(unsigned long addr)
 {
-	kvm_hypercall(KVM_HYPERCALL_FLUSH_TLB_SINGLE, addr, 0, 0, 0);
+	int mode = x86_read_percpu(paravirt_state)->mode;
+
+	if (mode == PARAVIRT_LAZY_MMU)
+		kvm_hypercall(KVM_HYPERCALL_FLUSH_TLB_SINGLE, addr, 0, 0, 0);
+	else
+		__native_flush_tlb_single(addr);
+}
+
+static void kvm_set_lazy_mode(enum paravirt_lazy_mode mode)
+{
+	struct kvm_paravirt_state *state
+		= per_cpu(paravirt_state, smp_processor_id());
+
+	if (mode == PARAVIRT_LAZY_FLUSH || mode == PARAVIRT_LAZY_NONE)
+		hypercall_queue_flush(state);
+
+	if (mode != PARAVIRT_LAZY_FLUSH)
+		state->mode = mode;
 }
 
 static void kvm_release_pt(u32 pfn)
@@ -320,6 +409,9 @@ static void paravirt_ops_setup(void)
 		paravirt_ops.release_pd = kvm_release_pt;
 	}
 
+	if (do_hypercall_batching)
+		paravirt_ops.set_lazy_mode = kvm_set_lazy_mode;
+
 	paravirt_ops.paravirt_enabled = 1;
 }
 
@@ -365,6 +457,9 @@ static int paravirt_initialize(void)
 	if ((edx & KVM_FEATURE_MMU_WRITE))
 		do_mmu_write = 1;
 
+	if ((edx & KVM_FEATURE_HYPERCALL_BATCHING))
+		do_hypercall_batching = 1;
+
 	on_each_cpu(paravirt_activate, NULL, 0, 1);
 
 	return 0;
@@ -375,6 +470,9 @@ static __init void paravirt_free_state(struct kvm_paravirt_state *state)
 	if (!state)
 		return;
 
+	if (state->queue)
+		__free_page(pfn_to_page(__pa(state->queue) >> PAGE_SHIFT));
+
 	if (state->hypercall)
 		__free_page(pfn_to_page(__pa(state->hypercall) >> PAGE_SHIFT));
 
@@ -401,8 +499,15 @@ static __init struct kvm_paravirt_state *paravirt_alloc_state(void)
 	if (!state->hypercall)
 		goto err;
 
+	state->queue = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!state->queue)
+		goto err;
+
 	state->vmca_gpa = __pa(state->vmca);
 	state->vmca->hypercall_gpa = __pa(state->hypercall);
+	state->queue_index = 0;
+	state->max_queue_index
+		= (PAGE_SIZE / sizeof(struct kvm_hypercall_entry));
 
 	return state;
 
diff --git a/drivers/kvm/kvm.h b/drivers/kvm/kvm.h
index 9a7462a..7e53374 100644
--- a/drivers/kvm/kvm.h
+++ b/drivers/kvm/kvm.h
@@ -291,6 +291,7 @@ struct kvm_vcpu {
 	gpa_t para_state_gpa;
 	struct page *para_state_page;
 	gpa_t hypercall_gpa;
+	struct page *queue_page;
 	unsigned long cr4;
 	unsigned long cr8;
 	u64 pdptrs[4]; /* pae */
diff --git a/drivers/kvm/kvm_main.c b/drivers/kvm/kvm_main.c
index 91aec56..e3afbde 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -96,7 +96,7 @@ struct vfsmount *kvmfs_mnt;
 #define KVM_PARAVIRT_FEATURES \
 	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY | \
 	 KVM_FEATURE_PARAVIRT_CLOCK | KVM_FEATURE_CR_READ_CACHE | \
-	 KVM_FEATURE_MMU_WRITE)
+	 KVM_FEATURE_MMU_WRITE | KVM_FEATURE_HYPERCALL_BATCHING)
 
 #define KVM_MSR_SET_VMCA	0x87655678
 
@@ -1410,6 +1410,24 @@ static int kvm_hypercall_release_pt(struct kvm_vcpu *vcpu, gpa_t addr)
 	return 0;
 }
 
+static int kvm_hypercall_set_cr(struct kvm_vcpu *vcpu,
+				u32 reg, unsigned long value)
+{
+	switch (reg) {
+	case 0:
+		set_cr0(vcpu, value);
+		break;
+	case 3:
+		set_cr3(vcpu, value);
+		break;
+	case 4:
+		set_cr4(vcpu, value);
+		break;
+	}
+
+	return 0;
+}
+
 static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 			      unsigned long p1, unsigned long p2,
 			      unsigned long p3, unsigned long p4)
@@ -1419,6 +1437,8 @@ static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 		return kvm_hypercall_mmu_write(vcpu, p1, p2, p3, p4);
 	case KVM_HYPERCALL_UPDATE_TIME:
 		return kvm_hypercall_update_time(vcpu);
+	case KVM_HYPERCALL_SET_CR:
+		return kvm_hypercall_set_cr(vcpu, p1, p2);
 	case KVM_HYPERCALL_FLUSH_TLB:
 		return kvm_hypercall_flush_tlb(vcpu);
 	case KVM_HYPERCALL_FLUSH_TLB_SINGLE:
@@ -1429,6 +1449,39 @@ static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 	return -KVM_ENOSYS;
 }
 
+static int kvm_hypercall_flush(struct kvm_vcpu *vcpu, gva_t addr, u32 nb_queue)
+{
+	struct kvm_hypercall_entry *queue;
+	struct page *queue_page;
+	hpa_t queue_hpa;
+	int ret = 0;
+	int i;
+
+	if (nb_queue > (PAGE_SIZE / sizeof(struct kvm_hypercall_entry)))
+		return -KVM_EFAULT;
+
+	queue_hpa = gpa_to_hpa(vcpu, addr);
+	if (is_error_hpa(queue_hpa))
+		return -KVM_EFAULT;
+
+	queue_page = pfn_to_page(queue_hpa >> PAGE_SHIFT);
+	queue = kmap(queue_page);
+
+	for (i = 0; i < nb_queue; i++)
+		ret |= dispatch_hypercall(vcpu, queue[i].nr, queue[i].p1,
+					  queue[i].p2, queue[i].p3,
+					  queue[i].p4);
+
+	if (ret < 0)
+		ret = -KVM_EINVAL;
+	else
+		ret = 0;
+
+	kunmap(queue_page);
+
+	return ret;
+}
+
 int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	unsigned long nr, a0, a1, a2, a3, a4, a5, ret;
@@ -1456,7 +1509,11 @@ int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		a5 = vcpu->regs[VCPU_REGS_RBP] & -1u;
 	}
 
-	ret = dispatch_hypercall(vcpu, nr, a0, a1, a2, a3);
+	if (nr == KVM_HYPERCALL_FLUSH)
+		ret = kvm_hypercall_flush(vcpu, a0, a1);
+	else
+		ret = dispatch_hypercall(vcpu, nr, a0, a1, a2, a3);
+
 	if (ret == -KVM_ENOSYS) {
 		run->hypercall.args[0] = a0;
 		run->hypercall.args[1] = a1;
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 560de6a..e220832 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -27,6 +27,7 @@ static int __init kvm_guest_init(void)
 #define KVM_FEATURE_PARAVIRT_CLOCK	(1UL << 2)
 #define KVM_FEATURE_CR_READ_CACHE	(1UL << 3)
 #define KVM_FEATURE_MMU_WRITE		(1UL << 4)
+#define KVM_FEATURE_HYPERCALL_BATCHING	(1UL << 5)
 
 struct kvm_vmca
 {
@@ -34,6 +35,15 @@ struct kvm_vmca
 	u64 real_nsecs;
 };
 
+struct kvm_hypercall_entry
+{
+	unsigned long nr;
+	unsigned long p1;
+	unsigned long p2;
+	unsigned long p3;
+	unsigned long p4;
+};
+
 /*
  * Hypercall calling convention:
  *
@@ -55,5 +65,7 @@ struct kvm_vmca
 #define KVM_HYPERCALL_FLUSH_TLB		2
 #define KVM_HYPERCALL_FLUSH_TLB_SINGLE	3
 #define KVM_HYPERCALL_RELEASE_PT	4
+#define KVM_HYPERCALL_SET_CR		5
+#define KVM_HYPERCALL_FLUSH		6
 
 #endif

--------------030304040703020109030302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------030304040703020109030302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------030304040703020109030302--
