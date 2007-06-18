From: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Subject: [PATCH 4/5] KVM: Add hypercall queue for paravirt_ops
	implementation
Date: Sun, 17 Jun 2007 22:00:56 -0500
Message-ID: <4675F568.90608@codemonkey.ws>
References: <4675F462.1010708@codemonkey.ws>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040606050705060307080109"
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
--------------040606050705060307080109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------040606050705060307080109
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
index 07ce38e..4b323f1 100644
--- a/arch/i386/kernel/kvm.c
+++ b/arch/i386/kernel/kvm.c
@@ -33,8 +33,10 @@ struct kvm_paravirt_state
 	unsigned long cached_cr[5];
 	int cr_valid[5];
 
-	struct kvm_vmca *vmca;
+	enum paravirt_lazy_mode mode;
 	struct kvm_hypercall_entry *queue;
+
+	struct kvm_vmca *vmca;
 	void (*hypercall)(void);
 
 	u64 vmca_gpa;
@@ -42,17 +44,17 @@ struct kvm_paravirt_state
 
 static DEFINE_PER_CPU(struct kvm_paravirt_state *, paravirt_state);
 
+static int do_hypercall_batching;
 static int do_mmu_write;
 static int do_cr_read_caching;
 static int do_nop_io_delay;
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
@@ -69,6 +71,55 @@ static long kvm_hypercall(unsigned int nr, unsigned long p1,
 	return ret;
 }
 
+static int can_defer_hypercall(struct kvm_paravirt_state *state,
+			       unsigned int nr)
+{
+	if (state->mode == PARAVIRT_LAZY_MMU) {
+		if (nr == KVM_HYPERCALL_MMU_WRITE)
+			return 1;
+	} else if (state->mode == PARAVIRT_LAZY_CPU) {
+		if (nr == KVM_HYPERCALL_SET_CR)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void _kvm_hypercall_defer(struct kvm_paravirt_state *state,
+				 unsigned int nr,
+				 unsigned long p1, unsigned long p2,
+				 unsigned long p3, unsigned long p4)
+{
+	struct kvm_hypercall_entry *entry;
+
+	if (state->vmca->queue_index == state->vmca->max_queue_index)
+		_kvm_hypercall(state, KVM_HYPERCALL_FLUSH, 0, 0, 0, 0);
+
+	/* FIXME: are we preempt safe here? */
+	entry = &state->queue[state->vmca->queue_index++];
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
+	struct kvm_paravirt_state *state
+		= per_cpu(paravirt_state, smp_processor_id());
+	long ret = 0;
+
+	if (can_defer_hypercall(state, nr))
+		_kvm_hypercall_defer(state, nr, p1, p2, p3, p4);
+	else
+		ret = _kvm_hypercall(state, nr, p1, p2, p3, p4);
+
+	return ret;
+}
+
 /*
  * No need for any "IO delay" on KVM
  */
@@ -107,7 +158,9 @@ static void kvm_write_cr(int reg, unsigned long value)
 	state->cr_valid[reg] = 1;
 	state->cached_cr[reg] = value;
 
-	if (reg == 0)
+	if (state->mode == PARAVIRT_LAZY_CPU)
+		kvm_hypercall(KVM_HYPERCALL_SET_CR, reg, value, 0, 0);
+	else if (reg == 0)
 		native_write_cr0(value);
 	else if (reg == 3)
 		native_write_cr3(value);
@@ -218,6 +271,18 @@ static void kvm_pmd_clear(pmd_t *pmdp)
 	kvm_mmu_write(pmdp, &pmd, sizeof(pmd));
 }
 
+static void kvm_set_lazy_mode(enum paravirt_lazy_mode mode)
+{
+	struct kvm_paravirt_state *state
+		= per_cpu(paravirt_state, smp_processor_id());
+
+	if (mode == PARAVIRT_LAZY_FLUSH || mode == PARAVIRT_LAZY_NONE) {
+		if (state->vmca->queue_index)
+			_kvm_hypercall(state, KVM_HYPERCALL_FLUSH, 0, 0, 0, 0);
+	}
+	state->mode = mode;
+}
+
 static void paravirt_ops_setup(void)
 {
 	paravirt_ops.name = "KVM";
@@ -249,6 +314,9 @@ static void paravirt_ops_setup(void)
 		paravirt_ops.set_pud = kvm_set_pud;
 	}
 
+	if (do_hypercall_batching)
+		paravirt_ops.set_lazy_mode = kvm_set_lazy_mode;
+
 	paravirt_ops.paravirt_enabled = 1;
 
 	apply_paravirt(__parainstructions, __parainstructions_end);
@@ -293,6 +361,9 @@ static int paravirt_initialize(void)
 	if ((edx & KVM_FEATURE_MMU_WRITE))
 		do_mmu_write = 1;
 
+	if ((edx & KVM_FEATURE_HYPERCALL_BATCHING))
+		do_hypercall_batching = 1;
+
 	on_each_cpu(paravirt_activate, NULL, 0, 1);
 
 	return 0;
@@ -303,6 +374,9 @@ static __init void paravirt_free_state(struct kvm_paravirt_state *state)
 	if (!state)
 		return;
 
+	if (state->queue)
+		__free_page(pfn_to_page(__pa(state->queue) >> PAGE_SHIFT));
+
 	if (state->hypercall)
 		__free_page(pfn_to_page(__pa(state->hypercall) >> PAGE_SHIFT));
 
@@ -329,8 +403,15 @@ static __init struct kvm_paravirt_state *paravirt_alloc_state(void)
 	if (!state->hypercall)
 		goto err;
 
+	state->queue = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!state->queue)
+		goto err;
+
 	state->vmca_gpa = __pa(state->vmca);
 	state->vmca->hypercall_gpa = __pa(state->hypercall);
