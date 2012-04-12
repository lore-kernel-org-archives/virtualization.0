From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH RFC V5 3/6] kvm : Add unhalt msr to aid (live) migration
Date: Wed, 11 Apr 2012 21:15:17 -0300
Message-ID: <20120412001517.GB32051@amt.cnet>
References: <20120323080503.14568.43092.sendpatchset@codeblue>
	<20120323080723.14568.23068.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120323080723.14568.23068.sendpatchset@codeblue>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, X86 <x86@kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Virtualization <virtualization@lists.linux-foundation.org>, Xen <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 23, 2012 at 01:37:26PM +0530, Raghavendra K T wrote:
> From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> 
> Currently guest does not need to know pv_unhalt state and intended to be
> used via GET/SET_MSR ioctls  during migration.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 9234f13..46f9751 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -40,6 +40,7 @@
>  #define MSR_KVM_SYSTEM_TIME_NEW 0x4b564d01
>  #define MSR_KVM_ASYNC_PF_EN 0x4b564d02
>  #define MSR_KVM_STEAL_TIME  0x4b564d03
> +#define MSR_KVM_PV_UNHALT   0x4b564d04
>  
>  struct kvm_steal_time {
>  	__u64 steal;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index bd5ef91..38e6c47 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -784,12 +784,13 @@ EXPORT_SYMBOL_GPL(kvm_rdpmc);
>   * kvm-specific. Those are put in the beginning of the list.
>   */
>  
> -#define KVM_SAVE_MSRS_BEGIN	9
> +#define KVM_SAVE_MSRS_BEGIN	10
>  static u32 msrs_to_save[] = {
>  	MSR_KVM_SYSTEM_TIME, MSR_KVM_WALL_CLOCK,
>  	MSR_KVM_SYSTEM_TIME_NEW, MSR_KVM_WALL_CLOCK_NEW,
>  	HV_X64_MSR_GUEST_OS_ID, HV_X64_MSR_HYPERCALL,
>  	HV_X64_MSR_APIC_ASSIST_PAGE, MSR_KVM_ASYNC_PF_EN, MSR_KVM_STEAL_TIME,
> +	MSR_KVM_PV_UNHALT,
>  	MSR_IA32_SYSENTER_CS, MSR_IA32_SYSENTER_ESP, MSR_IA32_SYSENTER_EIP,
>  	MSR_STAR,
>  #ifdef CONFIG_X86_64
> @@ -1606,7 +1607,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 data)
>  		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
>  
>  		break;
> -
> +	case MSR_KVM_PV_UNHALT:
> +		vcpu->pv_unhalted = (u32) data;
> +		break;
>  	case MSR_IA32_MCG_CTL:
>  	case MSR_IA32_MCG_STATUS:
>  	case MSR_IA32_MC0_CTL ... MSR_IA32_MC0_CTL + 4 * KVM_MAX_MCE_BANKS - 1:
> @@ -1917,6 +1920,9 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
>  	case MSR_KVM_STEAL_TIME:
>  		data = vcpu->arch.st.msr_val;
>  		break;
> +	case MSR_KVM_PV_UNHALT:
> +		data = (u64)vcpu->pv_unhalted;
> +		break;
>  	case MSR_IA32_P5_MC_ADDR:
>  	case MSR_IA32_P5_MC_TYPE:
>  	case MSR_IA32_MCG_CAP:

Unless there is a reason to use an MSR, should use a normal ioctl
such as KVM_{GET,SET}_MP_STATE.
