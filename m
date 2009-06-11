From: Matias Zabaljauregui <zabaljauregui@gmail.com>
Subject: Re: [PATCH] lguest: PAE support
Date: Thu, 11 Jun 2009 20:20:56 -0300
Message-ID: <1244762456.5360.20.camel__48251.4893672944$1244762505$gmane$org@zetabook>
References: <1244218142.7700.24.camel@zetabook>
	<200906071058.23921.rusty@rustcorp.com.au>
	<1244397067.21275.33.camel@zetabook>
	<200906111710.45772.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200906111710.45772.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2009-06-11 at 17:10 +0930, Rusty Russell wrote:
> Debugged why guest was crashing immediately with unhandled page fault, also
> fixed a potential future problem.  Please review.
> 
> lguest: PAE fixes
> 
> 1) j wasn't initialized in setup_pagetables, so they weren't set up for me
>    causing immediate guest crashes.
Oops,  don't understand how it worked on my test boxes all these days.

> 
> 2) gpte_addr should not re-read the pmd from the Guest.  Especially
>    not BUG_ON() based on the value.  If we ever supported SMP guests,
>    they could trigger that.  And the Launcher could also trigger it
>    (tho currently root-only).
> 
thanks for fixing this as well.


Matias


> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> diff --git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
> --- a/drivers/lguest/page_tables.c
> +++ b/drivers/lguest/page_tables.c
> @@ -154,26 +154,25 @@ static unsigned long gpmd_addr(pgd_t gpg
>  	BUG_ON(!(pgd_flags(gpgd) & _PAGE_PRESENT));
>  	return gpage + pmd_index(vaddr) * sizeof(pmd_t);
>  }
> -#endif
>  
>  static unsigned long gpte_addr(struct lg_cpu *cpu,
> +			       pmd_t gpmd, unsigned long vaddr)
> +{
> +	unsigned long gpage = pmd_pfn(gpmd) << PAGE_SHIFT;
> +
> +	BUG_ON(!(pmd_flags(gpmd) & _PAGE_PRESENT));
> +	return gpage + pte_index(vaddr) * sizeof(pte_t);
> +}
> +#else
> +static unsigned long gpte_addr(struct lg_cpu *cpu,
>  				pgd_t gpgd, unsigned long vaddr)
>  {
> -#ifdef CONFIG_X86_PAE
> -	pmd_t gpmd;
> -#endif
> -	unsigned long gpage;
> +	unsigned long gpage = pgd_pfn(gpgd) << PAGE_SHIFT;
>  
>  	BUG_ON(!(pgd_flags(gpgd) & _PAGE_PRESENT));
> -#ifdef CONFIG_X86_PAE
> -	gpmd = lgread(cpu, gpmd_addr(gpgd, vaddr), pmd_t);
> -	gpage = pmd_pfn(gpmd) << PAGE_SHIFT;
> -	BUG_ON(!(pmd_flags(gpmd) & _PAGE_PRESENT));
> -#else
> -	gpage = pgd_pfn(gpgd) << PAGE_SHIFT;
> -#endif
>  	return gpage + pte_index(vaddr) * sizeof(pte_t);
>  }
> +#endif
>  /*:*/
>  
>  /*M:014 get_pfn is slow: we could probably try to grab batches of pages here as
> @@ -339,10 +338,15 @@ bool demand_page(struct lg_cpu *cpu, uns
>  		 * number in the shadow PMD is the page we just allocated. */
>  		native_set_pmd(spmd, __pmd(__pa(ptepage) | pmd_flags(gpmd)));
>  	}
> -#endif
> +
> +	/* OK, now we look at the lower level in the Guest page table: keep its
> +	 * address, because we might update it later. */
> +	gpte_ptr = gpte_addr(cpu, gpmd, vaddr);
> +#else
>  	/* OK, now we look at the lower level in the Guest page table: keep its
>  	 * address, because we might update it later. */
>  	gpte_ptr = gpte_addr(cpu, gpgd, vaddr);
> +#endif
>  	gpte = lgread(cpu, gpte_ptr, pte_t);
>  
>  	/* If this page isn't in the Guest page tables, we can't page it in. */
> @@ -522,7 +526,6 @@ unsigned long guest_pa(struct lg_cpu *cp
>  {
>  	pgd_t gpgd;
>  	pte_t gpte;
> -
>  #ifdef CONFIG_X86_PAE
>  	pmd_t gpmd;
>  #endif
> @@ -534,13 +537,14 @@ unsigned long guest_pa(struct lg_cpu *cp
>  		return -1UL;
>  	}
>  
> -	gpte = lgread(cpu, gpte_addr(cpu, gpgd, vaddr), pte_t);
>  #ifdef CONFIG_X86_PAE
>  	gpmd = lgread(cpu, gpmd_addr(gpgd, vaddr), pmd_t);
>  	if (!(pmd_flags(gpmd) & _PAGE_PRESENT))
>  		kill_guest(cpu, "Bad address %#lx", vaddr);
> +	gpte = lgread(cpu, gpte_addr(cpu, gpmd, vaddr), pte_t);
> +#else
> +	gpte = lgread(cpu, gpte_addr(cpu, gpgd, vaddr), pte_t);
>  #endif
> -	gpte = lgread(cpu, gpte_addr(cpu, gpgd, vaddr), pte_t);
>  	if (!(pte_flags(gpte) & _PAGE_PRESENT))
>  		kill_guest(cpu, "Bad address %#lx", vaddr);
>  
> @@ -847,7 +851,7 @@ static unsigned long setup_pagetables(st
>  	/* The top level points to the linear page table pages above.
>  	 * We setup the identity and linear mappings here. */
>  #ifdef CONFIG_X86_PAE
> -	for (i = 0, j; i < mapped_pages && j < PTRS_PER_PMD;
> +	for (i = j = 0; i < mapped_pages && j < PTRS_PER_PMD;
>  	     i += PTRS_PER_PTE, j++) {
>  		native_set_pmd(&pmd, __pmd(((unsigned long)(linear + i)
>  		- mem_base) | _PAGE_PRESENT | _PAGE_RW | _PAGE_USER));
> 
