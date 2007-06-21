From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 4/5] KVM: Add paravirt MMU write support
Date: Wed, 20 Jun 2007 22:08:38 -0500
Message-ID: <4679EBB6.5060902@codemonkey.ws>
References: <4679EAAF.2060103@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060405080607060206070301"
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
--------------060405080607060206070301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------060405080607060206070301
Content-Type: text/x-patch;
 name="kvm-mmu-write.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-mmu-write.diff"

Subject: [PATCH] KVM: Add paravirt MMU write support
Author: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

On at least AMD hardware, hypercall based manipulation of page table memory
is significantly faster than taking a page fault.  Additionally, using
hypercalls to manipulation page table memory provides the infrastructure needed
to do lazy MMU updates.

Signed-off-by: Anthony Liguori <aliguori-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

diff --git a/arch/i386/kernel/kvm.c b/arch/i386/kernel/kvm.c
index bf77159..21133e4 100644
--- a/arch/i386/kernel/kvm.c
+++ b/arch/i386/kernel/kvm.c
@@ -25,6 +25,7 @@
 #include <linux/kvm_para.h>
 #include <linux/cpu.h>
 #include <linux/mm.h>
+#include <asm/tlbflush.h>
 
 #include <linux/clocksource.h>
 #include <linux/workqueue.h>
@@ -54,6 +55,7 @@ struct kvm_paravirt_state
 
 static DEFINE_PER_CPU(struct kvm_paravirt_state *, paravirt_state);
 
+static int do_mmu_write;
 static int do_cr_read_caching;
 static int do_nop_io_delay;
 static int do_paravirt_clock;
@@ -197,6 +199,84 @@ static void kvm_write_cr4(unsigned long value)
 	kvm_write_cr(4, value);
 }
 
+static void kvm_mmu_write(void *dest, const void *src, size_t size)
+{
+	const uint8_t *p = src;
+	u32 a1 = 0;
+
+	size >>= 2;
+	if (size == 2)
+		a1 = *(u32 *)&p[4];
+
+	kvm_hypercall(KVM_HYPERCALL_MMU_WRITE, (u32)dest, size, *(u32 *)p, a1);
+}
+
+/*
+ * We only need to hook operations that are MMU writes.  We hook these so that
+ * we can use lazy MMU mode to batch these operations.  We could probably
+ * improve the performance of the host code if we used some of the information
+ * here to simplify processing of batched writes.
+ */
+static void kvm_set_pte(pte_t *ptep, pte_t pte)
+{
+	kvm_mmu_write(ptep, &pte, sizeof(pte));
+}
+
+static void kvm_set_pte_at(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, pte_t pte)
+{
+	kvm_mmu_write(ptep, &pte, sizeof(pte));
+}
+
+static void kvm_set_pte_atomic(pte_t *ptep, pte_t pte)
+{
+	kvm_mmu_write(ptep, &pte, sizeof(pte));
+}
+
+static void kvm_set_pte_present(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte)
+{
+	kvm_mmu_write(ptep, &pte, sizeof(pte));
+}
+
+static void kvm_pte_clear(struct mm_struct *mm,
+			  unsigned long addr, pte_t *ptep)
+{
+	pte_t pte = __pte(0);
+	kvm_mmu_write(ptep, &pte, sizeof(pte));
+}
+
+static void kvm_set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	kvm_mmu_write(pmdp, &pmd, sizeof(pmd));
+}
+
+static void kvm_set_pud(pud_t *pudp, pud_t pud)
+{
+	kvm_mmu_write(pudp, &pud, sizeof(pud));
+}
+
+static void kvm_pmd_clear(pmd_t *pmdp)
+{
+	pmd_t pmd = __pmd(0);
+	kvm_mmu_write(pmdp, &pmd, sizeof(pmd));
+}
+
+static void kvm_flush_tlb(void)
+{
+	kvm_hypercall(KVM_HYPERCALL_FLUSH_TLB, 0, 0, 0, 0);
+}
+
+static void kvm_flush_tlb_single(unsigned long addr)
+{
+	kvm_hypercall(KVM_HYPERCALL_FLUSH_TLB_SINGLE, addr, 0, 0, 0);
+}
+
+static void kvm_release_pt(u32 pfn)
+{
+	kvm_hypercall(KVM_HYPERCALL_RELEASE_PT, pfn << PAGE_SHIFT, 0, 0, 0);
+}
+
 static void paravirt_ops_setup(void)
 {
 	paravirt_ops.name = "KVM";
@@ -225,6 +305,21 @@ static void paravirt_ops_setup(void)
 		paravirt_ops.read_cr4_safe = kvm_read_cr4;
 	}
 
