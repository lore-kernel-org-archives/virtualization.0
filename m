From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 1/4] KVM/vmx: re-write the msr auto switch feature
Date: Mon, 25 Sep 2017 12:44:53 +0800
Message-ID: <1506314696-4632-2-git-send-email-wei.w.wang__14187.4915258542$1506315529$gmane$org@intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, mst@redhat.com, rkrcmar@redhat.com, ak@linux.intel.com, mingo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This patch clarifies a vague statement in the SDM: the recommended maximum
number of MSRs that can be automically switched by CPU during VMExit and
VMEntry is 512, rather than 512 Bytes of MSRs.

Depending on the CPU implementations, it may also support more than 512
MSRs to be auto switched. This can be calculated by
(MSR_IA32_VMX_MISC[27:25] + 1) * 512.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 arch/x86/kvm/vmx.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 0726ca7..8434fc8 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -158,6 +158,7 @@ module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
 #define KVM_VMX_DEFAULT_PLE_WINDOW_SHRINK 0
 #define KVM_VMX_DEFAULT_PLE_WINDOW_MAX    \
 		INT_MAX / KVM_VMX_DEFAULT_PLE_WINDOW_GROW
+#define KVM_VMX_DEFAULT_MSR_AUTO_LOAD_COUNT 512
 
 static int ple_gap = KVM_VMX_DEFAULT_PLE_GAP;
 module_param(ple_gap, int, S_IRUGO);
@@ -178,9 +179,10 @@ static int ple_window_actual_max = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
 static int ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
 module_param(ple_window_max, int, S_IRUGO);
 
+static int msr_autoload_count_max = KVM_VMX_DEFAULT_MSR_AUTO_LOAD_COUNT;
+
 extern const ulong vmx_return;
 
-#define NR_AUTOLOAD_MSRS 8
 #define VMCS02_POOL_SIZE 1
 
 struct vmcs {
@@ -588,8 +590,8 @@ struct vcpu_vmx {
 	bool                  __launched; /* temporary, used in vmx_vcpu_run */
 	struct msr_autoload {
 		unsigned nr;
-		struct vmx_msr_entry guest[NR_AUTOLOAD_MSRS];
-		struct vmx_msr_entry host[NR_AUTOLOAD_MSRS];
+		struct vmx_msr_entry *guest;
+		struct vmx_msr_entry *host;
 	} msr_autoload;
 	struct {
 		int           loaded;
@@ -1942,6 +1944,7 @@ static void clear_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr)
 	m->host[i] = m->host[m->nr];
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->nr);
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->nr);
+	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, m->nr);
 }
 
 static void add_atomic_switch_msr_special(struct vcpu_vmx *vmx,
@@ -1997,7 +2000,7 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 		if (m->guest[i].index == msr)
 			break;
 
-	if (i == NR_AUTOLOAD_MSRS) {
+	if (i == msr_autoload_count_max) {
 		printk_once(KERN_WARNING "Not enough msr switch entries. "
 				"Can't add msr %x\n", msr);
 		return;
@@ -2005,6 +2008,7 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 		++m->nr;
 		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->nr);
 		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->nr);
+		vmcs_write32(VM_EXIT_MSR_STORE_COUNT, m->nr);
 	}
 
 	m->guest[i].index = msr;
@@ -5501,6 +5505,7 @@ static int vmx_vcpu_setup(struct vcpu_vmx *vmx)
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, 0);
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, 0);
 	vmcs_write64(VM_EXIT_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.host));
+	vmcs_write64(VM_EXIT_MSR_STORE_ADDR, __pa(vmx->msr_autoload.guest));
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, 0);
 	vmcs_write64(VM_ENTRY_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.guest));
 
@@ -6670,6 +6675,21 @@ static void update_ple_window_actual_max(void)
 			                    ple_window_grow, INT_MIN);
 }
 
+static void update_msr_autoload_count_max(void)
+{
+	u64 vmx_msr;
+	int n;
+
+	/*
+	 * According to the Intel SDM, if Bits 27:25 of MSR_IA32_VMX_MISC is
+	 * n, then (n + 1) * 512 is the recommended max number of MSRs to be
+	 * included in the VMExit and VMEntry MSR auto switch list.
+	 */
+	rdmsrl(MSR_IA32_VMX_MISC, vmx_msr);
+	n = ((vmx_msr & 0xe000000) >> 25) + 1;
+	msr_autoload_count_max = n * KVM_VMX_DEFAULT_MSR_AUTO_LOAD_COUNT;
+}
+
 /*
  * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
  */
