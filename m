From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC V9 19/19] kvm hypervisor: Add directed yield in vcpu
	block path
Date: Mon, 3 Jun 2013 12:05:40 -0400
Message-ID: <20130603160540.GI4224@phenom.dumpdata.com>
References: <20130601192125.5966.35563.sendpatchset@codeblue>
	<20130601192645.5966.42685.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130601192645.5966.42685.sendpatchset@codeblue>
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
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jun 02, 2013 at 12:56:45AM +0530, Raghavendra K T wrote:
> kvm hypervisor: Add directed yield in vcpu block path
> 
> From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> 
> We use the improved PLE handler logic in vcpu block patch for
> scheduling rather than plain schedule, so that we can make
> intelligent decisions

You are missing '.' there, and

> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  arch/ia64/include/asm/kvm_host.h    |    5 +++++
>  arch/powerpc/include/asm/kvm_host.h |    5 +++++
>  arch/s390/include/asm/kvm_host.h    |    5 +++++
>  arch/x86/include/asm/kvm_host.h     |    2 +-
>  arch/x86/kvm/x86.c                  |    8 ++++++++
>  include/linux/kvm_host.h            |    2 +-
>  virt/kvm/kvm_main.c                 |    6 ++++--
>  7 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/ia64/include/asm/kvm_host.h b/arch/ia64/include/asm/kvm_host.h
> index 989dd3f..999ab15 100644
> --- a/arch/ia64/include/asm/kvm_host.h
> +++ b/arch/ia64/include/asm/kvm_host.h
> @@ -595,6 +595,11 @@ int kvm_emulate_halt(struct kvm_vcpu *vcpu);
>  int kvm_pal_emul(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run);
>  void kvm_sal_emul(struct kvm_vcpu *vcpu);
>  
> +static inline void kvm_do_schedule(struct kvm_vcpu *vcpu)
> +{
> +	schedule();
> +}
> +
>  #define __KVM_HAVE_ARCH_VM_ALLOC 1
>  struct kvm *kvm_arch_alloc_vm(void);
>  void kvm_arch_free_vm(struct kvm *kvm);
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index af326cd..1aeecc0 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -628,4 +628,9 @@ struct kvm_vcpu_arch {
>  #define __KVM_HAVE_ARCH_WQP
>  #define __KVM_HAVE_CREATE_DEVICE
>  
> +static inline void kvm_do_schedule(struct kvm_vcpu *vcpu)
> +{
> +	schedule();
> +}
> +
>  #endif /* __POWERPC_KVM_HOST_H__ */
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 16bd5d1..db09a56 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -266,4 +266,9 @@ struct kvm_arch{
>  };
>  
>  extern int sie64a(struct kvm_s390_sie_block *, u64 *);
> +static inline void kvm_do_schedule(struct kvm_vcpu *vcpu)
> +{
> +	schedule();
> +}
> +
>  #endif
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 95702de..72ff791 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1042,5 +1042,5 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
>  int kvm_pmu_read_pmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
>  void kvm_handle_pmu_event(struct kvm_vcpu *vcpu);
>  void kvm_deliver_pmi(struct kvm_vcpu *vcpu);
> -
> +void kvm_do_schedule(struct kvm_vcpu *vcpu);
>  #endif /* _ASM_X86_KVM_HOST_H */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b963c86..d26c4be 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7281,6 +7281,14 @@ bool kvm_arch_can_inject_async_page_present(struct kvm_vcpu *vcpu)
>  			kvm_x86_ops->interrupt_allowed(vcpu);
>  }
>  
> +void kvm_do_schedule(struct kvm_vcpu *vcpu)
> +{
> +	/* We try to yield to a kikced vcpu else do a schedule */

s/kikced/kicked/

> +	if (kvm_vcpu_on_spin(vcpu) <= 0)
> +		schedule();
> +}
> +EXPORT_SYMBOL_GPL(kvm_do_schedule);
> +
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_exit);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_inj_virq);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_page_fault);
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f0eea07..39efc18 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -565,7 +565,7 @@ void mark_page_dirty_in_slot(struct kvm *kvm, struct kvm_memory_slot *memslot,
>  void kvm_vcpu_block(struct kvm_vcpu *vcpu);
>  void kvm_vcpu_kick(struct kvm_vcpu *vcpu);
>  bool kvm_vcpu_yield_to(struct kvm_vcpu *target);
> -void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu);
> +bool kvm_vcpu_on_spin(struct kvm_vcpu *vcpu);
>  void kvm_resched(struct kvm_vcpu *vcpu);
>  void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
>  void kvm_put_guest_fpu(struct kvm_vcpu *vcpu);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 302681c..8387247 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1685,7 +1685,7 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
>  		if (signal_pending(current))
>  			break;
>  
> -		schedule();
> +		kvm_do_schedule(vcpu);
>  	}
>  
>  	finish_wait(&vcpu->wq, &wait);
> @@ -1786,7 +1786,7 @@ bool kvm_vcpu_eligible_for_directed_yield(struct kvm_vcpu *vcpu)
>  }
>  #endif
>  
> -void kvm_vcpu_on_spin(struct kvm_vcpu *me)
> +bool kvm_vcpu_on_spin(struct kvm_vcpu *me)
>  {
>  	struct kvm *kvm = me->kvm;
>  	struct kvm_vcpu *vcpu;
> @@ -1835,6 +1835,8 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>  
>  	/* Ensure vcpu is not eligible during next spinloop */
>  	kvm_vcpu_set_dy_eligible(me, false);
> +
> +	return yielded;
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_on_spin);
>  
> 