+	if (do_mmu_write) {
+		paravirt_ops.set_pte = kvm_set_pte;
+		paravirt_ops.set_pte_at = kvm_set_pte_at;
+		paravirt_ops.set_pte_atomic = kvm_set_pte_atomic;
+		paravirt_ops.set_pte_present = kvm_set_pte_present;
+		paravirt_ops.pte_clear = kvm_pte_clear;
+		paravirt_ops.set_pmd = kvm_set_pmd;
+		paravirt_ops.pmd_clear = kvm_pmd_clear;
+		paravirt_ops.set_pud = kvm_set_pud;
+		paravirt_ops.flush_tlb_user = kvm_flush_tlb;
+		paravirt_ops.flush_tlb_single = kvm_flush_tlb_single;
+		paravirt_ops.release_pt = kvm_release_pt;
+		paravirt_ops.release_pd = kvm_release_pt;
+	}
+
 	paravirt_ops.paravirt_enabled = 1;
 }
 
@@ -267,6 +362,9 @@ static int paravirt_initialize(void)
 	if ((edx & KVM_FEATURE_CR_READ_CACHE))
 		do_cr_read_caching = 1;
 
+	if ((edx & KVM_FEATURE_MMU_WRITE))
+		do_mmu_write = 1;
+
 	on_each_cpu(paravirt_activate, NULL, 0, 1);
 
 	return 0;
diff --git a/drivers/kvm/kvm.h b/drivers/kvm/kvm.h
index b08272b..9a7462a 100644
--- a/drivers/kvm/kvm.h
+++ b/drivers/kvm/kvm.h
@@ -538,6 +538,7 @@ void kvm_resched(struct kvm_vcpu *vcpu);
 void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
 void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
 void kvm_flush_remote_tlbs(struct kvm *kvm);
+void mmu_unshadow(struct kvm_vcpu *vcpu, gfn_t gfn);
 
 int kvm_read_guest(struct kvm_vcpu *vcpu,
 	       gva_t addr,
diff --git a/drivers/kvm/kvm_main.c b/drivers/kvm/kvm_main.c
index 35d73b8..91aec56 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -95,7 +95,8 @@ struct vfsmount *kvmfs_mnt;
 
 #define KVM_PARAVIRT_FEATURES \
 	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY | \
-	 KVM_FEATURE_PARAVIRT_CLOCK | KVM_FEATURE_CR_READ_CACHE)
+	 KVM_FEATURE_PARAVIRT_CLOCK | KVM_FEATURE_CR_READ_CACHE | \
+	 KVM_FEATURE_MMU_WRITE)
 
 #define KVM_MSR_SET_VMCA	0x87655678
 
@@ -1348,6 +1349,28 @@ int kvm_emulate_halt(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_halt);
 
