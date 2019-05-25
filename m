From: Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH 5/6] x86/mm/tlb: Flush remote and local TLBs
	concurrently
Date: Sat, 25 May 2019 10:54:50 +0200
Message-ID: <08b21fb5-2226-7924-30e3-31e4adcfc0a3__31301.6051238932$1558774508$gmane$org@suse.com>
References: <20190525082203.6531-1-namit@vmware.com>
	<20190525082203.6531-6-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190525082203.6531-6-namit@vmware.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 25/05/2019 10:22, Nadav Amit wrote:
> To improve TLB shootdown performance, flush the remote and local TLBs
> concurrently. Introduce flush_tlb_multi() that does so. The current
> flush_tlb_others() interface is kept, since paravirtual interfaces need
> to be adapted first before it can be removed. This is left for future
> work. In such PV environments, TLB flushes are not performed, at this
> time, concurrently.
> 
> Add a static key to tell whether this new interface is supported.
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Sasha Levin <sashal@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: kvm@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/hyperv/mmu.c                 |  2 +
>  arch/x86/include/asm/paravirt.h       |  8 +++
>  arch/x86/include/asm/paravirt_types.h |  6 ++
>  arch/x86/include/asm/tlbflush.h       |  6 ++
>  arch/x86/kernel/kvm.c                 |  1 +
>  arch/x86/kernel/paravirt.c            |  3 +
>  arch/x86/mm/tlb.c                     | 80 +++++++++++++++++++++++----
>  arch/x86/xen/mmu_pv.c                 |  2 +
>  8 files changed, 96 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index e65d7fe6489f..ca28b400c87c 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -233,4 +233,6 @@ void hyperv_setup_mmu_ops(void)
>  	pr_info("Using hypercall for remote TLB flush\n");
>  	pv_ops.mmu.flush_tlb_others = hyperv_flush_tlb_others;
>  	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
> +
> +	static_key_disable(&flush_tlb_multi_enabled.key);
>  }
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index c25c38a05c1c..192be7254457 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -47,6 +47,8 @@ static inline void slow_down_io(void)
>  #endif
>  }
>  
> +DECLARE_STATIC_KEY_TRUE(flush_tlb_multi_enabled);
> +
>  static inline void __flush_tlb(void)
>  {
>  	PVOP_VCALL0(mmu.flush_tlb_user);
> @@ -62,6 +64,12 @@ static inline void __flush_tlb_one_user(unsigned long addr)
>  	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
>  }
>  
> +static inline void flush_tlb_multi(const struct cpumask *cpumask,
> +				   const struct flush_tlb_info *info)
> +{
> +	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
> +}
> +
>  static inline void flush_tlb_others(const struct cpumask *cpumask,
>  				    const struct flush_tlb_info *info)
>  {
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 946f8f1f1efc..3a156e63c57d 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -211,6 +211,12 @@ struct pv_mmu_ops {
>  	void (*flush_tlb_user)(void);
>  	void (*flush_tlb_kernel)(void);
>  	void (*flush_tlb_one_user)(unsigned long addr);
> +	/*
> +	 * flush_tlb_multi() is the preferred interface. When it is used,
> +	 * flush_tlb_others() should return false.

This comment does not make sense. flush_tlb_others() return type is
void.


Juergen
