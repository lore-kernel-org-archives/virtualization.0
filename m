From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 4/4] Modify KVM to update guest time
	accounting.
Date: Mon, 20 Aug 2007 16:40:24 +0300
Message-ID: <46C999C8.4080307__7275.84103956378$1187618093$gmane$org@qumranet.com>
References: <46C993A6.3060001@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C993A6.3060001@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Laurent Vivier wrote:
> [PATCH 4/4] Modify KVM to update guest time accounting.
>
>   

> Index: kvm/drivers/kvm/kvm.h
> ===================================================================
> --- kvm.orig/drivers/kvm/kvm.h	2007-08-20 13:23:53.000000000 +0200
> +++ kvm/drivers/kvm/kvm.h	2007-08-20 13:23:58.000000000 +0200
> @@ -589,6 +589,17 @@ void kvm_mmu_unload(struct kvm_vcpu *vcp
>  
>  int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run);
>  
> +static inline void kvm_guest_enter(void)
> +{
> +#ifdef CONFIG_GUEST_ACCOUNTING
> +	current->flags |= PF_VCPU;
> +#endif
>   

Since you select GUEST_ACCOUNTING, the #ifdef is always true?

> +}
> +
> +static inline void kvm_guest_exit(void)
> +{
>   

Missing content?

-- 
error compiling committee.c: too many arguments to function