+	state->vmca->queue_gpa = __pa(state->queue);
+	state->vmca->max_queue_index
+		= (PAGE_SIZE / sizeof(struct kvm_hypercall_entry));
 
 	return state;
 
diff --git a/drivers/kvm/kvm.h b/drivers/kvm/kvm.h
index b08272b..d531899 100644
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
index 4f65729..79a2a64 100644
--- a/drivers/kvm/kvm_main.c
+++ b/drivers/kvm/kvm_main.c
@@ -94,7 +94,8 @@ struct vfsmount *kvmfs_mnt;
 
 #define KVM_PARAVIRT_FEATURES \
 	(KVM_FEATURE_VMCA | KVM_FEATURE_NOP_IO_DELAY | \
-	 KVM_FEATURE_CR_READ_CACHE | KVM_FEATURE_MMU_WRITE)
+	 KVM_FEATURE_CR_READ_CACHE | KVM_FEATURE_MMU_WRITE | \
+	 KVM_FEATURE_HYPERCALL_BATCHING)
 
 #define KVM_MSR_SET_VMCA	0x87655678
 
@@ -1369,6 +1370,24 @@ static int kvm_hypercall_mmu_write(struct kvm_vcpu *vcpu, gva_t addr,
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
@@ -1376,10 +1395,36 @@ static int dispatch_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 	switch (nr) {
 	case KVM_HYPERCALL_MMU_WRITE:
 		return kvm_hypercall_mmu_write(vcpu, p1, p2, p3, p4);
+	case KVM_HYPERCALL_SET_CR:
+		return kvm_hypercall_set_cr(vcpu, p1, p2);
 	}
 	return -ENOSYS;
 }
 