+static int kvm_hypercall_mmu_write(struct kvm_vcpu *vcpu, gva_t addr,
+				   unsigned long size, unsigned long a0,
+				   unsigned long a1)
+{
+	gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, addr);
+	u64 value;
+
+	if (gpa == UNMAPPED_GVA)
+		return -KVM_EFAULT;
+	if (size == 1) {
+		if (!emulator_write_phys(vcpu, gpa, &a0, sizeof(a0)))
+			return -KVM_EFAULT;
+	} else if (size == 2) {
+		value = (u64)a1 << 32 | a0;
+		if (!emulator_write_phys(vcpu, gpa, &value, sizeof(value)))
+			return -KVM_EFAULT;
+	} else
+		return -KVM_E2BIG;
+
+	return 0;
+}
+
 static int kvm_hypercall_update_time(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vmca *vmca;
@@ -1368,13 +1391,40 @@ static int kvm_hypercall_update_time(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int kvm_hypercall_flush_tlb(struct kvm_vcpu *vcpu)
+{
+	kvm_arch_ops->tlb_flush(vcpu);
+	return 0;
+}
+
+static int kvm_hypercall_flush_tlb_single(struct kvm_vcpu *vcpu, gva_t addr)
+{
+	if (kvm_arch_ops->invlpg)
+		kvm_arch_ops->invlpg(vcpu, addr);
+	return 0;
+}
+
+static int kvm_hypercall_release_pt(struct kvm_vcpu *vcpu, gpa_t addr)
+{
+	mmu_unshadow(vcpu, addr >> PAGE_SHIFT);
+	return 0;
+}
+
 static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 			      unsigned long p1, unsigned long p2,
 			      unsigned long p3, unsigned long p4)
 {
 	switch (nr) {
+	case KVM_HYPERCALL_MMU_WRITE:
+		return kvm_hypercall_mmu_write(vcpu, p1, p2, p3, p4);
 	case KVM_HYPERCALL_UPDATE_TIME:
 		return kvm_hypercall_update_time(vcpu);
+	case KVM_HYPERCALL_FLUSH_TLB:
+		return kvm_hypercall_flush_tlb(vcpu);
+	case KVM_HYPERCALL_FLUSH_TLB_SINGLE:
+		return kvm_hypercall_flush_tlb_single(vcpu, p1);
+	case KVM_HYPERCALL_RELEASE_PT:
+		return kvm_hypercall_release_pt(vcpu, p1);
 	}
 	return -KVM_ENOSYS;
 }
diff --git a/drivers/kvm/mmu.c b/drivers/kvm/mmu.c
index ad50cfd..1581286 100644
--- a/drivers/kvm/mmu.c
+++ b/drivers/kvm/mmu.c
@@ -728,7 +728,7 @@ static int kvm_mmu_unprotect_page(struct kvm_vcpu *vcpu, gfn_t gfn)
 	return r;
 }
 
-static void mmu_unshadow(struct kvm_vcpu *vcpu, gfn_t gfn)
+void mmu_unshadow(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	struct kvm_mmu_page *page;
 
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index d4aa7e8..560de6a 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -26,6 +26,7 @@ static int __init kvm_guest_init(void)
 #define KVM_FEATURE_NOP_IO_DELAY	(1UL << 1)
 #define KVM_FEATURE_PARAVIRT_CLOCK	(1UL << 2)
 #define KVM_FEATURE_CR_READ_CACHE	(1UL << 3)
+#define KVM_FEATURE_MMU_WRITE		(1UL << 4)
 
 struct kvm_vmca
 {
@@ -46,7 +47,13 @@ struct kvm_vmca
 
 #define KVM_ENOSYS	ENOSYS
 #define KVM_EINVAL	EINVAL
+#define KVM_EFAULT	EFAULT
+#define KVM_E2BIG	E2BIG
 
 #define KVM_HYPERCALL_UPDATE_TIME	0
+#define KVM_HYPERCALL_MMU_WRITE		1
+#define KVM_HYPERCALL_FLUSH_TLB		2
+#define KVM_HYPERCALL_FLUSH_TLB_SINGLE	3
+#define KVM_HYPERCALL_RELEASE_PT	4
 
 #endif

--------------060405080607060206070301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------060405080607060206070301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------060405080607060206070301--
