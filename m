From: Jes Sorensen <jes@sgi.com>
Subject: Re: [16/18]KVM:IA64 : Add kvm sal/pal virtulization support.V9
Date: Tue, 01 Apr 2008 17:26:18 +0200
Message-ID: <47F2541A.50007__34022.2601233565$1207064009$gmane$org@sgi.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC0104872F@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC0104872F@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>
Cc: Carsten Otte <cotte@de.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
>>From 5c70c038c57190144390ae9d30c3d06afba103d4 Mon Sep 17 00:00:00 2001
> From: Xiantao Zhang <xiantao.zhang@intel.com>
> Date: Tue, 1 Apr 2008 14:59:30 +0800
> Subject: [PATCH] KVM:IA64 : Add kvm sal/pal virtulization support.
> 
> Some sal/pal calls would be traped to kvm for virtulization
> from guest firmware.
> Signed-off-by: Xiantao Zhang <xiantao.zhang@intel.com>
> ---
>  arch/ia64/kvm/kvm_fw.c |  500

Hi Xiantao,

A few more comments:


> --- /dev/null
> +++ b/arch/ia64/kvm/kvm_fw.c

> +static void kvm_get_pal_call_data(struct kvm_vcpu *vcpu,
> +		u64 *gr28, u64 *gr29, u64 *gr30, u64 *gr31) {
> +	struct exit_ctl_data *p;
> +
> +	if (vcpu) {
> +		p = &vcpu->arch.exit_data;
> +		if (p->exit_reason == EXIT_REASON_PAL_CALL) {
> +			*gr28 = p->u.pal_data.gr28;
> +			*gr29 = p->u.pal_data.gr29;
> +			*gr30 = p->u.pal_data.gr30;
> +			*gr31 = p->u.pal_data.gr31;
> +			return ;
> +		}
> +	}
> +	printk(KERN_DEBUG"Error occurs in kvm_get_pal_call_data!!\n");

Maybe make this error message a bit more elaborate with information
about what the error is?

> +static void set_sal_result(struct kvm_vcpu *vcpu,
> +		struct sal_ret_values result) {
> +	struct exit_ctl_data *p;
> +
> +	p = kvm_get_exit_data(vcpu);
> +	if (p && p->exit_reason == EXIT_REASON_SAL_CALL) {
> +		p->u.sal_data.ret = result;
> +		return ;
> +	}
> +	printk(KERN_WARNING"Error occurs!!!\n");

I love this error message :-) Seriously though, please make it say
where it is and what has been detected.

Cheers,
Jes
