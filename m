From: Jes Sorensen <jes@sgi.com>
Subject: Re: [04/17] [PATCH] Add kvm arch-specific core code for kvm/ia64.-V8
Date: Mon, 31 Mar 2008 14:01:59 +0200
Message-ID: <47F0D2B7.7080607__14739.0356324197$1206975003$gmane$org@sgi.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC01048245@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC01048245@pdsmsx415.ccr.corp.intel.com>
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
>>From 62895ff991d48398a77afdbf7f2bef127e802230 Mon Sep 17 00:00:00 2001
> From: Xiantao Zhang <xiantao.zhang@intel.com>
> Date: Fri, 28 Mar 2008 09:49:57 +0800
> Subject: [PATCH] KVM: IA64: Add kvm arch-specific core code for
> kvm/ia64.
> 
> kvm_ia64.c is created to handle kvm ia64-specific core logic.
> Signed-off-by: Xiantao Zhang <xiantao.zhang@intel.com>

More comments, a couple of bugs in this one.

> +#include <linux/module.h>
> +#include <linux/vmalloc.h>

Don't think you need vmalloc.h here.

> +int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs
> *regs)
> +{
[snip]
> +	copy_from_user(&vcpu->arch.guest, regs->saved_guest,
> +						sizeof(union context));
> +	copy_from_user(vcpu + 1, regs->saved_stack + sizeof(struct
> kvm_vcpu),
> +			IA64_STK_OFFSET - sizeof(struct kvm_vcpu));

You need to check the return values from copy_from_user() here and
deal with possible failure.

> +	vcpu->arch.apic = kzalloc(sizeof(struct kvm_lapic), GFP_KERNEL);
> +	vcpu->arch.apic->vcpu = vcpu;

Whoops! Missing NULL pointer check here after the kzalloc.

> +	copy_to_user(regs->saved_guest, &vcpu->arch.guest,
> +					sizeof(union context));
> +	copy_to_user(regs->saved_stack, (void *)vcpu, IA64_STK_OFFSET);

Same problem as above - check the return values.

Cheers,
Jes
