From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 20/26] Xen-paravirt_ops: Core Xen
	implementation
Date: Fri, 16 Mar 2007 10:14:11 +0100
Message-ID: <20070316091411.GF23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232528.812011702@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232528.812011702@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Core Xen Implementation
> 
> This patch is a rollup of all the core pieces of the Xen 
> implementation, including booting, memory management, interrupts, time 
> and so on.

> --- a/arch/i386/kernel/head.S
> +++ b/arch/i386/kernel/head.S
> @@ -535,6 +535,10 @@ unhandled_paravirt:
>  	ud2
>  #endif
>  
> +#ifdef CONFIG_XEN
> +#include "../xen/xen-head.S"
> +#endif

i'd suggest to remove the #ifdef and push it into xen-head.S.

>  /*
>   * BSS section
>   */
> -.section ".bss.page_aligned","w"
> +.section ".bss.page_aligned","wa"

why is this done?

>  ENTRY(swapper_pg_dir)
> +	.align PAGE_SIZE_asm
>  	.fill 1024,4,0

does the native kernel lose memory here?

> @@ -437,9 +437,9 @@ static unsigned long native_store_tr(voi
>  
>  static void native_load_tls(struct thread_struct *t, unsigned int cpu)
>  {
> -#define C(i) get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + i] = t->tls_array[i]
> -	C(0); C(1); C(2);
> -#undef C
> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 0] = t->tls_array[0];
> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 1] = t->tls_array[1];
> +	get_cpu_gdt_table(cpu)[GDT_ENTRY_TLS_MIN + 2] = t->tls_array[2];
>  }

this is a cleanup unrelated to the purpose of the patch.

> +static void xen_safe_halt(void)
> +{
> +	stop_hz_timer();
> +	/* Blocking includes an implicit local_irq_enable(). */
> +	if (HYPERVISOR_sched_op(SCHEDOP_block, 0) != 0)
> +		BUG();
> +	start_hz_timer();
> +}

change this to tick_nohz_stop_sched_tick()/restart_sched_tick() instead.

> +static void xen_halt(void)
> +{
> +#if 0
> +	if (irqs_disabled())
> +		HYPERVISOR_vcpu_op(VCPUOP_down, smp_processor_id(), NULL);
> +#endif

hm?

> +		op->arg1.linear_addr = arbitrary_virt_to_machine((unsigned long)addr).maddr;

80+ chars line. (there are more instances of this throughout the patch)

> +	for (va = dtr->address, f = 0;
> +	     va < dtr->address + size;
> +	     va += PAGE_SIZE, f++) {
> +		frames[f] = virt_to_mfn(va);
> +		make_lowmem_page_readonly((void *)va);
> +	}

coding style.

> +	/* This is used very early, so we can't rely on per-cpu data
> +	   being set up, so no multicalls */

comment coding style. (there are instances of this throughout the patch)

> +	spin_lock(&lock);
> +	for(in = out = 0; in < count; in++) {

missing whitespace.

> +		if (HYPERVISOR_update_descriptor(virt_to_machine(dt + entry*8).maddr,

80+ chars.

> +static void xen_set_iopl_mask(unsigned mask)
> +{
> +#if 0
> +	struct physdev_set_iopl set_iopl;
> +
> +	/* Force the change at ring 0. */
> +	set_iopl.iopl = (mask == 0) ? 1 : (mask >> 12) & 3;
> +	HYPERVISOR_physdev_op(PHYSDEVOP_set_iopl, &set_iopl);
> +#endif

hm?

> +	}
> +
> +	write_pda(xen.cr3, cr3);
> +
> +
> +	{

unnecessary newline.

> +static struct irq_chip xen_dynamic_chip __read_mostly = {
> +	.name		= "xen-virq",
> +	.mask		= disable_dynirq,
> +	.unmask		= enable_dynirq,
> +	.ack		= ack_dynirq,
> +	.set_affinity	= set_affinity_irq,
> +	.retrigger	= retrigger_dynirq,
> +};

nicely done! :-)

> +void xen_set_pte(pte_t *ptep, pte_t pte)
> +{
> +#if 1
> +	struct mmu_update u;
> +
> +	u.ptr = virt_to_machine(ptep).maddr;
> +	u.val = pte_val_ma(pte);
> +	if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) < 0)
> +		BUG();
> +#else
> +	ptep->pte_high = pte.pte_high;
> +	smp_wmb();
> +	ptep->pte_low = pte.pte_low;
> +#endif

hm?

> +	pgd = swapper_pg_dir + pgd_index(vaddr);
> +	if (pgd_none(*pgd)) {
> +		BUG();
> +		return;

hm?

> +void xen_pte_clear(struct mm_struct *mm, unsigned long addr,pte_t *ptep)
> +{
> +#if 1
> +	ptep->pte_low = 0;
> +	smp_wmb();
> +	ptep->pte_high = 0;
> +#else
> +	set_64bit((u64 *)ptep, 0);
> +#endif

hm?

> +unsigned long xen_pmd_val(pmd_t pmd)
> +{
> +	BUG();
> +	return 0;
> +}

make it noret.

> +pmd_t xen_make_pmd(unsigned long pmd)
> +{
> +	BUG();
> +	return __pmd(0);
> +}

ditto.

> +static void xen_timer_interrupt_hook(void)
> +{

> +				runstate->time[RUNSTATE_offline] -
> +				__get_cpu_var(processed_stolen_time);

NACK for now, for the reasons outlined in the 'stolen time' thread. 
Stolen time accounting is a concept only related to the scheduler tick, 
it's not a concept that should leak into normal timer interrupt 
concepts.

> +	/* System-wide jiffy work. */
> +	ticks = 0;
> +	while(delta > NS_PER_TICK) {
> +		delta -= NS_PER_TICK;
> +		processed_system_time += NS_PER_TICK;
> +		ticks++;
> +	}
> +	do_timer(ticks);

that should be updated to clockevents. (i suspect it already is?)

> +
> +#if 0
> +	if (unlikely((mfn >> machine_to_phys_order) != 0))
> +		return max_mapnr;
> +#endif

hm?

	Ingo