+static int kvm_hypercall_flush(struct kvm_vcpu *vcpu)
+{
+	struct kvm_hypercall_entry *queue;
+	struct kvm_vmca *vmca;
+	int ret = 0;
+	int i;
+
+	queue = kmap(vcpu->queue_page);
+	vmca = kmap(vcpu->para_state_page);
+
+	for (i = 0; i < vmca->queue_index; i++)
+		ret |= dispatch_hypercall(vcpu, queue[i].nr, queue[i].p1,
+					  queue[i].p2, queue[i].p3,
+					  queue[i].p4);
+
+	vmca->queue_index = 0;
+	mark_page_dirty(vcpu->kvm, vcpu->para_state_gpa >> PAGE_SHIFT);
+
+	kunmap(vcpu->para_state_page);
+	kunmap(vcpu->queue_page);
+
+	return ret;
+}
+
 int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
 	unsigned long nr, a0, a1, a2, a3, a4, a5, ret;
@@ -1407,7 +1452,11 @@ int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		a5 = vcpu->regs[VCPU_REGS_RBP] & -1u;
 	}
 
-	ret = dispatch_hypercall(vcpu, nr, a0, a1, a2, a3);
+	if (nr == KVM_HYPERCALL_FLUSH)
+		ret = kvm_hypercall_flush(vcpu);
+	else
+		ret = dispatch_hypercall(vcpu, nr, a0, a1, a2, a3);
+
 	if (ret == -ENOSYS) {
 		run->hypercall.args[0] = a0;
 		run->hypercall.args[1] = a1;
@@ -1498,8 +1547,8 @@ void realmode_set_cr(struct kvm_vcpu *vcpu, int cr, unsigned long val,
 static int vcpu_register_para(struct kvm_vcpu *vcpu, gpa_t para_state_gpa)
 {
 	struct kvm_vmca *para_state;
-	hpa_t para_state_hpa, hypercall_hpa;
-	struct page *para_state_page;
+	hpa_t para_state_hpa, hypercall_hpa, queue_hpa;
+	struct page *para_state_page, *queue_page;
 	unsigned char *hypercall;
 	gpa_t hypercall_gpa;
 
@@ -1526,10 +1575,16 @@ static int vcpu_register_para(struct kvm_vcpu *vcpu, gpa_t para_state_gpa)
 	if (is_error_hpa(hypercall_hpa))
 		goto err_kunmap_skip;
 
+	queue_hpa = gpa_to_hpa(vcpu, para_state->queue_gpa);
+	if (is_error_hpa(queue_hpa))
+		goto err_kunmap_skip;
+	queue_page = pfn_to_page(queue_hpa >> PAGE_SHIFT);
+
 	printk(KERN_DEBUG "kvm: para guest successfully registered.\n");
 	vcpu->para_state_page = para_state_page;
 	vcpu->para_state_gpa = para_state_gpa;
 	vcpu->hypercall_gpa = hypercall_gpa;
+	vcpu->queue_page = queue_page;
 
 	mark_page_dirty(vcpu->kvm, hypercall_gpa >> PAGE_SHIFT);
 	hypercall = kmap_atomic(pfn_to_page(hypercall_hpa >> PAGE_SHIFT),
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index e8ff676..7dd0cef 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -15,10 +15,23 @@
 #define KVM_FEATURE_NOP_IO_DELAY	(1UL << 1)
 #define KVM_FEATURE_CR_READ_CACHE	(1UL << 2)
 #define KVM_FEATURE_MMU_WRITE		(1UL << 3)
+#define KVM_FEATURE_HYPERCALL_BATCHING	(1UL << 4)
 
 struct kvm_vmca
 {
 	u64 hypercall_gpa;
+	u64 queue_gpa;
+	u32 queue_index;
+	u32 max_queue_index;
+};
+
+struct kvm_hypercall_entry
+{
+	unsigned long nr;
+	unsigned long p1;
+	unsigned long p2;
+	unsigned long p3;
+	unsigned long p4;
 };
 
 /*
@@ -33,5 +46,7 @@ struct kvm_vmca
  */
 
 #define KVM_HYPERCALL_MMU_WRITE		0
+#define KVM_HYPERCALL_SET_CR		1
+#define KVM_HYPERCALL_FLUSH		2
 
 #endif

--------------040606050705060307080109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------040606050705060307080109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kvm-devel mailing list
kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/kvm-devel

--------------040606050705060307080109--
