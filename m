From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 3/5] KVM: Add paravirt MMU write support
Date: Sun, 17 Jun 2007 22:00:03 -0500
Message-ID: <4675F533.40809@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050409030800090804060502"
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
--------------050409030800090804060502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------050409030800090804060502
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
index 89e83a4..07ce38e 100644
--- a/arch/i386/kernel/kvm.c
+++ b/arch/i386/kernel/kvm.c
@@ -42,6 +42,7 @@ struct kvm_paravirt_state
 
 static DEFINE_PER_CPU(struct kvm_paravirt_state *, paravirt_state);
 
+static int do_mmu_write;
 static int do_cr_read_caching;
 static int do_nop_io_delay;
 static u64 msr_set_vmca;
@@ -154,6 +155,69 @@ static void kvm_write_cr4(unsigned long value)
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
+	pte_t pte = {0};
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
+	pmd_t pmd = {0};
+	kvm_mmu_write(pmdp, &pmd, sizeof(pmd));
+}
+
 static void paravirt_ops_setup(void)
 {
 	paravirt_ops.name = "KVM";
@@ -174,6 +238,17 @@ static void paravirt_ops_setup(void)
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
+	}
+
 	paravirt_ops.paravirt_enabled = 1;
 
 	apply_paravirt(__parainstructions, __parainstructions_end);
@@ -215,6 +290,9 @@ static int paravirt_initialize(void)
 	if ((edx & KVM_FEATURE_CR_READ_CACHE))
 		do_cr_read_caching = 1;
 
+	if ((edx & KVM_FEATURE_MMU_WRITE))
+		do_mmu_write = 1;
+
 	on_each_cpu(paravirt_activate, NULL, 0, 1);
 
 	return 0;
diff --git a/drivers/kvm/kvm_main.c b/drivers/kvm/kvm_main.c
index 7b57431..4f65729 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -94,7 +94,7 @@ struct vfsmount *kvmfs_mnt;
 
 #define KVM_PARAVIRT_FEATURES \
 	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY | \
-	 KVM_FEATURE_CR_READ_CACHE)
+	 KVM_FEATURE_CR_READ_CACHE | KVM_FEATURE_MMU_WRITE)
 
 #define KVM_MSR_SET_VMCA	0x87655678
 
@@ -1347,10 +1347,36 @@ int kvm_emulate_halt(struct kvm_vcpu *vcpu)
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
+		return -EFAULT;
+	if (size == 1) {
+		if (!emulator_write_phys(vcpu, gpa, &a0, sizeof(a0)))
+			return -EFAULT;
+	} else if (size == 2) {
+		value = (u64)a1 << 32 | a0;
+		if (!emulator_write_phys(vcpu, gpa, &value, sizeof(value)))
+			return -EFAULT;
+	} else
+		return -E2BIG;
+
+	return 0;
+}
+
 static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 			      unsigned long p1, unsigned long p2,
 			      unsigned long p3, unsigned long p4)
 {
+	switch (nr) {
+	case KVM_HYPERCALL_MMU_WRITE:
+		return kvm_hypercall_mmu_write(vcpu, p1, p2, p3, p4);
+	}
 	return -ENOSYS;
 }
 
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index 121a09c..e8ff676 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -14,6 +14,7 @@
 #define KVM_FEATURE_VMCA		(1UL << 0)
 #define KVM_FEATURE_NOP_IO_DELAY	(1UL << 1)
 #define KVM_FEATURE_CR_READ_CACHE	(1UL << 2)
+#define KVM_FEATURE_MMU_WRITE		(1UL << 3)
 
 struct kvm_vmca
 {
@@ -31,4 +32,6 @@ struct kvm_vmca
  * return value is in RAX.
  */
 
+#define KVM_HYPERCALL_MMU_WRITE		0
+
 #endif

--------------050409030800090804060502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------050409030800090804060502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------050409030800090804060502--
