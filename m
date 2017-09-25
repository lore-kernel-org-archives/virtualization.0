From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 4/4] KVM/vmx: enable lbr for the guest
Date: Mon, 25 Sep 2017 11:16:57 +0200
Message-ID: <d4a81b5d-87ec-d118-112f-b017e58aa6e7__22204.9037729905$1506331052$gmane$org@redhat.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<1506314696-4632-5-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506314696-4632-5-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, ak@linux.intel.com, mingo@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 25/09/2017 06:44, Wei Wang wrote:
> Passthrough the LBR stack to the guest, and auto switch the stack MSRs
> upon VMEntry and VMExit.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

This has to be enabled separately for each guest, because it may prevent
live migration to hosts with a different family/model.

Paolo

> ---
>  arch/x86/kvm/vmx.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 5f5c2f1..35e02a7 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -107,6 +107,9 @@ static u64 __read_mostly host_xss;
>  static bool __read_mostly enable_pml = 1;
>  module_param_named(pml, enable_pml, bool, S_IRUGO);
>  
> +static bool __read_mostly enable_lbrv = 1;
> +module_param_named(lbrv, enable_lbrv, bool, 0444);
> +
>  #define KVM_VMX_TSC_MULTIPLIER_MAX     0xffffffffffffffffULL
>  
>  /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
> @@ -5428,6 +5431,25 @@ static void ept_set_mmio_spte_mask(void)
>  				   VMX_EPT_MISCONFIG_WX_VALUE);
>  }
>  
> +static void auto_switch_lbr_msrs(struct vcpu_vmx *vmx)
> +{
> +	int i;
> +	struct perf_lbr_stack lbr_stack;
> +
> +	perf_get_lbr_stack(&lbr_stack);
> +
> +	add_atomic_switch_msr(vmx, MSR_LBR_SELECT, 0, 0);
> +	add_atomic_switch_msr(vmx, lbr_stack.lbr_tos, 0, 0);
> +
> +	for (i = 0; i < lbr_stack.lbr_nr; i++) {
> +		add_atomic_switch_msr(vmx, lbr_stack.lbr_from + i, 0, 0);
> +		add_atomic_switch_msr(vmx, lbr_stack.lbr_to + i, 0, 0);
> +		if (lbr_stack.lbr_info)
> +			add_atomic_switch_msr(vmx, lbr_stack.lbr_info + i, 0,
> +					      0);
> +	}
> +}
> +
>  #define VMX_XSS_EXIT_BITMAP 0
>  /*
>   * Sets up the vmcs for emulated real mode.
> @@ -5508,6 +5530,9 @@ static int vmx_vcpu_setup(struct vcpu_vmx *vmx)
>  
>  	add_atomic_switch_msr(vmx, MSR_IA32_DEBUGCTLMSR, 0, 0);
>  
> +	if (enable_lbrv)
> +		auto_switch_lbr_msrs(vmx);
> +
>  	if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT)
>  		vmcs_write64(GUEST_IA32_PAT, vmx->vcpu.arch.pat);
>  
> @@ -6721,6 +6746,28 @@ void vmx_enable_tdp(void)
>  	kvm_enable_tdp();
>  }
>  
> +static void vmx_passthrough_lbr_msrs(void)
> +{
> +	int i;
> +	struct perf_lbr_stack lbr_stack;
> +
> +	if (perf_get_lbr_stack(&lbr_stack) < 0) {
> +		enable_lbrv = false;
> +		return;
> +	}
> +
> +	vmx_disable_intercept_for_msr(MSR_LBR_SELECT, false);
> +	vmx_disable_intercept_for_msr(lbr_stack.lbr_tos, false);
> +
> +	for (i = 0; i < lbr_stack.lbr_nr; i++) {
> +		vmx_disable_intercept_for_msr(lbr_stack.lbr_from + i, false);
> +		vmx_disable_intercept_for_msr(lbr_stack.lbr_to + i, false);
> +		if (lbr_stack.lbr_info)
> +			vmx_disable_intercept_for_msr(lbr_stack.lbr_info + i,
> +						      false);
> +	}
> +}
> +
>  static __init int hardware_setup(void)
>  {
>  	int r = -ENOMEM, i, msr;
> @@ -6822,6 +6869,9 @@ static __init int hardware_setup(void)
>  	vmx_disable_intercept_for_msr(MSR_IA32_SYSENTER_EIP, false);
>  	vmx_disable_intercept_for_msr(MSR_IA32_DEBUGCTLMSR, false);
>  
> +	if (enable_lbrv)
> +		vmx_passthrough_lbr_msrs();
> +
>  	memcpy(vmx_msr_bitmap_legacy_x2apic_apicv,
>  			vmx_msr_bitmap_legacy, PAGE_SIZE);
>  	memcpy(vmx_msr_bitmap_longmode_x2apic_apicv,
> 