@@ -6837,6 +6857,7 @@ static __init int hardware_setup(void)
 		kvm_disable_tdp();
 
 	update_ple_window_actual_max();
+	update_msr_autoload_count_max();
 
 	/*
 	 * Only enable PML when hardware supports PML feature, and both EPT
@@ -9248,6 +9269,19 @@ static void vmx_arm_hv_timer(struct kvm_vcpu *vcpu)
 	vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
 }
 
+/*
+ * Currently, the CPU does not support the auto save of MSRs on VMEntry, so we
+ * save the MSRs for the host before entering into guest.
+ */
+static void vmx_save_host_msrs(struct msr_autoload *m)
+
+{
+	u32 i;
+
+	for (i = 0; i < m->nr; i++)
+		m->host[i].value = __rdmsr(m->host[i].index);
+}
+
 static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -9304,6 +9338,8 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	vmx_arm_hv_timer(vcpu);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
+
+	vmx_save_host_msrs(&vmx->msr_autoload);
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
@@ -9504,6 +9540,7 @@ static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
 static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	size_t bytes = msr_autoload_count_max * sizeof(struct vmx_msr_entry);
 
 	if (enable_pml)
 		vmx_destroy_pml_buffer(vmx);
@@ -9512,15 +9549,17 @@ static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 	vmx_free_vcpu_nested(vcpu);
 	free_loaded_vmcs(vmx->loaded_vmcs);
 	kfree(vmx->guest_msrs);
+	free_pages_exact(vmx->msr_autoload.host, bytes);
+	free_pages_exact(vmx->msr_autoload.guest, bytes);
 	kvm_vcpu_uninit(vcpu);
 	kmem_cache_free(kvm_vcpu_cache, vmx);
 }
 
 static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 {
-	int err;
+	int err, cpu;
+	size_t bytes;
 	struct vcpu_vmx *vmx = kmem_cache_zalloc(kvm_vcpu_cache, GFP_KERNEL);
-	int cpu;
 
 	if (!vmx)
 		return ERR_PTR(-ENOMEM);
@@ -9559,6 +9598,17 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 		goto free_msrs;
 	loaded_vmcs_init(vmx->loaded_vmcs);
 
+	bytes = msr_autoload_count_max * sizeof(struct vmx_msr_entry);
+	vmx->msr_autoload.guest = alloc_pages_exact(bytes,
+						    GFP_KERNEL | __GFP_ZERO);
+	if (!vmx->msr_autoload.guest)
+		goto free_vmcs;
+
+	vmx->msr_autoload.host = alloc_pages_exact(bytes,
+						   GFP_KERNEL | __GFP_ZERO);
+	if (!vmx->msr_autoload.guest)
+		goto free_autoload_guest;
+
 	cpu = get_cpu();
 	vmx_vcpu_load(&vmx->vcpu, cpu);
 	vmx->vcpu.cpu = cpu;
@@ -9566,11 +9616,11 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx_vcpu_put(&vmx->vcpu);
 	put_cpu();
 	if (err)
-		goto free_vmcs;
+		goto free_autoload_host;
 	if (cpu_need_virtualize_apic_accesses(&vmx->vcpu)) {
 		err = alloc_apic_access_page(kvm);
 		if (err)
-			goto free_vmcs;
+			goto free_autoload_host;
 	}
 
 	if (enable_ept) {
@@ -9579,7 +9629,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 				VMX_EPT_IDENTITY_PAGETABLE_ADDR;
 		err = init_rmode_identity_map(kvm);
 		if (err)
-			goto free_vmcs;
+			goto free_autoload_host;
 	}
 
 	if (nested) {
@@ -9594,6 +9644,10 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 
 	return &vmx->vcpu;
 
+free_autoload_host:
+	free_pages_exact(vmx->msr_autoload.host, bytes);
+free_autoload_guest:
+	free_pages_exact(vmx->msr_autoload.guest, bytes);
 free_vmcs:
 	free_vpid(vmx->nested.vpid02);
 	free_loaded_vmcs(vmx->loaded_vmcs);
-- 
2.7.4
