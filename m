From: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 2/4] KVM/vmx: auto switch MSR_IA32_DEBUGCTLMSR
Date: Mon, 25 Sep 2017 12:44:54 +0800
Message-ID: <1506314696-4632-3-git-send-email-wei.w.wang@intel.com>
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

Passthrough the MSR_IA32_DEBUGCTLMSR to the guest, and take advantage of
the hardware VT-x feature to auto switch the msr upon VMExit and VMEntry.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 arch/x86/kvm/vmx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8434fc8..5f5c2f1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5502,13 +5502,12 @@ static int vmx_vcpu_setup(struct vcpu_vmx *vmx)
 	if (cpu_has_vmx_vmfunc())
 		vmcs_write64(VM_FUNCTION_CONTROL, 0);
 
-	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, 0);
-	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, 0);
 	vmcs_write64(VM_EXIT_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.host));
 	vmcs_write64(VM_EXIT_MSR_STORE_ADDR, __pa(vmx->msr_autoload.guest));
-	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, 0);
 	vmcs_write64(VM_ENTRY_MSR_LOAD_ADDR, __pa(vmx->msr_autoload.guest));
 
+	add_atomic_switch_msr(vmx, MSR_IA32_DEBUGCTLMSR, 0, 0);
+
 	if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT)
 		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
 
@@ -6821,6 +6820,7 @@ static __init int hardware_setup(void)
 	vmx_disable_intercept_for_msr(MSR_IA32_SYSENTER_CS, false);
 	vmx_disable_intercept_for_msr(MSR_IA32_SYSENTER_ESP, false);
 	vmx_disable_intercept_for_msr(MSR_IA32_SYSENTER_EIP, false);
+	vmx_disable_intercept_for_msr(MSR_IA32_DEBUGCTLMSR, false);
 
 	memcpy(vmx_msr_bitmap_legacy_x2apic_apicv,
 			vmx_msr_bitmap_legacy, PAGE_SIZE);
@@ -9285,7 +9285,7 @@ static void vmx_save_host_msrs(struct msr_autoload *m)
 static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned long debugctlmsr, cr3, cr4;
+	unsigned long cr3, cr4;
 
 	/* Don't enter VMX if guest state is invalid, let the exit handler
 	   start emulation until we arrive back to a valid state */
@@ -9333,7 +9333,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 		__write_pkru(vcpu->arch.pkru);
 
 	atomic_switch_perf_msrs(vmx);
-	debugctlmsr = get_debugctlmsr();
 
 	vmx_arm_hv_timer(vcpu);
 
@@ -9445,10 +9444,6 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 #endif
 	      );
 
-	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
-	if (debugctlmsr)
-		update_debugctlmsr(debugctlmsr);
-
 #ifndef CONFIG_X86_64
 	/*
 	 * The sysexit path does not restore ds/es, so we must set them to
-- 
2.7.4
