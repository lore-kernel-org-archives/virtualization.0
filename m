From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC PATCH v2 1/7] x86/paravirt: Add pv_idle_ops to paravirt ops
Date: Tue, 29 Aug 2017 09:55:48 -0400
Message-ID: <20170829135548.GG32175@char.us.oracle.com>
References: <1504007201-12904-1-git-send-email-yang.zhang.wz@gmail.com>
	<1504007201-12904-2-git-send-email-yang.zhang.wz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1504007201-12904-2-git-send-email-yang.zhang.wz@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yang Zhang <yang.zhang.wz@gmail.com>, xen-devel@lists.xensource.com, jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, rkrcmar@redhat.com, kvm@vger.kernel.org, mst@redhat.com, peterz@infradead.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, wanpeng.li@hotmail.com, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Chris Wright <chrisw@sous-sol.org>, Andy Lutomirski <luto@kernel.org>, dmatlack@google.com, tglx@linutronix.de, Quan Xu <quan.xu0@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 29, 2017 at 11:46:35AM +0000, Yang Zhang wrote:
> So far, pv_idle_ops.poll is the only ops for pv_idle. .poll is called in
> idle path which will polling for a while before we enter the real idle
> state.
> 
> In virtualization, idle path includes several heavy operations
> includes timer access(LAPIC timer or TSC deadline timer) which will hurt
> performance especially for latency intensive workload like message
> passing task. The cost is mainly come from the vmexit which is a
> hardware context switch between VM and hypervisor. Our solution is to
> poll for a while and do not enter real idle path if we can get the
> schedule event during polling.
> 
> Poll may cause the CPU waste so we adopt a smart polling mechanism to
> reduce the useless poll.
> 
> Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
> Signed-off-by: Quan Xu <quan.xu0@gmail.com>
> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
> Cc: Chris Wright <chrisw@sous-sol.org>
> Cc: Alok Kataria <akataria@vmware.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org

Adding xen-devel.

Juergen, we really should replace Jeremy's name with xen-devel or
your name.. Wasn't there an patch by you that took some of the 
mainternship over it?

> ---
>  arch/x86/include/asm/paravirt.h       | 5 +++++
>  arch/x86/include/asm/paravirt_types.h | 6 ++++++
>  arch/x86/kernel/paravirt.c            | 6 ++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 9ccac19..6d46760 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -202,6 +202,11 @@ static inline unsigned long long paravirt_read_pmc(int counter)
>  
>  #define rdpmcl(counter, val) ((val) = paravirt_read_pmc(counter))
>  
> +static inline void paravirt_idle_poll(void)
> +{
> +	PVOP_VCALL0(pv_idle_ops.poll);
> +}
> +
>  static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
>  {
>  	PVOP_VCALL2(pv_cpu_ops.alloc_ldt, ldt, entries);
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index 9ffc36b..cf45726 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -324,6 +324,10 @@ struct pv_lock_ops {
>  	struct paravirt_callee_save vcpu_is_preempted;
>  } __no_randomize_layout;
>  
> +struct pv_idle_ops {
> +	void (*poll)(void);
> +} __no_randomize_layout;
> +
>  /* This contains all the paravirt structures: we get a convenient
>   * number for each function using the offset which we use to indicate
>   * what to patch. */
> @@ -334,6 +338,7 @@ struct paravirt_patch_template {
>  	struct pv_irq_ops pv_irq_ops;
>  	struct pv_mmu_ops pv_mmu_ops;
>  	struct pv_lock_ops pv_lock_ops;
> +	struct pv_idle_ops pv_idle_ops;
>  } __no_randomize_layout;
>  
>  extern struct pv_info pv_info;
> @@ -343,6 +348,7 @@ struct paravirt_patch_template {
>  extern struct pv_irq_ops pv_irq_ops;
>  extern struct pv_mmu_ops pv_mmu_ops;
>  extern struct pv_lock_ops pv_lock_ops;
> +extern struct pv_idle_ops pv_idle_ops;
>  
>  #define PARAVIRT_PATCH(x)					\
>  	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index bc0a849..1b5b247 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -128,6 +128,7 @@ static void *get_call_destination(u8 type)
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  		.pv_lock_ops = pv_lock_ops,
>  #endif
> +		.pv_idle_ops = pv_idle_ops,
>  	};
>  	return *((void **)&tmpl + type);
>  }
> @@ -312,6 +313,10 @@ struct pv_time_ops pv_time_ops = {
>  	.steal_clock = native_steal_clock,
>  };
>  
> +struct pv_idle_ops pv_idle_ops = {
> +	.poll = paravirt_nop,
> +};
> +
>  __visible struct pv_irq_ops pv_irq_ops = {
>  	.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
>  	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
> @@ -471,3 +476,4 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
>  EXPORT_SYMBOL    (pv_mmu_ops);
>  EXPORT_SYMBOL_GPL(pv_info);
>  EXPORT_SYMBOL    (pv_irq_ops);
> +EXPORT_SYMBOL    (pv_idle_ops);
> -- 
> 1.8.3.1
> 
